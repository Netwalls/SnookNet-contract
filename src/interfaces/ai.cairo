use core::starknet::ContractAddress;
use super::snooknet::{GameState, ShotData};

// AI Types
#[derive(Drop, Serde, Copy)]
pub struct AIConfig {
    model_version: felt252,
    difficulty: u8,
    learning_rate: u16,
    reward_weight: u16,
}

#[derive(Drop, Serde)]
pub struct AIGameState {
    game_state: GameState,
    predicted_moves: Array<ShotData>,
    confidence_scores: Array<u16>,
    reward_history: Array<i16>,
}

#[derive(Drop, Serde, Copy)]
pub struct AIStats {
    games_played: u32,
    games_won: u32,
    highest_break: u16,
    average_accuracy: u16,
    learning_iterations: u64,
}

// AI Interface
#[starknet::interface]
pub trait IAI<TContractState> {
    // Configuration
    fn get_config(self: @TContractState) -> AIConfig;
    fn update_config(ref self: TContractState, config: AIConfig);

    // Game Analysis
    fn analyze_game_state(self: @TContractState, game_state: GameState) -> AIGameState;
    fn predict_next_shot(self: @TContractState, game_state: GameState) -> ShotData;
    fn evaluate_shot(self: @TContractState, shot: ShotData, result: GameState) -> u16;

    // Learning & Stats
    fn train(ref self: TContractState, training_data: Array<(GameState, ShotData)>);
    fn get_stats(self: @TContractState) -> AIStats;
    fn reset_learning(ref self: TContractState);

    // Difficulty Management
    fn adjust_difficulty(ref self: TContractState, player_elo: u16);
    fn get_current_difficulty(self: @TContractState) -> u8;
    fn create_ai_challenge(ref self: TContractState, difficulty: u8) -> u256;
    fn train_ai_model(ref self: TContractState, game_data: Array<felt252>);
    fn get_ai_move(self: @TContractState, game_state: GameState) -> ShotData;
    fn get_ghost_player_move(self: @TContractState, game_state: GameState) -> ShotData;
}
