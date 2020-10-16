# Getting started with {{ data-transfer-name }}

Copy or replicate data between the databases of the service by creating endpoints and configuring transfers between them.

{% note warning %}

Put the transfer in the same folder with the endpoints that it connects together.

{% endnote %}

## Before you start {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}). Then log in to Yandex.Cloud or sign up if you don't have an account.
1. On the [billing page]({{ link-console-billing }}), make sure that a [billing account](../billing/concepts/billing-account.md) is linked and that its status is `ACTIVE` or `TRIAL_ACTIVE`. If you don't have a billing account, [create one](../billing/quickstart/index.md#create_billing_account).
1. On the [IAM]({{ link-console-access-management }}) page, make sure you have the `editor` role or higher. The role must be assigned for the folder where you'll work or the cloud that the folder belongs to.

## Create a source endpoint {#source}

To create an endpoint for the source database:

1. In [management console]({{ link-console-main }}), select the folder to create an endpoint in.
1. In the list of services, select **{{ data-transfer-name }}**.
1. Click **Create endpoint**.
1. In the window that opens, make sure that the **Direction** field is set to **Source**.
1. In the **Name** field, enter a name for the endpoint.
1. (optional) In the **Description** field, enter a description of the endpoint.
1. In the **Database** field, select the database you want to transfer the data from.
1. Under **Endpoint parameters**:
    * If you selected {{ mpg-name }} or {{ mmy-name }}<sup>®</sup>:
        1. In the **Cluster ID** field, enter the identifier of the {{ PG }} cluster you want to transfer data from.
        1. In the **Username** field, enter the name of the database user.
        1. In the **Password** field, enter the user's password to the database.
        1. In the **Database name** field, enter the name of the database.
        1. (optional) Fill in the other parameters.
    * If you selected {{ PG }} or {{ MY }}:
        1. In the **Host IP or FQDN** field, enter the IP address or FQDN of the host to transfer data from.
        1. In the **Database name** field, enter the name of the database.
        1. In the **Username** field, enter the name of the database user.
        1. In the **Password** field, enter the user's password to the database.
        1. (optional) Fill in the other parameters.
1. Click **Create**.

## Create a target endpoint. {#target}

To create an endpoint for the target database:

1. In [management console]({{ link-console-main }}), select the folder to create an endpoint in.
1. In the list of services, select **{{ data-transfer-name }}**.
1. Click **Create endpoint**.
1. In the window that opens, make sure that the **Direction** field is set to **Target**.
1. In the **Name** field, enter a name for the endpoint.
1. (optional) In the **Description** field, enter a description of the endpoint.
1. In the **Database** field, select the database you want to transfer data to.
1. Under **Endpoint parameters**:
    * If you selected {{ mpg-name }} or {{ mmy-name }}:
        1. In the **Cluster ID** field, enter the ID of the {{ PG }} cluster you want to transfer data to.
        1. In the **Username** field, enter the name of the database user.
        1. In the **Password** field, enter the user's password to the database.
        1. In the **Database name** field, enter the name of the database.
        1. (optional) Fill in the other parameters.
    * If you selected {{ PG }} or {{ MY }}:
        1. In the **Host IP or FQDN** field, enter the IP address or FQDN of the host to transfer data to.
        1. In the **Database name** field, enter the name of the database.
        1. In the **Username** field, enter the name of the database user.
        1. In the **Password** field, enter the user's password to the database.
        1. (optional) Fill in the other parameters.
1. Click **Create**.

## Create a transfer {#create-transfer}

To create a transfer between the two databases:

1. In [management console]({{ link-console-main }}), select the folder to create a transfer in.
1. In the list of services, select **{{ data-transfer-name }}**.
1. Select the **Transfer** tab.
1. Click **Create transfer**.
1. In the window that opens, select the source database endpoint in the **Endpoint** field under **Source**.
1. Under **Target**, select the target database endpoint in the **Endpoint** field.
1. Under **Transfer parameters**:
    1. In the **Name** field, enter the name of the transfer.
    1. Under **Type**, select the transfer type.
    1. (optional) In the **Description** field, enter a description of the transfer.
1. Click **Create**.

## Activate the transfer {#activate}

To activate the transfer:

1. In [management console]({{ link-console-main }}), select the folder to create a transfer in.
1. In the list of services, select **{{ data-transfer-name }}**.
1. Select the **Transfer** tab.
1. In the window that opens, click the ![image](../_assets/horizontal-ellipsis.svg) icon.
1. In the menu that opens, click **Activate**.
