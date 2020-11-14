---
content_title: Securing your contract
---

These are basic recommendations that should be the foundation of securing your smart contract:

1. The master git branch has the `has_auth`, `require_auth`, `require_auth2` and `require_recipient` methods available in the LeoPays library.

2. Understand how each of your contracts' actions is impacting the RAM, CPU, and NET consumption, and which account ends up paying for these resources.

3. Have a solid and comprehensive development process that includes security considerations from day one of the product planning and development.

4. Test your smart contracts with every update announced for the blockchain you have deployed to. To ease your work, automate the testing as much as possible so you can run them often, and improve them periodically.

5. Conduct independent smart contract audits, at least two from different organizations.

6. Host periodic bug bounties on your smart contracts and keep a continuous commitment to reward real security problems reported at any time.