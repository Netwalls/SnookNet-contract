#[starknet::contract]
mod GRUFT {
    use core::starknet::ContractAddress;
    use core::array::Array;
    use core::num::traits::Zero;
    use crate::interfaces::gruft::{IGRUFT, StakingPosition, RewardConfig, RewardInfo};
    use crate::interfaces::erc20::{IERC20};
    use starknet::storage::{
        Map, StorageMapReadAccess, StorageMapWriteAccess, StoragePointerReadAccess,
        StoragePointerWriteAccess,
    };

    const DECIMAL_PLACES: u8 = 18;
    const INITIAL_SUPPLY: u256 = 1000000000000000000000000; // 1 million tokens

    #[storage]
    struct Storage {
        // ERC20 state
        name: felt252,
        symbol: felt252,
        total_supply: u256,
        balances: Map::<ContractAddress, u256>,
        allowances: Map::<(ContractAddress, ContractAddress), u256>,
        // Game-specific state
        staked_amounts: Map::<(ContractAddress, u256), u256>, // (player, competition_id) -> amount
        voting_power: Map::<ContractAddress, u256>,
        reward_rates: Map::<u8, u256>,
        rewards_paused: bool,
    }

    #[constructor]
    fn constructor(ref self: ContractState) {
        self.name.write('GRUFT Token');
        self.symbol.write('GRUFT');
        self.total_supply.write(INITIAL_SUPPLY);
        // Mint initial supply to contract deployer
        let deployer = starknet::get_caller_address();
        self.balances.write(deployer, INITIAL_SUPPLY);
    }

    #[abi(embed_v0)]
    impl IERC20Impl of IERC20<ContractState> {
        fn name(self: @ContractState) -> felt252 {
            self.name.read()
        }

        fn symbol(self: @ContractState) -> felt252 {
            self.symbol.read()
        }

        fn decimals(self: @ContractState) -> u8 {
            DECIMAL_PLACES
        }

        fn total_supply(self: @ContractState) -> u256 {
            self.total_supply.read()
        }

        fn balance_of(self: @ContractState, account: ContractAddress) -> u256 {
            self.balances.read(account)
        }

        fn allowance(
            self: @ContractState, owner: ContractAddress, spender: ContractAddress,
        ) -> u256 {
            self.allowances.read((owner, spender))
        }

        fn transfer(ref self: ContractState, recipient: ContractAddress, amount: u256) -> bool {
            let sender = starknet::get_caller_address();
            self.transfer_helper(sender, recipient, amount);
            true
        }

        fn transfer_from(
            ref self: ContractState,
            sender: ContractAddress,
            recipient: ContractAddress,
            amount: u256,
        ) -> bool {
            let caller = starknet::get_caller_address();
            assert(
                self.allowances.read((sender, caller)) >= amount, 'ERC20: insufficient allowance',
            );
            self.transfer_helper(sender, recipient, amount);
            self
                .allowances
                .write((sender, caller), self.allowances.read((sender, caller)) - amount);
            true
        }

        fn approve(ref self: ContractState, spender: ContractAddress, amount: u256) -> bool {
            let owner = starknet::get_caller_address();
            self.allowances.write((owner, spender), amount);
            true
        }
    }

    #[abi(embed_v0)]
    impl GRUFTImpl of IGRUFT<ContractState> {
        fn stake(ref self: ContractState, amount: u256, lock_duration: u64) {// TODO: Implement
        }

        fn unstake(ref self: ContractState, position_id: u256) {// TODO: Implement
        }

        fn get_staking_position(self: @ContractState, position_id: u256) -> StakingPosition {
            // TODO: Implement
            StakingPosition { amount: 0, lock_duration: 0, start_time: 0, multiplier: 0 }
        }

        fn get_all_positions(
            self: @ContractState, account: ContractAddress,
        ) -> Array<StakingPosition> {
            // TODO: Implement
            ArrayTrait::new()
        }

        fn get_pending_rewards(self: @ContractState, account: ContractAddress) -> u256 {
            // TODO: Implement
            0
        }

        fn claim_rewards(ref self: ContractState) {// TODO: Implement
        }

        fn get_reward_info(self: @ContractState, account: ContractAddress) -> RewardInfo {
            // TODO: Implement
            RewardInfo { pending: 0, claimed: 0, last_claim: 0 }
        }

        fn get_reward_config(self: @ContractState) -> RewardConfig {
            // TODO: Implement
            RewardConfig { base_rate: 0, bonus_multiplier: 0, minimum_lock: 0, maximum_lock: 0 }
        }

        fn calculate_apy(self: @ContractState, amount: u256, lock_duration: u64) -> u16 {
            // TODO: Implement
            0
        }

        fn get_voting_power(self: @ContractState, account: ContractAddress) -> u256 {
            // TODO: Implement
            0
        }

        fn delegate_voting_power(ref self: ContractState, delegatee: ContractAddress) {// TODO: Implement
        }

        fn get_delegated_power(self: @ContractState, account: ContractAddress) -> u256 {
            // TODO: Implement
            0
        }
    }

    // Internal functions
    #[generate_trait]
    impl InternalFunctions of InternalFunctionsTrait {
        fn transfer_helper(
            ref self: ContractState,
            sender: ContractAddress,
            recipient: ContractAddress,
            amount: u256,
        ) {
            assert(recipient.is_non_zero(), 'ERC20: transfer to zero');
            assert(self.balances.read(sender) >= amount, 'ERC20: insufficient balance');

            self.balances.write(sender, self.balances.read(sender) - amount);
            self.balances.write(recipient, self.balances.read(recipient) + amount);
        }

        fn calculate_rewards(
            self: @ContractState, player: ContractAddress, activity_type: u8,
        ) -> u256 {
            // TODO: Implement reward calculation
            // - Consider stake amount
            // - Apply reward rate
            // - Include any bonuses
            0
        }
    }
}
