
# chmod -R 0755 ./crypto-config
# # Delete existing artifacts
# rm -rf ./crypto-config
# rm genesis.block mlchannel.tx
# rm -rf ./channel-artifacts/*

#Generate Crypto artifactes for organizations
cryptogen generate --config=./crypto-config.yaml --output=./crypto-config/



# System channel
SYS_CHANNEL="sys-channel"

# channel name defaults to "meatledger"
CHANNEL_NAME="meatledger"

echo $CHANNEL_NAME

# Generate System Genesis block
configtxgen -profile OrdererGenesis -configPath . -channelID $SYS_CHANNEL  -outputBlock ./channel-artifacts/genesis.block


# Generate channel configuration block
configtxgen -profile MLChannel -configPath . -outputCreateChannelTx ./channel-artifacts/meatledger.tx -channelID $CHANNEL_NAME

echo "#######    Generating anchor peer update for HerdsmanMSP  ##########"
configtxgen -profile MLChannel -configPath . -outputAnchorPeersUpdate ./channel-artifacts/HerdsmanMSPanchors.tx -channelID $CHANNEL_NAME -asOrg HerdsmanMSP

echo "#######    Generating anchor peer update for SlaughterMSP  ##########"
configtxgen -profile MLChannel -configPath . -outputAnchorPeersUpdate ./channel-artifacts/SlaughterMSPanchors.tx -channelID $CHANNEL_NAME -asOrg SlaughterMSP

echo "#######    Generating anchor peer update for RetailerMSP  ##########"
configtxgen -profile MLChannel -configPath . -outputAnchorPeersUpdate ./channel-artifacts/RetailerMSPanchors.tx -channelID $CHANNEL_NAME -asOrg RetailerMSP