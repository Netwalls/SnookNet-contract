use array::Array;
use super::types::GameState;
use super::game::ShotData;

#[starknet::interface]
trait IAI {
    fn create_ai_challenge(ref self: ContractState, difficulty: u8) -> u256;
    fn train_ai_model(ref self: ContractState, game_data: Array<felt252>);
    fn get_ai_move(self: @ContractState, game_state: GameState) -> ShotData;
    fn get_ghost_player_move(self: @ContractState, game_state: GameState) -> ShotData;
}
