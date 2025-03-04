use core::starknet::ContractAddress;

// DAO Types
#[derive(Copy, Debug, Drop, PartialEq, Serde, starknet::Store)]
pub struct Proposal {
    pub proposer: ContractAddress,
    pub description: felt252,
    pub execution_hash: felt252,
    pub voting_start: u64,
    pub voting_end: u64,
    pub for_votes: u256,
    pub against_votes: u256,
    pub executed: bool,
}

#[derive(Copy, Debug, Drop, PartialEq, Serde, starknet::Store)]
pub struct ChallengeData {
    pub creator: ContractAddress,
    pub description: felt252,
    pub start_time: u64,
    pub end_time: u64,
    pub reward: u256,
    pub completed: bool,
}

#[derive(Copy, Debug, Drop, PartialEq, Serde, starknet::Store)]
pub struct VotingPower {
    pub base_power: u256,
    pub boost_multiplier: u16,
    pub lock_duration: u64,
}

// DAO Interface
#[starknet::interface]
pub trait IDAO<TContractState> {
    // Proposal Management
    fn propose_rule_change(ref self: TContractState, proposal: Proposal);
    fn vote(ref self: TContractState, proposal_id: u256, support: bool);
    fn execute_proposal(ref self: TContractState, proposal_id: u256);

    // Challenge System
    fn create_custom_challenge(ref self: TContractState, challenge_data: ChallengeData) -> u256;
    fn participate_in_challenge(ref self: TContractState, challenge_id: u256);
    fn complete_challenge(ref self: TContractState, challenge_id: u256);
    fn claim_challenge_reward(ref self: TContractState, challenge_id: u256);

    // Governance Views
    fn get_proposal(self: @TContractState, proposal_id: u256) -> Proposal;
    fn get_voting_power(self: @TContractState, voter: ContractAddress) -> VotingPower;
    fn get_total_voting_power(self: @TContractState) -> u256;
}
