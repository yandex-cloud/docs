# Identity Server based on Ory Kratos

This is an application for authentication, authorization, and user account management based on [Ory Kratos](https://www.ory.sh/docs/kratos/ory-kratos-intro).

Use it if you need a ready-made scalable and fault-tolerant service for:
* User registration and authorization.
* Multi-factor authentication.
* Account recovery and verification.
* User profile storage and management.

## Required paid resources {#paid-resources}

The cost of resources for the application includes:

* Fee for continuously running virtual machines (see [{{ compute-full-name }} pricing](../compute/pricing.md)).
* Fee for computing resources, the amount of storage and backups for a {{ PG }} cluster (see [{{ mpg-full-name }} pricing](../managed-postgresql/pricing.md)).
* Fee for incoming traffic processed by a network load balancer and for the number of network load balancers (see [{{ network-load-balancer-full-name }} pricing](../network-load-balancer/pricing.md)).
* Fee for the number of function calls, computing resources allocated to execute the function, and outgoing traffic (see [{{ sf-full-name }} pricing](../functions/pricing.md)).
* Fee for the number of container calls, computing resources allocated to execute the application, and outgoing traffic (see [{{ serverless-containers-full-name }} pricing](../serverless-containers/pricing.md)).
* Secret storage and request fees (see [{{ lockbox-full-name }} pricing](../lockbox/pricing.md)).
* Fee for the number of requests to the API gateway and outgoing traffic (see [{{ api-gw-full-name }} pricing](../api-gateway/pricing.md)).
* Fee for logging operations and log storage (see [{{ cloud-logging-full-name }} pricing](../logging/pricing.md)).

## Getting started {#before-begin}

1. [Get](../compute/operations/images-with-pre-installed-software/operate.md#creating-ssh-keys) an SSH key pair to connect to a VM.
1. Request from your email service provider the data required to connect to the SMTP server, including the SMTP server address and port, username and password to access the SMTP server. This data will be used for authorization in the service sending emails.
1. [Create](../vpc/operations/network-create.md) a cloud network {{ vpc-name }}.

## Deploy the application {#deploy-app}

1. In the [management console]({{ link-console-main }}), select the folder where you want to deploy the application.
1. Select **{{ cloud-apps-name }}**.
1. On the left-hand panel, select **Marketplace**.
1. Select **Identity Server based on Ory Kratos** and click **Use**.
1. Specify the following:
   * Application name.
   * (Optional) Application description.
   * Service account with the `admin` role for the folder, or select **Auto** to have the service account created when installing the application. This service account will be used to create the application resources.
   * ID of the [cloud network](../vpc/concepts/network.md#network) that you [created previously](#before-begin).
   * CIDRs of [subnets](../vpc/concepts/network.md#subnet) in the `ru-central1-a`, `ru-central1-b`, and `ru-central1-c` [availability zones](../overview/concepts/geo-scope.md). The subnets will be automatically created in the specified cloud network during the application installation.
   * Number of VM instances for the Ory Kratos API.
   * Username to use to access the VM instances via SSH.
   * Public SSH key that you [obtained earlier](#before-begin).
   * Username and password to access the DB. Come up with your username and password yourself. Password must be at least eight characters long.
   * Password to access the private Ory Kratos API. Come up with the password yourself.
   * [Previously obtained](#before-begin) SMTP server address and port, username and password to access the SMTP server.
   * Sender username and email address to specify in emails from Identity Server based on Ory Kratos.
1. Click **Install** and wait for the installation to complete.

You can find the link to access the Ory Kratos API in the management console, on the API gateway page, in the **Service domain** field. Use the `/public`, `/admin`, or `/ui` path to access the public API, private API, or GUI, respectively.

Ory Kratos API configuration files are generated based on the [VM instance metadata](../compute/concepts/vm-metadata.md). To edit them, open the management console, select the appropriate instance group, click **Change** and then click ![image](../_assets/console-icons/ellipsis.svg) → **Edit** under **Instance template**.
