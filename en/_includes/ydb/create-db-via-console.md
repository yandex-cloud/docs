To create a database:

1. In the [management console]({{ link-console-main }}), select a folder to create your database in.

1. In the list of services, select **{{ ydb-name }}**.

    {{ ydb-full-name }} is at the Preview stage and appears in the list of available resources only after your request is approved.

1. Click **Create database**.

1. Enter a name for the database. Naming requirements:

    {% include [name-format](../name-format.md) %}

1. Under **Computing resources**, select the type and amount of [computing resources](../../ydb/concepts/resources.md#resource-presets).

1. Under **Storage groups**, select the disk type and number of [storage groups](../../ydb/concepts/resources.md#storage-groups) that determine the total storage size.

1. Under **Network**, select a network and allow assigning public IP addresses to DB nodes.

   If you plan to send DB requests both from the {{ yandex-cloud }} network and the internet, select the **Assign** option next to the **Public IP addresses** field.

   {% include  [traffic_metering](../../ydb/_includes/traffic_metering.md) %}

   Select an existing network from the **Cloud network** list.

   If there is no network, create one:
   * Click **Create new**.
   * In the window that opens, enter a name for the new network and select the **Create subnets** option if no [subnets](../../vpc/concepts/network.md#subnet) were created. Subnets are created for each [availability zone](../../overview/concepts/geo-scope.md).
   * Click **Create**.

1. Click **Create database**.

1. Wait until the database starts. When a database is being created, it has the `Provisioning` status. When it is ready for use, the status changes to `Running`.

