use array::Array;

#[derive(Copy, Drop, Serde, starknet::Store)]
struct LocationData {
    latitude: felt252,
    longitude: felt252,
    altitude: felt252,
    metadata: felt252
}

#[starknet::interface]
trait IAR {
    fn register_qr_location(ref self: ContractState, location_data: LocationData) -> u256;
    fn claim_location_reward(ref self: ContractState, qr_code: felt252, proof: Array<felt252>);
    fn project_table(ref self: ContractState, location: LocationData) -> bool;
}
