# Metrics Collector

The application collects information about {{ yandex-cloud }} resource usage and writes the resulting values in [{{ monitoring-full-name }}](../monitoring) on a timer.

## Required paid resources {#paid-resources}

The cost of application resources includes charges for the number of function calls, computing resources allocated to function execution, and outgoing traffic (see [{{ sf-full-name }} pricing](../functions/pricing.md)).

## Deploy the application {#deploy-app}

1. In the [management console]({{ link-console-main }}), select the folder where you want to deploy the application.
1. Select **{{ cloud-apps-name }}**.
1. On the left-hand panel, select **Marketplace**.
1. Select **Metrics Collector** and click **Use**.
1. Specify the following:
   * Application name.
   * (optional) Application description.
   * Service account with the `admin` role for the folder, or select **Auto** to have the service account created when installing the application. This service account will be used to create the application resources.
1. Click **Install** and wait for the installation to complete.
