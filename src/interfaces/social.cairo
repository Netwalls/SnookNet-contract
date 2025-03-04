use core::starknet::ContractAddress;

// Social Types
#[derive(Drop, Serde, Copy)]
pub struct Message {
    sender: ContractAddress,
    receiver: ContractAddress,
    content: felt252,
    timestamp: u64,
    read: bool,
}

#[derive(Drop, Serde, Copy)]
pub struct FriendRequest {
    from: ContractAddress,
    to: ContractAddress,
    message: felt252,
    timestamp: u64,
}

#[derive(Drop, Serde)]
pub struct SocialProfile {
    friends: Array<ContractAddress>,
    blocked: Array<ContractAddress>,
    status: felt252,
    last_online: u64,
}

#[derive(Drop, Serde, Copy)]
pub enum PrivacyLevel {
    Public,
    FriendsOnly,
    Private,
}

// Social Interface
#[starknet::interface]
pub trait ISocial<TContractState> {
    // Friend Management
    fn add_friend(ref self: TContractState, friend: ContractAddress);
    fn remove_friend(ref self: TContractState, friend: ContractAddress);
    fn get_friends(self: @TContractState) -> Array<ContractAddress>;
    fn block_player(ref self: TContractState, player: ContractAddress);

    // Messaging
    fn send_message(ref self: TContractState, to: ContractAddress, message: felt252);
    fn get_messages(self: @TContractState, with: ContractAddress) -> Array<Message>;
    fn mark_as_read(ref self: TContractState, message_ids: Array<u256>);

    // Social Profile
    fn get_social_profile(self: @TContractState, player: ContractAddress) -> SocialProfile;
    fn update_status(ref self: TContractState, status: felt252);
    fn set_privacy_level(ref self: TContractState, level: PrivacyLevel);

    // Friend Requests
    fn send_friend_request(ref self: TContractState, to: ContractAddress, message: felt252);
    fn accept_friend_request(ref self: TContractState, from: ContractAddress);
    fn reject_friend_request(ref self: TContractState, from: ContractAddress);
    fn get_pending_requests(self: @TContractState) -> Array<FriendRequest>;

    fn set_room_visibility(ref self: TContractState, room_id: u256, is_public: bool);
}
