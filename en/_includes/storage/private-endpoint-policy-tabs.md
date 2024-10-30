{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you configured the {{ vpc-short-name }} service connection.
  1. Select **{{ objstorage-name }}**.
  1. Select a bucket from the list.
  1. Go to the ![image](../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud.storage.bucket.switch_security }}** tab in the left-hand menu.
  1. At the top of the screen, go to the **{{ ui-key.yacloud.storage.bucket.switch_policy }}** tab.
  1. Click **{{ ui-key.yacloud.storage.bucket.policy.button_policy-edit }}**.
  1. Enter a bucket policy ID, e.g., `private-endpoint-policy`.
  1. Set up a rule:

      1. Enter a rule ID, e.g., `private-endpoint-rule`.
      1. Configure rule settings:
          * **{{ ui-key.yacloud.storage.bucket.policy.field_effect }}**: Enable.
          * **{{ ui-key.yacloud.storage.bucket.policy.field_principal-type }}**: Include users.
          * **{{ ui-key.yacloud.storage.bucket.policy.field_user }}**: All users.
          * **{{ ui-key.yacloud.storage.bucket.policy.field_action }}**: Select **All actions**.
          * **{{ ui-key.yacloud.storage.bucket.policy.field_resource }}** — `<bucket_name>/*`.

            Click **{{ ui-key.yacloud.storage.bucket.policy.button_add-resource }}** and enter `<bucket_name>`.

            {% note info %}

            {% include [policy-bucket-objects](policy-bucket-objects.md) %}

            {% endnote %}

      1. Add a [condition](../../storage/s3/api-ref/policy/conditions.md) for the rule:

          * In the **{{ ui-key.yacloud.storage.bucket.policy.field_key }}** field, select `private-endpoint-id`.
          * In the **{{ ui-key.yacloud.storage.bucket.policy.field_operator }}** field, select `StringEquals`.
          * In the **{{ ui-key.yacloud.storage.bucket.policy.field_value }}** field, specify the service connection (Private Endpoint) ID, e.g., `enpd7rq1s3f5********`.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- AWS CLI {#aws-cli}

  {% note info %}

  To manage a policy using the AWS CLI, a service account must have the `storage.admin` [role](../../storage/security/index.md#storage-admin) assigned.

  {% endnote %}

  If you do not have the AWS CLI yet, [install and configure it](../../storage/tools/aws-cli.md).

  1. Describe your access policy configuration as a [data schema](../../storage/s3/api-ref/policy/scheme.md) in JSON format:

      {% include [policy-scheme-json](../vpc/policy-scheme-json.md) %}

  1. Once complete, save the configuration to a file named `policy.json`.

  1. Run this command:

      ```bash
      aws s3api put-bucket-policy \
        --endpoint https://{{ s3-storage-host }} \
        --bucket <bucket_name> \
        --policy file://policy.json
      ```

  After successfully applying the bucket policy, connection to the bucket will be possible only from the {{ vpc-short-name }} cloud network in which the relevant service connection (Private Endpoint) was created.

{% endlist %}

To learn more about managing a bucket policy, see [Bucket policy management](../../storage/operations/buckets/policy.md).