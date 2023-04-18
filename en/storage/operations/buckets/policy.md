# Managing bucket policies

[Bucket policies](../../concepts/policy.md) set permissions for bucket, object, and object group actions.

## Applying or editing a policy {#apply-policy}

The minimum role required to apply or modify an access policy is `storage.configurer`. See the [role description](../../../storage/security/#storage-configurer).

To apply or edit a bucket access policy:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you need to configure a bucket access policy.
   1. Select **{{ objstorage-name }}**.
   1. Select a bucket from the list.
   1. Click the **{{ ui-key.yacloud.storage.bucket.switch_policy }}** tab in the left-hand menu.
   1. Click ![pencil](../../../_assets/pencil.svg) **{{ ui-key.yacloud.storage.bucket.policy.button_policy-edit }}**.
   1. Enter a bucket policy ID.
   1. Set up a rule:
      1. Enter a rule ID.
      1. Configure rule settings:
         * **{{ ui-key.yacloud.storage.bucket.policy.field_effect }}**: Allow or forbid.
         * **{{ ui-key.yacloud.storage.bucket.policy.field_principal-type }}**: Include or exclude users.
         * **{{ ui-key.yacloud.storage.bucket.policy.field_user }}**: All users or specific users.
         * **{{ ui-key.yacloud.storage.bucket.policy.field_action }}** for which the rule is being created. You can also select the **All actions** option.
         * **{{ ui-key.yacloud.storage.bucket.policy.field_resource }}**: Selected bucket specified by default. To add other resources to the rule, click **{{ ui-key.yacloud.storage.bucket.policy.button_add-resource }}**.
      1. Add conditions to the rule as required:
         * Choose **{{ ui-key.yacloud.storage.bucket.policy.field_key }}** from the list.
         * Choose **{{ ui-key.yacloud.storage.bucket.policy.field_operator }}** from the list. For the operator to apply to the existing fields, select **{{ ui-key.yacloud.storage.bucket.policy.label_if-exists }}**. This way, if a field does not exist, the conditions will be considered satisfied.
         * Enter **{{ ui-key.yacloud.storage.bucket.policy.field_value }}**.
         * Click **{{ ui-key.yacloud.storage.bucket.policy.button_add-value }}** to add another value to a condition.
   1. Add and configure rules as required.
   1. Click **{{ ui-key.yacloud.storage.permissions-dialog.button_save }}**.

- {{ yandex-cloud }} CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to edit a bucket ACL:

      ```bash
      yc storage bucket update --help
      ```

   1. Describe your access policy configuration as a [data schema](../../s3/api-ref/policy/scheme.md) in JSON format:

      ```json
      {
        "Version": "2012-10-17",
        "Statement": {
          "Effect": "Allow",
          "Principal": "*",
          "Action": "s3:GetObject",
          "Resource": "arn:aws:s3:::<bucket name>/*",
          "Condition": {
            "Bool": {
              "aws:SecureTransport": "true"
            }
          }
        }
      }
      ```

   1. Run the following command:

      ```bash
      yc storage bucket update <bucket_name> --policy-from-file <policy_file_path>
      ```
      Result:

      ```bash
      name: my-bucket
      folder_id: csgeoelk7fl15s6dsvbo
      default_storage_class: STANDARD
      versioning: VERSIONING_SUSPENDED
      max_size: "10737418240"
      policy:
          Statement:
            Action: s3:GetObject
            Condition:
              Bool:
                aws:SecureTransport: "true"
              Effect: Allow
              Principal: '*'
              Resource: arn:aws:s3:::my-bucket
            Version: "2012-10-17"
      acl: {}
      created_at: "2022-12-14T08:42:16.273717Z"
      ```

- AWS CLI

   {% note info %}

   To manage a policy using the AWS CLI, a service account must have the `storage.admin` role assigned to it.

   {% endnote %}

   If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).

   1. Describe your access policy configuration as a [data schema](../../s3/api-ref/policy/scheme.md) in JSON format:

      ```json
      {
        "Version": "2012-10-17",
        "Statement": {
          "Effect": "Allow",
          "Principal": "*",
          "Action": "s3:GetObject",
          "Resource": "arn:aws:s3:::<bucket name>/*",
          "Condition": {
            "Bool": {
              "aws:SecureTransport": "true"
            }
          }
        }
      }
      ```

      Once completed, save the configuration to a file named `policy.json`.
   1. Run the following command:

      ```bash
      aws --endpoint https://{{ s3-storage-host }} s3api put-bucket-policy \
        --bucket <bucket name> \
        --policy file://policy.json
      ```

   If a previous access policy already exists for a bucket, it will be completely overwritten once you apply the new policy.

