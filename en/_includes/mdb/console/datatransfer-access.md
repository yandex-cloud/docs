**Access from {{ data-transfer-name }}**: Enable this option to allow access to the cluster from [{{ data-transfer-full-name }}](../../../data-transfer/index.yaml) in Serverless mode.

This will enable you to connect to {{ data-transfer-full-name }} running in {{ k8s }} via a special network. It will also cause other operations to run faster, such as transfer launch and deactivation.
