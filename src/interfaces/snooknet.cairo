use core::starknet::ContractAddress;

// Game Types
#[derive(Copy, Debug, Drop, PartialEq, Serde)]
pub struct TournamentConfig {
    entry_fee: u256,
    max_players: u16,
    start_time: u64,
    prize_pool: u256,
}

#[derive(Debug, Drop, PartialEq, Serde)]
pub struct GameState {
    pub room_id: u256,
    pub players: Array<ContractAddress>,
    pub current_player: u8,
    pub scores: Array<u16>,
    pub status: u8,
    pub timestamp: u64,
}

#[derive(Copy, Debug, Drop, PartialEq, Serde)]
pub struct ShotData {
    power: u8,
    angle: u16,
    spin: i8,
    position: Position,
}

#[derive(Copy, Debug, Drop, PartialEq, Serde)]
pub struct Position {
    x: u16,
    y: u16,
}

#[derive(Copy, Debug, Drop, PartialEq, Serde)]
pub enum RoomType {
    Casual,
    Ranked,
    Tournament,
    Practice,
    AIChallenge,
}

// Matchmaking Types
#[derive(Copy, Debug, Drop, PartialEq, Serde)]
pub enum QueueType {
    Casual,
    Ranked,
    Tournament,
}

#[derive(Copy, Debug, Drop, PartialEq, Serde)]
pub struct QueueStatus {
    pub player_count: u16,
    pub average_wait_time: u64,
    pub active_matches: u16,
}

#[derive(Drop, Serde, Copy)]
pub struct MatchConfig {
    frames: u8,
    time_limit: u64,
    entry_fee: u256,
}

// Main Game Interface
#[starknet::interface]
pub trait ISNOOKNET<TContractState> {
    // Game Room Management
    fn create_game_room(ref self: TContractState, room_type: RoomType, entry_fee: u256) -> u256;
    fn join_game(ref self: TContractState, room_id: u256);
    fn leave_game(ref self: TContractState, room_id: u256);
    fn start_game(ref self: TContractState, room_id: u256);

    // Core Game Mechanics
    fn make_shot(ref self: TContractState, game_id: u256, shot_data: ShotData);
    fn end_frame(ref self: TContractState, game_id: u256);
    fn concede_game(ref self: TContractState, game_id: u256);
    fn claim_timeout_win(ref self: TContractState, game_id: u256);

    // Game State Views
    fn get_game_state(self: @TContractState, game_id: u256) -> GameState;
    fn get_current_break(self: @TContractState, game_id: u256) -> u16;
    fn get_highest_break(self: @TContractState, game_id: u256) -> u16;
    fn get_remaining_balls(self: @TContractState, game_id: u256) -> Array<(u8, Position)>;

    // Game Rules and Scoring
    fn validate_shot(self: @TContractState, game_id: u256, shot_data: ShotData) -> bool;
    fn calculate_points(self: @TContractState, game_id: u256, ball_type: u8) -> u8;
    fn check_foul(self: @TContractState, game_id: u256, shot_data: ShotData) -> (bool, u8);

    // Matchmaking Functions
    fn join_queue(ref self: TContractState, queue_type: QueueType, stake_amount: u256);
    fn leave_queue(ref self: TContractState, queue_type: QueueType);
    fn get_queue_status(self: @TContractState, queue_type: QueueType) -> QueueStatus;
    fn find_match(ref self: TContractState, player: ContractAddress) -> Option<u256>;
    fn accept_match(ref self: TContractState, match_id: u256);
    fn decline_match(ref self: TContractState, match_id: u256);
    fn calculate_elo(ref self: TContractState, winner: ContractAddress, loser: ContractAddress);
    fn get_player_elo(self: @TContractState, player: ContractAddress) -> u16;
    fn create_private_match(ref self: TContractState, config: MatchConfig) -> u256;
    fn invite_player(ref self: TContractState, match_id: u256, player: ContractAddress);
    fn respond_to_invite(ref self: TContractState, match_id: u256, accepted: bool);

    // Tournament Features
    fn create_tournament(ref self: TContractState, config: TournamentConfig) -> u256;
    fn register_for_tournament(ref self: TContractState, tournament_id: u256);
    fn start_tournament_match(ref self: TContractState, tournament_id: u256, match_id: u256);
    fn get_tournament_standings(
        self: @TContractState, tournament_id: u256,
    ) -> Array<(ContractAddress, u16)>;

    // Practice Mode
    fn start_practice_mode(ref self: TContractState) -> u256;
    fn set_practice_scenario(ref self: TContractState, game_id: u256, scenario_id: u256);
    fn reset_practice_frame(ref self: TContractState, game_id: u256);
}
