# Metrics Collector

On a timer, the application collects information on {{ yandex-cloud }} resource usage and records the resulting values in [{{ monitoring-full-name }}](../monitoring).

## Required paid resources

The cost of the application resources includes charges for the number of function calls, computing resources allocated to function execution, and outgoing traffic (see [{{ sf-full-name }} pricing](../functions/pricing.md)).

## Deploy the application

1. In the [management console]({{ link-console-main }}), select the folder where you wish to deploy the application.
1. Select **{{ cloud-apps-name }}**.
1. On the left-hand panel, select **Marketplace**.
1. Select **Metrics Collector** and click **Use**.
1. Indicate the following:
   * Application name.
   * (optional) Application description.
   * A service account with the `admin` role for the folder, or select **Auto** to have the service account created when installing the application. This service account will be used to create the application resources.
1. Click **Install** and wait for the installation to complete.
