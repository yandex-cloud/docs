# Django Container

Demo website. Implemented using [Django](https://www.djangoproject.com/) in a [{{ serverless-containers-full-name }}](../serverless-containers) container. It enables you to use Django in serverless mode.

## Required paid resources

The cost of resources for the application includes:

* A fee for the number of container calls, computing resources allocated to execute the application, and outgoing traffic (see [{{ serverless-containers-full-name }} pricing](../serverless-containers/pricing.md)).
* A fee for the number of requests to the API gateway and outgoing traffic (see [{{ api-gw-full-name }} pricing](../api-gateway/pricing.md)).

## Deploy the application

1. In the [management console]({{ link-console-main }}), select the folder where you wish to deploy the application.
1. Select **{{ cloud-apps-name }}**.
1. On the left-hand panel, select **Marketplace**.
1. Select **Django Container** and click **Use**.
1. Indicate the following:
   * Application name.
   * (optional) Application description.
   * A service account with the `admin` role for the folder, or select **Auto** to have the service account created when installing the application. This service account will be used to create the application resources.
1. Click **Install**.

## Test functionality

On the **Overview** page, find the API gateway under **Application resources**, go to the gateway page, and copy the service domain link. Follow the link in your browser and open the demo Django website welcome page.

## What's next

You can build upon the application to implement more sophisticated services and websites. To modify container behavior, select a new Docker image, move it to [{{ container-registry-full-name }}](../container-registry), and create a new version of the {{ serverless-containers-name }} container.
