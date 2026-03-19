# Working with {{ VLK }} modules

In {{ mrd-name }}, you can use [modules](../concepts/modules.md) ({{ VLK }} kernel extensions). Modules provide functionality to address modern-day needs through the use of high-load services and AI platforms: vector search, efficiently stored JSON data structures, and scalable probability filters.

You can connect modules to a [new](cluster-create.md) or [existing](#enable-modules) cluster or [reconfigure a module](#change-modules).

## Connecting modules {#enable-modules}

{% include [modules-warn](../../_includes/mdb/mvk/enable-modules-note.md) %}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder containing your cluster.
    1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}** service.
    1. Select the cluster.
    1. At the top of the page, click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
    1. Under **{{ ui-key.yacloud.redis.local.valkey_modules_aQacT }}**, enable the required {{ VLK }} modules.

        For the **{{ ui-key.yacloud.redis.local.valkey_search_vfqdy }}** module, configure the following: **{{ ui-key.yacloud.redis.ModulesFormCard.valkey_search_reader_threads_fNBHR }}** and **{{ ui-key.yacloud.redis.ModulesFormCard.valkey_search_writer_threads_6HRjb }}**.

    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To connect modules:

  1. View the description of the CLI command for updating a cluster:

     ```bash
     {{ yc-mdb-rd }} cluster update --help
     ```

  1. Run this command to connect modules:

     ```bash
     {{ yc-mdb-rd }} cluster update \
       --cluster-name=<cluster_name> \
       --valkey-modules enable-valkey-search=<enable_Valkey-Search_module>,`
                        `valkey-search-reader-threads=<number_of_request_processing_threads>,`
                        `valkey-search-writer-threads=<number_of_indexing_threads>,`
                        `enable-valkey-json=<enable_Valkey-JSON_module>,`
                        `enable-valkey-bloom=<enable_Valkey-Bloom_module>
     ```

     Where:
     * `--cluster-name`: {{ mrd-name }} cluster name. You can get it from the [list of clusters in the folder](cluster-list.md#list-clusters).
     * `--valkey-modules`: [{{ VLK }} module](../concepts/modules.md) parameters:
        * `enable-valkey-search`: Enable the `Valkey-Search` module, `true` or `false`.
        * `valkey-search-reader-threads`: Number of request processing threads in the `Valkey-Search` module.
        * `valkey-search-writer-threads`: Number of indexing threads in the `Valkey-Search` module.
        * `enable-valkey-json`: Enable the `Valkey-JSON` module, `true` or `false`.
        * `enable-valkey-bloom`: Enable the `Valkey-Bloom` module, `true` or `false`.

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        For more on how to create this file, see [Creating a cluster](./cluster-create.md).

    1. Add the `modules` section to the {{ mrd-name }} cluster description:

        ```hcl
        resource "yandex_mdb_redis_cluster_v2" "<cluster_name>" {
          ...
          modules = {
            valkey_bloom = {
              enabled = <enable_Valkey-Bloom_module>
            }
            valkey_json = {
              enabled = <enable_Valkey-JSON_module>
            }
            valkey_search = {
              enabled        = <enable_Valkey-Search_module>
              reader_threads = <number_of_request_processing_threads>
              writer_threads = <number_of_indexing_threads>
            }
          }
        }
        ```

        Where:

        * `valkey_bloom.enabled`: Enable the `Valkey-Bloom` module, `true` or `false`.
        * `valkey_json.enabled`: Enable the `Valkey-JSON` module, `true` or `false`.
        * `valkey_search.enabled`: Enable the `Valkey-Search` module, `true` or `false`.
        * `valkey_search.reader_threads`: Number of request processing threads in the `Valkey-Search` module.
        * `valkey_search.writer_threads`: Number of indexing threads in the `Valkey-Search` module.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see [this {{ TF }} provider guide]({{ tf-provider-mrd }}).

    {% include [Terraform timeouts](../../_includes/mdb/mvk/terraform/timeouts.md) %}

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
            --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<cluster_ID>' \
            --data '{
                      "updateMask": "configSpec.modules.valkeySearch.enabled,configSpec.modules.valkeySearch.readerThreads,configSpec.modules.valkeySearch.writerThreads,configSpec.valkeyJson.enabled,configSpec.valkeyBloom.enabled",
                      "configSpec": {
                        "modules": {
                          "valkeySearch": {
                            "enabled": "<enable_Valkey-Search_module>",
                            "readerThreads": "<number_of_request_processing_threads>",
                            "writerThreads": "<number_of_indexing_threads>"
                          },
                          "valkeyJson": {
                            "enabled": "<enable_Valkey-JSON_module>"
                          },
                          "valkeyBloom": {
                            "enabled": "<enable_Valkey-Bloom_module>"
                          }
                        }
                      }
                    }'
        ```

        Where:

        * `updateMask`: Comma-separated string of settings to update.

        * `configSpec.modules`: {{ VLK }} module parameters:

            * `valkeySearch.enabled`: Enable the `Valkey-Search` module, `true` or `false`. What you can set up for the module:
                * `valkeySearch.readerThreads`: Number of request processing threads.
                * `valkeySearch.writerThreads`: Number of indexing threads.
            * `valkeyJson.enabled`: Enable the `Valkey-JSON` module, `true` or `false`.
            * `valkeyBloom.enabled`: Enable the `Valkey-Bloom` module, `true` or `false`.

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

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
            -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "update_mask": {
                    "paths": [
                      "config_spec.modules.valkey_search.enabled",
                      "config_spec.modules.valkey_search.reader_threads",
                      "config_spec.modules.valkey_search.writer_threads",
                      "config_spec.valkey_json.enabled",
                      "config_spec.valkey_bloom.enabled"
                    ]
                  },
                  "config_spec": {
                    "modules": {
                      "valkey_search": {
                        "enabled": "<enable_Valkey-Search_module>",
                        "reader_threads": "<number_of_request_processing_threads>",
                        "writer_threads": "<number_of_indexing_threads>"
                      },
                      "valkey_json": {
                        "enabled": "<enable_Valkey-JSON_module>"
                      },
                      "valkey_bloom": {
                        "enabled": "<enable_Valkey-Bloom_module>"
                      }
                    }
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.redis.v1.ClusterService.Update
        ```

        Where:

        * `update_mask`: List of settings to update as an array of strings (`paths[]`).

        * `config_spec.modules`: {{ VLK }} module parameters:

            * `valkey_search.enabled`: Enable the `Valkey-Search` module, `true` or `false`. What you can set up for the module:
                * `valkey_search.reader_threads`: Number of request processing threads.
                * `valkey_search.writer_threads`: Number of indexing threads.
            * `valkey_json.enabled`: Enable the `Valkey-JSON` module, `true` or `false`.
            * `valkey_bloom.enabled`: Enable the `Valkey-Bloom` module, `true` or `false`.

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Updating module settings {#change-modules}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder containing your cluster.
    1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}** service.
    1. Select the cluster.
    1. At the top of the page, click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
    1. Under **{{ ui-key.yacloud.redis.local.valkey_modules_aQacT }}**, edit the {{ VLK }} module settings.

        You can set up the following for the **{{ ui-key.yacloud.redis.local.valkey_search_vfqdy }}** module:

        * **{{ ui-key.yacloud.redis.ModulesFormCard.valkey_search_reader_threads_fNBHR }}**.
        * **{{ ui-key.yacloud.redis.ModulesFormCard.valkey_search_writer_threads_6HRjb }}**.

    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To update module settings:

  1. View the description of the CLI command for updating a cluster:

     ```bash
     {{ yc-mdb-rd }} cluster update --help
     ```

  1. Run this command to update module settings:

     ```bash
     {{ yc-mdb-rd }} cluster update \
       --cluster-name=<cluster_name> \
       --valkey-modules valkey-search-reader-threads=<number_of_request_processing_threads>,`
                        `valkey-search-writer-threads=<number_of_indexing_threads>
     ```

     Where:
     * `--cluster-name`: {{ mrd-name }} cluster name. You can get it from the [list of clusters in the folder](cluster-list.md#list-clusters).
     * `--valkey-modules`: [{{ VLK }} module](../concepts/modules.md) parameters:
        * `valkey-search-reader-threads`: Number of request processing threads in the `Valkey-Search` module.
        * `valkey-search-writer-threads`: Number of indexing threads in the `Valkey-Search` module.

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

       For more on how to create this file, see [Creating a cluster](./cluster-create.md).

    1. In the {{ mrd-name }} cluster description, do the necessary editing under `modules.valkey_search`:

        ```hcl
        resource "yandex_mdb_redis_cluster_v2" "<cluster_name>" {
          ...
          modules = {
            ...
            valkey_search = {
              ...
              reader_threads = <number_of_request_processing_threads>
              writer_threads = <number_of_indexing_threads>
            }
          }
        }
        ```

        Where:

        * `reader_threads`: Number of request processing threads in the `Valkey-Search` module.
        * `writer_threads`: Number of indexing threads in the `Valkey-Search` module.

    1. Make sure the settings are correct.

       {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see [this {{ TF }} provider guide]({{ tf-provider-mrd }}).

    {% include [Terraform timeouts](../../_includes/mdb/mvk/terraform/timeouts.md) %}

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
            --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<cluster_ID>' \
            --data '{
                      "updateMask": "configSpec.modules.valkeySearch.readerThreads,configSpec.modules.valkeySearch.writerThreads",
                      "configSpec": {
                        "modules": {
                          "valkeySearch": {
                            "readerThreads": "<number_of_request_processing_threads>",
                            "writerThreads": "<number_of_indexing_threads>"
                          }
                        }
                      }
                    }'
        ```

        Where:

        * `updateMask`: Comma-separated string of settings to update.

        * `configSpec.modules`: {{ VLK }} module parameters:

            * `valkeySearch.readerThreads`: Number of request processing threads in the `Valkey-Search` module.
            * `valkeySearch.writerThreads`: Number of indexing threads in the `Valkey-Search` module.

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

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
            -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "update_mask": {
                    "paths": [
                      "config_spec.modules.valkey_search.reader_threads",
                      "config_spec.modules.valkey_search.writer_threads"
                    ]
                  },
                  "modules": {
                    "valkey_search": {
                      "reader_threads": "<number_of_request_processing_threads>",
                      "writer_threads": "<number_of_indexing_threads>"
                    }
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.redis.v1.ClusterService.Update
        ```

        Where:

        * `update_mask`: List of parameters to update as an array of strings (`paths[]`).

        * `config_spec.modules`: {{ VLK }} module parameters:

            * `valkey_search.reader_threads`: Number of request processing threads in the `Valkey-Search` module.
            * `valkey_search.writer_threads`: Number of indexing threads in the `Valkey-Search` module.

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}
