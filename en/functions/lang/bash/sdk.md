# Using the SDK

The runtime has the [YC CLI](../../../cli) utility installed by default to access the Yandex.Cloud API.

The user interacts with Yandex.Cloud services using the [service account](../../operations/function-sa.md) specified in the function. This doesn't require any additional actions from the user: the utility applies the service account automatically.

For example, you can get a list of available clouds using the following script:

```shell script
#!/bin/bash
set -e

HOME=/tmp yc --format json resource-manager cloud list | jq -c  '{body:. | tostring}'
```

In addition, to work with Yandex.Cloud compatible services, such as [Yandex Object Storage](../../../storage) and [Yandex Message Queue](../../../message-queue), the runtime environment has the [AWS CLI version 2](https://docs.aws.amazon.com/cli/index.html) utility pre-installed.

In this case, copy the [static access keys for the service account](../../../iam/operations/sa/create-access-key.md) and pass them, for example, using the function's [environment variables](../../concepts/runtime/environment-variables.md).

For more information and sample commands, see [AWS Command Line Interface](../../../storage/tools/aws-cli.md) and the [Yandex Message Queue](../../../message-queue/instruments/index.md) documentation.

