use starknet::ContractAddress;
use super::types::Position;

#[starknet::interface]
trait ISocial {
    fn create_trophy_room(ref self: ContractState) -> u256;
    fn display_nft(ref self: ContractState, room_id: u256, nft_id: u256, position: Position);
    fn invite_player(ref self: ContractState, room_id: u256, player: ContractAddress);
    fn set_room_visibility(ref self: ContractState, room_id: u256, is_public: bool);
} 