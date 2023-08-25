# Instance Group Scheduled Scaler

This application is based on [{{ sf-full-name }}](../functions). Modifies the size of a specified [group of {{ compute-full-name }} virtual machines](../compute/concepts/instance-groups/index.md) on a schedule.

Use to autoscale a service at times of high load.

## Required paid resources {#paid-resources}

The cost of application resources includes charges for the number of function calls, computing resources allocated to function execution, and outgoing traffic (see [{{ sf-full-name }} pricing](../functions/pricing.md)).

## Deploy the application {#deploy-app}

1. In the [management console]({{ link-console-main }}), select the folder where you want to deploy the application.
1. Select **{{ cloud-apps-name }}**.
1. On the left-hand panel, select **Marketplace**.
1. Select **Instance Group Scheduled Scale** and click **Use**.
1. Specify the following:
   * Application name.
   * (Optional) Application description.
   * Service account with the `admin` role for the folder, or select **Auto** to have the service account created when installing the application. This service account will be used to create the application resources.
   * ID of a group of {{ compute-name }} virtual machines.
   * Schedule in [cron expression](../functions/concepts/trigger/timer.md#cron-expression) format to change the size of a group of VMs to the baseline.
   * Baseline VM group size.
   * Schedule in [cron expression](../functions/concepts/trigger/timer.md#cron-expression) format to change the VM group size to the scaled-up one.
   * Scaled-up VM group size.
1. Click **Install** and wait for the installation to complete.
