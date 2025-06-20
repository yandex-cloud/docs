{% note warning %}

To get job execution logs, enable logging in your cluster while [creating](../../managed-spark/operations/cluster-create.md) it.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. Click the cluster name and open the **{{ ui-key.yacloud.mdb.cluster.switch_jobs }}** tab.
    1. Click the job name.
    1. In the **{{ ui-key.yacloud.dataproc.jobs.label_job-logs }}** field, click the link.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../../managed-spark/api-ref/authentication.md) and put it into the environment variable:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [JobService.ListLog](../../managed-spark/api-ref/grpc/Job/listLog.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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

    1. View the [server response](../../managed-spark/api-ref/grpc/Job/listLog.md#yandex.cloud.spark.v1.ListJobLogResponse) to make sure the request was successful.

{% endlist %}
