#[cfg(test)]
mod tests {
    use core::traits::Into;
    use snforge_std::{declare, ContractClassTrait, start_prank, stop_prank};
    use super::super::contracts::snooknet::SnookNet;
    use super::super::types::game::{GameState, ShotData, Position, RoomType};
    use starknet::{ContractAddress, contract_address_const};

    #[test]
    fn test_create_game_room() {
        // Deploy contract
        let contract = declare('SnookNet');
        let contract_address = contract.deploy(@ArrayTrait::new()).unwrap();

        // Create a game room
        let room_type = RoomType::Standard;
        let entry_fee = 1000;

        // Call the contract
        let room_id = SnookNet::create_game_room(contract_address, room_type, entry_fee);

        // Assert
        assert(room_id == 1, 'Invalid room ID');
    }

    #[test]
    fn test_start_practice_mode() {
        // Deploy contract
        let contract = declare('SnookNet');
        let contract_address = contract.deploy(@ArrayTrait::new()).unwrap();

        // Start practice mode
        let game_id = SnookNet::start_practice_mode(contract_address);

        // Assert
        assert(game_id == 1, 'Invalid game ID');
    }
}
