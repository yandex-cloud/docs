To create a secret:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder to create the [secret](../../lockbox/concepts/secret.md).
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
   1. Click **{{ ui-key.yacloud.lockbox.button_create-secret }}**.
   1. In the **{{ ui-key.yacloud.common.name }}** field, enter a name for the secret.
   1. (Optional) In the **{{ ui-key.yacloud.lockbox.forms.field_kms-key }}** field, specify an existing key or [create a new one](../../kms/operations/key.md#create).

      The specified {{ kms-short-name }} key is used to encrypt your secret. If you do not specify a key, the secret will be encrypted with a special system key.

      {% note tip %}

      By using your own [{{ kms-short-name }} key](../../kms/concepts/key.md), you can take full advantage of {{ kms-full-name }}.

      {% endnote %}

   1. (optional) Enable **{{ ui-key.yacloud.lockbox.forms.field_deletion-protection }}**. You cannot delete a secret with this option enabled. This does not protect the secret's contents.
   1. Under **{{ ui-key.yacloud.lockbox.forms.section_version }}**:

      * In the **{{ ui-key.yacloud.lockbox.forms.label_key }}** field, enter a non-secret ID.
      * In the **{{ ui-key.yacloud.lockbox.forms.label_value }}** field, enter the confidential data you want to store.

      To add more data, click **{{ ui-key.yacloud.lockbox.forms.button_add-pair }}** and repeat the steps.
   1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI create [secret](../../lockbox/concepts/secret.md) command:

      ```bash
      yc lockbox secret create --help
      ```

   1. Run this command:

      ```bash
      yc lockbox secret create \
        --name <secret_name> \
        --description <secret_description> \
        --payload "<array_with_secret_contents>" \
        --cloud-id <cloud_ID> \
        --folder-id <folder_ID> \
        --deletion-protection
      ```

      Where:

      * `--name`: Secret name. This is a required parameter.
      * `--description`: Secret description. This is an optional parameter.
      * `--payload`: Contents of the secret as a YAML or JSON array.

         You can provide one or more `key` keys at a time. If your secret is going to contain several values, list them separated by commas. If the keys contain binary values, provide them in the `base64` encoding.

         For instance, to save the `username` key with the `myusername` text value or the `avatar` key with a binary value loaded from the `avatar.jpg` file, you can specify:
         `[{'key': 'username', 'text_value': 'myusername'},{'key': 'avatar', 'binary_value': $(base64 -w 0 ./avatar.jpg)}]`.
      * `--cloud-id`: [ID of the cloud](../../resource-manager/operations/cloud/get-id.md) where you want to create your secret.
      * `--folder-id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) where your secret will be created.
      * `--deletion-protection`: Secret deletion protection. You cannot delete a secret with this option enabled. This does not protect the secret's contents. This is an optional parameter.

      Sample command for creating a secret:

      ```bash
      yc lockbox secret create \
        --name sample-secret \
        --description sample_secret \
        --payload "[{'key': 'username', 'text_value': 'myusername'},{'key': 'avatar', 'binary_value': $(base64 -w 0 ./avatar.jpg)}]" \
        --cloud-id b1gwa87mbaom******** \
        --folder-id b1qt6g8ht345******** \
        --deletion-protection
      ```

      In this example, a secret is created with two keys: one with a text value and one with a binary value.

      Result:

      ```
      id: e6q6nbjfu9m2********
      folder_id: b1qt6g8ht345********
      created_at: "2023-10-09T16:29:11.402Z"
      name: sample-secret
      description: sample_secret
      status: ACTIVE
      current_version:
        id: e6q0s9airqca********
        secret_id: e6q6nbjfu9m2********
        created_at: "2023-10-09T16:29:11.402Z"
        status: ACTIVE
        payload_entry_keys:
          - username
          - avatar
      deletion_protection: true
      ```

- {{ TF }} {#tf}

   A [secret](../../lockbox/concepts/secret.md) only contains its own metadata, including its name, description, and unique ID. To start using the secret, you need to [create a secret version](../../lockbox/operations/secret-version-manage.md).

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   1. In the configuration file, describe the parameters of the resources you want to create:

      
      ```
      terraform {
        required_providers {
          yandex = {
            source = "yandex-cloud/yandex"
          }
        }
        required_version = ">= 0.13"
      }
      provider "yandex" {
        zone = "{{ region-id }}-a"
      }

      resource "yandex_lockbox_secret" "my_secret" {
        name                = "<secret_name>"
        description         = "<secret_description>"
        folder_id           = "<folder_ID>"
        kms_key_id          = "<encryption_key_ID>"
        deletion_protection = <deletion_protection_flag>
        labels              = {
          <key_of_label_1>  = "<value_of_label_1>",
          <key_of_label_2>  = "<value_of_label_2>"
        }
      }
      ```



      Where:

      * `name`: Secret name. This is a required parameter.
      * `description`: Secret description. This is an optional parameter.
      * `folder_id`: [ID](../../resource-manager/operations/folder/get-id.md) of the folder where you want to create your secret. This is an optional parameter.
      * `kms_key_id`: ID of the [{{ kms-short-name }} encryption key](../../kms/concepts/). The specified KMS key is used to encrypt your secret. If you do not specify a key, the secret will be encrypted with a special system key. This is an optional parameter.
      * `deletion_protection`: Deletion protection flag. To enable protection, set `true`. To disable protection, set `false`. The default value is `false`. This is an optional parameter.
      * `labels`: Resource [label](../../overview/concepts/services.md#labels) in `<key>:"<value>"` format. This is an optional parameter.

      For more information about the parameters of the `yandex_lockbox_secret` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}Resources/lockbox_secret).

   1. Create resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

   This will create a secret in the specified folder. You can check the new secret and its configuration using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

   ```bash
   yc lockbox secret get <secret_name>
   ```

- API {#api}

   To create a secret, use the [create](../../lockbox/api-ref/Secret/create.md) REST API method for the [Secret](../../lockbox/api-ref/Secret/index.md) resource or the [SecretService/Create](../../lockbox/api-ref/grpc/secret_service.md#Create) gRPC API call.

{% endlist %}
