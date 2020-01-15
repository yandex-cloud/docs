# Creating a {{ PG }} cluster for 1C:Enterprise

{{ mpg-name }} allows you to create failsafe {{ PG }} clusters optimized for 1C:Enterprise.

When you select a [host class](../concepts/instance-types.md), base it on the number of users in your 1C:Enterprise installation. The **s2.small** hosts can accommodate up to 50 users at once. We recommend that you use the **s2.medium** class if 50 or more users are going to access the database. Choose the storage size based on your expected data scope and allow for possible growth in your data volumes.

## Create a cluster {{ PG }} {#create-cluster}

To create a {{ mpg-name }} cluster for 1C:

1. On the folder page in [management console]({{ link-console-main }}), click **Create resource** and select **PostgreSQL cluster**.

1. In the **Name** field, enter the cluster name: `postgresql-1c`.

1. In the **Environment** field, select `PRODUCTION`.

1. In the **Version** field, select `10-1c`.

1. Under **Host class**, select **s2.small**.

1. Under **Storage size**, enter 10 GB.

1. Under **Database**, enter:
    - In the **DB name** field, enter the cluster name: `postgresql-1c`.
    - In the **Username** field, enter `user-1c`.
    - In the **Password** field, enter the password you will use to access the DB.

1. Under **Network**, select the network for the cluster hosts.

1. Under **Hosts**, add two more hosts in the other availability zones to ensure failover. The database is automatically [replicated](../concepts/replication.md).

1. Under **Additional settings**, set the time to start backups.

1. Click **Create cluster**.

Creating the DB cluster may take several minutes.

## Connect the database to 1C:Enterprise {#connect-to-1c}

Add the created database as an information base to 1C:Enterprise. When adding the database, use the following parameters:

* **Secure connection**: `Disabled`.
* **DBMS type**: `PostgreSQL`.
* **Database server**: `<master host name>.mdb.yandexcloud.net port=6432`.
* **Database name**: `postgresql-1c`.
* **Database user**: `user-1c`.
* **User password**: `<database user password>`.
* **Create database if none present**: disabled.

