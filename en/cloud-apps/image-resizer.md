# Image Resizer

The application automatically detects images uploaded to the [{{ objstorage-full-name }}](../storage/) directory, modifies their resolution, and re-saves them to a new directory. You set the desired resolution when creating the application.

Use it when developing services that handle images.

## Required paid resources

The cost of resources for the application includes:
* A fee for the number of function calls, computing resources allocated to executing the function, and outgoing traffic (see [{{ sf-full-name }} pricing](../functions/pricing.md)).
* A fee for storing data in a bucket (see [{{ objstorage-full-name }} pricing](../storage/pricing.md)).

## Deploy the application

1. In the [management console]({{ link-console-main }}), select the folder where you wish to deploy the application.
1. Select **{{ cloud-apps-name }}**.
1. On the left-hand panel, select **Marketplace**.
1. Select **Image Resizer** and click **Use**.
1. Indicate the following:
   * Application name.
   * (optional) Application description.
   * A service account with the `admin` role for the folder, or select **Auto** to have the service account created when installing the application. This service account will be used to create the application resources.
   * An {{ objstorage-name }} bucket.
   * A directory with the source images.
   * A target directory.
   * Resulting image size.
1. Click **Install** and wait for the installation to complete.
