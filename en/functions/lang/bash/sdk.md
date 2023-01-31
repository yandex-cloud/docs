# Using the SDK for Bash functions

The runtime environment has the [YC CLI](../../../cli/) installed by default to work with the {{ yandex-cloud }} API.

The user interacts with {{ yandex-cloud }} services using the [service account](../../operations/function-sa.md) specified in the Bash function. This doesn't require any additional actions from the user: the utility applies the service account automatically.

For example, you can get a list of available clouds using the following script:

```shell script
#!/bin/bash
set -e

HOME=/tmp yc --format json resource-manager cloud list | jq -c '{body:. | tostring}'
```

To work with {{ yandex-cloud }} compatible services, such as [Yandex Object Storage](../../../storage/) and [Yandex Message Queue](../../../message-queue/) the runtime environment comes pre-packaged with the [AWS CLI version 2](https://docs.aws.amazon.com/cli/index.html).

In this case, copy the [static access keys for the service account](../../../iam/operations/sa/create-access-key.md) and pass them, for example, using the function's [environment variables](../../concepts/runtime/environment-variables.md).

For more information and sample commands, see [AWS Command Line Interface](../../../storage/tools/aws-cli.md) and the [Yandex Message Queue](../../../message-queue/instruments/index.md) documentation.

