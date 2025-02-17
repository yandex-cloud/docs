To create a key:

1. Describe the parameters of the `yandex_kms_symmetric_key` resource in the configuration file:

   ```hcl
   resource "yandex_kms_symmetric_key" "key-a" {
     name                = "<key_name>"
     description         = "<key_description>"
     default_algorithm   = "AES_128"
     rotation_period     = "8760h"
     deletion_protection = true
     lifecycle {
       prevent_destroy = true
     }
   }
   ```

   Where:

   * `name`: Key name. The name format is as follows:

      {% include [name-format](../../_includes/name-format.md) %}

   * `description`: Key description.
   * `default_algorithm`: Encryption algorithm. The possible values are `AES-128`, `AES-192`, or `AES-256`.
   * `rotation_period`: [Rotation](../../kms/concepts/version.md#rotate-key) period (how often to change key versions). To create a key without automatic rotation, do not specify the `rotation_period` parameter.
   * `deletion_protection`: Key deletion protection. To create a key without deletion protection, do not specify the `deletion_protection` parameter.
   * `lifecycle.prevent_destroy`: Key deletion protection when running {{ TF }} commands. To create a key without such protection, do not specify the `lifecycle` section.

   {% note warning %}

   Deleting a {{ kms-short-name }} key destroys all data encrypted with that key: the data becomes unrecoverable after the key is deleted. The `deletion_protection` parameter and the `lifecycle` section are required to prevent the deletion of the key (e.g., with the `terraform destroy` command).

   {% endnote %}

   For more information about resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/kms_symmetric_key).

1. Check the configuration using this command:

   ```bash
   terraform validate
   ```

   If the configuration is correct, you will get this message:

   ```text
   Success! The configuration is valid.
   ```

1. Run this command:

   ```bash
   terraform plan
   ```

   The terminal will display a list of resources with their parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

1. Apply the configuration changes:

   ```bash
   terraform apply
   ```

1. Confirm the changes: type `yes` into the terminal and press **Enter**.

   This will create all the resources you need in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-main }}) or these [CLI](../../cli/quickstart.md) commands:

   ```bash
   yc kms symmetric-key list
   ```
