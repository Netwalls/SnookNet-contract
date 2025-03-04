#[derive(Copy, Drop, Serde, starknet::Store)]
struct PlayerStats {
    skill_level: u8,
    tokens_staked: u256,
    achievements: u256,
    nfts_owned: u256,
    games_played: u32,
    games_won: u32
}

#[derive(Copy, Drop, Serde, starknet::Store)]
enum FeatureType {
    Table,
    Cue,
    TimeWrap,
    TrophyRoom
} 