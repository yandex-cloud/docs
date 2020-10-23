You can create a database in a **Serverless** configuration or with **Dedicated** servers in each availability zone. For more information about the differences in configurations, see [{#T}](../concepts/index.md).

To create a database:

{% list tabs %}

* Serverless

   1. In the [management console](https://console.cloud.yandex.ru), select a folder to create your database in.

   1. In the list of services, select **{{ ydb-name }}**.

   1. Click **Create database**.

   1. Enter a name for the database. Naming requirements:

      {% include [name-format](../../_includes/name-format.md) %}

   1. Under **Database type**, select the **Serverless** option.

   1. Click **Create database**.

   1. Wait until the database starts. When a database is being created, it has the `Provisioning` status. When it is ready for use, the status changes to `Running`.

* Dedicated

   1. In the [management console](https://console.cloud.yandex.ru), select a folder to create your database in.

   1. In the list of services, select **{{ ydb-name }}**.

   1. Click **Create database**.

   1. Enter a name for the database. Naming requirements:

      {% include [name-format](../../_includes/name-format.md) %}

   1. Under **Computing resources**, select the type and amount of [computing resources](../concepts/databases.md#compute-units).

   1. Under **Storage groups**, select the disk type and number of [storage groups](../concepts/databases.md#storage-groups) that determines the total amount of storage.

   1. Under **Network**, select a network and allow assigning public IP addresses to DB nodes.

      If you plan to send DB requests both from the {{ yandex-cloud }} network and the internet, select the **Assign** option next to the **Public IP addresses** field.

      {% include  [traffic_metering](../_includes/traffic_metering.md) %}

      Select an existing network from the **Cloud network** list.

      If there is no network, create one:
      * Click **Create new**.
      * In the window that opens, enter a name for the new network and select the **Create subnets** option if no [subnets](../../vpc/concepts/network.md#subnet) were created. Subnets are created for each [availability zone](../../overview/concepts/geo-scope.md).
      * Click **Create**.

   1. Click **Create database**.

   1. Wait until the database starts. When a database is being created, it has the `Provisioning` status. When it is ready for use, the status changes to `Running`.

{% endlist %}

