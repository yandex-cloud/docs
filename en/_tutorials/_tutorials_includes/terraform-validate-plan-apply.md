1. In the terminal, navigate to the folder where you edited the configuration file.
1. Make sure the configuration file is correct using this command:

   ```bash
   terraform validate
   ```

   If the configuration is correct, you will get this message:

   ```bash
   Success! The configuration is valid.
   ```

1. Run this command:

   ```bash
   terraform plan
   ```

   You will see a detailed list of resources. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.
1. Apply the changes:

   ```bash
   terraform apply
   ```

1. Confirm the changes by typing `yes` in the terminal and pressing **Enter**.