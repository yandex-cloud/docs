# Managing a custom geobase in {{ mch-name }}

A {{ CH }} geobase consists of text files containing the names and hierarchy of regions. You can add several alternative geobases to {{ CH }} to reflect different points of view on what regions belong to what countries. For more information, see [this {{ CH }} guide](https://{{ ch-domain }}/docs/ru/sql-reference/dictionaries/internal-dicts/).

To add a custom geobase to a {{ CH }} cluster:

1. [Create a geobase](#create).
1. [Upload the geobase to {{ objstorage-full-name }}](#upload).
1. [Add the geobase to a {{ CH }} cluster](#add).

If you are not using your custom geobase, [remove it](#disconnect).

## Creating a geobase {#create}

1. Create a file named `regions_hierarchy.txt`. It must be a [TSV](https://en.wikipedia.org/wiki/Tab-separated_values) table without headers, containing the following columns:
   * Region ID (UInt32)
   * Parent region ID (UInt32)
   * Region type (UInt8):
        * `1`: Continent
        * `3`: Country
        * `4`: Federal district
        * `5`: Region
        * `6`: City
   * Population (UInt32): Optional column.
1. To add an alternative hierarchy of regions, create the `regions_hierarchy_<suffix>.txt` files with the same structure. To use an alternative geobase, provide this suffix when calling the function. Here is an example:

    * `regionToCountry(RegionID)`: Uses the default dictionary, `regions_hierarchy.txt`.
    * `regionToCountry(RegionID, 'alt')`: Uses the dictionary with the `alt` suffix, `regions_hierarchy_alt.txt`.

1. Create a file named `regions_names.txt`. It must be a [TSV](https://en.wikipedia.org/wiki/Tab-separated_values) table without headers, containing the following columns:

    * Region ID (UInt32).
    * Region name (String): Cannot contain tab or newline characters, even escaped ones.

1. To add region names in other languages to your geobase, create the `regions_names_<language_code>.txt` files with the same structure. For example, you can create `regions_names_en.txt` for English and `regions_names_tr.txt` for Turkish.
1. Create a `tar`, `tar.gz`, or `zip` archive from the geobase files.

## Uploading a geobase to {{ objstorage-full-name }} {#upload}

{{ mch-short-name }} only works with geobases uploaded to {{ objstorage-full-name }} and accessible for reading:


1. To attach a [service account](../../iam/concepts/users/service-accounts.md) to a cluster, [assign](../../iam/operations/roles/grant.md) the [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) role or higher to your {{ yandex-cloud }} account.
1. [Upload](../../storage/operations/objects/upload.md) the geobase archive to {{ objstorage-full-name }}.
1. [Attach the service account to the cluster](s3-access.md#connect-service-account). You will use this [service account](../../iam/concepts/users/service-accounts.md) to configure access to the geobase archive.
1. [Assign](s3-access.md#configure-acl) the `storage.viewer` role to the service account.
1. In the bucket ACL, [add](../../storage/operations/buckets/edit-acl.md) the `READ` permission to the service account.
1. [Get a link](s3-access.md#get-link-to-object) to the geobase archive.


## Adding a geobase to a {{ CH }} cluster {#add}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the cluster is in.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Select your cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_settings }}**, click **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}**.
  1. In the **Geobase uri** field, enter a link to the geobase archive in {{ objstorage-full-name }}.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To add a geobase:

    1. View the description of the CLI command to update the cluster configuration:

        ```bash
        {{ yc-mdb-ch }} cluster update-config --help
        ```

    1. Run this command, providing the link to the archive with the geobase being added in the `geobase_uri` parameter:

        ```bash
        {{ yc-mdb-ch }} cluster update-config <cluster_name_or_ID> \
             --set geobase_uri="<link_to_geobase_archive_in_Object_Storage>"
        ```

        You can request the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        For information on how to create such a file, see [Creating a cluster](cluster-create.md).

    1. In the {{ mch-name }} cluster settings, add the `geobase_uri` parameter with the link to the archive containing the geobase being added in {{ objstorage-full-name }}:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<cluster_name>" {
          ...
          clickhouse {
            config {
              geobase_uri = "<link_to_geobase_archive_in_Object_Storage>"
              ...
            }
          ...
          }
        ...
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.Update](../api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>' \
            --data '{
                      "updateMask": "configSpec.clickhouse.config.geobaseUri",
                      "configSpec": {
                        "clickhouse": {
                          "config": {
                            "geobaseUri": "<link>"
                          }
                        }
                      }
                    }'
        ```

        Where:

        * `updateMask`: Comma-separated list of settings you want to update.

            Here, we only specified a single setting, `configSpec.clickhouse.config.geobaseUri`.

        * `configSpec.clickhouse.config.geobaseUri`: Link to the geobase archive in {{ objstorage-name }}.

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Call the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "update_mask": {
                    "paths": [
                      "config_spec.clickhouse.config.geobase_uri"
                    ]
                  },
                  "config_spec": {
                    "clickhouse": {
                      "config": {
                        "geobase_uri": "<link>"
                      }
                    }
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.Update
        ```

        Where:

        * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

            Here, we only specified a single setting, `config_spec.clickhouse.config.geobase_uri`.

        * `config_spec.clickhouse.config.geobase_uri`: Link to the geobase archive in {{ objstorage-name }}.

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Removing a geobase {#disconnect}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder the cluster is in.
    1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Select your cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_settings }}**, click **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}**.
    1. Delete the value in the **Geobase uri** field.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To remove a geobase:

    1. View the description of the CLI command to update the cluster configuration:

        ```bash
        {{ yc-mdb-ch }} cluster update-config --help
        ```

    1. Run this command, providing an empty value in the `geobase_uri` parameter:

        ```bash
        {{ yc-mdb-ch }} cluster update-config <cluster_name_or_ID> \
             --set geobase_uri=""
        ```

        You can get the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list-clusters).


- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.Update](../api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>' \
            --data '{
                      "updateMask": "configSpec.clickhouse.config.geobaseUri",
                      "configSpec": {
                        "clickhouse": {
                          "config": {
                            "geobaseUri": ""
                          }
                        }
                      }
                    }'
        ```

        Where:

        * `updateMask`: Comma-separated list of settings you want to update.

            Here, we only specified a single setting, `configSpec.clickhouse.config.geobaseUri`.

        * `configSpec.clickhouse.config.geobaseUri`: Link to the geobase archive in {{ objstorage-name }}. Set an empty value for this parameter.

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "update_mask": {
                    "paths": [
                      "config_spec.clickhouse.config.geobase_uri"
                    ]
                  },
                  "config_spec": {
                    "clickhouse": {
                      "config": {
                        "geobase_uri": ""
                      }
                    }
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.Update
        ```

        Where:

        * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

            Here, we only specified a single setting, `config_spec.clickhouse.config.geobase_uri`.

        * `config_spec.clickhouse.config.geobase_uri`: Link to the geobase archive in {{ objstorage-name }}. Set an empty value for this parameter.

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
