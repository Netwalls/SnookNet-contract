use starknet::ContractAddress;

#[derive(Copy, Drop, Serde, starknet::Store)]
struct Position {
    x: u16,
    y: u16,
    z: u16
}

#[derive(Copy, Drop, Serde, starknet::Store)]
struct GameState {
    current_player: ContractAddress,
    score: (u16, u16),
    balls_remaining: u8,
    current_break: u16,
    status: GameStatus
}

#[derive(Copy, Drop, Serde, starknet::Store)]
enum GameStatus {
    Waiting,
    InProgress,
    Completed,
    Abandoned
}

#[derive(Copy, Drop, Serde, starknet::Store)]
enum RoomType {
    Standard,
    Tournament,
    Practice,
    AIChallenge
}

#[derive(Copy, Drop, Serde, starknet::Store)]
struct ShotData {
    force: u8,
    angle: u16,
    spin: u8,
    cue_position: Position
} 