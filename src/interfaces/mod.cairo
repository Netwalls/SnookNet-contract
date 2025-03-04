pub mod snooknet;
pub mod dao;
pub mod player;
pub mod social;
pub mod ai;
pub mod ar;
pub mod erc20;
pub mod erc721;
pub mod gruft;

pub use snooknet::ISNOOKNET;
pub use dao::IDAO;
pub use player::IPlayer;
pub use social::ISocial;
pub use ai::IAI;
pub use ar::IAR;
pub use erc20::IERC20;
pub use erc721::IERC721;
pub use gruft::IGRUFT;

// Re-export common types
pub use snooknet::{GameState, ShotData, Position, RoomType, QueueType, QueueStatus, MatchConfig};
pub use dao::{Proposal, ChallengeData, VotingPower};
pub use player::{PlayerProfile, PlayerStats, PlayerAchievement, PlayerInventory};
pub use social::{Message, FriendRequest, SocialProfile, PrivacyLevel};
pub use ai::{AIConfig, AIGameState, AIStats};
pub use ar::{ARConfig, TrackingMode, ARFrame, CalibrationResult};
pub use gruft::{StakingPosition, RewardConfig, RewardInfo};
