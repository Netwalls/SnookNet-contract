use super::super::types::dao::{Proposal, ChallengeData};

#[starknet::interface]
trait IDAO {
    fn propose_rule_change(ref self: ContractState, proposal: Proposal);
    fn vote(ref self: ContractState, proposal_id: u256, support: bool);
    fn execute_proposal(ref self: ContractState, proposal_id: u256);
    fn create_custom_challenge(ref self: ContractState, challenge_data: ChallengeData) -> u256;
} 