{% note warning %}

To get job execution logs, enable logging in your cluster while [creating](../../managed-spark/operations/cluster-create.md) it.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

    1. Go to the [folder page]({{ link-console-main }}).
    1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. Click the name of your cluster and select the **{{ ui-key.yacloud.mdb.cluster.switch_jobs }}** tab.
    1. Click the job name.
    1. In the **{{ ui-key.yacloud.dataproc.jobs.label_job-logs }}** field, click the link.

- CLI {#cli}
    
    {% include [cli-install](../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../_includes/default-catalogue.md) %}
    
    To get job execution logs:

    1. See the description of the CLI command for getting job logs:

        ```bash
        yc managed-spark job log --help
        ```
    
    1. Get job logs by running this command:

        ```bash
        yc managed-spark job log <job_ID> \
          --cluster-id <cluster_ID>
        ```

        You can get the cluster ID with the [list of clusters in the folder](../../managed-spark/operations/cluster-list.md#list-clusters).

        You can get the job ID with the [list of cluster jobs](#list).

        To get logs for multiple jobs, list their IDs separated by spaces, e.g.:
        
        ```bash
        yc managed-spark job log c9q9veov4uql******** c9qu8uftedte******** \
          --cluster-id c9q8ml85r1oh********
        ```

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../../managed-spark/api-ref/authentication.md) and put it in an environment variable:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [JobService.ListLog](../../managed-spark/api-ref/grpc/Job/listLog.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/spark/v1/job_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                   "cluster_id": "<cluster_ID>",
                   "job_id": "<job_ID>"
               }' \
            {{ api-host-spark }}:{{ port-https }} \
            yandex.cloud.spark.v1.JobService.ListLog
        ```

        You can request the cluster ID with the [list of clusters in the folder](../../managed-spark/operations/cluster-list.md#list-clusters), and the job ID, with the [list of cluster jobs](#list).

    1. View the [server response](../../managed-spark/api-ref/grpc/Job/listLog.md#yandex.cloud.spark.v1.ListJobLogResponse) to make sure your request was successful.

{% endlist %}
