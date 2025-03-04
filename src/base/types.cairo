mod player;
mod game;
mod dao;
mod social;
mod ai;
mod ar;

// Common types used across multiple interfaces
#[derive(Copy, Drop, Serde, starknet::Store)]
struct Position {
    x: u16,
    y: u16,
    z: u16
}

#[derive(Copy, Drop, Serde, starknet::Store)]
struct GameState {
    current_player: ContractAddress,
    score: (u16, u16),
    balls_remaining: u8,
    current_break: u16,
    status: GameStatus
}

#[derive(Copy, Drop, Serde, starknet::Store)]
enum GameStatus {
    Waiting,
    InProgress,
    Completed,
    Abandoned
}

// Re-export common types
use player::PlayerStats;
use game::ShotData;
use dao::{Proposal, ChallengeData};
use ar::LocationData;

#[starknet::interface]
trait IPlayer {
    fn get_player_stats(self: @ContractState, player_address: ContractAddress) -> PlayerStats;
    fn stake_tokens(ref self: ContractState, amount: u256, competition_id: u256);
    fn unlock_feature(ref self: ContractState, feature_type: FeatureType, token_id: u256);
    fn lease_nft(ref self: ContractState, nft_id: u256, duration: u64, price: u256);
    fn claim_rewards(ref self: ContractState, achievement_id: u256);
}

#[derive(Copy, Drop, Serde, starknet::Store)]
enum FeatureType {
    Table,
    Cue,
    TimeWrap,
    TrophyRoom
}

#[starknet::interface]
trait IGame {
    fn create_game_room(ref self: ContractState, room_type: RoomType, entry_fee: u256) -> u256;
    fn join_game(ref self: ContractState, room_id: u256);
    fn make_shot(ref self: ContractState, game_id: u256, shot_data: ShotData);
    fn end_game(ref self: ContractState, game_id: u256);
    fn get_game_state(self: @ContractState, game_id: u256) -> GameState;
}

#[derive(Copy, Drop, Serde, starknet::Store)]
enum RoomType {
    Standard,
    Tournament,
    Practice,
    AIChallenge
}

#[starknet::interface]
trait IDAO {
    fn propose_rule_change(ref self: ContractState, proposal: Proposal);
    fn vote(ref self: ContractState, proposal_id: u256, support: bool);
    fn execute_proposal(ref self: ContractState, proposal_id: u256);
    fn create_custom_challenge(ref self: ContractState, challenge_data: ChallengeData) -> u256;
}

#[starknet::interface]
trait ISocial {
    fn create_trophy_room(ref self: ContractState) -> u256;
    fn display_nft(ref self: ContractState, room_id: u256, nft_id: u256, position: Position);
    fn invite_player(ref self: ContractState, room_id: u256, player: ContractAddress);
    fn set_room_visibility(ref self: ContractState, room_id: u256, is_public: bool);
}

#[starknet::interface]
trait IAI {
    fn create_ai_challenge(ref self: ContractState, difficulty: u8) -> u256;
    fn train_ai_model(ref self: ContractState, game_data: Array<felt252>);
    fn get_ai_move(self: @ContractState, game_state: GameState) -> ShotData;
    fn get_ghost_player_move(self: @ContractState, game_state: GameState) -> ShotData;
}

#[starknet::interface]
trait IAR {
    fn register_qr_location(ref self: ContractState, location_data: LocationData) -> u256;
    fn claim_location_reward(ref self: ContractState, qr_code: felt252, proof: Array<felt252>);
    fn project_table(ref self: ContractState, location: LocationData) -> bool;
}
