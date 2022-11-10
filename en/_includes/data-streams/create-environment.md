
1. Log in to [management console]({{link-console-main }}). If you haven't registered yet, go to the management console and follow the instructions.
{% if product == "yandex-cloud" %}
1. [On the billing page]({{ link-console-billing }}) make sure that you have a [billing account] connected (../../billing/concepts/billing-account.md) and it is in the status `ACTIVE` or `TRIAL_ACTIVE`. If there is no billing account, [create one](../../billing/quickstart/index.md#create_billing_account).
{% endif %}
1. If you don't have a folder yet, [create it](../../resource-manager/operations/folder/create.md).
1. [Create] (../../iam/operations/sa/create.md) a service account and [assign] (../../iam/operations/sa/assign-role-for-sa.md) to it the `editor` role for your directory.
1. [Create](../../iam/operations/sa/create-access-key.md) a static access key.
1. Configure the AWS CLI:
    1. Install [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html) and run the command:

        ```bash
        aws configure
        ```

    1. Enter sequentially:

        * `AWS Access Key ID [None]:`: service account [key ID](../../iam/concepts/authorization/access-key.md).
        * `AWS Secret Access Key [None]:`: service account [secret key](../../iam/concepts/authorization/access-key.md).
        * `Default region name [None]:`: availability zone `{{ region-id }}`.
