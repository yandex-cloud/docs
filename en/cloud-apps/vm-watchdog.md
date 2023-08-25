# VM Watchdog

This application is based on [{{ sf-full-name }}](../functions). It starts and stops a {{ compute-full-name }} [virtual machine](../compute/concepts/vm.md) on a pre-set schedule.

Use it to shut VMs down automatically when they are not needed to save on idle resources.

## Required paid resources {#paid-resources}

The cost of application resources includes charges for the number of function calls, computing resources allocated to function execution, and outgoing traffic (see [{{ sf-full-name }} pricing](../functions/pricing.md)).

## Deploy the application {#deploy-app}

1. In the [management console]({{ link-console-main }}), select the folder where you want to deploy the application.
1. Select **{{ cloud-apps-name }}**.
1. On the left-hand panel, select **Marketplace**.
1. Select **VM Watchdog** and click **Use**.
1. Specify the following:
   * Application name.
   * (Optional) Application description.
   * Service account with the `admin` role for the folder, or select **Auto** to have the service account created when installing the application. This service account will be used to create the application resources.
   * {{ compute-name }} virtual machine ID.
   * Schedules for VM startup and shutdown as [cron expressions](../functions/concepts/trigger/timer.md#cron-expression).
1. Click **Install** and wait for the installation to complete.
