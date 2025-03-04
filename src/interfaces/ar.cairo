use core::starknet::ContractAddress;
use super::snooknet::{Position, ShotData};

// AR Types
#[derive(Drop, Serde)]
pub struct ARConfig {
    calibration_data: Array<u16>,
    tracking_mode: TrackingMode,
    latency_threshold: u16,
    accuracy_threshold: u16,
}

#[derive(Drop, Serde, Copy, starknet::Store)]
pub enum TrackingMode {
    TableOnly,
    BallsOnly,
    FullTracking,
    Debug,
}

#[derive(Drop, Serde)]
pub struct ARFrame {
    timestamp: u64,
    ball_positions: Array<(u8, Position)>,
    cue_position: Position,
    table_corners: Array<Position>,
    confidence: u16,
}

#[derive(Drop, Serde)]
pub struct CalibrationResult {
    success: bool,
    error_margin: u16,
    suggested_adjustments: Array<u16>,
}

// AR Interface
#[starknet::interface]
pub trait IAR<TContractState> {
    // Configuration
    fn get_config(self: @TContractState) -> ARConfig;
    fn update_config(ref self: TContractState, config: ARConfig);
    fn calibrate_system(ref self: TContractState) -> CalibrationResult;

    // Real-time Tracking
    fn process_frame(ref self: TContractState, frame_data: ARFrame) -> bool;
    fn get_current_state(self: @TContractState) -> ARFrame;
    fn validate_shot_tracking(self: @TContractState, shot: ShotData) -> bool;

    // Diagnostics
    fn get_tracking_quality(self: @TContractState) -> u16;
    fn get_system_latency(self: @TContractState) -> u16;
    fn get_error_log(self: @TContractState) -> Array<felt252>;

    // Maintenance
    fn reset_tracking(ref self: TContractState);
    fn update_calibration(ref self: TContractState, calibration_data: Array<u16>);
    fn set_tracking_mode(ref self: TContractState, mode: TrackingMode);
}
