# Image Resizer

The application automatically detects images uploaded to the [{{ objstorage-full-name }}](../storage/) directory, modifies their resolution, and re-saves them to a new directory. You set the desired resolution when creating the application.

Use it when developing services that handle images.

## Required paid resources {#paid-resources}

The cost of resources for the application includes:
* Fee for the number of function calls, computing resources allocated to executing the function, and outgoing traffic (see [{{ sf-full-name }} pricing](../functions/pricing.md)).
* Fee for storing data in a bucket (see [{{ objstorage-full-name }} pricing](../storage/pricing.md)).

## Deploy the application {#deploy-app}

1. In the [management console]({{ link-console-main }}), select the folder where you want to deploy the application.
1. Select **{{ cloud-apps-name }}**.
1. On the left-hand panel, select **Marketplace**.
1. Select **Image Resizer** and click **Use**.
1. Specify the following:
   * Application name.
   * (Optional) Application description.
   * Service account with the `admin` role for the folder, or select **Auto** to have the service account created when installing the application. This service account will be used to create the application resources.
   * {{ objstorage-name }} bucket.
   * Directory with the source images.
   * Target directory.
   * Resulting image size.
1. Click **Install** and wait for the installation to complete.
