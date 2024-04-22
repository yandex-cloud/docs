The `loadtesting.externalAgent` role enables registering external agents in Load Testing, as well as creating, modifying, and running load tests using an agent.

Users with this role can:
* Register external [agents](../../load-testing/concepts/agent.md) in Load Testing.
* Create, edit, and run load tests.
* Create and edit load test configurations.
* Upload the test [result](../../load-testing/concepts/load-test-results.md) data to the storage.

This role also includes the `loadtesting.generatorClient` permissions.

Assign this role to the [service account](../../iam/concepts/users/service-accounts.md) under which you create a VM with an agent.