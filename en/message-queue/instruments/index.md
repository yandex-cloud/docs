# Tools for working with {{ message-queue-full-name }}

To access the API, use any Amazon SQS compatible tools, such as AWS CLI, Boto3, or other [supported by SDK](https://aws.amazon.com/tools/#sdk).

## Getting started {#preparations}

1. [Create a service account](../../iam/operations/sa/create.md).
1. [Assign to the service account the roles](../../iam/operations/sa/assign-role-for-sa.md) required for your project. For more information about roles, see the [{{ iam-name }} documentation](../../iam/concepts/access-control/roles.md).
1. [Create a static access key](../../iam/operations/authentication/manage-access-keys.md#create-access-key).


Use the following parameters when configuring the tools:

* Static key ID for `AWS_ACCESS_KEY_ID`
* Secret key for `AWS_SECRET_ACCESS_KEY`
* `{{ region-id }}` for the region
* `https://message-queue.{{ api-host }}` for the endpoint