- {{ TF }}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   Retrieve [static access keys](../../../iam/operations/sa/create-access-key.md): a static key and a key ID used to authenticate in {{ objstorage-name }}.
   1. In the configuration file, describe the parameters of the resources you want to create:

      ```hcl
      resource "yandex_storage_bucket" "b" {
        bucket = "my-policy-bucket"
        policy = <<POLICY
       {
        "Version": "2012-10-17",
        "Statement": [
          {
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:*",
            "Resource": [
              "arn:aws:s3:::my-policy-bucket/*",
              "arn:aws:s3:::my-policy-bucket"
            ]
          },
          {
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:PutObject",
            "Resource": [
              "arn:aws:s3:::my-policy-bucket/*",
              "arn:aws:s3:::my-policy-bucket"
            ]
          }
        ]
      }
      POLICY
      }
      ```

      Where:
      * `access_key`: ID of the static access key.
      * `secret_key`: Value of the secret access key.
      * `bucket`: Bucket name. This parameter is required.
      * `policy`: Policy name. This parameter is required.

      For more information on resources that you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).
   1. Make sure the configuration files are valid.
      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using this command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.
   1. Deploy cloud resources.
      1. If the configuration does not contain any errors, run this command:

         ```bash
         terraform apply
         ```

      1. Confirm that you want to create the resources.

      Once you are done, all the resources you need will be created in the specified folder. You can check that the resources are there and their settings are correct using the [management console]({{ link-console-main }}).

- API

   Use the [PutBucketPolicy](../../s3/api-ref/policy/put.md). If a previous access policy already exists for a bucket, it will be completely overwritten once you apply the new policy.

{% endlist %}

## Viewing a policy {#view-policy}

The minimum role required to view an access policy is `storage.configViewer`. See the [role description](../../../storage/security/#storage-config-viewer).

To view the access policy applied to a bucket:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you need to view a bucket access policy.
   1. Select **{{ objstorage-name }}**.
   1. Select a bucket from the list.
   1. Click the **{{ ui-key.yacloud.storage.bucket.switch_policy }}** tab in the left-hand menu.

- AWS CLI

   Run the following command:

   ```bash
   aws --endpoint https://{{ s3-storage-host }} s3api get-bucket-policy \
     --bucket <bucket name> \
     --output text
   ```

   Result:

   ```json
   {
     "Policy": "{\"Version\":\"2012-10-17\",\"Statement\":{\"Effect\":\"Allow\",\"Principal\":\"*\",\"Action\":\"s3:GetObject\",\"Resource\":\"arn:aws:s3:::<bucket name>/*\",\"Condition\":{\"Bool\":{\"aws:SecureTransport\":\"true\"}}}}"
   }
   ```

   For more information about parameters, see the [data schema](../../s3/api-ref/policy/scheme.md) description.

- API

   Use the [GetBucketPolicy](../../s3/api-ref/policy/get.md).

{% endlist %}

## Deleting a policy {#delete-policy}

The minimum role required to delete an access policy is `storage.configurer`. See the [role description](../../../storage/security/#storage-configurer).

To delete a bucket policy:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you need to configure a bucket access policy.
   1. Select **{{ objstorage-name }}**.
   1. Select a bucket from the list.
   1. Click the **{{ ui-key.yacloud.storage.bucket.switch_policy }}** tab in the left-hand menu.
   1. Click ![options](../../../_assets/horizontal-ellipsis.svg) and select **{{ ui-key.yacloud.storage.bucket.policy.button_policy-delete }}**.
   1. Click **{{ ui-key.yacloud.storage.bucket.button_action-delete }}**.

- AWS CLI

   Run the following command:

   ```bash
   aws --endpoint https://{{ s3-storage-host }} s3api delete-bucket-policy \
     --bucket <bucket name>
   ```

- {{ TF }}

   Learn more about {{ TF }} in the [documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   If you applied a bucket policy using {{ TF }}, you can delete it:
   1. Find the parameters of the previously created bucket policy to delete in the configuration file:

      ```hcl
      resource "yandex_storage_bucket" "b" {
        bucket = "my-policy-bucket"
        policy = <<POLICY
       {
        "Version": "2012-10-17",
        "Statement": [
          {
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:*",
            "Resource": [
              "arn:aws:s3:::my-policy-bucket/*",
              "arn:aws:s3:::my-policy-bucket"
            ]
          },
          {
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:PutObject",
            "Resource": [
              "arn:aws:s3:::my-policy-bucket/*",
              "arn:aws:s3:::my-policy-bucket"
            ]
          }
        ]
      }
      POLICY
      }
      ```

   1. Delete the `policy` field describing the bucket policy settings from the configuration file.
   1. Make sure the configuration files are valid.
      1. In the command line, change to the folder where you edited the configuration file.
      1. Run the check using this command:

         ```bash
         terraform plan
         ```

      If the configuration is described properly, the terminal will display a list of the resources being created and their parameters without the bucket policy being deleted. If the configuration contains any errors, {{ TF }} will point them out.
   1. Delete the bucket policy.
      1. If the configuration does not contain any errors, run this command:

         ```bash
         terraform apply
         ```

      1. Type `yes` and press **Enter**.

      Afterwards, the bucket policy will be deleted from the specified folder. You can verify that the bucket policy is no longer there in the [management console]({{ link-console-main }}).

- API

   Use the [DeleteBucketPolicy](../../s3/api-ref/policy/delete.md).

{% endlist %}
