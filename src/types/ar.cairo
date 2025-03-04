#[derive(Copy, Drop, Serde, starknet::Store)]
struct LocationData {
    latitude: felt252,
    longitude: felt252,
    altitude: felt252,
    metadata: felt252
} 