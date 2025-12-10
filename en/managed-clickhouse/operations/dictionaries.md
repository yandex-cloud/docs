# Connecting external dictionaries in {{ mch-name }}

You can connect [external dictionaries](../concepts/dictionaries.md#external-dicts) to your cluster and disconnect them. For more information about dictionaries, see [this {{ CH }} article]({{ ch.docs }}/sql-reference/dictionaries/).

{{ mch-name }} supports the following types of dictionary sources:

* {{ CH }}
* HTTP(s)
* {{ SD }}
* {{ MY }}
* {{ PG }}

You can manage dictionaries either via SQL (recommended) or via {{ yandex-cloud }} cloud interfaces.

{% note info %}

The number of dictionaries you can connect to a cluster is limited. To learn more about limits, see [Quotas and limits](../concepts/limits.md).

{% endnote %}

## Getting a list of dictionaries {#get-dicts-list}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Click the cluster name and select the **{{ ui-key.yacloud.clickhouse.cluster.switch_dictionaries }}** tab.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get a list of external dictionaries in a {{ CH }} cluster:

    1. View the description of the CLI command for getting detailed cluster information:

        ```bash
        {{ yc-mdb-ch }} cluster get --help
        ```

    1. Run this command:

        ```bash
        {{ yc-mdb-ch }} cluster get <cluster_name>
        ```

    You can find the connected dictionaries in the `dictionaries:` section of the command output.

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.ListExternalDictionaries](../api-ref/Cluster/listExternalDictionaries.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>/externalDictionaries'
        ```

        You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/listExternalDictionaries.md#yandex.cloud.mdb.clickhouse.v1.ListClusterExternalDictionariesResponse) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [ClusterService.ListExternalDictionaries](../api-ref/grpc/Cluster/listExternalDictionaries.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

        You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/listExternalDictionaries.md#yandex.cloud.mdb.clickhouse.v1.ListClusterExternalDictionariesResponse) to make sure your request was successful.

- SQL {#sql}

    1. [Connect](connect/clients.md) to the required database of the {{ mch-name }} cluster using `clickhouse-client`.
    1. Run the `SHOW DICTIONARIES` [query]({{ ch.docs }}/sql-reference/statements/show/#show-dictionaries).

{% endlist %}

## Creating a dictionary {#add-dictionary}

{% note info %}

* Dictionaries created via the {{ yandex-cloud }} interfaces are located in the {{ CH }} cluster’s global namespace. When using SQL, you can only create a dictionary in the specified database and it will reside in that database's namespace.
* When creating an external dictionary via SQL, more sources and settings are available. For example, you can only create dictionaries from a Redis or Cassandra source via SQL.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

    {% note warning %}

    If you create a dictionary in the console, you cannot manage it via SQL.

    {% endnote %}

    1. In the [management console]({{ link-console-main }}), navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Click the cluster name and select the **{{ ui-key.yacloud.clickhouse.cluster.switch_dictionaries }}** tab.
    1. In the top-right corner, click **{{ ui-key.yacloud.mdb.cluster.dictionaries.button-action_add-dictionary }}**.
    1. [Configure your dictionary](#settings).
    1. Click **{{ ui-key.yacloud.mdb.cluster.dictionaries.button_submit }}**.

- CLI {#cli}

    {% note warning %}

    If you add a dictionary via the CLI, you cannot manage it via SQL.

    {% endnote %}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To create an external dictionary in a {{ CH }} cluster:

    1. View the description of the CLI command for adding dictionaries:

        ```bash
        {{ yc-mdb-ch }} cluster add-external-dictionary --help
        ```

    1. Run the command to add a dictionary, specifying [its settings](#settings):

        ```bash
        {{ yc-mdb-ch }} cluster add-external-dictionary \
           --name=<{{ CH }}_cluster_name> \
           --dict-name=<dictionary_name> \
           ...
        ```

- REST API {#api}

    {% note warning %}

    If you add a dictionary via the API, you cannot manage it via SQL.

    {% endnote %}

    To create an external dictionary in a {{ CH }} cluster:

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.CreateExternalDictionary](../api-ref/Cluster/createExternalDictionary.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        1. Create a file named `body.json` and paste the following code into it:

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
                  "rangeMin": {<RANGE_HASHED_initial_column>},
                  "rangeMax": {<RANGE_HASHED_final_column>},
                  "attributes": [
                     <field_description_array>
                  ]
                },
                "layout": {<memory_layout>},
                "fixedLifetime": "<fixed_update_interval>",
                "lifetimeRange": {<range_for_selecting_update_interval>},
                "httpSource": {<HTTP(s)_source_settings>},
                "mysqlSource": {<{{ MY }}_source_settings>},
                "clickhouseSource": {<{{ CH }}_source_settings>},
                "mongodbSource": {<Yandex_StoreDoc_source_settings>},
                "postgresqlSource": {<{{ PG }}_source_settings>}
              }
            }
            ```

            Where:

            * `externalDictionary.name`: Dictionary name.
            * `externalDictionary.structure`: Dictionary structure:
                * `id.name`: Dictionary key column name.
                * `key.attributes`: Array describing the dictionary's composite key.
                * `rangeMin`: Description of the initial column required when using the `RANGE_HASHED` memory layout.
                * `rangeMax`: Description of the final column required when using the `RANGE_HASHED` memory layout.
                * `attributes`: Array of descriptions of the fields available for database queries.

                {% include [structure](../../_includes/mdb/mch/note-ext-dict-structure.md) %}

            * `externalDictionary.layout`: Memory layout for the dictionary.
            * `externalDictionary.fixedLifetime`: Fixed interval between dictionary updates, in seconds.
            * `externalDictionary.lifetimeRange`: Time range for {{ CH }} to randomly select the time for update. This helps distribute the dictionary source load when updating across many servers.

              {% include [lifetime single](../../_includes/mdb/mch/note-ext-dict-lifetime-restapi.md) %}

            * `externalDictionary.***Source`: Dictionary data source settings. Select one of the following sources and specify its settings:
                * `httpSource`: HTTP(s) source
                * `mysqlSource`: {{ MY }} source
                * `clickhouseSource`: {{ CH }} source
                * `mongodbSource`: {{ SD }} source
                * `postgresqlSource`: {{ PG }} source

            For a detailed description of the dictionary attributes and other settings, see [below](#settings).

        1. Run this query:

            ```bash
            curl \
              --request POST \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --header "Content-Type: application/json" \
              --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>:createExternalDictionary' \
              --data '@body.json'
            ```

            You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/createExternalDictionary.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    {% note warning %}

    If you add a dictionary via the API, you cannot manage it via SQL.

    {% endnote %}

    To create an external dictionary in a {{ CH }} cluster:

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [ClusterService.CreateExternalDictionary](../api-ref/grpc/Cluster/createExternalDictionary.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        1. Create a file named `body.json` and paste the following code into it:

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
                  "range_min": {<RANGE_HASHED_initial_column>},
                  "range_max": {<RANGE_HASHED_final_column>},
                  "attributes": [<field_description_array>]
                },
                "layout": {<memory_layout>},
                "fixed_lifetime": "<fixed_update_interval>",
                "lifetime_range": {<range_for_selecting_update_interval>},
                "http_source": {<HTTP(s)_source_settings>},
                "mysql_source": {<{{ MY }}_source_settings>},
                "clickhouse_source": {<{{ CH }}_source_settings>},
                "mongodb_source": {<Yandex_StoreDoc_source_settings>},
                "postgresql_source": {<{{ PG }}_source_settings>}
              }
            }
            ```

            Where:

            * `external_dictionary.name`: Dictionary name.
            * `external_dictionary.structure`: Dictionary structure:
                * `id.name`: Dictionary key column name.
                * `key.attributes`: Array of descriptions of columns with dictionary data.
                * `range_min`: Description of the initial column required when using the `RANGE_HASHED` memory layout.
                * `range_max`: Description of the final column required when using the `RANGE_HASHED` memory layout.
                * `attributes`: Array of descriptions of the fields available for database queries.

                {% include [structure](../../_includes/mdb/mch/note-ext-dict-structure.md) %}

            * `external_dictionary.layout`: Memory layout for the dictionary.
            * `external_dictionary.fixed_lifetime`: Fixed interval between dictionary updates, in seconds.
            * `external_dictionary.lifetime_range`: Time range for {{ CH }} to randomly select the time for update. This helps distribute the dictionary source load when updating across many servers.

              {% include [lifetime single](../../_includes/mdb/mch/note-ext-dict-lifetime-grpcapi.md) %}

            * `external_dictionary.***_source`: Dictionary data source settings. Select one of the following sources and specify its settings:
                * `http_source`: HTTP(s) source
                * `mysql_source`: {{ MY }} source
                * `clickhouse_source`: {{ CH }} source
                * `mongodb_source`: {{ SD }} source
                * `postgresql_source`: {{ PG }} source

            For a detailed description of the dictionary attributes and other settings, see [below](#settings).

            You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

        1. Run this query:

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

    1. View the [server response](../api-ref/grpc/Cluster/createExternalDictionary.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- SQL {#sql}

    {% note warning %}

    If you add a dictionary via SQL, you cannot manage it via the console, CLI, or API.

    {% endnote %}

    1. [Connect](connect/clients.md) to the required database of the {{ mch-name }} cluster using `clickhouse-client`.
    1. Run this [DDL query]({{ ch.docs }}/sql-reference/statements/create/dictionary/):

        ```sql
        CREATE DICTIONARY <dictionary_name>(
          <data_columns>
        )
        PRIMARY KEY <name_of_column_with_keys>
        SOURCE(<source>(<source_configuration>))
        LIFETIME(<update_interval>)
        LAYOUT(<memory_layout>());
        ```

        Where:

        * `<dictionary_name>`: Name of the new dictionary.
        * `<data_columns>`: List of columns with dictionary entries and their type.
        * `PRIMARY KEY`: Dictionary key column name.
        * `SOURCE`: Source and its parameters.
        * `LIFETIME`: Dictionary update interval.
        * `LAYOUT`: Memory layout for the dictionary. The supported layout types include:
          * `flat`
          * `hashed`
          * `cache`
          * `range_hashed`
          * `complex_key_hashed`
          * `complex_key_cache`

    For more information about the settings, see [this {{ CH }} guide]({{ ch.docs }}/sql-reference/dictionaries/#dbms).

{% endlist %}

## Updating a dictionary {#update-dictionary}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Click the cluster name and select the **{{ ui-key.yacloud.clickhouse.cluster.switch_dictionaries }}** tab.
    1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the row with the dictionary and select **{{ ui-key.yacloud.common.edit }}**.
    1. Change the [dictionary settings](#settings) as needed.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To update an external dictionary in a {{ CH }} cluster:

    1. View the description of the CLI command for updating dictionaries:

        ```bash
        {{ yc-mdb-ch }} cluster update-external-dictionary --help
        ```

    1. Run the command to add a dictionary, specifying [its settings](#settings):

        ```bash
        {{ yc-mdb-ch }} cluster update-external-dictionary \
           --name <{{ CH }}_cluster_name> \
           --dict-name <dictionary_name> \
           ...
        ```

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.UpdateExternalDictionary](../api-ref/Cluster/updateExternalDictionary.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        1. Create a file named `body.json` and paste the following code into it:

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
                  "rangeMin": {<RANGE_HASHED_initial_column>},
                  "rangeMax": {<RANGE_HASHED_final_column>},
                  "attributes": [
                     <field_description_array>
                  ]
                },
                "layout": {<memory_layout>},
                "fixedLifetime": "<fixed_update_interval>",
                "lifetimeRange": {<range_for_selecting_update_interval>},
                "httpSource": {<HTTP(s)_source_settings>},
                "mysqlSource": {<{{ MY }}_source_settings>},
                "clickhouseSource": {<{{ CH }}_source_settings>},
                "mongodbSource": {<Yandex_StoreDoc_source_settings>},
                "postgresqlSource": {<{{ PG }}_source_settings>}
              },
              "updateMask": "externalDictionary.<setting_1>,...,externalDictionary.<setting_N>"
            }
            ```

            Where:

            * `updateMask`: Comma-separated string of settings you want to update.

              In this case, list all the dictionary settings to update.

            * `externalDictionary.name`: Dictionary name.
            * `externalDictionary.structure`: Dictionary structure:
                * `id.name`: Dictionary key column name.
                * `key.attributes`: Array describing the dictionary's composite key.
                * `rangeMin`: Description of the initial column required when using the `RANGE_HASHED` memory layout.
                * `rangeMax`: Description of the final column required when using the `RANGE_HASHED` memory layout.
                * `attributes`: Array of descriptions of the fields available for database queries.

                {% include [structure](../../_includes/mdb/mch/note-ext-dict-structure.md) %}

            * `externalDictionary.layout`: Memory layout for the dictionary.
            * `externalDictionary.fixedLifetime`: Fixed interval between dictionary updates, in seconds.
            * `externalDictionary.lifetimeRange`: Time range for {{ CH }} to randomly select the time for update. This helps distribute the dictionary source load when updating across many servers.

              {% include [lifetime single](../../_includes/mdb/mch/note-ext-dict-lifetime-restapi.md) %}

            * `externalDictionary.***Source`: Dictionary data source settings. Select one of the following sources and specify its settings:
                * `httpSource`: HTTP(s) source
                * `mysqlSource`: {{ MY }} source
                * `clickhouseSource`: {{ CH }} source
                * `mongodbSource`: {{ SD }} source
                * `postgresqlSource`: {{ PG }} source

            For a detailed description of the dictionary attributes and other settings, see [below](#settings).

        1. Run this query:

            ```bash
            curl \
              --request POST \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --header "Content-Type: application/json" \
              --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>:updateExternalDictionary' \
              --data '@body.json'
            ```

            You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/updateExternalDictionary.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [ClusterService.UpdateExternalDictionary](../api-ref/grpc/Cluster/updateExternalDictionary.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        1. Create a file named `body.json` and paste the following code into it:

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
                  "range_min": {<RANGE_HASHED_initial_column>},
                  "range_max": {<RANGE_HASHED_final_column>},
                  "attributes": [<field_description_array>]
                },
                "layout": {<memory_layout>},
                "fixed_lifetime": "<fixed_update_interval>",
                "lifetime_range": {<range_for_selecting_update_interval>},
                "http_source": {<HTTP(s)_source_settings>},
                "mysql_source": {<{{ MY }}_source_settings>},
                "clickhouse_source": {<{{ CH }}_source_settings>},
                "mongodb_source": {<Yandex_StoreDoc_source_settings>},
                "postgresql_source": {<{{ PG }}_source_settings>}
              },
              "update_mask": "externalDictionary.<setting_1>,...,externalDictionary.<setting_N>"
            }
            ```

            Where:

            * `update_mask`: Comma-separated string of settings you want to update.

              In this case, list all the dictionary settings to update.

            * `external_dictionary.name`: Dictionary name.
            * `external_dictionary.structure`: Dictionary structure:
                * `id.name`: Dictionary key column name.
                * `key.attributes`: Array of descriptions of columns with dictionary data.
                * `range_min`: Description of the initial column required when using the `RANGE_HASHED` memory layout.
                * `range_max`: Description of the final column required when using the `RANGE_HASHED` memory layout.
                * `attributes`: Array of descriptions of the fields available for database queries.

                {% include [structure](../../_includes/mdb/mch/note-ext-dict-structure.md) %}

            * `external_dictionary.layout`: Memory layout for the dictionary.
            * `external_dictionary.fixed_lifetime`: Fixed interval between dictionary updates, in seconds.
            * `external_dictionary.lifetime_range`: Time range for {{ CH }} to randomly select the time for update. This helps distribute the dictionary source load when updating across many servers.

              {% include [lifetime single](../../_includes/mdb/mch/note-ext-dict-lifetime-grpcapi.md) %}

            * `external_dictionary.***_source`: Dictionary data source settings. Select one of the following sources and specify its settings:
                * `http_source`: HTTP(s) source
                * `mysql_source`: {{ MY }} source
                * `clickhouse_source`: {{ CH }} source
                * `mongodb_source`: {{ SD }} source
                * `postgresql_source`: {{ PG }} source

            For a detailed description of the dictionary attributes and other settings, see [below](#settings).

            You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

        1. Run this query:

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

    1. View the [server response](../api-ref/grpc/Cluster/updateExternalDictionary.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Deleting a dictionary {#delete-dictionary}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Click the cluster name and select the **{{ ui-key.yacloud.clickhouse.cluster.switch_dictionaries }}** tab.
    1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the row with the dictionary and select **{{ ui-key.yacloud.mdb.cluster.dictionaries.button_action-delete }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To delete an external dictionary:

    1. View the description of the CLI command for deleting a dictionary:

        ```bash
        {{ yc-mdb-ch }} cluster remove-external-dictionary --help
        ```

    1. To delete a dictionary, run this command:

        ```bash
        {{ yc-mdb-ch }} cluster remove-external-dictionary \
           --name=<cluster_name> \
           --dict-name=<dictionary_name>
        ```

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.DeleteExternalDictionary](../api-ref/Cluster/deleteExternalDictionary.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

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

        Where `externalDictionaryName` is the name of the dictionary you need to delete. You can get the dictionary name with the [list of external dictionaries in the cluster](#get-dicts-list).

        You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/deleteExternalDictionary.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [ClusterService.DeleteExternalDictionary](../api-ref/grpc/Cluster/deleteExternalDictionary.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

        Where `external_dictionary_name` is the name of the dictionary you need to delete. You can get the dictionary name with the [list of external dictionaries in the cluster](#get-dicts-list).

        You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/deleteExternalDictionary.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- SQL {#sql}

    1. [Connect](connect/clients.md) to the required database of the {{ mch-name }} cluster using `clickhouse-client`.
    1. Run the `DROP DICTIONARY<DB_name>.<dictionary_name>` [query]({{ ch.docs }}/sql-reference/statements/drop/#drop-dictionary).

{% endlist %}

## Dictionary settings {#settings}

{% note warning %}

Changing dictionary settings will restart {{ CH }} servers on the cluster hosts.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_name }}**: Name of the new dictionary. Once a dictionary is created, you cannot change its name.

  * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_source }}**: Dictionary source settings. Select one of the listed sources and specify its settings:

    {% cut "{{ CH }}" %}

    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_host }}**: {{ CH }} host name. This is an optional setting.

        The host must be in the same network as the {{ CH }} cluster.

    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_port }}**: Port for connecting to the source. This is an optional setting.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_user }}**: Name of the source database user.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_password }}**: Password to access the source database.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_db }}**: Source database name.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_table }}**: Source table name.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_where }}**: Condition for selecting rows to build a dictionary from. For example, the `id=10` condition is the same as the `WHERE id=10` SQL clause.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_invalidate-query }}**: SQL query to check for dictionary changes. {{ CH }} will only update the dictionary if the results of this query change. This is an optional setting.

    {% endcut %}

    {% cut "{{ SD }}" %}

    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_host }}**: {{ SD }} host name. The host must be in the same network as the {{ CH }} cluster.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_port }}**: Port for connecting to the source.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_user }}**: Name of the source database user.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_password }}**: Password to access the source database.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_db }}**: Source database name.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_collection }}**: {{ SD }} collection name.

    {% endcut %}

    {% cut "{{ MY }}" %}

    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_replicas }}**: List of {{ MY }} replicas to use as the dictionary source.
        For replicas, you can set general connection settings or set up a port, username, and password.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_port }}**: Port for connecting to the source.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_user }}**: Name of the source database user.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_password }}**: Password to access the source database.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_db }}**: Source database name.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_table }}**: Source table name.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_where }}**: Condition for selecting rows to build a dictionary from. For example, the `id=10` condition is the same as the `WHERE id=10` SQL clause.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_invalidate-query }}**: SQL query to check for dictionary changes. {{ CH }} will only update the dictionary if the results of this query change. This is an optional setting.

    {% endcut %}

    {% cut "{{ PG }}" %}

    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_hosts }}**: Names of the {{ PG }} master host and its [replicas](../../managed-postgresql/concepts/replication.md) to use as dictionary sources. The hosts must be in the same network as the {{ CH }} cluster.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_port }}**: Port for connecting to the source.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_user }}**: Name of the source database user.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_password }}**: Password to access the source database.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_db }}**: Source database name.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_table }}**: Source table name.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_invalidate-query }}**: SQL query to check for dictionary changes. {{ CH }} will only update the dictionary if the results of this query change. This is an optional setting.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_postgresql-ssl-mode }}**: Mode of secure SSL TCP/IP connection to the {{ PG }} database. For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/libpq-connect.html#LIBPQ-PARAMKEYWORDS).

    {% endcut %}

    {% cut "HTTP(s)" %}

    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_http-url }}**: HTTP(s) source URL.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_http-format }}**: File [format]({{ ch.docs }}/interfaces/formats/#formats) for the HTTP(s) source. Read more about formats in [this {{ CH }} article]({{ ch.docs }}/interfaces/formats/#formats).

    {% endcut %}

    For more information about dictionary sources and their connection parameters, see [this {{ CH }} guide]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-source/).

  * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_layout-type }}**: Memory layout for the dictionary. The supported layout types include `flat`, `hashed`, `complex_key_hashed`, `range_hashed`, `cache`, `complex_key_cache`, `sparse_hashed`, `complex_key_sparse_hashed`, `complex_key_range_hashed`, `direct`, `complex_key_direct`, and `ip_trie`. For more information about dictionary layouts, see the [this {{ CH }} guide]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/).
  * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_size-in-cells }}**: Number of cache cells for the `cache` and `complex_key_cache` layouts. For more information, see [this {{ CH }} guide]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/#cache).
  * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_allow-read-expired-keys }}**: Set to allow reading expired keys. This setting is used for the `cache` and `complex_key_cache` layouts. For more information, see [this {{ CH }} guide]({{ ch.docs }}/sql-reference/dictionaries#cache).
  * Settings of the update queue for cache update issues, if keys are not found in the dictionary. These settings are used for the `cache` and `complex_key_cache` layouts.

    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_max-update-queue-size }}**: Maximum number of update issues per queue. The default value is `100000`.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_update-queue-push-timeout-milliseconds }}**: Maximum update issue queuing timeout, in milliseconds. The default value is `10`.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_query-wait-timeout-milliseconds }}**: Maximum update issue completion timeout, in milliseconds. The default value is `60000` (one minute).
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_max-threads-for-updates }}**: Maximum number of threads for cache dictionary update. The default value is `4`.

    For more information, see [this {{ CH }} guide]({{ ch.docs }}/sql-reference/dictionaries#cache).

  * Flat array size settings. They are used for the `flat` layout.

    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_initial-array-size }}**: Initial dictionary key size. The default value is `1024`.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_max-array-size }}**: Maximum dictionary key size. It determines the memory size used by the dictionary, this size being proportional to the largest key value. The default value is `500000`.

    For more information, see [this {{ CH }} guide]({{ ch.docs }}/sql-reference/dictionaries#flat).

  * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_access-to-key-from-attributes }}**: Gets the name of the composite key using the `dictGetString` function. This setting is used for the `ip_trie` layout. Enabling this setting increases RAM usage.
  * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_structure-id }}**: Dictionary key column name. The key column must have the `UInt64` data type. This setting is used for the `flat`, `hashed`, `range_hashed`, `cache`, `sparse_hashed`, and `direct` layouts. For more information, see [this {{ CH }} guide]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-structure/#ext_dict-numeric-key).
  * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_structure-attributes }}**: Description of the dictionary's composite key. The key may consist of one or more elements. This setting is used for the `complex_key_*` and `ip_trie` layouts:

    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.column_attributes-name }}**: Column name.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.column_attributes-type }}**: Column data type.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.column_attributes-nullValue }}**: Default value for an empty element. This is an optional setting. When loading a dictionary, all empty elements are replaced with this value. You cannot put `NULL` in this field.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.column_attributes-expression }}**: [Expression]({{ ch.docs }}/sql-reference/syntax/#syntax-expressions) {{ CH }} applies to the column value. This is an optional setting.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.column_attributes-hierarchical }}**: Hierarchical support flag.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.column_attributes-injective }}**: Injective `id` → `attribute` mapping flag.

    For more information about composite key settings, see [this {{ CH }} guide]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-structure/#composite-key).

  * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_layout-type }}**: Dictionary update rate settings:

    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_update-interval }}**: Dictionary update interval. Select the update interval type and its settings:

      * **{{ ui-key.yacloud.mdb.cluster.dictionaries.label_fixed-lifetime }}**: Fixed period between dictionary updates:
        * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_fixed-lifetime }}**: Dictionary data update interval, in seconds.

      * **{{ ui-key.yacloud.mdb.cluster.dictionaries.label_range-lifetime }}**: Time range for {{ CH }} to randomly select the time for update. This helps distribute the dictionary source load when updating across many servers:
        * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_range-lifetime-min }}**: Minimum interval between dictionary updates, in seconds.
        * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_range-lifetime-max }}**: Maximum interval between dictionary updates, in seconds.

    For more information about updating dictionaries, see [this {{ CH }} guide]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-lifetime/).

- CLI {#cli}

  * `--dict-name`: Name of the new dictionary.
  * `--***-source`: Dictionary source settings. Select one of the listed sources and specify its settings:

    {% cut "`--clickhouse-source`: {{ CH }} source" %}

    * `host`: Source host name. This is an optional setting.

        The host must be in the same network as the {{ CH }} cluster.

    * `port`: Port for connecting to the source. This is an optional setting.
    * `db`: Source database name.
    * `user`: Name of the source database user.
    * `password`: Password to access the source database.
    * `table`: Source table name.
    * `where`: Condition for selecting rows to build a dictionary from. For example, the `id=10` condition is the same as the `WHERE id=10` SQL clause.
    * `secure`: Set to establish an SSL connection.

    {% endcut %}

    {% cut "`--mongodb-source`: {{ SD }} source" %}

    * `host`: Source host name. The host must be in the same network as the {{ CH }} cluster.
    * `port`: Port for connecting to the source.
    * `db`: Source database name.
    * `user`: Name of the source database user.
    * `password`: Password to access the source database.
    * `connection`: Source collection name.

    {% endcut %}

    {% cut "`--mysql-source`: {{ MY }} source" %}

    * `db`: Source database name.
    * `user`: Name of the source database user.
    * `password`: Password to access the source database.
    * `table`: Source table name.
    * `where`: Condition for selecting rows to build a dictionary from. For example, the `id=10` condition is the same as the `WHERE id=10` SQL clause.
    * `share-connection`: Set to share the connection between multiple queries.
    * `close-connection`: Set to close the connection after each query.

    {% endcut %}

    {% cut "`--postgresql-source`: {{ PG }} source" %}

    * `table`: Source table name.
    * `ssl-mode`: Mode of secure SSL TCP/IP connection to the {{ PG }} database. You can set it to `disable`, `allow`, `prefer`, `verify-ca`, or `verify-full`.

    {% endcut %}

    {% cut "`--http-source`: HTTP(s) source" %}

    * `url`: HTTP(s) source URL.
    * `format`: File format for the HTTP(s) source. Read more about formats in [this {{ CH }} article]({{ ch.docs }}/interfaces/formats/#formats).

    {% endcut %}

  * `--http-header`: Special HTTP header for the request to the HTTP(s) source:

    * `name`: Header name.
    * `value`: Header value.

  * `--mysql-replica`: Settings of {{ MY }} source replicas:

    * `host`: Replica host name.
    * `priority`: Replica priority. When attempting to connect, {{ CH }} follows the replica priority order. The lower the number, the higher the priority.
    * `port`: Port for connecting to the replica.
    * `user`: Database user name.
    * `password`: Password to access the database.

  * `--mysql-invalidate-query`: Query to check for {{ MY }} dictionary changes. {{ CH }} will only update the dictionary if the results of this query change.

  * `--postgresql-source-hosts`: Names of the {{ PG }} master host and its [replicas](../../managed-postgresql/concepts/replication.md) to used as a {{ PG }} source. The hosts must be in the same network as the {{ CH }} cluster.

  * `--postgresql-invalidate-query`: Query to check for {{ PG }} dictionary changes. {{ CH }} will only update the dictionary if the results of this query change.

  * `--layout-type`: Memory layout for the dictionary. The supported layout types include `flat`, `hashed`, `complex_key_hashed`, `range_hashed`, `cache`, `complex_key_cache`, `sparse_hashed`, `complex_key_sparse_hashed`, `complex_key_range_hashed`, `direct`, `complex_key_direct`, and `ip_trie`. For more information about dictionary layouts, see the [this {{ CH }} guide]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/).
  * `--layout-size-in-cells`: Number of cache cells for the `cache` and `complex_key_cache` layouts. For more information about cache, see [this {{ CH }} article]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/#cache).
  * `--layout-allow-read-expired-keys`: Set to allow reading expired keys. This setting is used for the `cache` and `complex_key_cache` layouts. For more information, see [this {{ CH }} guide]({{ ch.docs }}/sql-reference/dictionaries#cache).
  * Settings of the update queue for cache update issues, if keys are not found in the dictionary. These settings are used for the `cache` and `complex_key_cache` layouts.

    * `--layout-max-update-queue-size`: Maximum number of update issues per queue. The default value is `100000`.
    * `--layout-update-queue-push-timeout-milliseconds`: Maximum update issue queuing timeout, in milliseconds. The default value is `10`.
    * `--layout-query-wait-timeout-milliseconds`: Maximum update issue completion timeout, in milliseconds. The default value is `60000` (one minute).
    * `--layout-max-threads-for-updates`: Maximum number of threads for cache dictionary update. The default value is `4`.

    For more information, see [this {{ CH }} guide]({{ ch.docs }}/sql-reference/dictionaries#cache).

  * Flat array size settings. They are used for the `flat` layout.

    * `--layout-initial-array-size`: Initial dictionary key size. The default value is `1024`.
    * `--layout-max-array-size`: Maximum dictionary key size. It determines the memory size used by the dictionary, this size being proportional to the largest key value. The default value is `500000`.

    For more information, see [this {{ CH }} guide]({{ ch.docs }}/sql-reference/dictionaries#flat).

  * `--layout-access-to-key-from-attributes`: Gets the name of the composite key using the `dictGetString` function. This setting is used for the `ip_trie` layout. Enabling this setting increases RAM usage.
  * `--structure-id`: Dictionary key column name. The key column must have the `UInt64` data type. This setting is used for the `flat`, `hashed`, `range_hashed`, `cache`, `sparse_hashed`, and `direct` layouts. For more information about keys, see [this {{ CH }} article]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-structure/#ext_dict-numeric-key).
  * `--structure-key`: Description of the dictionary's composite key. The key may consist of one or more elements. This setting is used for the `complex_key_*` and `ip_trie` layouts:

    * `name`: Column name.
    * `type`: Column data type.
    * `null-value`: Default value for an empty element. When loading a dictionary, all empty elements are replaced with this value. You cannot put `NULL` in this field.
    * `expression`: [Expression]({{ ch.docs }}/sql-reference/syntax/#syntax-expressions) {{ CH }} applies to the column value.
    * `hierarchical`: Hierarchical support flag.
    * `injective`: Injective `id` → `attribute` mapping flag.

    For more information about composite key settings, see [this {{ CH }} guide]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-structure/#composite-key).

    {% note warning %}

    The `--structure-id` and `--structure-key` settings are mutually exclusive, so using one means you cannot use the other.

    {% endnote %}

  * `--structure-attribute`: Description of the fields available for database queries:

    * `name`: Column name.
    * `type`: Column data type.
    * `null-value`: Default value for an empty element. When loading a dictionary, all empty elements are replaced with this value. You cannot put `NULL` in this field.
    * `expression`: [Expression]({{ ch.docs }}/sql-reference/syntax/#syntax-expressions) {{ CH }} applies to the column value.
    * `hierarchical`: Hierarchical support flag.
    * `injective`: Injective `id` → `attribute` mapping flag.

  * `--fixed-lifetime`: Fixed interval between dictionary updates, in seconds.
  * `--lifetime-range`: Time range for {{ CH }} to randomly select the time for update. This helps distribute the dictionary source load when updating across many servers.

    * `min`: Minimum interval between dictionary updates, in seconds.
    * `max`: Maximum interval between dictionary updates, in seconds.

    {% note warning %}

    The `--fixed-lifetime` and `--lifetime-range` settings are mutually exclusive, so using one means you cannot use the other.

    {% endnote %}

- REST API {#api}

  * `externalDictionary`: New dictionary settings:

    * `name`: Name of the new dictionary.
    * `***Source`: Dictionary data source. Select one of the listed sources and specify its settings:

      {% cut "`clickhouseSource`: {{ CH }} source" %}

      * `db`: Source database name.
      * `table`: Source table name.
      * `where`: Condition for selecting rows to build a dictionary from. For example, the `id=10` condition is the same as the `WHERE id=10` SQL clause.
      * `host`: Source host name. This is an optional setting.

          The host must be in the same network as the {{ CH }} cluster.

      * `port`: Port for connecting to the source. This is an optional setting.
      * `user`: Name of the source database user.
      * `password`: Password to access the source database.
      * `secure`: Set to establish an SSL connection.

      {% endcut %}

      {% cut "`mongodbSource`: {{ SD }} source" %}

      * `db`: Source database name.
      * `host`: Source host name. The host must be in the same network as the {{ CH }} cluster.
      * `port`: Port for connecting to the source.
      * `user`: Name of the source database user.
      * `password`: Password to access the source database.
      * `collection`: Source collection name.

      {% endcut %}

      {% cut "`mysqlSource`: {{ MY }} source" %}

      * `db`: Source database name.
      * `table`: Source table name.
      * `where`: Condition for selecting rows to build a dictionary from. For example, the `id=10` condition is the same as the `WHERE id=10` SQL clause.
      * `user`: Name of the source database user.
      * `password`: Password to access the source database.
      * `replicas`: Source replica settings:
        * `host`: Replica host name. The host must be in the same network as the {{ CH }} cluster.
        * `priority`: Replica priority. When attempting to connect, {{ CH }} follows the replica priority order. The lower the number, the higher the priority.
        * `port`: Port for connecting to the replica.
        * `user`: Database user name.
        * `password`: Password to access the database.
      * `invalidateQuery`: Query to check for {{ MY }} dictionary changes. {{ CH }} will only update the dictionary if the results of this query change.
      * `shareConnection`: Set to share the connection between multiple queries.
      * `closeConnection`: Set to close the connection after each query.

      {% endcut %}

      {% cut "`postgresqlSource`: {{ PG }} source" %}

      * `db`: Source database name.
      * `table`: Source table name.
      * `port`: Port for connecting to the source.
      * `user`: Name of the source database user.
      * `password`: Password to access the source database.
      * `sslMode`: Mode of secure SSL TCP/IP connection to the {{ PG }} database. You can set it to `DISABLE`, `ALLOW`, `PREFER`, `VERIFY_CA`, or `VERIFY_FULL`.
      * `hosts`: Names of the {{ PG }} master host and its [replicas](../../managed-postgresql/concepts/replication.md) to use as dictionary sources. The hosts must be in the same network as the {{ CH }} cluster.
      * `invalidateQuery`: Query to check for dictionary changes. {{ CH }} will only update the dictionary if the results of this query change.

      {% endcut %}

      {% cut "`httpSource`: HTTP(s) source" %}

      * `url`: HTTP(s) source URL.
      * `format`: File format for the HTTP(s) source. Read more about formats in [this {{ CH }} article]({{ ch.docs }}/interfaces/formats/#formats).
      * `headers`: Special HTTP headers for the request to the source:
        * `name`: Header name.
        * `value`: Header value.

      {% endcut %}

    * `layout.type`: Memory layout for the dictionary. The supported layout types include `FLAT`, `HASHED`, `COMPLEX_KEY_HASHED`, `RANGE_HASHED`, `CACHE`, `COMPLEX_KEY_CACHE`, `SPARSE_HASHED`, `COMPLEX_KEY_SPARSE_HASHED`, `COMPLEX_KEY_RANGE_HASHED`, `DIRECT`, `COMPLEX_KEY_DIRECT`, and `IP_TRIE`. For more information about dictionary layouts, see the [this {{ CH }} guide]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/).
    * `layout.sizeInCells`: Number of cache cells for the `CACHE` and `COMPLEX_KEY_CACHE` layouts. For more information about cache, see [this {{ CH }} article]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/#cache).
    * `layout.allowReadExpiredKeys`: Set to allow reading expired keys. This setting is used for the `CACHE` and `COMPLEX_KEY_CACHE` layouts. For more information, see [this {{ CH }} guide]({{ ch.docs }}/sql-reference/dictionaries#cache).
    * Settings of the update queue for cache update issues, if keys are not found in the dictionary. They are used for the `CACHE` and `COMPLEX_KEY_CACHE` layouts.

      * `layout.maxUpdateQueueSize`: Maximum number of update issues per queue. The default value is `100000`.
      * `layout.updateQueuePushTimeoutMilliseconds`: Maximum update issue queuing timeout, in milliseconds. The default value is `10`.
      * `layout.queryWaitTimeoutMilliseconds`: Maximum update issue completion timeout, in milliseconds. The default value is `60000` (one minute).
      * `layout.maxThreadsForUpdates`: Maximum number of threads for cache dictionary update. The default value is `4`.

      For more information, see [this {{ CH }} guide]({{ ch.docs }}/sql-reference/dictionaries#cache).

    * Flat array size settings. They are used for the `FLAT` layout.

      * `layout.initialArraySize`: Initial dictionary key size. The default value is `1024`.
      * `layout.maxArraySize`: Maximum dictionary key size. It determines the memory size used by the dictionary, this size being proportional to the largest key value. The default value is `500000`.

      For more information, see [this {{ CH }} guide]({{ ch.docs }}/sql-reference/dictionaries#flat).

    * `layout.accessToKeyFromAttributes`: Gets the name of the composite key using the `dictGetString` function. This setting is used for the `IP_TRIE` layout. Enabling this setting increases RAM usage.
    * `structure.id.name`: Dictionary key column name. The key column must have the `UInt64` data type. This setting is used for the `FLAT`, `HASHED`, `RANGE_HASHED`, `CACHE`, `SPARSE_HASHED`, and `DIRECT` layouts. For more information about keys, see [this {{ CH }} article]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-structure/#ext_dict-numeric-key).
    * `structure.key.attributes`: Description of the dictionary's composite key. The key may consist of one or more elements. This setting is used for the `COMPLEX_KEY_*` and `IP_TRIE` layouts.

      * `name`: Column name.
      * `type`: Column data type.
      * `nullValue`: Default value for an empty element. When loading a dictionary, all empty elements are replaced with this value. You cannot put `NULL` in this field.
      * `expression`: [Expression]({{ ch.docs }}/sql-reference/syntax/#syntax-expressions) {{ CH }} applies to the column value.
      * `hierarchical`: Hierarchical support flag.
      * `injective`: Injective `id` → `attribute` mapping flag.

      For more information about composite key settings, see [this {{ CH }} guide]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-structure/#composite-key).

      {% include [structure](../../_includes/mdb/mch/note-ext-dict-structure.md) %}

    * `structure.attributes`: Description of the fields available for database queries:

      * `name`: Column name.
      * `type`: Column data type.
      * `nullValue`: Default value for an empty element. When loading a dictionary, all empty elements are replaced with this value. You cannot put `NULL` in this field.
      * `expression`: [Expression]({{ ch.docs }}/sql-reference/syntax/#syntax-expressions) {{ CH }} applies to the column value.
      * `hierarchical`: Hierarchical support flag.
      * `injective`: Injective `id` → `attribute` mapping flag.

    * `fixedLifetime`: Fixed interval between dictionary updates, in seconds.
    * `lifetimeRange`: Time range for {{ CH }} to randomly select the time for update. This helps distribute the dictionary source load when updating across many servers. To specify the range boundaries, use these settings:

      * `min`: Minimum interval between dictionary updates, in seconds.
      * `max`: Maximum interval between dictionary updates, in seconds.

      {% include [lifetime single](../../_includes/mdb/mch/note-ext-dict-lifetime-restapi.md) %}

- gRPC API {#grpc-api}

  * `external_dictionary`: New dictionary settings:

    * `name`: Name of the new dictionary.
    * `***_source`: Dictionary data source. Select one of the listed sources and specify its settings:

      {% cut "`clickhouse_source`: {{ CH }} source" %}

      * `db`: Source database name.
      * `table`: Source table name.
      * `where`: Condition for selecting rows to build a dictionary from. For example, the `id=10` condition is the same as the `WHERE id=10` SQL clause.
      * `host`: Source host name. This is an optional setting.

          The host must be in the same network as the {{ CH }} cluster.

      * `port`: Port for connecting to the source. This is an optional setting.
      * `user`: Name of the source database user.
      * `password`: Password to access the source database.
      * `secure`: Set to establish an SSL connection.

      {% endcut %}

      {% cut "`mongodb_source`: {{ SD }} source" %}

      * `db`: Source database name.
      * `host`: Source host name. The host must be in the same network as the {{ CH }} cluster.
      * `port`: Port for connecting to the source.
      * `user`: Name of the source database user.
      * `password`: Password to access the source database.
      * `collection`: Source collection name.

      {% endcut %}

      {% cut "`mysql_source`: {{ MY }} source" %}

      * `db`: Source database name.
      * `table`: Source table name.
      * `where`: Condition for selecting rows to build a dictionary from. For example, the `id=10` condition is the same as the `WHERE id=10` SQL clause.
      * `user`: Name of the source database user.
      * `password`: Password to access the source database.
      * `replicas`: Source replica settings:
        * `host`: Replica host name. The host must be in the same network as the {{ CH }} cluster.
        * `priority`: Replica priority. When attempting to connect, {{ CH }} follows the replica priority order. The lower the number, the higher the priority.
        * `port`: Port for connecting to the replica.
        * `user`: Database user name.
        * `password`: Password to access the database.
      * `invalidate_query`: Query to check for {{ MY }} dictionary changes. {{ CH }} will only update the dictionary if the results of this query change.
      * `share_connection`: Set to share the connection between multiple queries.
      * `close_connection`: Set to close the connection after each query.

      {% endcut %}

      {% cut "`postgresql_source`: {{ PG }} source" %}

      * `db`: Source database name.
      * `table`: Source table name.
      * `port`: Port for connecting to the source.
      * `user`: Name of the source database user.
      * `password`: Password to access the source database.
      * `ssl_mode`: Mode of secure SSL TCP/IP connection to the {{ PG }} database. You can set it to `DISABLE`, `ALLOW`, `PREFER`, `VERIFY_CA`, or `VERIFY_FULL`.
      * `hosts`: Names of the {{ PG }} master host and its [replicas](../../managed-postgresql/concepts/replication.md) to use as dictionary sources. The hosts must be in the same network as the {{ CH }} cluster.
      * `invalidate_query`: Query to check for dictionary changes. {{ CH }} will only update the dictionary if the results of this query change.

      {% endcut %}

      {% cut "`http_source`: HTTP(s) source" %}

      * `url`: HTTP(s) source URL.
      * `format`: File format for the HTTP(s) source. Read more about formats in [this {{ CH }} article]({{ ch.docs }}/interfaces/formats/#formats).
      * `headers`: Special HTTP headers for the request to the source:
        * `name`: Header name.
        * `value`: Header value.

      {% endcut %}

    * `layout.type`: Memory layout for the dictionary. The supported layout types include `FLAT`, `HASHED`, `COMPLEX_KEY_HASHED`, `RANGE_HASHED`, `CACHE`, `COMPLEX_KEY_CACHE`, `SPARSE_HASHED`, `COMPLEX_KEY_SPARSE_HASHED`, `COMPLEX_KEY_RANGE_HASHED`, `DIRECT`, `COMPLEX_KEY_DIRECT`, and `IP_TRIE`. For more information about dictionary layouts, see the [this {{ CH }} guide]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/).
    * `layout.size_in_cells`: Number of cache cells for the `CACHE` and `COMPLEX_KEY_CACHE` layouts. For more information about cache, see [this {{ CH }} article]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/#cache).
    * `layout.allow_read_expired_keys`: Set to allow reading expired keys. This setting is used for the `CACHE` and `COMPLEX_KEY_CACHE` layouts. For more information, see [this {{ CH }} guide]({{ ch.docs }}/sql-reference/dictionaries#cache).
    * Settings of the update queue for cache update issues, if keys are not found in the dictionary. They are used for the `CACHE` and `COMPLEX_KEY_CACHE` layouts.

      * `layout.max_update_queue_size`: Maximum number of update issues per queue. The default value is `100000`.
      * `layout.update_queue_push_timeout_milliseconds`: Maximum update issue queuing timeout, in milliseconds. The default value is `10`.
      * `layout.query_wait_timeout_milliseconds`: Maximum update issue completion timeout, in milliseconds. The default value is `60000` (one minute).
      * `layout.max_threads_for_updates`: Maximum number of threads for cache dictionary update. The default value is `4`.

      For more information, see [this {{ CH }} guide]({{ ch.docs }}/sql-reference/dictionaries#cache).

    * Flat array size settings. They are used for the `FLAT` layout.

      * `layout.initial_array_size`: Initial dictionary key size. The default value is `1024`.
      * `layout.max_array_size`: Maximum dictionary key size. It determines the memory size used by the dictionary, this size being proportional to the largest key value. The default value is `500000`.

      For more information, see [this {{ CH }} guide]({{ ch.docs }}/sql-reference/dictionaries#flat).

    * `layout.access_to_key_from_attributes`: Gets the name of the composite key using the `dictGetString` function. This setting is used for the `IP_TRIE` layout. Enabling this setting increases RAM usage.
    * `structure.id.name`: Dictionary key column name. The key column must have the `UInt64` data type. This setting is used for the `FLAT`, `HASHED`, `RANGE_HASHED`, `CACHE`, `SPARSE_HASHED`, and `DIRECT` layouts. For more information about keys, see [this {{ CH }} article]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-structure/#ext_dict-numeric-key).
    * `structure.key.attributes`: Description of the dictionary's composite key. The key may consist of one or more elements. This setting is used for the `COMPLEX_KEY_*` and `IP_TRIE` layouts.

      * `name`: Column name.
      * `type`: Column data type.
      * `null_value`: Default value for an empty element. When loading a dictionary, all empty elements are replaced with this value. You cannot put `NULL` in this field.
      * `expression`: [Expression]({{ ch.docs }}/sql-reference/syntax/#syntax-expressions) {{ CH }} applies to the column value.
      * `hierarchical`: Hierarchical support flag.
      * `injective`: Injective `id` → `attribute` mapping flag.

      For more information about composite key settings, see [this {{ CH }} guide]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-structure/#composite-key).

      {% include [structure](../../_includes/mdb/mch/note-ext-dict-structure.md) %}

    * `structure.attributes`: Description of the fields available for database queries:

      * `name`: Column name.
      * `type`: Column data type.
      * `null_value`: Default value for an empty element. When loading a dictionary, all empty elements are replaced with this value. You cannot put `NULL` in this field.
      * `expression`: [Expression]({{ ch.docs }}/sql-reference/syntax/#syntax-expressions) {{ CH }} applies to the column value.
      * `hierarchical`: Hierarchical support flag.
      * `injective`: Injective `id` → `attribute` mapping flag.

    * `fixed_lifetime`: Fixed interval between dictionary updates, in seconds.
    * `lifetime_range`: Time range for {{ CH }} to randomly select the time for update. This helps distribute the dictionary source load when updating across many servers. To specify the range boundaries, use these settings:

      * `min`: Minimum interval between dictionary updates, in seconds.
      * `max`: Maximum interval between dictionary updates, in seconds.

      {% include [lifetime single](../../_includes/mdb/mch/note-ext-dict-lifetime-grpcapi.md) %}

{% endlist %}

## Examples {#examples}

Let's assume there is a {{ CH }} cluster named `mych` with the `{{ cluster-id }}` ID, and you need to connect a dictionary with the following test settings to it:

* Dictionary name: `mychdict`.
* Key column name: `id`.
* Fields available for database queries:
    * `id`, `UInt64` type.
    * `field1`, `String` type.
* Fixed interval between dictionary updates: 300 seconds.
* Memory layout for the dictionary: `cache` with cache size of 1,024 cells.
* {{ PG }} source:
    * Database: `db1`.
    * Table name: `table1`.
    * Port for connection: `{{ port-mpg }}`.
    * Database user name: `user1`.
    * Database access password: `user1user1`.
    * Mode of secure SSL TCP/IP connection to the database: `verify-full`.
    * Master host's special FQDN: `c-c9qash3nb1v9********.rw.{{ dns-zone }}`.

{% list tabs group=instructions %}

- CLI {#cli}

    Run this command:

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

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Create a file named `body.json` and paste the following code into it:

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
              "table": "table1",
              "port": "5432",
              "user": "user1",
              "password": "user1user1",
              "sslMode": "VERIFY_FULL",
              "hosts": ["c-c9qash3nb1v9********.rw.{{ dns-zone }}"]
            }
          }
        }
        ```

    1. Run this {{ api-examples.rest.tool }} request:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/{{ cluster-id }}:createExternalDictionary' \
            --data '@body.json'
        ```

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Create a file named `body.json` and paste the following code into it:

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
              "table": "table1",
              "port": "5432",
              "user": "user1",
              "password": "user1user1",
              "ssl_mode": "VERIFY_FULL",
              "hosts": ["c-c9qash3nb1v9********.rw.{{ dns-zone }}"]
            }
          }
        }
        ```

    1. Run this {{ api-examples.rest.tool }} request:

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

- SQL {#sql}

    1. [Connect](connect/clients.md) to the required database of the {{ mch-name }} cluster using `clickhouse-client`.
    1. Run this [DDL query]({{ ch.docs }}/sql-reference/statements/create/dictionary/):

        ```sql
        CREATE DICTIONARY mychdict(
          `id` UInt64,
          `field1` String
        )
        PRIMARY KEY id
        SOURCE(POSTGRESQL(
           port 5432
           host 'c-c9qash3nb1v9********.rw.{{ dns-zone }}'
           user 'user1'
           password 'user1user1'
           db 'db1'
           table 'table1'
        ))
        LIFETIME(300)
        LAYOUT(CASHE(SIZE_IN_CELLS 1024));
        ```

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
