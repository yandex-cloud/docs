To create a key:

1. Describe the parameters of the `yandex_kms_symmetric_key` resource in a configuration file:

   ```hcl
   resource "yandex_kms_symmetric_key" "key-a" {
     name              = "<key_name>"
     description       = "<key_description>"
     default_algorithm = "AES_128"
     rotation_period   = "8760h"
     lifecycle {
       prevent_destroy = true
     }
   }
   ```

   Where:

   * `name`: Key name. The name format is as follows:

      {% include [name-format](../../_includes/name-format.md) %}

   * `description`: Key description.
   * `default-algorithm`: Encryption algorithm. Possible values: `AES-128`, `AES-192`, or `AES-256`.
   * `rotation-period`: [Rotation](../../kms/concepts/version.md#rotate-key) period (default key version change frequency). To create a key without automatic rotation, do not specify the `rotation-period` parameter.

   {% note warning %}

   Deleting a {{ kms-short-name }} key destroys all data encrypted with that key: the data becomes unrecoverable after the key is deleted. The `lifecycle` block is necessary to prevent users from destroying keys (with the `terraform destroy` command, for example).

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

   The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

1. Apply the configuration changes:

   ```bash
   terraform apply
   ```

1. Confirm the changes: type `yes` into the terminal and press **Enter**.

   All the resources you need will then be created in the specified folder. You can check if the resources are there and properly configured either from the [management console]({{ link-console-main }}) or using this [CLI](../../cli/quickstart.md) command:

   ```bash
   yc kms symmetric-key list
   ```
