1. After checking the configuration, run the command:

   ```
   terraform plan
   ```

   The terminal will display a list of resources with parameters. This is a test step. No resources are created. If there are errors in the configuration, {{ TF }} points them out.

     {% note alert %}

     You're charged for all resources created using {{ TF }}. Check the plan carefully.

     {% endnote %}

1. To create resources, run the command:

   ```
   terraform apply
   ```

1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

   {{ TF }} will create all the required resources and the terminal will display the IP addresses of the created VMs. You can check resource availability and their settings in the [management console]({{ link-console-main }}).

