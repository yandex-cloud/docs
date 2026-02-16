{% list tabs group=instructions %}

- Management console {#console}

    1. Go to the [folder page]({{ link-console-main }}).
    1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. Click the name of your cluster and select the **{{ ui-key.yacloud.mdb.cluster.switch_jobs }}** tab.

- CLI {#cli}
    
    {% include [cli-install](../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../_includes/default-catalogue.md) %}
    
    To get a list of cluster jobs:

    1. See the description of the CLI command for getting a list of jobs:

        ```bash
        yc managed-spark job list --help
        ```
    
    1. Get the list of jobs by running this command:

        ```bash
        yc managed-spark job list \
          --cluster-id <cluster_ID>
        ```

        You can get the cluster ID with the [list of clusters in the folder](../../managed-spark/operations/cluster-list.md#list-clusters).

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../../managed-spark/api-ref/authentication.md) and put it in an environment variable:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [JobService.List](../../managed-spark/api-ref/grpc/Job/list.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/spark/v1/job_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                   "cluster_id": "<cluster_ID>"
               }' \
            {{ api-host-spark }}:{{ port-https }} \
            yandex.cloud.spark.v1.JobService.List
        ```

        You can get the cluster ID with the [list of clusters in the folder](../../managed-spark/operations/cluster-list.md#list-clusters).

    1. View the [server response](../../managed-spark/api-ref/grpc/Job/list.md#yandex.cloud.spark.v1.ListJobsResponse) to make sure your request was successful.

{% endlist %}
