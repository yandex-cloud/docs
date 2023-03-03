To delete the resources created with {{ TF }}:
1. Run the command:

   ```bash
   terraform destroy
   ```

   {% note alert %}

   {{ TF }} deletes all the resources that you created in the current configuration, such as clusters, networks, subnets, and VMs.

   {% endnote %}

   After the command is executed, the terminal will display a list of resources to be deleted.

1. Type the word `yes`, then press **Enter**.