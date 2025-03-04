use core::starknet::ContractAddress;

// GRUFT Types
#[derive(Drop, Serde, Copy)]
pub struct StakingPosition {
    pub amount: u256,
    pub lock_duration: u64,
    pub start_time: u64,
    pub multiplier: u16,
}

#[derive(Drop, Serde, Copy)]
pub struct RewardConfig {
    pub base_rate: u16,
    pub bonus_multiplier: u16,
    pub minimum_lock: u64,
    pub maximum_lock: u64,
}

#[derive(Drop, Serde, Copy)]
pub struct RewardInfo {
    pub pending: u256,
    pub claimed: u256,
    pub last_claim: u64,
}

// GRUFT Token Interface (extends ERC20)
#[starknet::interface]
pub trait IGRUFT<TContractState> {
    // Staking
    fn stake(ref self: TContractState, amount: u256, lock_duration: u64);
    fn unstake(ref self: TContractState, position_id: u256);
    fn get_staking_position(self: @TContractState, position_id: u256) -> StakingPosition;
    fn get_all_positions(self: @TContractState, account: ContractAddress) -> Array<StakingPosition>;

    // Rewards
    fn get_pending_rewards(self: @TContractState, account: ContractAddress) -> u256;
    fn claim_rewards(ref self: TContractState);
    fn get_reward_info(self: @TContractState, account: ContractAddress) -> RewardInfo;

    // Configuration
    fn get_reward_config(self: @TContractState) -> RewardConfig;
    fn calculate_apy(self: @TContractState, amount: u256, lock_duration: u64) -> u16;

    // Governance
    fn get_voting_power(self: @TContractState, account: ContractAddress) -> u256;
    fn delegate_voting_power(ref self: TContractState, delegatee: ContractAddress);
    fn get_delegated_power(self: @TContractState, account: ContractAddress) -> u256;
}
