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
   * `aad_context`: ([AAD context](../../kms/concepts/symmetric-encryption.md#add-context)).
   * `plaintext`: String to be encrypted.

   {% note warning %}

   `yandex_kms_secret_ciphertext` enables you to hide secrets when deploying an infrastructure. However, in general, it is not safe to openly specify the `plaintext` and `aad_context` in the configuration file. Secrets can be read from configuration files or execution logs and can end up in the {{ TF }} state.

   {% endnote %}

   For more information about resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/kms_secret_ciphertext).

1. Check the configuration using this command:

   ```
   terraform validate
   ```

   If the configuration is correct, you will get this message:

   ```
   Success! The configuration is valid.
   ```

1. Run this command:

   ```
   terraform plan
   ```

   The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

1. Apply the configuration changes:

   ```
   terraform apply
   ```

1. Confirm the changes: type `yes` into the terminal and press **Enter**.

   The ciphertext can then be accessed via the `ciphertext` variable, and the encrypted data via the `plaintext` variable.


   To check, you can add the following code with the `decrypted_pass` output variable to the configuration file.

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

