1. In the terminal, change to the folder where you edited the configuration file.
1. Make sure the configuration file is correct using the command:

   ```bash
   terraform validate
   ```

   If the configuration is correct, the following message is returned:

   ```bash
   Success! The configuration is valid.
   ```

1. Run the command:

   ```bash
   terraform plan
   ```

   The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains errors, {{ TF }} will point them out.
1. Apply the configuration changes:

   ```bash
   terraform apply
   ```

1. Confirm the changes: type `yes` in the terminal and press **Enter**.