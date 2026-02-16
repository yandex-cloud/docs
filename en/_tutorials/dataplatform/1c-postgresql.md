# Creating a {{ PG }} cluster for 1C:Enterprise


{{ mpg-name }} allows creating fault-tolerant {{ PG }} clusters optimized for 1C:Enterprise. To this end, the service supports PostgreSQL versions {{ pg.versions.console.str-1c }} with all the required [extensions](#extensions) installed and the connection pooler configuration modified.

{% note warning %}

You can only connect 1C:Enterprise to {{ pg.versions.console.str-1c }} clusters.

{% endnote %}

Select your [host class](../../managed-postgresql/concepts/instance-types.md) based on the number of users in your 1C:Enterprise installation. The **s2.small** hosts can accommodate up to 50 users at a time. We recommend using the **s2.medium** class if 50 or more users are going to access the database. Choose the storage size based on your expected data scope and allow for possible growth in your data volumes.


## Required paid resources {#paid-resources}

The support cost includes:

* {{ mpg-name }} cluster fee: Using computing resources allocated to hosts and disk space (see [{{ mpg-name }} pricing](../../managed-postgresql/pricing.md)).
* Fee for using public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).


## Create a {{ mpg-name }} cluster {#create-cluster}

{% list tabs group=instructions %}

- Manually {#manual}

    [Create](../../managed-postgresql/operations/cluster-create.md#create-cluster) a {{ mpg-name }} cluster of any suitable configuration with the following settings:

    * **{{ ui-key.yacloud.mdb.forms.base_field_environment }}**: `PRODUCTION`.
    * **{{ ui-key.yacloud.mdb.forms.base_field_version }}**: {{ PG }} version for 1C:Enterprise. The names of such versions end with `-1c`.
    * **{{ ui-key.yacloud.mdb.forms.section_resource }}**: `s2.small` or higher.
    * **{{ ui-key.yacloud.mdb.forms.section_host }}**: Add at least two more hosts in different availability zones. This provides the fault tolerance of the cluster. The database is automatically replicated. For more information, see [{#T}](../../managed-postgresql/concepts/replication.md).

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the [postgresql-1c.tf](https://github.com/yandex-cloud-examples/yc-postgresql-1c/blob/main/postgresql-1c.tf) configuration file to the same working directory.

        This file describes:

        * [Network](../../vpc/concepts/network.md#network).
        * [Subnet](../../vpc/concepts/network.md#subnet).
        * [Security group](../../vpc/concepts/security-groups.md) and rule enabling cluster connections.
        * {{ mpg-name }} cluster for 1C:Enterprise with a database and a user.

    1. Specify the infrastructure settings in the `postgresql-1c.tf` configuration file under `locals`:

        * `cluster_name`: Cluster name.
        * `pg_version`: {{ PG }} version for 1C:Enterprise. The names of such versions end with `-1c`.
        * `db_name`: Database name.
        * `username` and `password`: Name and user password of the database owner.

    1. Make sure the {{ TF }} configuration files are correct using this command:

       ```bash
       terraform validate
       ```

       {{ TF }} will show any errors found in your configuration files.

    1. Create the required infrastructure:

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

       {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

Creating a DB cluster may take a few minutes.

## Connect the database to 1C:Enterprise {#connect-to-1c}

Add the created database as an information base to 1C:Enterprise. When adding the database, use the following parameters:

* **Server cluster**: Name of the 1C:Enterprise server to create the information base on.
* **Information base name in cluster**: Name of the information base to create on the 1C:Enterprise server.
* **Secure connection**: Disabled.
* **DBMS type**: `PostgreSQL`.
* **Database server**: `c-<cluster_ID>.rw.{{ dns-zone }} port={{ port-mpg }}`.
* **Database name**: Name of the database you specified when creating the {{ mpg-name }} cluster.
* **Database user**: Username of the database owner.
* **User password**: Password of the database owner.
* **Create database if none present**: Disabled.

### {{ PG }} extensions to support 1C:Enterprise {#extensions}

List of extensions installed in PostgreSQL {{ pg.versions.console.str-1c }} clusters:

* [online_analyze](https://postgrespro.ru/docs/postgrespro/10/online-analyze?lang=en)

* [plantuner](https://postgrespro.ru/docs/postgrespro/10/plantuner?lang=en)

* [fasttrun](https://postgrespro.ru/docs/postgrespro/10/fasttrun?lang=en)

* [fulleq](https://postgrespro.ru/docs/postgrespro/10/fulleq?lang=en)

* [mchar](https://postgrespro.ru/docs/postgrespro/10/mchar?lang=en)

## Delete the resources you created {#clear-out}

Delete the resources you no longer need to avoid paying for them:

{% list tabs group=instructions %}

- Manually {#manual}

    [Delete the {{ mpg-name }} cluster](../../managed-postgresql/operations/cluster-delete.md).

- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
