use starknet::ContractAddress;
use array::Array;

#[starknet::interface]
trait IERC721 {
    // Metadata
    fn name(self: @ContractState) -> felt252;
    fn symbol(self: @ContractState) -> felt252;
    fn token_uri(self: @ContractState, token_id: u256) -> felt252;

    // View functions
    fn balance_of(self: @ContractState, owner: ContractAddress) -> u256;
    fn owner_of(self: @ContractState, token_id: u256) -> ContractAddress;
    fn get_approved(self: @ContractState, token_id: u256) -> ContractAddress;
    fn is_approved_for_all(
        self: @ContractState, owner: ContractAddress, operator: ContractAddress,
    ) -> bool;

    // Transfer and approval functions
    fn approve(ref self: ContractState, to: ContractAddress, token_id: u256);
    fn set_approval_for_all(ref self: ContractState, operator: ContractAddress, approved: bool);
    fn transfer_from(
        ref self: ContractState, from: ContractAddress, to: ContractAddress, token_id: u256,
    );
    fn safe_transfer_from(
        ref self: ContractState,
        from: ContractAddress,
        to: ContractAddress,
        token_id: u256,
        data: Array<felt252>,
    );

    // Gaming-specific extensions
    fn mint_game_item(
        ref self: ContractState,
        to: ContractAddress,
        item_type: felt252,
        attributes: Array<felt252>,
    ) -> u256;

    fn get_item_attributes(self: @ContractState, token_id: u256) -> Array<felt252>;

    // Rental system for game items
    fn create_rental(ref self: ContractState, token_id: u256, duration: u64, price: u256);

    fn end_rental(ref self: ContractState, token_id: u256);

    // Achievement NFTs
    fn mint_achievement(
        ref self: ContractState,
        to: ContractAddress,
        achievement_id: u256,
        metadata: Array<felt252>,
    ) -> u256;
}
