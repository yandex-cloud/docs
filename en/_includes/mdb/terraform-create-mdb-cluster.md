1. Make sure that the configuration files are correct.

   1. In the command line, use the `cd <folder path>` command to go to the folder where you created the configuration file.
   1. Run the check using the command:
      ```
      terraform plan
      ```
   If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, {{ TF }} points them out. This is a test step. No resources are created.

1. Create a cluster.

   1. If the configuration doesn't contain any errors, run the command:
      ```
      terraform apply
      ```
   1. Confirm that you want to create the resources.

   After this, all the necessary resources will be created in the specified folder and the IP addresses of the VMs will be displayed in the terminal. You can check resource availability and their settings in the [management console]({{ link-console-main }}).

