`--datatransfer-access`: Allows access to the cluster from [{{ data-transfer-full-name }}](../../../data-transfer/) in serverless mode: `true` or `false`. The default value is `false`.

This will enable you to connect to {{ data-transfer-full-name }} running in {{ k8s }} via a special network. As a result, other operations, e.g., transfer launch and deactivation, will run faster.
