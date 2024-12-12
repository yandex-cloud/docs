# Changing {{ CH }} settings at the query level

You can specify [{{ CH }} settings at the query level](https://clickhouse.com/docs/en/operations/settings/query-level) to flexibly configure databases in a {{ mch-name }} cluster. You can specify settings in several ways:

* Using the [{{ yandex-cloud }} interfaces](#yandex-cloud-interfaces). This way, you can specify only the [{{ CH }} settings available in {{ yandex-cloud }}](../concepts/settings-list.md#user-level-settings).
* Using SQL queries. This way you can specify any {{ CH }} settings at the query level. The method of specifying settings depends on their type:

   * [User settings](#user). In the `CREATE USER` and `ALTER USER` SQL queries, you can use the `SETTINGS` condition to provide settings. This way, settings will apply to the selected user only.

      To use this method, enable the **{{ ui-key.yacloud.mdb.forms.database_field_sql-user-management }}** option when [creating](cluster-create.md) or [updating](update.md#SQL-management) the cluster. After that, you will not be able to manage users using the {{ yandex-cloud }} interfaces; however, you cannot disable user management via SQL.

   * [Settings at the profile level](#settings-profile). In {{ CH }}, the [settings profile]({{ ch.docs }}/operations/access-rights#settings-profiles-management) contains the values and limitations of these settings as well as the list of roles and users to whom the profile applies. {{ CH }} settings are provided in the `CREATE SETTINGS PROFILE` and `ALTER SETTINGS PROFILE` SQL queries.

      To use this method, enable the **{{ ui-key.yacloud.mdb.forms.database_field_sql-user-management }}** option when [creating](cluster-create.md) or [updating](update.md#SQL-management) the cluster.

   * [Session settings](#session). During a session, you can specify {{ CH }} settings using the `SET` SQL query. This way you can specify settings in a cluster with any configuration, but they will apply to the current session only.

      This method is not suitable for all SQL editors: in some of them, every query runs in a separate session. Check the characteristics of your SQL editor before configuring a session.

   * [Connection settings](#connection). When you connect to a database using the [clickhouse-client](connect/clients.md#clickhouse-client) utility, you can specify {{ CH }} settings using flags. This way you can specify settings in a cluster with any configuration, but they will apply to the currently established connection only.

      You can also specify connection settings in different drivers for {{ CH }} or provide them as URL parameters when sending {{ CH }} HTTP API requests. For more information about these methods, see the [{{ CH }} documentation](https://clickhouse.com/docs/en/interfaces/overview).

## Getting the list of {{ CH }} settings at the query level {#get-list}

{% list tabs group=instructions %}

- SQL {#sql}

   1. [Connect](connect/clients.md) to the database in the cluster.
   1. Run this request:

      ```sql
      SELECT name, description, value FROM system.settings;
      ```

      The result contains names, descriptions, and values of {{ CH }} settings at the query level. The result displays values for the current session and the user who established that session.

{% endlist %}

## Specifying {{ CH }} settings using the {{ yandex-cloud }} interfaces {#yandex-cloud-interfaces}

{% list tabs group=instructions %}

- Management console {#console}

   To configure {{ CH }}:

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
   1. Click the name of the cluster you need, then go the **{{ ui-key.yacloud.clickhouse.cluster.switch_users }}** section.
   1. In the appropriate user row, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}**.
   1. In the **{{ ui-key.yacloud.mdb.forms.section_additional }}** list, expand **settings** and specify the [{{ CH }} settings](../concepts/settings-list.md#user-level-settings).
   1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To configure {{ CH }}:

   1. View the full list of settings specified for a user:

      ```bash
      {{ yc-mdb-ch }} user get <username> <cluster_name_or_ID>
      ```

   1. View the description of the CLI command for changing user settings:

      ```bash
      {{ yc-mdb-ch }} user update --help
      ```

   1. Set the required parameter values:

      ```bash
      {{ yc-mdb-ch }} user update <username> \
         --cluster-name=<cluster_name> \
         --settings="<parameter_1_name>=<value_1>,<parameter_2_name>=<value_2>,..."
      ```

- {{ TF }} {#tf}

   To configure {{ CH }}:

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [Creating clusters](cluster-create.md).

   1. In the {{ mch-name }} cluster user description, under `settings`, change the values of the following parameters:

      ```hcl
      resource "yandex_mdb_clickhouse_cluster" "<cluster_name>" {
        ...
        user {
          name = <username>
          ...
          settings {
            <parameter1_name> = <Value_1>
            <parameter2_name> = <Value_2>
            ...
          }
        }
        ...
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [User.update](../api-ref/User/update.md) method and make a request, e.g., using {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>/users/<username>' \
            --data '{
                      "updateMask": "<list_of_settings_to_update>",
                      "settings": { <{{ CH }}_settings> }
                    }'
        ```

        Where:

        * `updateMask`: List of parameters to update as a single string, separated by commas.

        * `settings`: Required [{{ CH }} settings](../concepts/settings-list.md#user-level-settings) with new values.

        You can get the cluster ID with a [list of clusters in the folder](./cluster-list.md#list-clusters). You can request the user name with the [list of users in the cluster](./cluster-users.md#list-users).

    1. View the [server response](../api-ref/User/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [UserService/Update](../api-ref/grpc/User/update.md) call and make a request, e.g., using {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/user_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "user_name": "<username>",
                  "update_mask": {
                    "paths": [
                      <list_of_settings_to_update>
                    ]
                  },
                  "settings": { <{{ CH }}_settings> }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.UserService.Update
        ```

        Where:

        * `update_mask`: List of parameters to update as an array of `paths[]` strings.

        * `settings`: Required [{{ CH }} settings](../concepts/settings-list.md#user-level-settings) with new values.

        You can get the cluster ID with a [list of clusters in the folder](./cluster-list.md#list-clusters). You can request the user name with the [list of users in the cluster](./cluster-users.md#list-users).

    1. View the [server response](../api-ref/grpc/User/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Specifying {{ CH }} settings in a user account {#user}

You can specify {{ CH }} settings when [adding a new user](#add-user) or [changing settings](#change-user-settings) of an existing user.

### Adding a new user with {{ CH }} settings {#add-user}

{% list tabs group=instructions %}

- SQL {#sql}

   1. [Connect](connect/clients.md) to the DB in the cluster using the `admin` account.
   1. Create a user:

      ```sql
      CREATE USER <username>
         IDENTIFIED WITH sha256_password BY '<user_password>'
         SETTINGS <list_of_{{ CH }}_settings>;
      ```

      {% include [sql-user-name-and-password-limits](../../_includes/mdb/mch/note-sql-info-user-name-and-pass-limits.md) %}

      In the `SETTINGS` parameter, apart from with the setting value, you can specify its minimum and maximum value. Here is an example for the [idle_connection_timeout](https://clickhouse.com/docs/en/operations/settings/settings#idle_connection_timeout) setting:

      ```sql
      CREATE USER <username>
         IDENTIFIED WITH sha256_password BY 'password'
         SETTINGS idle_connection_timeout = 60 MIN 5 MAX 120;
      ```

      For more information about creating users, see the [{{ CH }} documentation]({{ ch.docs }}/sql-reference/statements/create/user/).

{% endlist %}

### Changing {{ CH }} settings of a user {#change-user-settings}

{% list tabs group=instructions %}

- SQL {#sql}

   1. [Connect](connect/clients.md) to the DB in the cluster using the `admin` account.
   1. Update the user account.

      ```sql
      ALTER USER <username> SETTINGS <list_of_{{ CH }}_settings>;
      ```

      For more information on updating accounts, see the [{{ CH }} documentation]({{ ch.docs }}/sql-reference/statements/alter/user).

{% endlist %}

## Specifying {{ CH }} settings in the settings profile {#settings-profile}

You can specify {{ CH }} settings when [creating](#create-settings-profile) or [updating a settings profile](#change-settings-profile).

### Creating a profile with {{ CH }} settings {#create-settings-profile}

{% list tabs group=instructions %}

- SQL {#sql}

   1. [Connect](connect/clients.md) to the DB in the cluster using the `admin` account.
   1. Create a settings profile:

      ```sql
      CREATE SETTINGS PROFILE <settings_profile_name>
         SETTINGS <list_of_{{ CH }}_settings>;
      ```

      In the `SETTINGS` parameter, apart from with the setting value, you can specify its minimum and maximum value. Here is an example for the [idle_connection_timeout](https://clickhouse.com/docs/en/operations/settings/settings#idle_connection_timeout) setting:

      ```sql
      CREATE SETTINGS PROFILE <settings_profile_name>
         SETTINGS idle_connection_timeout = 60 MIN 5 MAX 120;
      ```

      You can attach a settings profile to a user:

      ```sql
      CREATE SETTINGS PROFILE <settings_profile_name>
         SETTINGS <list_of_{{ CH }}_settings>
         TO <username>;
      ```

      For more information about creating settings profiles, see the [{{ CH }} documentation]({{ ch.docs }}/sql-reference/statements/create/settings-profile).

{% endlist %}

### Changing {{ CH }} settings in the settings profile {#change-settings-profile}

{% list tabs group=instructions %}

- SQL {#sql}

   1. [Connect](connect/clients.md) to the DB in the cluster using the `admin` account.
   1. Update a settings profile:

      ```sql
      ALTER SETTINGS PROFILE <settings_profile_name>
         SETTINGS <list_of_{{ CH }}_settings>;
      ```

      In this query, you can specify the boundary values of settings and bind the profile to a user. For more information about changing settings profiles, see the [{{ CH }} documentation]({{ ch.docs }}/sql-reference/statements/alter/settings-profile).

{% endlist %}

## Specifying {{ CH }} settings in a session {#session}

{% list tabs group=instructions %}

- SQL {#sql}

   1. [Connect](connect/clients.md) to the database in the cluster.
   1. Run this request:

      ```sql
      SET <username> SETTINGS <list_of_{{ CH }}_settings>;
      ```

      The applied settings will be valid during the opened session only.

   1. Make sure the settings were applied:

      ```sql
      SELECT value FROM system.settings;
      ```

      To view the value of a setting, run this query:

      ```sql
      SELECT value FROM system.settings WHERE name='<setting_name>';
      ```

{% endlist %}

## Specifying {{ CH }} settings when connecting to a database via the command line {#connection}

{% list tabs group=instructions %}

- SQL {#sql}

   1. [Set the dependencies](connect/clients.md#clickhouse-client) required for connecting to a database.
   1. View the description of the command for connecting to a database:

      ```bash
      clickhouse-client --help
      ```

      Most flags in the command output are advanced {{ CH }} settings.

   1. Select the flags with the required settings by matching the flag names with the [names of {{ CH }} settings]({{ ch.docs }}/operations/settings/settings).
   1. Specify the selected flags in the command for connecting to a database:

      * Connecting without SSL:

         ```bash
         clickhouse-client --host <FQDN_of_any_{{ CH }}_host> \
                           --user <username> \
                           --database <DB_name> \
                           --port 9000 \
                           --ask-password \
                           <flags_with_{{ CH }}_settings>
         ```


      * Connecting via SSL:

         ```bash
         clickhouse-client --host <FQDN_of_any_{{ CH }}_host> \
                           --secure \
                           --user <username> \
                           --database <DB_name> \
                           --port 9440 \
                           --ask-password \
                           <flags_with_{{ CH }}_settings>
         ```


      * Here is an example of connecting without SSL with the [idle_connection_timeout](https://clickhouse.com/docs/en/operations/settings/settings#idle_connection_timeout) setting:

         ```bash
         clickhouse-client --host rc1d-***.mdb.yandexcloud.net \
                           --user user1 \
                           --database db1 \
                           --port 9440 \
                           --ask-password \
                           --idle_connection_timeout 60
         ```

   1. Make sure the settings were applied:

      ```sql
      SELECT value FROM system.settings;
      ```

      To view the value of a setting, run this query:

      ```sql
      SELECT value FROM system.settings WHERE name='<setting_name>';
      ```

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
