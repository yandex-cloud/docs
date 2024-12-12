# Changing PXF settings

The [PXF](../external-tables.md) settings you can configure using the {{ yandex-cloud }} tools match those in the {{ GP }} [pxf-application.properties]({{ gp.docs.vmware }}-Platform-Extension-Framework/6.9/greenplum-platform-extension-framework/config_files.html#pxfapplicationproperties-1) configuration file. It describes the features of the PXF protocol. In {{ GP }} clusters, PXF settings have the default values. To optimize working with [external tables](../../concepts/external-tables.md), you can update the PXF settings using the {{ yandex-cloud }} interfaces rather than edit the file.

{% list tabs group=instructions %}

- Management console {#console}

    To change the PXF settings:

    1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Click the cluster name and select ![image](../../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.greenplum.label_pxf }}** in the left-hand panel.
    1. Click ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.greenplum.cluster.pxf.action_edit-settings }}** at the top of the page.
    1. Change the settings:

        * **Connection Timeout**: Timeout for connection to the Apache Tomcat® server when making read queries. The value range is from `5` to `600` seconds. You can specify the values in various time units.
        * **Upload Timeout**: Timeout for connection to the Apache Tomcat® server when making write queries. The value range is from `5` to `600` seconds. You can specify the values in various time units.
        * **Max Threads**: Maximum number of the Apache Tomcat® threads. The value range is from `1` to `1024`.

            To prevent situations when requests get stuck or fail due to running out of memory or malfunctioning of the Java garbage collector, specify the number of the Apache Tomcat® threads. Learn more about adjusting the number of threads in the [VMware {{ GP }} Platform Extension Framework]({{ gp.docs.vmware }}-Platform-Extension-Framework/6.9/greenplum-platform-extension-framework/cfg_mem.html) documentation.

        * **Pool Allow Core Thread Timeout**: Determines whether a timeout for core streaming threads is allowed.
        * **Pool Core Size**: Number of core streaming threads per pool. The value range is from `1` to `1024`.
        * **Pool Queue Capacity**: Maximum number of queries you can add to a pool queue after core streaming threads. The values may range from zero upward. If `0`, no pool queue is generated.
        * **Pool Max Size**: Maximum allowed number of core streaming threads. The value range is from `1` to `1024`.
        * **Xmx**: Initial size of the JVM heap for the PXF daemon. The value range is from `64` to `16384` MB. You can specify the values in various units.
        * **Xms**: Maximum size of the JVM heap for the PXF daemon. The value range is from `64` to `16384` MB. You can specify the values in various units.

    1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To change the PXF settings:

    1. View a description of the update cluster configuration CLI command:

        ```bash
        {{ yc-mdb-gp }} cluster update --help
        ```

    1. Specify PXF settings:

        ```bash
        {{ yc-mdb-gp }} cluster update <cluster_name_or_ID> \
           --pxf-connection-timeout=<read_queries_timeout> \
           --pxf-upload-timeout=<write_queries_timeout> \
           --pxf-max-threads=<Maximum_number_of_the_Apache_Tomcat®_threads> \
           --pxf-pool-allow-core-thread-timeout=<whether_a_timeout_for_core_streaming_threads_is_allowed> \
           --pxf-poll-core-size=<number_of_streaming_threads> \
           --pxf-pool-queue-capacity=<pool_queue_capacity_for_streaming_threads> \
           --pxf-pool-max-size=<maximum_number_of_streaming_threads> \
           --pxf-xmx=<initial_size_of_the_JVM_heap> \
           --pxf-xms=<maximum_size_of_the_JVM_heap>
        ```

        Where:

        * `pxf-connection-timeout`: Timeout for connection to the Apache Tomcat® server when making read queries, in seconds. The value range is from `5` to `600`.
        * `pxf-upload-timeout`: Timeout for connection to the Apache Tomcat® server when making write queries, in seconds. The value range is from `5` to `600`.
        * `pxf-max-threads`: Maximum number of the Apache Tomcat® threads. The value range is from `1` to `1024`.

            To prevent situations when requests get stuck or fail due to running out of memory or malfunctioning of the Java garbage collector, specify the number of the Apache Tomcat® threads. Learn more about adjusting the number of threads in the [VMware {{ GP }} Platform Extension Framework]({{ gp.docs.vmware }}-Platform-Extension-Framework/6.9/greenplum-platform-extension-framework/cfg_mem.html) documentation.

        * `pxf-pool-allow-core-thread-timeout`: Determines whether a timeout for core streaming threads is allowed. The default value is `false`.
        * `pxf-poll-core-size`: Number of core streaming threads per pool. The value range is from `1` to `1024`.
        * `pxf-pool-queue-capacity`: Maximum number of queries you can add to a pool queue after core streaming threads. The values may range from zero upward. If `0`, no pool queue is generated.
        * `pxf-pool-max-size`: Maximum allowed number of core streaming threads. The value range is from `1` to `1024`.
        * `pxf-xmx`: Initial size of the JVM heap for the PXF daemon, in megabytes. The value range is from `64` to `16384`.
        * `pxf-xms`: Maximum size of the JVM heap for the PXF daemon, in megabytes. The value range is from `64` to `16384`.

        You can [get the cluster name with a list of clusters in the folder](../cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    To change the PXF settings:

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For more information about creating this file, see [{#T}](../cluster-create.md).

        For a complete list of available {{ mgp-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mgp }}).

    1. In the cluster description, under `pxf_config`, configure the PXF settings:

        ```hcl
        resource "yandex_mdb_greenplum_cluster" "<cluster_name>" {
          ...
          pxf_config {
            connection_timeout             = <read_queries_timeout>
            upload_timeout                 = <write_queries_timeout>
            max_threads                    = <Maximum_number_of_the_Apache_Tomcat®_threads>
            pool_allow_core_thread_timeout = <whether_a_timeout_for_core_streaming_threads_is_allowed>
            pool_core_size                 = <number_of_streaming_threads>
            pool_queue_capacity            = <pool_queue_capacity_for_streaming_threads>
            pool_max_size                  = <maximum_number_of_streaming_threads>
            xmx                            = <initial_size_of_the_JVM_heap>
            xms                            = <maximum_size_of_the_JVM_heap>
          }
        }
        ```

        Where:

        * `connection_timeout`: Timeout for connection to the Apache Tomcat® server when making read queries, in seconds. The value range is from `5` to `600`.
        * `upload_timeout`: Timeout for connection to the Apache Tomcat® server when making write queries, in seconds. The value range is from `5` to `600`.
        * `max_threads`: Maximum number of the Apache Tomcat® threads. The value range is from `1` to `1024`.

            To prevent situations when requests get stuck or fail due to running out of memory or malfunctioning of the Java garbage collector, specify the number of the Apache Tomcat® threads. Learn more about adjusting the number of threads in the [VMware {{ GP }} Platform Extension Framework]({{ gp.docs.vmware }}-Platform-Extension-Framework/6.9/greenplum-platform-extension-framework/cfg_mem.html) documentation.

        * `pool_allow_core_thread_timeout`: Determines whether a timeout for core streaming threads is allowed. The default value is `false`.
        * `pool_core_size`: Number of core streaming threads per pool. The value range is from `1` to `1024`.
        * `pool_queue_capacity`: Maximum number of queries you can add to a pool queue after core streaming threads. The values may range from zero upward. If `0`, no pool queue is generated.
        * `pool_max_size`: Maximum allowed number of core streaming threads. The value range is from `1` to `1024`.
        * `xmx`: Initial size of the JVM heap for the PXF daemon, in megabytes. The value range is from `64` to `16384`.
        * `xms`: Maximum size of the JVM heap for the PXF daemon, in megabytes. The value range is from `64` to `16384`.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.Update](../../api-ref/Cluster/update.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<cluster_ID>' \
            --data '{
                      "updateMask": "configSpec.pxfConfig.connectionTimeout,configSpec.pxfConfig.uploadTimeout,configSpec.pxfConfig.maxThreads,configSpec.pxfConfig.poolAllowCoreThreadTimeout,configSpec.pxfConfig.poolCoreSize,configSpec.pxfConfig.poolQueueCapacity,configSpec.pxfConfig.poolMaxSize,configSpec.pxfConfig.xmx,configSpec.pxfConfig.xms",
                      "configSpec": {
                        "pxfConfig" : {
                          "connectionTimeout": "<read_queries_timeout>",
                          "uploadTimeout": "<write_queries_timeout>",
                          "maxThreads": "<Maximum_number_of_the_Apache_Tomcat®_threads>",
                          "poolAllowCoreThreadTimeout": <whether_a_timeout_for_core_streaming_threads_is_allowed>,
                          "poolCoreSize": "<number_of_streaming_threads>",
                          "poolQueueCapacity": "<pool_queue_capacity_for_streaming_threads>",
                          "poolMaxSize": "<maximum_number_of_streaming_threads>",
                          "xmx": "<initial_size_of_the_JVM_heap>",
                          "xms": "<maximum_size_of_the_JVM_heap>"
                        }
                      }
                    }'
        ```

        Where:

        * `updateMask`: List of parameters to update as a single string, separated by commas.
        * `connectionTimeout`: Timeout for connection to the Apache Tomcat® server when making read queries, in seconds. The value range is from `5` to `600`.
        * `uploadTimeout`: Timeout for connection to the Apache Tomcat® server when making write queries, in seconds. The value range is from `5` to `600`.
        * `maxThreads`: Maximum number of the Apache Tomcat® threads. The value range is from `1` to `1024`.

            To prevent situations when requests get stuck or fail due to running out of memory or malfunctioning of the Java garbage collector, specify the number of the Apache Tomcat® threads. Learn more about adjusting the number of threads in the [VMware {{ GP }} Platform Extension Framework]({{ gp.docs.vmware }}-Platform-Extension-Framework/6.9/greenplum-platform-extension-framework/cfg_mem.html) documentation.

        * `poolAllowCoreThreadTimeout`: Determines whether a timeout for core streaming threads is allowed. The default value is `false`.
        * `poolCoreSize`: Number of core streaming threads per pool. The value range is from `1` to `1024`.
        * `poolQueueCapacity`: Maximum number of queries you can add to a pool queue after core streaming threads. The values may range from zero upward. If `0`, no pool queue is generated.
        * `poolMaxSize`: Maximum allowed number of core streaming threads. The value range is from `1` to `1024`.
        * `xmx`: Initial size of the JVM heap for the PXF daemon, in megabytes. The value range is from `64` to `16384`.
        * `xms`: Maximum size of the JVM heap for the PXF daemon, in megabytes. The value range is from `64` to `16384`.

        You can get the cluster ID with a [list of clusters in the folder](../cluster-list.md#list-clusters).

    1. View the [server response](../../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.Update](../../api-ref/grpc/Cluster/update.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "update_mask": {
                    "paths": [ 
                      "config_spec.pxf_config.connection_timeout",
                      "config_spec.pxf_config.upload_timeout",
                      "config_spec.pxf_config.max_threads",
                      "config_spec.pxf_config.pool_allow_core_thread_timeout",
                      "config_spec.pxf_config.pool_core_size",
                      "config_spec.pxf_config.pool_queue_capacity",
                      "config_spec.pxf_config.pool_max_size",
                      "config_spec.pxf_config.xmx",
                      "config_spec.pxf_config.xms"
                    ]
                  },
                  "config_spec": {
                    "pxf_config" : {
                      "connection_timeout": "<read_queries_timeout>",
                      "upload_timeout": "<write_queries_timeout>",
                      "max_threads": "<Maximum_number_of_the_Apache_Tomcat®_threads>",
                      "pool_allow_core_thread_timeout": <whether_a_timeout_for_core_streaming_threads_is_allowed>,
                      "pool_core_size": "<number_of_streaming_threads>",
                      "pool_queue_capacity": "<pool_queue_capacity_for_streaming_threads>",
                      "pool_max_size": "<maximum_number_of_streaming_threads>",
                      "xmx": "<initial_size_of_the_JVM_heap>",
                      "xms": "<maximum_size_of_the_JVM_heap>"
                    }
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.ClusterService.Update
        ```

        Where:

        * `update_mask`: List of parameters to update as a single string, separated by commas.
        * `connection_timeout`: Timeout for connection to the Apache Tomcat® server when making read queries, in seconds. The value range is from `5` to `600`.
        * `upload_timeout`: Timeout for connection to the Apache Tomcat® server when making write queries, in seconds. The value range is from `5` to `600`.
        * `max_threads`: Maximum number of the Apache Tomcat® threads. The value range is from `1` to `1024`.

            To prevent situations when requests get stuck or fail due to running out of memory or malfunctioning of the Java garbage collector, specify the number of the Apache Tomcat® threads. Learn more about adjusting the number of threads in the [VMware {{ GP }} Platform Extension Framework]({{ gp.docs.vmware }}-Platform-Extension-Framework/6.9/greenplum-platform-extension-framework/cfg_mem.html) documentation.

        * `pool_allow_core_thread_timeout`: Determines whether a timeout for core streaming threads is allowed. The default value is `false`.
        * `pool_core_size`: Number of core streaming threads per pool. The value range is from `1` to `1024`.
        * `pool_queue_capacity`: Maximum number of queries you can add to a pool queue after core streaming threads. The values may range from zero upward. If `0`, no pool queue is generated.
        * `pool_max_size`: Maximum allowed number of core streaming threads. The value range is from `1` to `1024`.
        * `xmx`: Initial size of the JVM heap for the PXF daemon, in megabytes. The value range is from `64` to `16384`.
        * `xms`: Maximum size of the JVM heap for the PXF daemon, in megabytes. The value range is from `64` to `16384`.

        You can get the cluster ID with a [list of clusters in the folder](../cluster-list.md#list-clusters).

    1. View the [server response](../../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
