{% note info %}

You cannot cancel jobs with the `ERROR`, `DONE`, or `CANCELLED` status. To find out a job's status, retrieve a [list of jobs](#list) in the cluster.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. Click the cluster name and open the **{{ ui-key.yacloud.mdb.cluster.switch_jobs }}** tab.
    1. Click the job name.
    1. Click **{{ ui-key.yacloud.common.cancel }}** in the top-right corner of the page.
    1. In the window that opens, select **{{ ui-key.yacloud.spark.jobs.popup-action_label_cancel-msg }}**.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../../managed-spark/api-ref/authentication.md) and put it into the environment variable:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [JobService.Cancel](../../managed-spark/api-ref/grpc/Job/cancel.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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
            yandex.cloud.spark.v1.JobService.Cancel
        ```

        You can get the cluster ID with the [list of folder clusters](../../managed-spark/operations/cluster-list.md#list-clusters), and the job ID, with the [list of cluster jobs](#list).

    1. View the [server response](../../managed-spark/api-ref/grpc/Job/cancel.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}
