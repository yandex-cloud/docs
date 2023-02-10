# Preparing the environment for {{ yds-name }}

1. Log in to [management console]({{ link-console-main }}). If you aren't registered, go to the management console and follow the instructions.
{% if product == "yandex-cloud" %}
1. [On the billing page]({{ link-console-billing }}) make sure that you have enabled a [billing account](../../billing/concepts/billing-account.md) and that it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you don't have a billing account, [create one](../../billing/quickstart/index.md#create_billing_account).
{% endif %}
1. If you don't have a folder, [create one](../../resource-manager/operations/folder/create.md).
1. [Create](../../iam/operations/sa/create.md) a service account and [assign](../../iam/operations/sa/assign-role-for-sa.md) it the `editor` role for your folder.
1. [Create](../../iam/operations/sa/create-access-key.md) a static access key.
1. Set up the AWS CLI:
   1. Install the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html) and run the command:

      ```bash
      aws configure
      ```

   1. Enter the following one by one:

        * `AWS Access Key ID [None]:`: The [ID of the key](../../iam/concepts/authorization/access-key.md) of the service account.
        * `AWS Secret Access Key [None]:`: The [secret key](../../iam/concepts/authorization/access-key.md) of the service account.
        * `Default region name [None]:`: The `{{ region-id }}` availability zone.
