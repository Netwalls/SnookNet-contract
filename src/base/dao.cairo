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

#[starknet::interface]
trait IDAO {
    fn propose_rule_change(ref self: ContractState, proposal: Proposal);
    fn vote(ref self: ContractState, proposal_id: u256, support: bool);
    fn execute_proposal(ref self: ContractState, proposal_id: u256);
    fn create_custom_challenge(ref self: ContractState, challenge_data: ChallengeData) -> u256;
}
