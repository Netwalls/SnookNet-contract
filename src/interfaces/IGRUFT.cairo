use starknet::ContractAddress;
use super::IERC20::IERC20;

#[starknet::interface]
trait IGRUFT {
    // Inherit standard ERC20 functions
    fn name(self: @ContractState) -> felt252;
    fn symbol(self: @ContractState) -> felt252;
    fn decimals(self: @ContractState) -> u8;
    fn total_supply(self: @ContractState) -> u256;
    fn balance_of(self: @ContractState, account: ContractAddress) -> u256;
    fn allowance(self: @ContractState, owner: ContractAddress, spender: ContractAddress) -> u256;
    fn transfer(ref self: ContractState, recipient: ContractAddress, amount: u256) -> bool;
    fn transfer_from(
        ref self: ContractState, sender: ContractAddress, recipient: ContractAddress, amount: u256,
    ) -> bool;
    fn approve(ref self: ContractState, spender: ContractAddress, amount: u256) -> bool;

    // Game-specific functions

    // Staking functions
    fn stake_for_competition(ref self: ContractState, amount: u256, competition_id: u256) -> bool;
    fn unstake_from_competition(ref self: ContractState, competition_id: u256) -> u256;
    fn get_staked_amount(
        self: @ContractState, account: ContractAddress, competition_id: u256,
    ) -> u256;

    // Reward functions
    fn claim_game_rewards(ref self: ContractState, game_id: u256) -> u256;
    fn claim_achievement_rewards(ref self: ContractState, achievement_id: u256) -> u256;
    fn distribute_competition_rewards(
        ref self: ContractState, competition_id: u256, winners: Array<(ContractAddress, u256)>,
    );

    // Feature unlocking
    fn pay_for_feature(ref self: ContractState, feature_id: u256, price: u256) -> bool;
    fn get_feature_price(self: @ContractState, feature_id: u256) -> u256;

    // NFT related functions
    fn pay_for_nft_rental(
        ref self: ContractState, nft_id: u256, duration: u64, price: u256,
    ) -> bool;
    fn claim_rental_earnings(ref self: ContractState, nft_id: u256) -> u256;

    // DAO functions
    fn stake_for_voting(ref self: ContractState, amount: u256) -> bool;
    fn get_voting_power(self: @ContractState, account: ContractAddress) -> u256;
    fn unstake_voting_tokens(ref self: ContractState) -> u256;

    // Admin functions
    fn set_reward_rate(ref self: ContractState, reward_type: u8, rate: u256);
    fn pause_rewards(ref self: ContractState);
    fn unpause_rewards(ref self: ContractState);

    // View functions
    fn get_reward_rate(self: @ContractState, reward_type: u8) -> u256;
    fn is_rewards_paused(self: @ContractState) -> bool;
    fn get_total_staked(self: @ContractState) -> u256;
    fn get_total_staked_in_competition(self: @ContractState, competition_id: u256) -> u256;
}
