## Creating a database {#create-db}

1. In the management console, select the folder where you want to create a database.

1. In the list of services, select **{{ ydb-full-name }}**.

1. Click **Create a database**.

1. Configure database parameters in the dialog box:

    1. **Name**. The database name is case-sensitive, it must start with a Latin letter followed by Latin letters and numbers.

    1. **Computing resources** Type and number of [computing resources](../concepts/databases.md#compute_units): Combinations of CPU and RAM.

    1. **Storage groups**. Type and number of [storage groups](../concepts/databases.md#storage_groups): Combinations of disk types and memory sizes.

1. In the **Network** section, add a network. If there aren't any [networks](../../vpc/concepts/network.md#network), create one. Each network must have at least one [subnet](../../vpc/concepts/network.md#subnet).

1. Click **Create database**.
