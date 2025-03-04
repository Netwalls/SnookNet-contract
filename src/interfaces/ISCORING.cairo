use starknet::ContractAddress;
use array::Array;

#[starknet::interface]
trait IScoring {
    // Score Tracking
    fn update_frame_score(
        ref self: ContractState, game_id: u256, points: u8, player: ContractAddress,
    );
    fn record_break(ref self: ContractState, game_id: u256, break_score: u16);
    fn record_century(ref self: ContractState, player: ContractAddress, break_score: u16);
    fn record_maximum_break(ref self: ContractState, player: ContractAddress, game_id: u256);

    // Statistics
    fn get_player_stats(self: @ContractState, player: ContractAddress) -> PlayerStats;
    fn get_highest_breaks(self: @ContractState, player: ContractAddress) -> Array<u16>;
    fn get_win_rate(self: @ContractState, player: ContractAddress) -> u16;
    fn get_average_break(self: @ContractState, player: ContractAddress) -> u16;

    // Achievements
    fn unlock_achievement(ref self: ContractState, player: ContractAddress, achievement_id: u256);
    fn get_player_achievements(self: @ContractState, player: ContractAddress) -> Array<u256>;
    fn check_achievement_progress(
        self: @ContractState, player: ContractAddress, achievement_id: u256,
    ) -> (bool, u8); // (completed, progress_percentage)

    // Rankings
    fn update_player_ranking(ref self: ContractState, player: ContractAddress, points: u16);
    fn get_player_ranking(self: @ContractState, player: ContractAddress) -> u32;
    fn get_leaderboard(self: @ContractState) -> Array<(ContractAddress, u32)>;
}

#[derive(Drop, Serde, starknet::Store)]
struct PlayerStats {
    total_frames_played: u32,
    frames_won: u32,
    highest_break: u16,
    century_breaks: u16,
    maximum_breaks: u8,
    tournament_wins: u16,
    ranking_points: u32,
    average_break: u16,
}
