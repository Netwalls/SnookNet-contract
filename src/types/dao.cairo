use starknet::ContractAddress;
use array::Array;

#[derive(Copy, Drop, Serde, starknet::Store)]
struct Proposal {
    proposer: ContractAddress,
    description: felt252,
    execution_data: Array<felt252>,
    voting_ends: u64
}

#[derive(Copy, Drop, Serde, starknet::Store)]
struct ChallengeData {
    name: felt252,
    description: felt252,
    requirements: Array<felt252>,
    rewards: Array<felt252>
} 