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
    pub execution_time: u64,
    pub total_nft_votes: u32,
    pub reward_claimed: bool,
}

#[derive(Copy, Debug, Drop, PartialEq, Serde, starknet::Store)]
pub struct ProposerRequirements {
    pub min_gruft_tokens: u256, // 8000 GRUFT
    pub min_nfts: u32, // 20 NFTs
    pub is_grandmaster: bool,
}

#[derive(Copy, Debug, Drop, PartialEq, Serde, starknet::Store)]
pub struct AutoExecuteThreshold {
    pub min_gruft_votes: u256, // 200,000 GRUFT
    pub min_nft_votes: u32 // 70 NFTs
}

#[derive(Copy, Debug, Drop, PartialEq, Serde, starknet::Store)]
pub struct VotingPower {
    pub base_power: u256,
    pub boost_multiplier: u16,
    pub lock_duration: u64,
    pub nft_count: u32,
}

// DAO Interface
#[starknet::interface]
pub trait IDAO<TContractState> {
    // Proposal Management
    fn propose_rule_change(ref self: TContractState, proposal: Proposal);
    fn vote(ref self: TContractState, proposal_id: u256, support: bool);
    fn execute_proposal(ref self: TContractState, proposal_id: u256);
    fn claim_proposal_reward(ref self: TContractState, proposal_id: u256);

    // Voting Power Management
    fn delegate_voting_power(ref self: TContractState, to: ContractAddress, amount: u256);
    fn get_delegated_power(self: @TContractState, account: ContractAddress) -> u256;


    // Governance Views
    fn get_proposal(self: @TContractState, proposal_id: u256) -> Proposal;
    fn get_voting_power(self: @TContractState, voter: ContractAddress) -> VotingPower;
    fn get_total_voting_power(self: @TContractState) -> u256;
    fn check_proposal_eligibility(
        self: @TContractState, account: ContractAddress,
    ) -> ProposerRequirements;
    fn can_auto_execute(self: @TContractState, proposal_id: u256) -> bool;
    fn get_auto_execute_threshold(self: @TContractState) -> AutoExecuteThreshold;
}
