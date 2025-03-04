use starknet::ContractAddress;
use super::types::Position;

#[derive(Copy, Drop, Serde, starknet::Store)]
struct PlayerStats {
    skill_level: u8,
    tokens_staked: u256,
    achievements: u256,
    nfts_owned: u256,
    games_played: u32,
    games_won: u32
}

#[derive(Copy, Drop, Serde, starknet::Store)]
enum FeatureType {
    Table,
    Cue,
    TimeWrap,
    TrophyRoom
}

#[starknet::interface]
trait IPlayer {
    fn get_player_stats(self: @ContractState, player_address: ContractAddress) -> PlayerStats;
    fn stake_tokens(ref self: ContractState, amount: u256, competition_id: u256);
    fn unlock_feature(ref self: ContractState, feature_type: FeatureType, token_id: u256);
    fn lease_nft(ref self: ContractState, nft_id: u256, duration: u64, price: u256);
    fn claim_rewards(ref self: ContractState, achievement_id: u256);
}
