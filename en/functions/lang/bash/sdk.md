# Using the SDK for Bash functions

The runtime environment comes with the [{{ yandex-cloud }} CLI](../../../cli/) utility installed by default to work with the {{ yandex-cloud }} API.

The user interacts with {{ yandex-cloud }} services using the [service account](../../operations/function-sa.md) specified in the Bash function. This does not require any additional actions from the user: the utility applies the service account automatically.

For example, you can get a list of cloud folders using the following script:

```shell script
#!/bin/bash
set -e

HOME=/tmp yc --format json resource-manager folder list --cloud-id <cloud_ID> | jq -c  '{body:. | tostring}'
```

For the {{ yandex-cloud }} CLI commands to be executed successfully, use the `--folder-id` or `--cloud-id` parameters to specify the [folder](../../../resource-manager/operations/folder/get-id.md) or [cloud](../../../resource-manager/operations/cloud/get-id.md) ID, respectively.
 
The runtime environment comes with pre-installed [AWS CLI version 2](https://docs.aws.amazon.com/cli/index.html) to support [{{ yandex-cloud }} services compatible with the AWS API](../../../iam/concepts/authorization/access-key.md#supported-services). To use it:
1. [Create](../../../iam/operations/authentication/manage-access-keys.md#create-access-key) a static access key for the service account.
1. [Save](../../../lockbox/operations/secret-create.md) the static access key to a {{ lockbox-full-name }} secret.
1. [Provide](../../operations/function/lockbox-secret-transmit.md) the {{ lockbox-full-name }} secret to a function.

For more information and examples of commands, see [AWS Command Line Interface](../../../storage/tools/aws-cli.md) and the relevant documentation of AWS-compatible {{ yandex-cloud }} services.
