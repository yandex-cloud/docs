# Creating a {{ PG }} cluster for <q>1C:Enterprise</q>

{{ mpg-name }} allows you to create fault-tolerant {{ PG }} clusters optimized for <q>1C:Enterprise</q>. For this, the service supports PostgreSQL versions {{ pg.versions.console.str-1c }} with all the necessary [extensions](#extensions) installed and connection pooler configuration changed.

{% note warning %}

You can only connect <q>1C:Enterprise</q> to clusters running version {{ pg.versions.console.str-1c }}.

{% endnote %}

Select your [host class](../../managed-postgresql/concepts/instance-types.md) based on the number of users in your <q>1C:Enterprise</q> installation. The **s2.small** hosts can accommodate up to 50 users at a time. We recommend using the **s2.medium** class if 50 or more users are going to access the database. Choose the storage size based on your expected data scope and allow for possible growth in your data volumes.

## Create a {{ mpg-name }} cluster {#create-cluster}

{% list tabs %}

- Manually

   [Create](../../managed-postgresql/operations/cluster-create.md#create-cluster) a {{ mpg-name }} cluster of any suitable configuration with the following settings:

   * **Environment**: `PRODUCTION`.
   * **Version**: {{ PG }} version used for working with <q>1C:Enterprise</q>. The names of these versions end in `-1c`.
   * **Host class**: At least `s2.small`.
   * **Hosts**: Add at least two more hosts in different availability zones. This provides the fault tolerance of the cluster. The database is automatically replicated. For more information, see [{#T}](../../managed-postgresql/concepts/replication.md).

- Using {{ TF }}

   1. If you don't have {{ TF }}, [install it](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. Download [the file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
   1. Download the [postgresql-1c.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/postgresql-1c.tf) configuration file to the same working directory.

      This file describes:

      * [Network](../../vpc/concepts/network.md#network).
      * [Subnet](../../vpc/concepts/network.md#subnet).
      * [Security group](../../vpc/concepts/security-groups.md) and rule enabling cluster connections.
      * {{ mpg-name }} cluster for <q>1C:Enterprise</q> with the database and user.

   1. Specify the infrastructure settings under `locals` in the `postgresql-1c.tf` configuration file:

      * `cluster_name`: The name of the cluster.
      * `pg_version`: {{ PG }} version used for working with <q>1C:Enterprise</q>. The names of these versions end in `-1c`.
      * `db_name`: Database name.
      * `username` and `password`: Database owner username and password.

   1. Run the command `terraform init` in the directory with the configuration file. This command initializes the provider specified in the configuration files and enables you to use the provider resources and data sources.
   1. Make sure the {{ TF }} configuration files are correct using the command:

      ```bash
      terraform validate
      ```

      If there are errors in the configuration files, {{ TF }} will point to them.

   1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

Creating the DB cluster may take several minutes.

## Connect the database to <q>1C:Enterprise</q> {#connect-to-1c}

Add the created database as an information base to <q>1C:Enterprise</q>. When adding the database, use the following parameters:

* **Secure connection**: Disabled.
* **DBMS type**: `PostgreSQL`.
* **Database server**: `c-<cluster ID>.rw.{{ dns-zone }} port={{ port-mpg }}`.
* **Database name**: The name of the database you specified when creating the cluster.
* **Database user**: The name of the user being the database owner.
* **User password**: The password of the user being the database owner.
* **Create database if none present**: Disabled.

### {{ PG }} extensions for <q>1C:Enterprise</q> support {#extensions}

List of extensions installed in PostgreSQL {{ pg.versions.console.str-1c }} clusters:

* [online_analyze](https://postgrespro.ru/docs/postgrespro/10/online-analyze?lang=en)

* [plantuner](https://postgrespro.ru/docs/postgrespro/10/plantuner?lang=en)

* [fasttrun](https://postgrespro.ru/docs/postgrespro/10/fasttrun?lang=en)

* [fulleq](https://postgrespro.ru/docs/postgrespro/10/fulleq?lang=en)

* [mchar](https://postgrespro.ru/docs/postgrespro/10/mchar?lang=en)

## Delete the resources you created {#clear-out}

{% list tabs %}

- Manually

   If you no longer need these resources, delete the [{{ mpg-name }} cluster](../../managed-postgresql/operations/cluster-delete.md).

- Using {{ TF }}

   To delete the infrastructure [created with {{ TF }}](#create-cluster):

   1. In the terminal window, change to the directory containing the infrastructure plan.
   1. Delete the `postgresql-1c.tf` configuration file.
   1. Make sure the {{ TF }} configuration files are correct using the command:

      ```bash
      terraform validate
      ```

      If there are errors in the configuration files, {{ TF }} will point to them.

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      All resources described in the `postgresql-1c.tf` configuration file will be deleted.

{% endlist %}
