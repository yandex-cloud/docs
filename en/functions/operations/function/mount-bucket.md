---
title: "Mounting a bucket to a function"
description: "Follow this guide to mount a bucket to a function."
---

# Mounting a bucket to a function

{% include [read-note](../../../_includes/functions/read-note.md) %}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder containing your function.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Select a function.
    1. Go to the **{{ ui-key.yacloud.serverless-functions.item.switch_editor }}** tab.
    1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.title_mount-files }}**, click **{{ ui-key.yacloud.serverless-functions.item.editor.label_add-folder }}**.
    1. Specify the following in the field:
        * **{{ ui-key.yacloud.serverless-functions.item.editor.label_mount-point-name }}**: Name of the mount point. The directory where the bucket is mounted will be accessible at the `/function/storage/<mount_point>` path.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.label_bucket }}**: Name of the bucket you want to mount. Alternatively, you can create a new bucket.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.label_bucket-prefix }}**: [Folder](../../../storage/concepts/object.md#folder) within the bucket. If you leave this field empty, the entire bucket will be mounted.
    1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- API {#api}

    To mount a bucket, use the [createVersion](../../functions/api-ref/Function/createVersion.md) REST API method for the [Function](../../functions/api-ref/Function/index.md) resource or the [FunctionService/CreateVersion](../../functions/api-ref/grpc/function_service.md#CreateVersion) gRPC API call.

{% endlist %}

## See also {#see-also}

* [Mounting a bucket to a function](../../concepts/mounting.md)
* [Mounting a bucket to a container](../../../serverless-containers/concepts/mounting.md)
