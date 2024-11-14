---
title: Mounting buckets to a {{ serverless-containers-full-name }} container
description: Follow this guide to mount a bucket to a {{ serverless-containers-name }} container.
---

# Mounting a bucket to a container

{% list tabs group=instructions %}

- Management console {#console}
    
    1. In the [management console]({{ link-console-main }}), select the folder with your container.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
    1. Select the container.
    1. Go to the **{{ ui-key.yacloud.serverless-containers.label_editor }}** tab.
    1. In the **{{ ui-key.yacloud.serverless-containers.section_parameters }}** section, select or create a new [service account](../../iam/concepts/users/service-accounts) with one of these roles:
       * `storage.viewer` to only read data from the mounted bucket.
       * `storage.uploader` to read and write data from/to the mounted bucket.
    1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.title_mount-files }}**, click **{{ ui-key.yacloud.serverless-functions.item.editor.label_add-folder }}**.
    1. Specify the following in the field:
        * **{{ ui-key.yacloud.serverless-functions.item.editor.label_mount-point-path }}**: Mount path. Use this path to access the directory in which the bucket is mounted.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.label_bucket }}**: Name of the bucket you want to mount. Alternatively, you can create a new bucket.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.label_bucket-prefix }}**: [Folder](../../storage/concepts/object.md#folder) within the bucket. Leave this field empty to mount the entire bucket.
    1. Click **{{ ui-key.yacloud.serverless-containers.button_deploy-revision }}**.

- API {#api}

  To mount a bucket, use the [deployRevision](../containers/api-ref/Container/deployRevision.md) REST API method for the [Container](../containers/api-ref/Container/index.md) resource or the [ContainerService/DeployRevision](../containers/api-ref/grpc/Container/deployRevision.md) gRPC API call.

{% endlist %}

## See also {#see-also}

* [Mounting file systems to a container](../concepts/mounting.md)
* [Mounting file systems to a function](../../functions/concepts/mounting.md)
