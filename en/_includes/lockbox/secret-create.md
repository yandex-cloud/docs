To create a secret:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you will be creating your [secret](../../lockbox/concepts/secret.md).
   1. In the list of services, select **{{ lockbox-short-name }}**.
   1. Click **Create secret**.
   1. In the **Name** field, enter a name for the secret.
   1. (Optional) In the **{{ kms-short-name }} Key** field, specify an existing key or [create a new one](../../kms/operations/key.md#create).

      The specified {{ kms-short-name }} key is used to encrypt your secret. If you do not specify the key, the secret will be encrypted with a special system key.

      {% note tip %}

      By using your own [{{ kms-short-name }} key](../../kms/concepts/key.md), you can take full advantage of {{ kms-full-name }}.

      {% endnote %}

   1. (Optional) Select **Don't destroy secret**. You cannot delete a secret with this option enabled. This does not protect the secret's contents.
   1. Under **Version**:

      * In the **Key** field, enter a non-secret ID.
      * In the **Value** field, enter the confidential data you want to store.

      To add more data, click **Add pair** and repeat the steps.
   1. Click **Create**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI create [secret](../../lockbox/concepts/secret.md) command:

      ```bash
      yc lockbox secret create --help
      ```

   1. Run the command, specifying the folder name and [cloud ID](../../resource-manager/operations/cloud/get-id.md) in the parameters. You can pass one or more `key` keys. If a secret will contain several values, enter them in a comma-separated list. The example shows two keys:

      ```bash
      yc lockbox secret create \
        --name <secret_name> \
        --description <secret_description> \
        --payload "[{'key': '<key>', 'text_value': '<text_value>'},{'key': '<key>', 'text_value': '<text_value>'}]" \
        --cloud-id <cloud_ID> \
        --folder-name <folder_name> \
        --deletion-protection
      ```

      Where:

      * `--name`: Secret name. Required parameter.
      * `--description`: Secret description. Optional parameter.
      * `--payload`: Contents of the secret as a YAML or JSON array. For example, to save the `username` key set to `myusername` and the `password` key set to `p@$$w0rd`, you can use the following array: `[{'key': '<username>', 'text_value': '<myusername>'},{'key': '<password>', 'text_value': '<p@$$w0rd>'}]`.
      * `--cloud-id`: ID of the cloud where you want to create your secret.
      * `--folder-name`: Name of the folder where you want to create your secret.
      * `--deletion-protection`: Secret deletion protection. You cannot delete a secret with this option enabled. This does not protect the secret's contents. Optional parameter.

      Result:

      ```
      id: f1sa31gi4v3s********
      folder_id: d3sad80hs4od********
      created_at: "2021-11-08T19:23:00.383Z"
      name: <secret name>
      description: <secret description>
      status: ACTIVE
      current_version:
        id: hfdf68j9fdjk********
        secret_id: f1s2tu3uqg12********
        created_at: "2021-11-08T19:23:00.383Z"
        status: ACTIVE
        payload_entry_keys:
        - <key>
      ```

- {{ TF }}

   A [secret](../../lockbox/concepts/secret.md) only contains its own metadata, including its name, description, and unique ID. To start using the secret, you need to [create a secret version](../../lockbox/operations/secret-version-manage.md).

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

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

      * `name`: Secret name. Required parameter.
      * `description`: Secret description. Optional parameter.
      * `folder_id`: [ID](../../resource-manager/operations/folder/get-id.md) of the folder where you want to create your secret. Optional parameter.
      * `kms_key_id`: ID of the [{{ kms-short-name }} encryption key](../../kms/concepts/). The specified KMS key is used to encrypt your secret. If you do not specify the key, the secret will be encrypted with a special system key. Optional parameter.
      * `deletion_protection`: Deletion protection flag. To enable protection, set `true`. To disable protection, set `false`. The default value is `false`. Optional parameter.
      * `labels`: Resource [label](../../overview/concepts/services.md#labels) in `<key>:"<value>"` format. Optional parameter.

      For more information about the parameters of the `yandex_lockbox_secret` resource in Terraform, see the [provider documentation]({{ tf-provider-resources-link }}/lockbox_secret).

   1. Create resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

   This will create a secret in the specified folder. You can verify that the secret is there and its configuration is correct using the [management console]({{ link-console-main }}) or the following [CLI](../../cli/quickstart.md) command:

   ```bash
   yc lockbox secret get <secret_name>
   ```

- API

   To create a secret, use the [create](../../lockbox/api-ref/Secret/create.md) REST API method for the [Secret](../../lockbox/api-ref/Secret/index.md) resource or the [SecretService/Create](../../lockbox/api-ref/grpc/secret_service.md#Create) gRPC API call.

{% endlist %}
