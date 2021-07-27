---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Getting started with {{ data-transfer-name }}

Copy or replicate data between the databases of the service by creating endpoints and configuring transfers between them.

{% note warning %}

Put the transfer in the same folder with the endpoints that it connects together.

{% endnote %}

## Before you start {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}). If you aren't registered, go to the management console and follow the instructions.
1. On the [Billing]({{ link-console-billing }}), make sure that a [billing account](../billing/concepts/billing-account.md) is linked and that its status is `ACTIVE` or `TRIAL_ACTIVE`. If you don't have a billing account, [create one](../billing/quickstart/index.md#create_billing_account).
1. If you don't have a folder, [create one](../resource-manager/operations/folder/create.md).
1. On the [Access management]({{ link-console-access-management }}) page, make sure you have the `editor` role or higher. The role must be assigned for the folder where you'll work or the cloud that the folder belongs to.

## Create a source endpoint {#source}

1. In the [management console]({{ link-console-main }}), select the folder to create an endpoint in.
1. In the list of services, select **{{ data-transfer-name }}**.
1. Click **Create endpoint**.
1. In the window that opens, make sure that the **Direction** field is set to **Source**.
1. Enter the **Name** of the endpoint.
1. (optional) Enter a **Description** of the endpoint.
1. Select the **Database** you want to transfer data from.
1. Under **Endpoint parameters**:
    * If you selected {{ mmy-name }}<sup>®</sup> or {{ mpg-name }}, specify:
        1. **ID** of the {{ MY }} or {{ PG }} cluster to transfer data from.
        1. **DB username**.
        1. **DB user password**.
        1. (optional) Other parameters.

    * If you selected {{ MY }} or {{ PG }}, specify:
        1. **IP or FQDN of the host** to transfer data from.
        1. **DB username**.
        1. **DB user password**.
        1. (optional) Other parameters.
1. Click **Create**.

## Create a target endpoint {#target}

To create an endpoint for the target database:

1. In the [management console]({{ link-console-main }}), select the folder to create an endpoint in.
1. In the list of services, select **{{ data-transfer-name }}**.
1. Click **Create endpoint**.
1. In the window that opens, make sure that the **Direction** field is set to **Target**.
1. Enter the **Name** of the endpoint.
1. (optional) Enter a **Description** of the endpoint.
1. Select the **Database** you want to transfer data to.
1. Under **Endpoint parameters**:
    * If you selected {{ mmy-name }} or {{ mpg-name }}, specify:
        1. **ID** of the {{ MY }} or {{ PG }} cluster you want to transfer data to.
        1. **DB username**.
        1. **DB user password**.
        1. (optional) Other parameters.

    * If you selected {{ MY }} or {{ PG }}, specify:
        1. **IP or FQDN of the host** to transfer data to.
        1. **DB username**.
        1. **DB user password**.
        1. (optional) Other parameters.
1. Click **Create**.

## Create a transfer {#create-transfer}

To create a transfer between the two databases:

1. In [management console]({{ link-console-main }}), select the folder to create a transfer in.
1. In the list of services, select **{{ data-transfer-name }}**.
1. Select the **Transfer** tab.
1. Click **Create transfer**.
1. In the window that opens, select the source database **Endpoint** under **Source**.
1. Select the target database **Endpoint** under **Target**.
1. Under **Transfer parameters**:
    1. Enter the transfer **Name**.
    1. Select the **Type of** [transfer](concepts/index.md#transfer-type).
    1. (optional) Enter the transfer **Description**.
1. Click **Create**.

## Activate the transfer {#activate}

To activate the transfer:

1. In [management console]({{ link-console-main }}), select the folder to create a transfer in.
1. In the list of services, select **{{ data-transfer-name }}**.
1. Select the **Transfer** tab.
1. In the window that opens, click the ![image](../_assets/horizontal-ellipsis.svg) icon.
1. In the menu that opens, click **Activate**.

