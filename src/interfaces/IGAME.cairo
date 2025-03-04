use super::super::types::game::{RoomType, ShotData, GameState};

#[starknet::interface]
trait IGame {
    fn create_game_room(ref self: ContractState, room_type: RoomType, entry_fee: u256) -> u256;
    fn join_game(ref self: ContractState, room_id: u256);
    fn make_shot(ref self: ContractState, game_id: u256, shot_data: ShotData);
    fn end_game(ref self: ContractState, game_id: u256);
    fn get_game_state(self: @ContractState, game_id: u256) -> GameState;
} 