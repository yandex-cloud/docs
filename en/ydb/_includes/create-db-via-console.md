You can create a database in a **Serverless** configuration or with **dedicated** servers. For more information about the differences in configurations, see [{#T}](../concepts/index.md).

To create a database:

{% list tabs %}

* Serverless

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a DB.

   1. In the list of services, select **{{ ydb-name }}**.

   1. Click **Create database**.

   1. Enter the database **Name**. Naming requirements:

      
      {% include [name-format](../../_includes/name-format.md) %}

   1. Under **Database type**, select the **Serverless** option.

   1. Click **Create database**.

   1. Wait until the database starts. When a database is being created, it has the `Provisioning` status. When it is ready for use, the status changes to `Running`.

* Dedicated

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a DB.

   1. In the list of services, select **{{ ydb-name }}**.

   1. Click **Create database**.

   1. Enter the database **Name**. Naming requirements:

      
      {% include [name-format](../../_includes/name-format.md) %}

   1. Under **Database type**, select the **Dedicated** option.

   1. Under **Computing resources**, select the type and amount of [computing resources](../concepts/databases.md#compute-units).

   1. Under **Storage groups**, select the disk type and number of [storage groups](../concepts/databases.md#storage-groups) that determines the total amount of storage.

   1. Under **Network**, configure network settings:

      1. (optional) Under **Public IP addresses**, select the **Assign** option if you plan to send DB requests both from the {{ yandex-cloud }} network and the internet.

         
         {% include  [traffic_metering](../_includes/traffic_metering.md) %}

      1. Select an existing network from the **Cloud network** list or create a new one:
         * Click **Create new**.
         * In the window that opens, enter a **Name** for the new network.
         * (optional) Select the **Create subnets** option. Subnets in each availability zone will be created automatically.
         * Click **Create**.

      1. Under **Subnets**, select or create a subnet for each [availability zone](../../overview/concepts/geo-scope.md):
         * Click **Create subnet**.
         * In the window that opens, enter a **Name** for the new subnet.
         * (optional) Enter a **Description** of the subnet.
         * Select the desired availability zone from the **Availability zone** list.
         * Specify the subnet address in [**CIDR**](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) format.
         * Click **Create**.

   1. Click **Create database**.

   1. Wait until the database starts. When a database is being created, it has the `Provisioning` status. When it is ready for use, the status changes to `Running`.

{% endlist %}

