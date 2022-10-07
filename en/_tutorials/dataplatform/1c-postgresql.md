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

   * **Name**: `postgresql-1c`.
   * **Environment**: `PRODUCTION`.
   * **Version**: `12-1c`.
   * **Host class**: At least `s2.small`.
   * **Storage size**: At least 10 GB.
   * **Database**:

      * **DB name**: `postgresql-1c`.
      * **Username**: `user-1c`.
      * **Password**: The password you will use to access the cluster.

   * **Hosts**: Add at least two more hosts in different availability zones. This provides the fault tolerance of the cluster. The database is automatically replicated. For more information, see [{#T}](../../managed-postgresql/concepts/replication.md).

- Using {{ TF }}

   1. If you don't have {{ TF }}, {% if audience != "internal" %}[install it](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform){% else %}install it{% endif %}.
   1. Download [the file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and {% if audience != "internal" %}[specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider){% else %}specify the parameter values{% endif %}.
   1. Download the cluster configuration file [postgresql-1c.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/postgresql-1c.tf) to the same working directory.

      This file describes:

      * Network.
      * Subnet.
      * Default security group and rules required to connect to the cluster from the internet.
      * {{ mpg-name }} cluster for <q>1C:Enterprise</q>.

   1. In `postgresql-1c.tf`, specify the password for `user-1c` that will be used to access a {{ mpg-name }} cluster.
   1. Run the command `terraform init` in the directory with the configuration file. This command initializes the providers specified in the configuration files and lets you work with the provider resources and data sources.
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

* **Secure connection**: `Disabled`.
* **DBMS type**: `PostgreSQL`.
* **Database server**: `c-<cluster ID>.rw.{{ dns-zone }} port={{ port-mpg }}`.
* **Database name**: `postgresql-1c`.
* **Database user**: `user-1c`.
* **User password**: `<database user password>`.
* **Create database if none present**: Disabled.

### {{ PG }} extensions for <q>1C:Enterprise</q> support {#extensions}

List of extensions installed in PostgreSQL {{ pg.versions.console.str-1c }} clusters:

* [online_analyze]{% if lang == "en" %}({{ pg.docs.pro }}/postgrespro/current/online-analyze?lang=en){% endif %}{% if lang == "ru" %}({{ pg.docs.pro }}/postgrespro/current/online-analyze){% endif %}

* [plantuner]{% if lang == "en" %}({{ pg.docs.pro }}postgrespro/current/plantuner?lang=en){% endif %}{% if lang == "ru" %}({{ pg.docs.pro }}postgrespro/current/plantuner){% endif %}

* [fasttrun]{% if lang == "en" %}({{ pg.docs.pro }}postgrespro/current/fasttrun?lang=en){% endif %}{% if lang == "ru" %}({{ pg.docs.pro }}postgrespro/current/fasttrun){% endif %}

* [fulleq]{% if lang == "en" %}({{ pg.docs.pro }}/postgrespro/current/fulleq?lang=en){% endif %}{% if lang == "ru" %}({{ pg.docs.pro }}/postgrespro/current/fulleq){% endif %}

* [mchar]{% if lang == "en" %}({{ pg.docs.pro }}/postgrespro/current/mchar?lang=en){% endif %}{% if lang == "ru" %}({{ pg.docs.pro }}/postgrespro/current/mchar){% endif %}

## Delete the resources you created {#clear-out}

{% list tabs %}

- Manually

   If you no longer need these resources, delete the [{{ mpg-name }} cluster](../../managed-postgresql/operations/cluster-delete.md).

- Using {{ TF }}

   To delete the infrastructure [created with {{ TF }}](#create-cluster):

   1. In the terminal window, change to the directory containing the infrastructure plan.
   1. Delete `postgresql-1c.tf`.
   1. Make sure the {{ TF }} configuration files are correct using the command:

      ```bash
      terraform validate
      ```

      If there are errors in the configuration files, {{ TF }} will point to them.

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      All resources described in `postgresql-1c.tf` will be deleted.

{% endlist %}
