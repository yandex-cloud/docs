1. In the command line, go to the directory with the {{ TF }} configuration file.

1. Check the configuration using the command:
   ```
   terraform validate
   ```

   If the configuration is correct, the following message is returned:

   ```
   Success! The configuration is valid.
   ```

1. Run the command:
   ```
   terraform plan
   ```

   The terminal will display a list of resources with parameters. No changes are made at this step. If there are errors in the configuration, {{ TF }} points them out.

1. Apply the configuration changes:
   ```
   terraform apply
   ```

1. Confirm the changes: type `yes` into the terminal and press Enter.