# Using the SDK for Bash functions

The runtime environment has the [{{ yandex-cloud }} CLI](../../../cli/) installed by default to work with the {{ yandex-cloud }} API.

The user interacts with {{ yandex-cloud }} services using the [service account](../../operations/function-sa.md) specified in the Bash function. This does not require any additional actions from the user: the utility applies the service account automatically.

For example, you can get a list of cloud folders using the following script:

```shell script
#!/bin/bash
set -e

HOME=/tmp yc --format json resource-manager folder list --cloud-id <cloud_ID> | jq -c '{body:. | tostring}'
```

For the YC CLI commands to be executed successfully, use the `--folder-id` or `--cloud-id` flags to specify the [folder](../../../resource-manager/operations/folder/get-id.md) or [cloud](../../../resource-manager/operations/cloud/get-id.md) ID, respectively.
 
The runtime environment comes with pre-installed [AWS CLI version 2](https://docs.aws.amazon.com/cli/index.html) for support of {{ yandex-cloud }}-compatible services, such as [{{ objstorage-full-name }}](../../../storage/index.yaml) and [{{ message-queue-full-name }}](../../../message-queue/index.yaml).

In which case copy the [static access keys for the service account](../../../iam/operations/sa/create-access-key.md) and provide them, e.g., via the function's [environment variables](../../concepts/runtime/environment-variables.md).

For more information and sample commands, see [AWS Command Line Interface](../../../storage/tools/aws-cli.md) and the [{{ message-queue-full-name }}](../../../message-queue/instruments/index.md) documentation.



