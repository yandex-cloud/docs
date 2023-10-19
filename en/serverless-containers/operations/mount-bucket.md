# Mounting a bucket to a container

{% include [read-note](../../_includes/functions/read-note.md) %}

{% list tabs %}

- Management console

    1. In the [management console]({{ link-console-main }}), select the folder with your container.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
    1. Select the container.
    1. Go to the **{{ ui-key.yacloud.serverless-containers.label_editor }}** tab.
    1. Under **Mounted buckets**, click the **Add bucket** button.
    1. Specify the following in the field:
        * **Mount path**: Mount path. Use this path to access the directory in which the bucket is mounted.
        * **Bucket**: Name of the bucket you want to mount. Alternatively, you can create a new bucket.
        * **Folder**: [Folder](../../storage/concepts/object.md#folder) within the bucket. If you leave this field empty, the entire bucket will be mounted.
    1. Click **{{ ui-key.yacloud.serverless-containers.button_deploy-revision }}**.

- API

  To mount a bucket, use the [deployRevision](../containers/api-ref/Container/deployRevision.md) REST API method for the [Container](../containers/api-ref/Container/index.md) resource or the [ContainerService/DeployRevision](../containers/api-ref/grpc/container_service.md#DeployRevision) gRPC API call.

{% endlist %}

## See also {#see-also}

* [Mounting a bucket to a container](../concepts/mounting.md)
* [Mounting a bucket to a function](../../functions/concepts/mounting.md)
