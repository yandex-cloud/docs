To encrypt data:

1. In the configuration file, describe the parameters of the `yandex_kms_secret_ciphertext` resource and specify the [{{ kms-short-name }} key](../../kms/concepts/key.md) in the `key_id` field:

   ```hcl
   resource "yandex_kms_secret_ciphertext" "password" {
     key_id      = "<key_ID>"
     aad_context = "additional authenticated data"
     plaintext   = "strong password"
   }
   ```

   Where:

   * `key_id`: {{ kms-short-name }} key ID.
   * `aad_context`: [AAD context](../../kms/concepts/symmetric-encryption.md#add-context).
   * `plaintext`: String to encrypt.

   {% note warning %}

   With `yandex_kms_secret_ciphertext`, you can hide secrets when deploying an infrastructure, but generally speaking it is unsafe to specify `plaintext` and `aad_context` in the configuration file in plain text. Secrets can be read from configuration files or execution logs and can end up in the {{ TF }} state.

   {% endnote %}

   For more information about resource properties in {{ TF }}, see [this provider guide]({{ tf-provider-resources-link }}/kms_secret_ciphertext).

1. Validate your configuration using this command:

   ```
   terraform validate
   ```

   If the configuration is valid, you will get this message:

   ```
   Success! The configuration is valid.
   ```

1. Run this command:

   ```
   terraform plan
   ```

   You will see a list of resources and their properties. No changes will be made at this step. {{ TF }} will show any errors in the configuration.

1. Apply the configuration changes:

   ```
   terraform apply
   ```

1. Type `yes` and press **Enter** to confirm the changes.

   After this, you can access the ciphertext through the `ciphertext` variable, and the encrypted data, through `plaintext`.


   For verification, you can add the following code with the `decrypted_pass` output variable to the configuration file.

   {% note alert %}

   This is not safe and can only be used for testing.

   {% endnote %}

   ```hcl
   output "decrypted_pass" {
     sensitive = true
     value     = yandex_kms_secret_ciphertext.password.plaintext
   }
   ```

   After updating the configuration, you can check the encrypted data using the command:

   ```hcl
   terraform output decrypted_pass
   ```

   Result:

   ```
   "strong password"
   ```

   {% endnote %}

