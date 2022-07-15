To allow access to the cluster from [{{ data-transfer-full-name }}](../../../data-transfer/index.yaml) in Serverless mode, pass `true` for the `configSpec.access.dataTransfer` parameter.

This will enable you to connect to {{ data-transfer-full-name }} running in {{ k8s }} via a special network. It will also cause other operations to run faster, such as transfer launch and deactivation.
