
const hre = require("hardhat");

async function main() {
  const crowdFunding = await hre.ethers.deployContract("CrowdFunding")
  await crowdFunding.waitForDeployment();

  console.log(
    `Deployed to ${crowdFunding.target}`
  );
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

