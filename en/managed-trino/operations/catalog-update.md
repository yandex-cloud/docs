---
title: Updating a {{ TR }} catalog
description: Follow this guide to update catalog parameters in a {{ mtr-name }} cluster.
---

# Updating a {{ TR }} catalog

{% list tabs group=instructions %}

- Management console {#console}

    1. On the [resource folder]({{ link-console-main }}) page, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
    1. Click the cluster name.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.trino.title_catalogs }}**.
    1. Next to the {{ TR }} catalog, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**.
    1. Update your {{ TR }} catalog parameters and click **{{ ui-key.yacloud.common.update }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. View the description of the CLI command for updating a {{ TR }} catalog:

        ```bash
        {{ yc-mdb-tr }} catalog update --help
        ```

    1. View the description of the CLI command for updating a {{ TR }} catalog with a specific connector:

        ```bash
        {{ yc-mdb-tr }} catalog update <connector_type> --help
        ```

    1. To update the catalog, run this command:

        ```bash
        {{ yc-mdb-tr }} catalog update <connector_type> <{{ TR }}_catalog_name> \
            --new-name <new_{{ TR }}_catalog_name>
        ```

        You can get the {{ TR }} catalog name together with the [list of {{ TR }} catalogs in the cluster](catalog-list#list-catalogs.md).

        In the command, you can also provide {{ TR }} catalog settings depending on the connector type. [Learn more about settings for various connector types](catalog-create.md#catalog-settings).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file that defines your infrastructure.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

    1. Edit the {{ TR }} catalog settings in the `yandex_trino_catalog` section:

        ```hcl
        resource "yandex_trino_catalog" "<{{ TR }}_catalog_name>" {
          ...
          <connector_type> = {
            <{{ TR }}_catalog_settings>
          }
        }
        ```

        [Learn more about the {{ TR }} catalog settings](catalog-create.md#catalog-settings) for various connector types.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Catalog.Update](../api-ref/Catalog/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters/<cluster_ID>/catalogs/<{{ TR }}_catalog_ID>' \
            --data '{
                      "updateMask": "catalog.name,catalog.connector.<connector_type>.<path_to_setting>.<setting_1>,catalog.connector.<connector_type>.<path_to_setting>.<setting_2>,...,catalog.connector.<connector_type>.<path_to_setting>.<setting_N>",
                      "catalog": {
                        "name": "<new_{{ TR }}_catalog_name>",
                        "connector": {
                          "<connector_type>": {
                            <{{ TR }}_catalog_settings_to_update>
                          }
                        }
                      }
                    }'
        ```

        Where `updateMask` is the list of parameters to update as a single string, separated by commas.

        [Learn more about the {{ TR }}](#catalog-settings) catalog settings for various connector types.

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters) and the folder ID with the [list of {{ TR }} catalogs in the cluster](catalog-list.md).

    1. View the [server response](../api-ref/Catalog/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [CatalogService.Update](../api-ref/grpc/Catalog/update.md) call and run the following request, e.g., via {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/trino/v1/catalog_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "catalog_id": "<{{ TR }}_catalog_ID>",
                  "update_mask": {
                    "paths": [
                      "catalog.name",
                      "catalog.connector.<connector_type>.<path_to_setting>.<setting_1>",
                      "catalog.connector.<connector_type>.<path_to_setting>.<setting_2>",
                      ...
                      "catalog.connector.<connector_type>.<path_to_setting>.<setting_N>"
                    ]
                  },
                  "catalog": {
                    "name": "<new_{{ TR }}_catalog_name>",
                    "connector": {
                      "<connector_type>": {
                        <{{ TR }}_catalog_settings_to_update>
                      }
                    }
                  }
                }' \
            {{ api-host-trino }}:{{ port-https }} \
            yandex.cloud.trino.v1.CatalogService.Update
        ```

        Where `update_mask` is the list of parameters to update as an array of `paths[]` strings.

        [Learn more about the {{ TR }}](#catalog-settings) catalog settings for various connector types.

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters) and the folder ID with the [list of {{ TR }} catalogs in the cluster](catalog-list.md).

    1. View the [server response](../api-ref/grpc/Catalog/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}