use super::super::types::game::{Position, ShotData};
use array::Array;

#[starknet::interface]
trait IPhysics {
    // Ball Physics
    fn calculate_ball_trajectory(
        self: @ContractState, initial_position: Position, shot_data: ShotData,
    ) -> Array<Position>;

    fn calculate_collision(
        self: @ContractState,
        ball1_pos: Position,
        ball1_velocity: (u16, u16, u16),
        ball2_pos: Position,
    ) -> ((u16, u16, u16), (u16, u16, u16));

    // Table Physics
    fn check_cushion_collision(
        self: @ContractState, ball_pos: Position, velocity: (u16, u16, u16),
    ) -> (bool, (u16, u16, u16));

    fn check_pocket_entry(
        self: @ContractState, ball_pos: Position, velocity: (u16, u16, u16),
    ) -> bool;

    // Spin Effects
    fn apply_spin_effect(
        ref self: ContractState,
        velocity: (u16, u16, u16),
        spin_data: (u8, u8, u8) // (top/bottom, left/right, side)
    ) -> (u16, u16, u16);

    fn calculate_cue_deflection(self: @ContractState, shot_data: ShotData) -> u16;

    // Environmental Effects
    fn apply_friction(
        ref self: ContractState, velocity: (u16, u16, u16), surface_type: u8,
    ) -> (u16, u16, u16);

    fn apply_temperature_effect(
        ref self: ContractState, cushion_bounce: u16, temperature: u8,
    ) -> u16;
}
