1. In the terminal, navigate to the configuration file directory.
1. Make sure the configuration is correct using this command:

   ```bash
   terraform validate
   ```

   If the configuration is valid, you will get this message:

   ```bash
   Success! The configuration is valid.
   ```

1. Run this command:

   ```bash
   terraform plan
   ```

   You will see a list of resources and their properties. No changes will be made at this step. {{ TF }} will show any errors in the configuration.
1. Apply the configuration changes:

   ```bash
   terraform apply
   ```

1. Type `yes` and press **Enter** to confirm the changes.