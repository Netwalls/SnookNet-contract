use core::starknet::ContractAddress;
use super::snooknet::{GameState, ShotData};

// Player Types
#[derive(Drop, Serde, Copy)]
pub struct PlayerProfile {
    username: felt252,
    avatar_id: u8,
    country_code: felt252,
    join_date: u64,
}

#[derive(Drop, Serde, Copy)]
pub struct PlayerStats {
    matches_played: u32,
    matches_won: u32,
    highest_break: u16,
    tournament_wins: u16,
    elo_rating: u16,
}

#[derive(Drop, Serde, Copy)]
pub struct PlayerAchievement {
    id: felt252,
    name: felt252,
    description: felt252,
    unlock_date: u64,
}

#[derive(Drop, Serde)]
pub struct PlayerInventory {
    cues: Array<u256>,
    chalks: Array<u256>,
    emotes: Array<u256>,
    table_skins: Array<u256>,
}

// Player Interface
#[starknet::interface]
pub trait IPlayer<TContractState> {
    // Profile Management
    fn get_profile(self: @TContractState, player: ContractAddress) -> PlayerProfile;
    fn update_profile(ref self: TContractState, profile: PlayerProfile);
    fn get_stats(self: @TContractState, player: ContractAddress) -> PlayerStats;

    // Achievements & Inventory
    fn get_achievements(self: @TContractState, player: ContractAddress) -> Array<PlayerAchievement>;
    fn unlock_achievement(ref self: TContractState, achievement_id: felt252);
    fn get_inventory(self: @TContractState, player: ContractAddress) -> PlayerInventory;

    // Game History
    fn get_match_history(self: @TContractState, player: ContractAddress) -> Array<GameState>;
    fn get_best_shots(self: @TContractState, player: ContractAddress) -> Array<ShotData>;
    fn get_win_streak(self: @TContractState, player: ContractAddress) -> u32;

    // Rankings & Rewards
    fn get_ranking(self: @TContractState, player: ContractAddress) -> u32;
    fn claim_season_rewards(ref self: TContractState);
    fn get_unclaimed_rewards(self: @TContractState, player: ContractAddress) -> u256;
}
