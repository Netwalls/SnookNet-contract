use starknet::ContractAddress;
use super::super::types::player::{PlayerStats, FeatureType};

#[starknet::interface]
trait IPlayer {
    fn get_player_stats(self: @ContractState, player_address: ContractAddress) -> PlayerStats;
    fn stake_tokens(ref self: ContractState, amount: u256, competition_id: u256);
    fn unlock_feature(ref self: ContractState, feature_type: FeatureType, token_id: u256);
    fn lease_nft(ref self: ContractState, nft_id: u256, duration: u64, price: u256);
    fn claim_rewards(ref self: ContractState, achievement_id: u256);
} 