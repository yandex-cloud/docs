The `loadtesting.editor` role enables managing agents, load tests and their settings, data stores, and regression dashboards. It also allows you to register agents created outside Load Testing.

Users with this role can:
* View info on load tests and [reports](../../load-testing/concepts/reports.md) on their run.
* Create, modify, delete, run and stop load tests and load [test data](../../load-testing/concepts/payload.md) into them.
* View info on load test configurations, as well as create, modify, and delete such configurations.
* View info on [agents](../../load-testing/concepts/agent.md) and create, modify, delete, run, restart, and stop them.
* Register external [agents](../../load-testing/concepts/agent.md) in Load Testing.
* View info on Yandex Object Storage [buckets](../../storage/concepts/bucket.md) used in load tests, upload test data to them, and create, modify, and delete buckets.
* View info on [regression dashboards](../../load-testing/concepts/load-test-regressions.md#dashbordy-regressij), as well as create, modify, and delete such dashboards.
* View information on the relevant [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

This role includes the `loadtesting.viewer`, `loadtesting.loadTester`, and `loadtesting.externalAgent` permissions.