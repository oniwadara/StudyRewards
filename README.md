# StudyRewards

StudyRewards is a blockchain-based educational achievement system built on the Stacks blockchain that tracks learning progress and distributes rewards to incentivize consistent study habits.

## Features

- **Progress Tracking**: Record and verify study sessions on the blockchain
- **Proportional Rewards**: Earn rewards based on your contribution to the overall knowledge pool
- **Transparent Distribution**: Fair and transparent bonus allocation for educational achievements
- **Immutable Records**: Blockchain-based records ensure academic integrity

## Smart Contract Functions

### Administration
- `launch-program`: Set up the StudyRewards system with an education coordinator
- `distribute-learning-bonuses`: Calculate and distribute bonus points based on time elapsed

### Student Functions
- `record-study-sessions`: Record new study sessions and add them to your total progress
- `claim-achievements`: Claim your accumulated progress and proportional bonuses

## Getting Started

1. Clone this repository
2. Install [Clarinet](https://github.com/hirosystems/clarinet) for local development
3. Run `clarinet check` to verify the contract
4. Deploy using Clarinet or the Stacks CLI

## For Students

Students can record their study sessions and claim rewards proportional to their contribution to the overall learning community.

## For Educational Institutions

Educational institutions can use this system to incentivize consistent study habits and create a competitive yet supportive learning environment.

## Technical Details

- Study sessions are tracked per student address
- Bonuses accumulate over time based on block height
- Rewards are distributed proportionally based on contribution to the knowledge pool
- All transactions are recorded on the Stacks blockchain for transparency