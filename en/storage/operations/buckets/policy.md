# Managing bucket policies

[Bucket policies](../../concepts/policy.md) set permissions for bucket, object, and object group actions.

## Applying or editing a policy {#apply-policy}

To apply or edit a bucket access policy:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you need to configure a bucket access policy.
   1. Select **{{ objstorage-name }}**.
   1. Select a bucket from the list.
   1. Click the **Access policy** tab in the menu on the left.
   1. Click ![pencil](../../../_assets/pencil.svg) **Configure access**.
   1. Enter a bucket policy ID.
   1. Set up a rule:
      1. Enter a rule ID.
      1. Configure rule settings:
         * **Result**: Allow or forbid.
         * **Selection principle**: Include or exclude users.
         * **User**: All users or a set of specific users.
         * **Action** for which the rule is being created. You can also select the **All actions** option.
         * **Resource**: Selected bucket specified by default. To add other resources to the rule, click **Add resource**.
      1. Add conditions to the rule as required:
         * Select a **Key** from the list.
         * Select an **Operator** from the list. For the operator to apply to the existing fields, select **Apply if field exists**. This way, if a field does not exist, the conditions will be considered satisfied.
         * Enter a **Value**.
         * Click **Add value** to add another value to a condition.
   1. Add and configure rules as required.
   1. Click **Save**.

- AWS CLI

   {% note info %}

   To manage a policy using the AWS CLI, a service account must have the `storage.admin` role assigned to it.

   {% endnote %}

   To apply or edit a policy using the [AWS CLI](../../tools/aws-cli.md):

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

   1. Run the command:

      ```bash
      aws --endpoint https://{{ s3-storage-host }} s3api put-bucket-policy \
        --bucket <bucket name> \
        --policy file://policy.json
      ```

   If a previous access policy already exists for a bucket, it will be completely overwritten once you apply the new policy.

- {{ TF }}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   Retrieve {% if audience != "internal" %}[static access keys](../../../iam/operations/sa/create-access-key.md){% else %}static access keys{% endif %}: a static key and a key ID used to authenticate in {{ objstorage-short-name }}.

   1. In the configuration file, describe the parameters of resources that you want to create:

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

      * `access_key`: The ID of the static access key.
      * `secret_key`: The value of the secret access key.
      * `bucket`: Bucket name. Required parameter.
      * `policy`: Policy name. Required parameter.

      For more information about the resources you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-link }}).

   1. Make sure that the configuration files are correct.
      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using the command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, {{ TF }} points them out.

   1. Deploy the cloud resources.
      1. If the configuration doesn't contain any errors, run the command:

         ```bash
         terraform apply
         ```

      1. Confirm that you want to create the resources.

      Afterwards, all the necessary resources are created in the specified folder. You can check that the resources are there with the correct settings using the [management console]({{ link-console-main }}).

- API

   Use the [PutBucketPolicy](../../s3/api-ref/policy/put.md). If a previous access policy already exists for a bucket, it will be completely overwritten once you apply the new policy.

{% endlist %}

## Viewing a policy {#view-policy}

To view the access policy applied to a bucket:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you need to view a bucket access policy.
   1. Select **{{ objstorage-name }}**.
   1. Select a bucket from the list.
   1. Click the **Access policy** tab in the menu on the left.

- AWS CLI

   Run the command:

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

To delete a bucket policy:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you need to configure a bucket access policy.
   1. Select **{{ objstorage-name }}**.
   1. Select a bucket from the list.
   1. Click the **Access policy** tab in the menu on the left.
   1. Click ![options](../../../_assets/horizontal-ellipsis.svg) and select **Delete access policy**.
   1. Click **Delete**.

- AWS CLI

   Run the command:

   ```bash
   aws --endpoint https://{{ s3-storage-host }} s3api delete-bucket-policy \
     --bucket <bucket name>
   ```

- {{ TF }}

   {% if audience != "internal" %}For more information about {{ TF }}, see the [documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).{% endif %}

   If you modified a bucket policy using {{ TF }}, you can delete it:

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

   1. Make sure that the configuration files are correct.
      1. In the command line, change to the folder where you edited the configuration file.
      1. Run the check using the command:

         ```bash
         terraform plan
         ```

      If the configuration is described properly, the terminal will display a list of the resources being created and their parameters without the bucket policy being deleted. If there are errors in the configuration, {{ TF }} points them out.

   1. Delete the bucket policy.
      1. If the configuration doesn't contain any errors, run the command:

         ```bash
         terraform apply
         ```

      1. Confirm bucket policy deletion.

      Afterwards, the bucket policy will be deleted from the specified folder. You can verify that the bucket policy is no longer there in the [management console]({{ link-console-main }}).

- API

   Use the [DeleteBucketPolicy](../../s3/api-ref/policy/delete.md).

{% endlist %}