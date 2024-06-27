1. In the command line, go to the folder where you created the configuration file.

1. Run a check using this command:

   ```bash
   terraform plan
   ```

If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out. This is a test step; no resources will be created.
