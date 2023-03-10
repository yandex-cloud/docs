# VM Watchdog

Application based on [{{ sf-full-name }}](../functions). It starts and stops a {{ compute-full-name }} [virtual machine](../compute/concepts/vm.md) on a pre-set schedule.

Use it to shut VMs down automatically when they aren't needed to save on idle resources.

## Required paid resources

The cost of application resources includes charges for the number of function calls, computing resources allocated to function execution, and outgoing traffic (see [{{ sf-full-name }} pricing](../functions/pricing.md)).

## Deploy the application

1. In the [management console]({{ link-console-main }}), select the folder where you wish to deploy the application.
1. Select **{{ cloud-apps-name }}**.
1. On the left-hand panel, select **Marketplace**.
1. Select **VM Watchdog** and click **Use**.
1. Indicate the following:
   * Application name.
   * (optional) Application description.
   * A service account with the `admin` role for the folder, or select **Auto** to have the service account created when installing the application. This service account will be used to create the application resources.
   * {{ compute-name }} virtual machine ID.
   * Schedules for VM startup and shutdown as [cron expressions](../functions/concepts/trigger/timer.md#cron-expression).
1. Click **Install** and wait for the installation to complete.
