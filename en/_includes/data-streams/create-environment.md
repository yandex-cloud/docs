
1. Log in to the [management console]({{ link-console-main }}). If you do not yet have an account, go to the management console and follow the instructions.
1. On the [**Billing**]({{ link-console-billing }}) page, make sure you have a [billing account](../../billing/concepts/billing-account.md) linked and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you do not yet have a billing account, [create one](../../billing/quickstart/index.md#create_billing_account).
1. If you do not have any folder, [create one](../../resource-manager/operations/folder/create.md).
1. [Create](../../iam/operations/sa/create.md) a service account and [assign](../../iam/operations/sa/assign-role-for-sa.md) it the `editor` role for your folder.
1. [Create](../../iam/operations/sa/create-access-key.md) a static access key.
1. Set up the AWS CLI:
    1. Install the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html) and run the command:

        ```bash
        aws configure
        ```

    1. Enter the following one by one:

        * `AWS Access Key ID [None]:`: Service account [key ID](../../iam/concepts/authorization/access-key.md).
        * `AWS Secret Access Key [None]:`: [Secret access key](../../iam/concepts/authorization/access-key.md) of the service account.
        * `Default region name [None]:`: `{{ region-id }}` availability zone.
