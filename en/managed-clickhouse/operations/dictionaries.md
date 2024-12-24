# Connecting external dictionaries in {{ mch-name }}

You can add [external dictionaries](../concepts/dictionaries.md#external-dicts) to your cluster and remove them. Read more about dictionaries in the [{{ CH }} documentation]({{ ch.docs }}/sql-reference/dictionaries/).

{{ mch-name }} supports several types of dictionary sources:

* {{ CH }}
* HTTP(s);
* {{ MG }}
* {{ MY }}
* {{ PG }}.

You can manage dictionaries either via SQL (recommended) or via {{ yandex-cloud }} cloud interfaces.

{% note warning %}

Changing dictionary settings will restart {{ CH }} servers on the cluster hosts.

{% endnote %}

## Getting a list of dictionaries {#get-dicts-list}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Click the cluster name and open the **{{ ui-key.yacloud.clickhouse.cluster.switch_dictionaries }}** tab.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get a list of external dictionaries in a {{ CH }} cluster:

    1. View a description of the CLI command for getting detailed cluster information:

        ```bash
        {{ yc-mdb-ch }} cluster get --help
        ```

    1. Run this command:

        ```bash
        {{ yc-mdb-ch }} cluster get <cluster_name>
        ```

    The added dictionaries are displayed in the `dictionaries:` section of the command output.

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.ListExternalDictionaries](../api-ref/Cluster/listExternalDictionaries.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>/externalDictionaries'
        ```

        You can get the cluster ID with a [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/listExternalDictionaries.md#yandex.cloud.mdb.clickhouse.v1.ListClusterExternalDictionariesResponse) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.ListExternalDictionaries](../api-ref/grpc/Cluster/listExternalDictionaries.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<cluster_ID>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.ListExternalDictionaries
        ```

        You can get the cluster ID with a [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/listExternalDictionaries.md#yandex.cloud.mdb.clickhouse.v1.ListClusterExternalDictionariesResponse) to make sure the request was successful.

- SQL {#sql}

    1. [Connect](connect/clients.md) to the required database of the {{ mch-name }} cluster using `clickhouse-client`.
    1. Run the `SHOW DICTIONARIES` [query]({{ ch.docs }}/sql-reference/statements/show/#show-dictionaries).

{% endlist %}

## Creating a dictionary {#add-dictionary}

{% list tabs group=instructions %}

- Management console {#console}

    {% note warning %}

    If the dictionary was created in the console, it cannot be managed via SQL.

    {% endnote %}

    1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Click the cluster name and open the **{{ ui-key.yacloud.clickhouse.cluster.switch_dictionaries }}** tab.
    1. In the top-right corner, click **{{ ui-key.yacloud.mdb.cluster.dictionaries.button-action_add-dictionary }}**.
    1. Specify the [dictionary settings](#settings).
    1. Click **{{ ui-key.yacloud.mdb.cluster.dictionaries.button_submit }}**.

- CLI {#cli}

    {% note warning %}

    If the dictionary is added via the CLI, it cannot be managed via SQL.

    {% endnote %}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To create an external dictionary in a {{ CH }} cluster:

    1. View a description of the CLI command for adding dictionaries:

        ```bash
        {{ yc-mdb-ch }} cluster add-external-dictionary --help
        ```

    1. Run the add dictionary command and specify [dictionary settings](#settings):

        ```bash
        {{ yc-mdb-ch }} cluster add-external-dictionary \
           --name=<{{ CH }}>_cluster_name \
           --dict-name=<dictionary_name> \
           ...
        ```

- REST API {#api}

    {% note warning %}

    If the dictionary is added via the API, it cannot be managed via SQL.

    {% endnote %}

    To create an external dictionary in a {{ CH }} cluster:

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.CreateExternalDictionary](../api-ref/Cluster/createExternalDictionary.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        1. Create a file named `body.json` and add the following contents to it:

            ```json
            {
              "externalDictionary": {
                "name": "<dictionary_name>",
                "structure": {
                  "id": {
                    "name": "<dictionary_key_column_name>"
                  },
                  "key": {
                    "attributes": [
                      <dictionary_data_column_array>
                    ]
                  },
                  "rangeMin": {<RANGE_HASHED_start_column>},
                  "rangeMax": {<RANGE_HASHED_end_column>},
                  "attributes": [
                     <field_description_array>
                  ]
                },
                "layout": {<memory_storage_method>},
                "fixedLifetime": "<fixed_interval_between_updates>",
                "lifetimeRange": {<range_for_selecting_interval_between_updates>},
                "httpSource": {<HTTP(s)_source_settings>},
                "mysqlSource": {<{{ MY }}>_source_settings},
                "clickhouseSource": {<{{ CH }}>_source_settings},
                "mongodbSource": {<{{ MG }}>_source_settings},
                "postgresqlSource": {<{{ PG }}>_source_settings}
              }
            }
            ```

            Where:

            * `externalDictionary.name`: Dictionary name.
            * `externalDictionary.structure`: Dictionary structure:
                * `id.name`: Dictionary key column name.
                * `key.attributes`: Array for description of the dictionary's composite key.
                * `rangeMin`: Description of the start column, required if using `RANGE_HASHED` as the memory layout type.
                * `rangeMax`: Description of the end column, required if using `RANGE_HASHED` as the memory layout type.
                * `attributes`: Array of descriptions of the fields available for database queries.

                {% include [structure](../../_includes/mdb/mch/note-ext-dict-structure.md) %}

            * `externalDictionary.layout`: Memory layout type for the dictionary.
            * `externalDictionary.fixedLifetime`: Fixed interval between dictionary updates in seconds.
            * `externalDictionary.lifetimeRange`: Time range for {{ CH }} to randomly select the time for update. This is necessary for distributing the load on the dictionary source when upgrading on a large number of servers.

              {% include [lifetime single](../../_includes/mdb/mch/note-ext-dict-lifetime-restapi.md) %}

            * `externalDictionary.***Source`: Dictionary data source settings. Select one of the sources and specify its settings:
                * `httpSource`: HTTP(s) source.
                * `mysqlSource`: {{ MY }} source.
                * `clickhouseSource`: {{ CH }} source.
                * `mongodbSource`: {{ MG }} source.
                * `postgresqlSource`: {{ PG }} source.

            For a detailed description of the dictionary attributes and other settings, see [below](#settings).

        1. Run this request:

            ```bash
            curl \
              --request POST \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --header "Content-Type: application/json" \
              --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>:createExternalDictionary' \
              --data '@body.json'
            ```

            You can get the cluster ID with a [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/createExternalDictionary.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    {% note warning %}

    If the dictionary is added via the API, it cannot be managed via SQL.

    {% endnote %}

    To create an external dictionary in a {{ CH }} cluster:

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.CreateExternalDictionary](../api-ref/grpc/Cluster/createExternalDictionary.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        1. Create a file named `body.json` and add the following contents to it:

            ```json
            {
              "cluster_id": "<cluster_ID>",
              "external_dictionary": {
                "name": "<dictionary_name>",
                "structure": {
                  "id": {
                    "name": "<dictionary_key_column_name>"
                  },
                  "key": {
                    "attributes": [<dictionary_data_column_array>]
                  },
                  "range_min": {<RANGE_HASHED_start_column>},
                  "range_max": {<RANGE_HASHED_end_column>},
                  "attributes": [<field_description_array>]
                },
                "layout": {<memory_storage_method>},
                "fixed_lifetime": "<fixed_interval_between_updates>",
                "lifetime_range": {<range_for_selecting_interval_between_updates>},
                "http_source": {<HTTP(s)_source_settings>},
                "mysql_source": {<MySQL_source_settings>},
                "clickhouse_source": {<ClickHouse®_source_settings>},
                "mongodb_source": {<MongoDB_source_settings>},
                "postgresql_source": {<PostgreSQL_source_settings>}
              }
            }
            ```

            Where:

            * `external_dictionary.name`: Dictionary name.
            * `external_dictionary.structure`: Dictionary structure.
                * `id.name`: Dictionary key column name.
                * `key.attributes`: Array of descriptions for columns with dictionary data.
                * `range_min`: Description of the start column, required if using `RANGE_HASHED` as the memory layout type.
                * `range_max`: Description of the end column, required if using `RANGE_HASHED` as the memory layout type.
                * `attributes`: Array of descriptions of the fields available for database queries.

                {% include [structure](../../_includes/mdb/mch/note-ext-dict-structure.md) %}

            * `external_dictionary.layout`: Memory layout type for the dictionary.
            * `external_dictionary.fixed_lifetime`: Fixed interval between dictionary updates in seconds.
            * `external_dictionary.lifetime_range`: Time range for {{ CH }} to randomly select the time for update. This is necessary for distributing the load on the dictionary source when upgrading on a large number of servers.

              {% include [lifetime single](../../_includes/mdb/mch/note-ext-dict-lifetime-grpcapi.md) %}

            * `external_dictionary.***_source`: Dictionary data source settings. Select one of the sources and specify its settings:
                * `http_source`: HTTP(s) source.
                * `mysql_source`: {{ MY }} source.
                * `clickhouse_source`: {{ CH }} source.
                * `mongodb_source`: {{ MG }} source.
                * `postgresql_source`: {{ PG }} source.

            For a detailed description of the dictionary attributes and other settings, see [below](#settings).

            You can get the cluster ID with a [list of clusters in the folder](./cluster-list.md#list-clusters).

        1. Run this request:

            ```bash
            grpcurl \
              -format json \
              -import-path ~/cloudapi/ \
              -import-path ~/cloudapi/third_party/googleapis/ \
              -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
              -rpc-header "Authorization: Bearer $IAM_TOKEN" \
              -d @ \
              {{ api-host-mdb }}:{{ port-https }} \
              yandex.cloud.mdb.clickhouse.v1.ClusterService.CreateExternalDictionary \
              < body.json
            ```

    1. View the [server response](../api-ref/grpc/Cluster/createExternalDictionary.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- SQL {#sql}

    {% note warning %}

    If the dictionary is added via SQL, management using the console, the CLI, and the API is not available for it.

    {% endnote %}

    1. [Connect](connect/clients.md) to the required database of the {{ mch-name }} cluster using `clickhouse-client`.
    1. Execute [DDL request]({{ ch.docs }}/sql-reference/statements/create/dictionary/):

        ```sql
        CREATE DICTIONARY <dictionary_name>(
          <data_columns>
        )
        PRIMARY KEY <name_of_column_with_keys>
        SOURCE(<source>(<source_configuration>))
        LIFETIME(<update_interval>)
        LAYOUT(<memory_storage_method>());
        ```

        Where:

        * `<dictionary_name>`: Name of the new dictionary.
        * `<data_columns>`: List of columns with dictionary entries and their type.
        * `PRIMARY KEY`: Dictionary key column name.
        * `SOURCE`: Source and its parameters.
        * `LIFETIME`: Dictionary update frequency.
        * `LAYOUT`: Memory layout type for the dictionary. Supported options:
          * `flat`,
          * `hashed`,
          * `cache`,
          * `range_hashed`,
          * `complex_key_hashed`,
          * `complex_key_cache`.

    For more information about the settings, see the [{{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict/) documentation.

{% endlist %}

## Updating a dictionary {#update-dictionary}

{% list tabs group=instructions %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.UpdateExternalDictionary](../api-ref/Cluster/updateExternalDictionary.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        1. Create a file named `body.json` and add the following contents to it:

            ```json
            {
              "externalDictionary": {
                "name": "<dictionary_name>",
                "structure": {
                  "id": {
                    "name": "<dictionary_key_column_name>"
                  },
                  "key": {
                    "attributes": [
                      <dictionary_data_column_array>
                    ]
                  },
                  "rangeMin": {<RANGE_HASHED_start_column>},
                  "rangeMax": {<RANGE_HASHED_end_column>},
                  "attributes": [
                     <field_description_array>
                  ]
                },
                "layout": {<memory_storage_method>},
                "fixedLifetime": "<fixed_interval_between_updates>",
                "lifetimeRange": {<range_for_selecting_interval_between_updates>},
                "httpSource": {<HTTP(s)_source_settings>},
                "mysqlSource": {<{{ MY }}>_source_settings},
                "clickhouseSource": {<{{ CH }}>_source_settings},
                "mongodbSource": {<{{ MG }}>_source_settings},
                "postgresqlSource": {<{{ PG }}>_source_settings}
              },
              "updateMask": "externalDictionary.<setting_1>,...,externalDictionary.<setting_N>"
            }
            ```

            Where:

            * `updateMask`: List of parameters to update as a single string, separated by commas.

              In this case, list all the dictionary settings to update.

            * `externalDictionary.name`: Dictionary name.
            * `externalDictionary.structure`: Dictionary structure:
                * `id.name`: Dictionary key column name.
                * `key.attributes`: Array for description of the dictionary's composite key.
                * `rangeMin`: Description of the start column, required if using `RANGE_HASHED` as the memory layout type.
                * `rangeMax`: Description of the end column, required if using `RANGE_HASHED` as the memory layout type.
                * `attributes`: Array of descriptions of the fields available for database queries.

                {% include [structure](../../_includes/mdb/mch/note-ext-dict-structure.md) %}

            * `externalDictionary.layout`: Memory layout type for the dictionary.
            * `externalDictionary.fixedLifetime`: Fixed interval between dictionary updates in seconds.
            * `externalDictionary.lifetimeRange`: Time range for {{ CH }} to randomly select the time for update. This is necessary for distributing the load on the dictionary source when upgrading on a large number of servers.

              {% include [lifetime single](../../_includes/mdb/mch/note-ext-dict-lifetime-restapi.md) %}

            * `externalDictionary.***Source`: Dictionary data source settings. Select one of the sources and specify its settings:
                * `httpSource`: HTTP(s) source.
                * `mysqlSource`: {{ MY }} source.
                * `clickhouseSource`: {{ CH }} source.
                * `mongodbSource`: {{ MG }} source.
                * `postgresqlSource`: {{ PG }} source.

            For a detailed description of the dictionary attributes and other settings, see [below](#settings).

        1. Run this request:

            ```bash
            curl \
              --request POST \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --header "Content-Type: application/json" \
              --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>:updateExternalDictionary' \
              --data '@body.json'
            ```

            You can get the cluster ID with a [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/updateExternalDictionary.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.UpdateExternalDictionary](../api-ref/grpc/Cluster/updateExternalDictionary.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        1. Create a file named `body.json` and add the following contents to it:

            ```json
            {
              "cluster_id": "<cluster_ID>",
              "external_dictionary": {
                "name": "<dictionary_name>",
                "structure": {
                  "id": {
                    "name": "<dictionary_key_column_name>"
                  },
                  "key": {
                    "attributes": [<dictionary_data_column_array>]
                  },
                  "range_min": {<RANGE_HASHED_start_column>},
                  "range_max": {<RANGE_HASHED_end_column>},
                  "attributes": [<field_description_array>]
                },
                "layout": {<memory_storage_method>},
                "fixed_lifetime": "<fixed_interval_between_updates>",
                "lifetime_range": {<range_for_selecting_interval_between_updates>},
                "http_source": {<HTTP(s)_source_settings>},
                "mysql_source": {<MySQL_source_settings>},
                "clickhouse_source": {<ClickHouse®_source_settings>},
                "mongodb_source": {<MongoDB_source_settings>},
                "postgresql_source": {<PostgreSQL_source_settings>}
              },
              "update_mask": "externalDictionary.<setting_1>,...,externalDictionary.<setting_N>"
            }
            ```

            Where:

            * `update_mask`: List of parameters to update as a single string, separated by commas.

              In this case, list all the dictionary settings to update.

            * `external_dictionary.name`: Dictionary name.
            * `external_dictionary.structure`: Dictionary structure.
                * `id.name`: Dictionary key column name.
                * `key.attributes`: Array of descriptions for columns with dictionary data.
                * `range_min`: Description of the start column, required if using `RANGE_HASHED` as the memory layout type.
                * `range_max`: Description of the end column, required if using `RANGE_HASHED` as the memory layout type.
                * `attributes`: Array of descriptions of the fields available for database queries.

                {% include [structure](../../_includes/mdb/mch/note-ext-dict-structure.md) %}

            * `external_dictionary.layout`: Memory layout type for the dictionary.
            * `external_dictionary.fixed_lifetime`: Fixed interval between dictionary updates in seconds.
            * `external_dictionary.lifetime_range`: Time range for {{ CH }} to randomly select the time for update. This is necessary for distributing the load on the dictionary source when upgrading on a large number of servers.

              {% include [lifetime single](../../_includes/mdb/mch/note-ext-dict-lifetime-grpcapi.md) %}

            * `external_dictionary.***_source`: Dictionary data source settings. Select one of the sources and specify its settings:
                * `http_source`: HTTP(s) source.
                * `mysql_source`: {{ MY }} source.
                * `clickhouse_source`: {{ CH }} source.
                * `mongodb_source`: {{ MG }} source.
                * `postgresql_source`: {{ PG }} source.

            For a detailed description of the dictionary attributes and other settings, see [below](#settings).

            You can get the cluster ID with a [list of clusters in the folder](./cluster-list.md#list-clusters).

        1. Run this request:

            ```bash
            grpcurl \
              -format json \
              -import-path ~/cloudapi/ \
              -import-path ~/cloudapi/third_party/googleapis/ \
              -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
              -rpc-header "Authorization: Bearer $IAM_TOKEN" \
              -d @ \
              {{ api-host-mdb }}:{{ port-https }} \
              yandex.cloud.mdb.clickhouse.v1.ClusterService.UpdateExternalDictionary \
              < body.json
            ```

    1. View the [server response](../api-ref/grpc/Cluster/updateExternalDictionary.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Deleting a dictionary {#delete-dictionary}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Click the cluster name and open the **{{ ui-key.yacloud.clickhouse.cluster.switch_dictionaries }}** tab.
    1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the dictionary you want to delete and select **{{ ui-key.yacloud.mdb.cluster.dictionaries.button_action-delete }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To remove an external dictionary:

    1. View a description of the CLI command for removing a dictionary:

        ```bash
        {{ yc-mdb-ch }} cluster remove-external-dictionary --help
        ```

    1. Run the command to remove a dictionary:

        ```bash
        {{ yc-mdb-ch }} cluster remove-external-dictionary \
           --name=<cluster_name> \
           --dict-name=<dictionary_name>
        ```

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.DeleteExternalDictionary](../api-ref/Cluster/deleteExternalDictionary.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>:deleteExternalDictionary' \
            --data '{
                      "externalDictionaryName": "<dictionary_name>"
                    }'
        ```

        Where `externalDictionaryName` is the name of the dictionary you need to delete. You can request the dictionary name with a [list of external dictionaries in the cluster](#get-dicts-list).

        You can get the cluster ID with a [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/deleteExternalDictionary.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.DeleteExternalDictionary](../api-ref/grpc/Cluster/deleteExternalDictionary.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<cluster_ID>",
                    "external_dictionary_name": "<dictionary_name>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.DeleteExternalDictionary
        ```

        Where `external_dictionary_name` is the name of the dictionary you need to delete. You can request the dictionary name with a [list of external dictionaries in the cluster](#get-dicts-list).

        You can get the cluster ID with a [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/deleteExternalDictionary.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- SQL {#sql}

    1. [Connect](connect/clients.md) to the required database of the {{ mch-name }} cluster using `clickhouse-client`.
    1. Run the `DROP DICTIONARY<DB_name>.<dictionary_name>` [query]({{ ch.docs }}/sql-reference/statements/drop/#drop-dictionary).

{% endlist %}

## Dictionary settings {#settings}

{% list tabs group=instructions %}

- Management console {#console}

  * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_name }}**: Name of the new dictionary.

  * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_source }}**: Dictionary source settings. Select one of the listed sources and specify its settings:

    {% cut "{{ CH }}" %}

    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_host }}**: {{ CH }} host name. This is an optional parameter.

        The host must be in the same network as the {{ CH }} cluster.

    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_port }}**: Port for connecting to the source. This is an optional parameter.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_user }}**: Name of source database user.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_password }}**: Password to access the source database.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_db }}**: Source database name.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_table }}**: Source table name.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_where }}**: Condition for selecting rows to generate a dictionary from. For example, the `id=10` selection condition is the same as the `WHERE id=10` SQL command.
    * (Optional) **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_invalidate-query }}**: SQL query to check for changes in a dictionary. {{ CH }} will update the dictionary only if the result of this query changes.

    {% endcut %}

    {% cut "{{ MG }}" %}

    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_host }}**: {{ MG }} host name. The host must be in the same network as the {{ CH }} cluster.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_port }}**: Port for connecting to the source.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_user }}**: Name of source database user.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_password }}**: Password to access the source database.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_db }}**: Source database name.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_collection }}**: {{ MG }} collection name.

    {% endcut %}

    {% cut "{{ MY }}" %}

    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_replicas }}**: List of {{ MY }} replicas that will be used as the dictionary source.
        For replicas, you can set general connection settings or set up a port, username and password.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_port }}**: Port for connecting to the source.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_user }}**: Name of source database user.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_password }}**: Password to access the source database.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_db }}**: Source database name.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_table }}**: Source table name.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_where }}**: Condition for selecting rows to generate a dictionary from. For example, the `id=10` selection condition is the same as the `WHERE id=10` SQL command.
    * (Optional) **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_invalidate-query }}**: SQL query to check for changes in a dictionary. {{ CH }} will update the dictionary only if the result of this query changes.

    {% endcut %}

    {% cut "{{ PG }}" %}

    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_hosts }}**: Names of the {{ PG }} master host and its [replicas](../../managed-postgresql/concepts/replication.md) that will be used as dictionary sources. The hosts must be in the same network as the {{ CH }} cluster.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_port }}**: Port for connecting to the source.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_user }}**: Name of source database user.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_password }}**: Password to access the source database.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_db }}**: Source database name.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_table }}**: Source table name.
    * (Optional) **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_invalidate-query }}**: SQL query to check for changes in a dictionary. {{ CH }} will update the dictionary only if the result of this query changes.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_postgresql-ssl-mode }}**: Mode of secure SSL TCP/IP connection to the {{ PG }} database. For more information, see the [{{ PG }}](https://www.postgresql.org/docs/current/libpq-connect.html#LIBPQ-PARAMKEYWORDS) documentation.

    {% endcut %}

    {% cut "HTTP(s)" %}

    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_http-url }}**: HTTP(s) source URL.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_http-format }}**: File [format]({{ ch.docs }}/interfaces/formats/#formats) for the HTTP(s) source. Read more about formats in the [{{ CH }}]({{ ch.docs }}/interfaces/formats/#formats) documentation.

    {% endcut %}

    For more information about dictionary sources and their connection parameters, see the [{{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-source/) documentation.

  * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_layout-type }}**: Memory layout type for the dictionary. Supported methods: `flat`, `hashed`, `cache`, `range_hashed`, `complex_key_hashed`, and `complex_key_cache`. For more information about how to store dictionaries in memory, see the [{{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/) documentation.
  * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_size-in-cells }}**: Number of cache cells for the `cache` and `complex_key_cache` methods. For more information, see the [{{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/#cache) documentation.
  * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_structure-id }}**: Dictionary key column name. The key column must be the UInt64 data type. It is used for the `flat`, `hashed`, `cache`, and `range_hashed` methods. For more information, see the [{{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-structure/#ext_dict-numeric-key) documentation.
  * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_structure-attributes }}**: Description of the dictionary's composite key. A composite key may consist of one or more elements. It is used for the `complex_key_hashed` and `complex_key_cache` methods:

    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.column_attributes-name }}**: Column name.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.column_attributes-type }}**: Column data type.
    * (Optional) **{{ ui-key.yacloud.mdb.cluster.dictionaries.column_attributes-nullValue }}**: Default value for an empty element. When loading a dictionary, all empty elements are replaced with this value. You cannot put `NULL` in this field.
    * (Optional) **{{ ui-key.yacloud.mdb.cluster.dictionaries.column_attributes-expression }}** [Expression]({{ ch.docs }}/sql-reference/syntax/#syntax-expressions) {{ CH }} applies to the column value.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.column_attributes-hierarchical }}**: Hierarchical support flag.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.column_attributes-injective }}**: Injective `id` → `attribute` mapping flag.

    For more information about composite key parameters, see the [{{ CH }} documentation]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-structure/#composite-key).

  * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_layout-type }}**: Dictionary update rate settings:

    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_update-interval }}**: Dictionary update frequency. Select the update interval type and settings:

      * **{{ ui-key.yacloud.mdb.cluster.dictionaries.label_fixed-lifetime }}**: Fixed period between dictionary updates:
        * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_fixed-lifetime }}**: Update interval for dictionary data in seconds.

      * **{{ ui-key.yacloud.mdb.cluster.dictionaries.label_range-lifetime }}**: Time range for {{ CH }} to randomly select the time for update. This is necessary for distributing the load on the dictionary source when upgrading on a large number of servers:
        * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_range-lifetime-min }}**: Minimum interval between dictionary updates in seconds.
        * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_range-lifetime-max }}**: Maximum interval between dictionary updates in seconds.

    For more information about updating dictionaries, see the [{{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-lifetime/) documentation.

- CLI {#cli}

  * `--dict-name`: Name of the new dictionary.
  * `--***-source`: Dictionary source settings. Select one of the listed sources and specify its settings:

    {% cut "`--clickhouse-source`: {{ CH }} source" %}

    * `host`: Source host name. This is an optional parameter.

        The host must be in the same network as the {{ CH }} cluster.

    * `port`: Port for connecting to the source. This is an optional parameter.
    * `db`: Source database name.
    * `user`: Name of source database user.
    * `password`: Password to access the source database.
    * `table`: Source table name.
    * `where`: Condition for selecting rows to generate a dictionary from. For example, the `id=10` selection condition is the same as the `WHERE id=10` SQL command.
    * `secure`: Whether to use SSL when establishing the connection.

    {% endcut %}

    {% cut "`--mongodb-source`: {{ MG }} source" %}

    * `host`: Source host name. The host must be in the same network as the {{ CH }} cluster.
    * `port`: Port for connecting to the source.
    * `db`: Source database name.
    * `user`: Name of source database user.
    * `password`: Password to access the source database.
    * `connection`: Name of the collection for the source.

    {% endcut %}

    {% cut "`--mysql-source`: {{ MY }} source" %}

    * `db`: Source database name.
    * `user`: Name of source database user.
    * `password`: Password to access the source database.
    * `table`: Source table name.
    * `where`: Condition for selecting rows to generate a dictionary from. For example, the `id=10` condition is the same as the `WHERE id=10` SQL clause.
    * `share-connection`: Whether to make the connection shared across multiple requests.
    * `close-connection`: Whether to close the connection after each request.

    {% endcut %}

    {% cut "`--postgresql-source`: {{ PG }} source" %}

    * `table`: Source table name.
    * `ssl-mode`: Mode of secure SSL TCP/IP connection to the {{ PG }} database. Acceptable values: `disable`, `allow`, `prefer`, `verify-ca`, and `verify-full`.

    {% endcut %}

    {% cut "`--http-source`: HTTP(s) source" %}

    * `url`: HTTP(s) source URL.
    * `format`: File format for the HTTP(s) source. Read more about formats in the [{{ CH }}]({{ ch.docs }}/interfaces/formats/#formats) documentation.

    {% endcut %}

  * `--http-header`: Special HTTP header for the request to the HTTP(s) source:

    * `name`: Header name.
    * `value`: Header value.

  * `--mysql-replica`: Settings of {{ MY }} source replicas:

    * `host`: Replica host name.
    * `priority`: Replica priority. During a connection attempt, {{ CH }} reads from replicas based on their priority. The lower the number, the higher the priority.
    * `port`: Port for connecting to the replica.
    * `user`: Database user name.
    * `password`: Password for access to the database.

  * `--mysql-invalidate-query`: Query for checking changes in a {{ MY }} dictionary. {{ CH }} updates the dictionary only if the results of this query change.

  * `--postgresql-source-hosts`: Names of the {{ PG }} master host and its [replicas](../../managed-postgresql/concepts/replication.md) that will be used as {{ PG }} sources. The hosts must be in the same network as the {{ CH }} cluster.

  * `--postgresql-invalidate-query`: Query for checking changes in a {{ PG }} dictionary. {{ CH }} updates the dictionary only if the results of this query change.

  * `--layout-type`: Memory layout type for the dictionary. Supported methods: `flat`, `hashed`, `cache`, `range_hashed`, `complex_key_hashed`, and `complex_key_cache`. For more information about how to store dictionaries in memory, see the [{{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/) documentation.
  * `--layout-size-in-cells`: Number of cache cells for the `cache` and `complex_key_cache` methods. For more information about the cache, see the [{{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/#cache) documentation.
  * `--layout-max-array-size`: Maximum key value for the `flat` method. Determines the memory size used by the dictionary, this size being proportional to the biggest key value. For more information about the key value, see the [{{ CH }} documentation]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/#flat).
  * `--structure-id`: Dictionary key column name. The key column must be the UInt64 data type. It is used for the `flat`, `hashed`, `cache`, and `range_hashed` methods. For more information about keys, see the [{{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-structure/#ext_dict-numeric-key) documentation.
  * `--structure-key`: Description of the dictionary's composite key. A composite key may consist of one or more elements. It is used for the `complex_key_hashed` and `complex_key_cache` methods:

    * `name`: Column name.
    * `type`: Column data type.
    * `null-value`: Default value for an empty element. When loading a dictionary, all empty elements are replaced with this value. You cannot put `NULL` in this field.
    * `expression`: [Expression]({{ ch.docs }}/sql-reference/syntax/#syntax-expressions) {{ CH }} applies to the column value.
    * `hierarchical`: Hierarchical support flag.
    * `injective`: Injective `id` → `attribute` mapping flag.

    For more information about composite key parameters, see the [{{ CH }} documentation]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-structure/#composite-key).

    {% note warning %}

    The `--structure-id` and `--structure-key` settings are mutually exclusive, i.e., the use of one makes it impossible to use the other.

    {% endnote %}

  * `--structure-attribute`: Description of the fields available for database queries.

    * `name`: Column name.
    * `type`: Column data type.
    * `null-value`: Default value for an empty element. When loading a dictionary, all empty elements are replaced with this value. You cannot put `NULL` in this field.
    * `expression`: [Expression]({{ ch.docs }}/sql-reference/syntax/#syntax-expressions) {{ CH }} applies to the column value.
    * `hierarchical`: Hierarchical support flag.
    * `injective`: Injective `id` → `attribute` mapping flag.

  * `--fixed-lifetime`: Fixed interval between dictionary updates in seconds.
  * `--lifetime-range`: Time range for {{ CH }} to randomly select the time for update. This is necessary for distributing the load on the dictionary source when upgrading on a large number of servers.

    * `min`: Minimum interval between dictionary updates in seconds.
    * `max`: Maximum interval between dictionary updates in seconds.

    {% note warning %}

    The `--fixed-lifetime` and `--lifetime-range` settings are mutually exclusive, i.e., the use of one makes it impossible to use the other.

    {% endnote %}

- REST API {#api}

  * `externalDictionary`: New dictionary settings:

    * `name`: Name of the new dictionary.
    * `***Source`: Dictionary data source. Select one of the listed sources and specify its settings:

      {% cut "`clickhouseSource`: {{ CH }} source" %}

      * `db`: Source database name.
      * `table`: Source table name.
      * `where`: Condition for selecting rows to generate a dictionary from. For example, the `id=10` selection condition is the same as the `WHERE id=10` SQL command.
      * `host`: Source host name. This is an optional parameter.

          The host must be in the same network as the {{ CH }} cluster.

      * `port`: Port for connecting to the source. This is an optional parameter.
      * `user`: Name of source database user.
      * `password`: Password to access the source database.
      * `secure`: Whether to use SSL to establish the connection.

      {% endcut %}

      {% cut "`mongodbSource`: {{ MG }} source" %}

      * `db`: Source database name.
      * `host`: Source host name. The host must be in the same network as the {{ CH }} cluster.
      * `port`: Port for connecting to the source.
      * `user`: Name of source database user.
      * `password`: Password to access the source database.
      * `collection`: Name of the collection for the source.

      {% endcut %}

      {% cut "`mysqlSource`: {{ MY }} source" %}

      * `db`: Source database name.
      * `table`: Source table name.
      * `where`: Condition for selecting rows to generate a dictionary from. For example, the `id=10` condition is the same as the `WHERE id=10` SQL clause.
      * `user`: Name of source database user.
      * `password`: Password to access the source database.
      * `replicas`: Settings for source replicas:
        * `host`: Replica host name. The host must be in the same network as the {{ CH }} cluster.
        * `priority`: Replica priority. During a connection attempt, {{ CH }} reads from replicas based on their priority. The lower the number, the higher the priority.
        * `port`: Port for connecting to the replica.
        * `user`: Database user name.
        * `password`: Password for access to the database.
      * `invalidateQuery`: Query for checking changes in a {{ MY }} dictionary. {{ CH }} updates the dictionary only if the results of this query change.
      * `shareConnection`: Whether to make the connection shared across multiple requests.
      * `closeConnection`: Whether to close the connection after each request.

      {% endcut %}

      {% cut "`postgresqlSource`: {{ PG }} source" %}

      * `db`: Source database name.
      * `table`: Source table name.
      * `port`: Port for connecting to the source.
      * `user`: Name of source database user.
      * `password`: Password to access the source database.
      * `sslMode`: Mode of secure SSL TCP/IP connection to the {{ PG }} database. Acceptable values: `DISABLE`, `ALLOW`, `PREFER`, `VERIFY_CA`, and `VERIFY_FULL`.
      * `hosts`: Names of the {{ PG }} master host and its [replicas](../../managed-postgresql/concepts/replication.md) that will be used as dictionary sources. The hosts must be in the same network as the {{ CH }} cluster.
      * `invalidateQuery`: SQL query to check for changes in a dictionary. {{ CH }} will update the dictionary only if the result of this query changes.

      {% endcut %}

      {% cut "`httpSource`: HTTP(s) source" %}

      * `url`: HTTP(s) source URL.
      * `format`: File format for the HTTP(s) source. Read more about formats in the [{{ CH }}]({{ ch.docs }}/interfaces/formats/#formats) documentation.
      * `headers`: Special HTTP headers for the request to the source:
        * `name`: Header name.
        * `value`: Header value.

      {% endcut %}

    * `layout.type`: Memory layout type for the dictionary. Supported methods: `FLAT`, `HASHED`, `CACHE`, `RANGE_HASHED`, `COMPLEX_KEY_HASHED`, and `COMPLEX_KEY_CACHE`. For more information about how to store dictionaries in memory, see the [{{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/) documentation.
    * `layout.sizeInCells`: Number of cache cells for the `CACHE` and `COMPLEX_KEY_CACHE` methods. For more information about the cache, see the [{{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/#cache) documentation.
    * `layout.maxArraySize`: Maximum key value for the `FLAT` method. Determines the memory size used by the dictionary, this size being proportional to the biggest key value. For more information about the key value, see the [{{ CH }} documentation]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/#flat).
    * `structure.id.name`: Dictionary key column name. The key column must be the UInt64 data type. It is used for the `FLAT`, `HASHED`, `CACHE`, and `RANGE_HASHED` methods. For more information about keys, see the [{{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-structure/#ext_dict-numeric-key) documentation.
    * `structure.key.attributes`: Description of the dictionary's composite key. A composite key may consist of one or more elements. It is used for the `COMPLEX_KEY_HASHED` and `COMPLEX_KEY_CACHE` methods:

      * `name`: Column name.
      * `type`: Column data type.
      * `nullValue`: Default value for an empty element. When loading a dictionary, all empty elements are replaced with this value. You cannot put `NULL` in this field.
      * `expression`: [Expression]({{ ch.docs }}/sql-reference/syntax/#syntax-expressions) {{ CH }} applies to the column value.
      * `hierarchical`: Hierarchical support flag.
      * `injective`: Injective `id` → `attribute` mapping flag.

      For more information about composite key parameters, see the [{{ CH }} documentation]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-structure/#composite-key).

      {% include [structure](../../_includes/mdb/mch/note-ext-dict-structure.md) %}

    * `structure.attributes`: Description of the fields available for database queries.

      * `name`: Column name.
      * `type`: Column data type.
      * `nullValue`: Default value for an empty element. When loading a dictionary, all empty elements are replaced with this value. You cannot put `NULL` in this field.
      * `expression`: [Expression]({{ ch.docs }}/sql-reference/syntax/#syntax-expressions) {{ CH }} applies to the column value.
      * `hierarchical`: Hierarchical support flag.
      * `injective`: Injective `id` → `attribute` mapping flag.

    * `fixedLifetime`: Fixed interval between dictionary updates in seconds.
    * `lifetimeRange`: Time range for {{ CH }} to randomly select the time for update. This is necessary for distributing the load on the dictionary source when upgrading on a large number of servers. The settings for the range boundaries are as follows:

      * `min`: Minimum interval between dictionary updates in seconds.
      * `max`: Maximum interval between dictionary updates in seconds.

      {% include [lifetime single](../../_includes/mdb/mch/note-ext-dict-lifetime-restapi.md) %}

- gRPC API {#grpc-api}

  * `external_dictionary`: New dictionary settings:

    * `name`: Name of the new dictionary.
    * `***_source`: Dictionary data source. Select one of the listed sources and specify its settings:

      {% cut "`clickhouse_source`: {{ CH }} source" %}

      * `db`: Source database name.
      * `table`: Source table name.
      * `where`: Condition for selecting rows to generate a dictionary from. For example, the `id=10` selection condition is the same as the `WHERE id=10` SQL command.
      * `host`: Source host name. This is an optional parameter.

          The host must be in the same network as the {{ CH }} cluster.

      * `port`: Port for connecting to the source. This is an optional parameter.
      * `user`: Name of source database user.
      * `password`: Password to access the source database.
      * `secure`: Whether to use SSL to establish the connection.

      {% endcut %}

      {% cut "`mongodb_source`: {{ MG }} source" %}

      * `db`: Source database name.
      * `host`: Source host name. The host must be in the same network as the {{ CH }} cluster.
      * `port`: Port for connecting to the source.
      * `user`: Name of source database user.
      * `password`: Password to access the source database.
      * `collection`: Name of the collection for the source.

      {% endcut %}

      {% cut "`mysql_source`: {{ MY }} source" %}

      * `db`: Source database name.
      * `table`: Source table name.
      * `where`: Condition for selecting rows to generate a dictionary from. For example, the `id=10` condition is the same as the `WHERE id=10` SQL clause.
      * `user`: Name of source database user.
      * `password`: Password to access the source database.
      * `replicas`: Settings for source replicas:
        * `host`: Replica host name. The host must be in the same network as the {{ CH }} cluster.
        * `priority`: Replica priority. During a connection attempt, {{ CH }} reads from replicas based on their priority. The lower the number, the higher the priority.
        * `port`: Port for connecting to the replica.
        * `user`: Database user name.
        * `password`: Password for access to the database.
      * `invalidate_query`: Query for checking changes in a {{ MY }} dictionary. {{ CH }} updates the dictionary only if the results of this query change.
      * `share_connection`: Whether to make the connection shared across multiple requests.
      * `close_connection`: Whether to close the connection after each request.

      {% endcut %}

      {% cut "`postgresql_source`: {{ PG }} source" %}

      * `db`: Source database name.
      * `table`: Source table name.
      * `port`: Port for connecting to the source.
      * `user`: Name of source database user.
      * `password`: Password to access the source database.
      * `ssl_mode`: Mode of secure SSL TCP/IP connection to the {{ PG }} database. Acceptable values: `DISABLE`, `ALLOW`, `PREFER`, `VERIFY_CA`, and `VERIFY_FULL`.
      * `hosts`: Names of the {{ PG }} master host and its [replicas](../../managed-postgresql/concepts/replication.md) that will be used as dictionary sources. The hosts must be in the same network as the {{ CH }} cluster.
      * `invalidate_query`: SQL query to check for changes in a dictionary. {{ CH }} will update the dictionary only if the result of this query changes.

      {% endcut %}

      {% cut "`http_source`: HTTP(s) source" %}

      * `url`: HTTP(s) source URL.
      * `format`: File format for the HTTP(s) source. Read more about formats in the [{{ CH }}]({{ ch.docs }}/interfaces/formats/#formats) documentation.
      * `headers`: Special HTTP headers for the request to the source:
        * `name`: Header name.
        * `value`: Header value.

      {% endcut %}

    * `layout.type`: Memory layout type for the dictionary. Supported methods: `FLAT`, `HASHED`, `CACHE`, `RANGE_HASHED`, `COMPLEX_KEY_HASHED`, and `COMPLEX_KEY_CACHE`. For more information about how to store dictionaries in memory, see the [{{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/) documentation.
    * `layout.size_in_cells`: Number of cache cells for the `CACHE` and `COMPLEX_KEY_CACHE` methods. For more information about the cache, see the [{{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/#cache) documentation.
    * `layout.max_array_size`: Maximum key value for the `FLAT` method. Determines the memory size used by the dictionary, this size being proportional to the biggest key value. For more information about the key value, see the [{{ CH }} documentation]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/#flat).
    * `structure.id.name`: Dictionary key column name. The key column must be the UInt64 data type. It is used for the `FLAT`, `HASHED`, `CACHE`, and `RANGE_HASHED` methods. For more information about keys, see the [{{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-structure/#ext_dict-numeric-key) documentation.
    * `structure.key.attributes`: Description of the dictionary's composite key. A composite key may consist of one or more elements. It is used for the `COMPLEX_KEY_HASHED` and `COMPLEX_KEY_CACHE` methods:

      * `name`: Column name.
      * `type`: Column data type.
      * `null_value`: Default value for an empty element. When loading a dictionary, all empty elements are replaced with this value. You cannot put `NULL` in this field.
      * `expression`: [Expression]({{ ch.docs }}/sql-reference/syntax/#syntax-expressions) {{ CH }} applies to the column value.
      * `hierarchical`: Hierarchical support flag.
      * `injective`: Injective `id` → `attribute` mapping flag.

      For more information about composite key parameters, see the [{{ CH }} documentation]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-structure/#composite-key).

      {% include [structure](../../_includes/mdb/mch/note-ext-dict-structure.md) %}

    * `structure.attributes`: Description of the fields available for database queries.

      * `name`: Column name.
      * `type`: Column data type.
      * `null_value`: Default value for an empty element. When loading a dictionary, all empty elements are replaced with this value. You cannot put `NULL` in this field.
      * `expression`: [Expression]({{ ch.docs }}/sql-reference/syntax/#syntax-expressions) {{ CH }} applies to the column value.
      * `hierarchical`: Hierarchical support flag.
      * `injective`: Injective `id` → `attribute` mapping flag.

    * `fixed_lifetime`: Fixed interval between dictionary updates in seconds.
    * `lifetime_range`: Time range for {{ CH }} to randomly select the time for update. This is necessary for distributing the load on the dictionary source when upgrading on a large number of servers. The settings for the range boundaries are as follows:

      * `min`: Minimum interval between dictionary updates in seconds.
      * `max`: Maximum interval between dictionary updates in seconds.

      {% include [lifetime single](../../_includes/mdb/mch/note-ext-dict-lifetime-grpcapi.md) %}

{% endlist %}

## Examples {#examples}

Let's assume there is a {{ CH }} cluster named `mych` with the `{{ cluster-id }}` ID, and you need to connect to it a dictionary with the following test characteristics:

* Dictionary name: `mychdict`.
* Key column name: `id`.
* Fields available for database queries:
    * `id`, `UInt64` type.
    * `field1`, `String` type.
* Fixed interval between dictionary updates: 300 seconds.
* Memory layout type for the dictionary: `cache` with cache size of 1024 cells.
* {{ PG }} source:
    * Database: `db1`.
    * Table name: `table1`.
    * Port for connection: `{{ port-mpg }}`.
    * Database user name: `user1`.
    * Password for access to the database: `user1user1`.
    * Mode of secure SSL TCP/IP connection to the database: `verify-full`.
    * Master host's special FQDN: `c-c9qash3nb1v9********.rw.{{ dns-zone }}`.

{% list tabs group=instructions %}

- CLI {#cli}

    Run the following command:

    ```bash
    {{ yc-mdb-ch }} cluster add-external-dictionary \
       --name=mych \
       --dict-name=mychdict \
       --structure-id=id \
       --structure-attribute name=id,`
                            `type=UInt64,`
                            `name=field1,`
                            `type=String \
       --fixed-lifetime=300 \
       --layout-type=cache \
       --layout-size-in-cells 1024 \
       --postgresql-source db=db1,`
                          `table=table1,`
                          `port={{ port-mpg }},`
                          `user=user1,`
                          `password=user1user1,`
                          `ssl-mode=verify-full \
       --postgresql-source-hosts=c-c9qash3nb1v9********.rw.{{ dns-zone }}
    ```

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Create a file named `body.json` and add the following contents to it:

        ```json
        {
          "externalDictionary": {
            "name": "mychdict",
            "structure": {
              "id": {
                "name": "id"
              },
              "attributes": [
                {
                  "name": "id",
                  "type": "UInt64"
                },
                {
                  "name": "field1",
                  "type": "String"
                }
              ]
            },
            "layout": {
              "type": "CACHE",
              "sizeInCells": "1024"
            },
            "fixedLifetime": "300",
            "postgresqlSource": {
              "db": "db1",
              "table": "table",
              "port": "5432",
              "user": "user1",
              "password": "user1user1",
              "sslMode": "VERIFY_FULL",
              "hosts": ["c-c9qash3nb1v9********.rw.{{ dns-zone }}"]
            }
          }
        }
        ```

    1. Run a query using {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/{{ cluster-id }}:createExternalDictionary' \
            --data '@body.json'
        ```

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Create a file named `body.json` and add the following contents to it:

        ```json
        {
          "cluster_id": "{{ cluster-id }}",
          "external_dictionary": {
            "name": "mychdict",
            "structure": {
              "id": {
                "name": "id"
              },
              "attributes": [
                {
                  "name": "id",
                  "type": "UInt64"
                },
                {
                  "name": "field1",
                  "type": "String"
                }
              ]
            },
            "layout": {
              "type": "CACHE",
              "size_in_cells": "1024"
            },
            "fixed_lifetime": "300",
            "postgresql_source": {
              "db": "db1",
              "table": "table",
              "port": "5432",
              "user": "user1",
              "password": "user1user1",
              "ssl_mode": "VERIFY_FULL",
              "hosts": ["c-c9qash3nb1v9********.rw.{{ dns-zone }}"]
            }
          }
        }
        ```

    1. Run a query using {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.CreateExternalDictionary \
            < body.json
        ```

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
