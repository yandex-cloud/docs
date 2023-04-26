# VM Folder Watchdog

This application is based on [{{ sf-full-name }}](../functions). It starts and stops all {{ compute-full-name }} [VM instances](../compute/concepts/vm.md) in a folder on a preset schedule.

Use it to shut VMs down automatically when they are not needed to save on idle resources.

## Required paid resources {#paid-resources}

The cost of resources for the application includes:
* Fee for the number of function calls, computing resources allocated to executing the function, and outgoing traffic (see [{{ sf-full-name }} pricing](../functions/pricing.md)).
* Fee for standard queue requests (see [{{ message-queue-full-name }} pricing](../message-queue/pricing.md)).

## Deploy the application {#deploy-app}

1. In the [management console]({{ link-console-main }}), select the folder where you want to deploy the application.
1. Select **{{ cloud-apps-name }}**.
1. On the left-hand panel, select **Marketplace**.
1. Select **VM Folder Watchdog** and click **Use**.
1. Specify the following:
   * Application name.
   * (optional) Application description.
   * Service account with the `admin` role for the folder, or select **Auto** to have the service account created when installing the application. This service account will be used to create the application resources.
   * Folder to start and stop VM instances in.
   * Schedules for VM startup and shutdown as [cron expressions](../functions/concepts/trigger/timer.md#cron-expression).
1. Click **Install** and wait for the installation to complete.
