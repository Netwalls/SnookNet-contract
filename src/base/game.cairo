use starknet::ContractAddress;
use super::types::{Position, GameState};

#[derive(Copy, Drop, Serde, starknet::Store)]
enum RoomType {
    Standard,
    Tournament,
    Practice,
    AIChallenge
}

#[derive(Copy, Drop, Serde, starknet::Store)]
struct ShotData {
    force: u8,
    angle: u16,
    spin: u8,
    cue_position: Position
}

#[starknet::interface]
trait IGame {
    fn create_game_room(ref self: ContractState, room_type: RoomType, entry_fee: u256) -> u256;
    fn join_game(ref self: ContractState, room_id: u256);
    fn make_shot(ref self: ContractState, game_id: u256, shot_data: ShotData);
    fn end_game(ref self: ContractState, game_id: u256);
    fn get_game_state(self: @ContractState, game_id: u256) -> GameState;
}
