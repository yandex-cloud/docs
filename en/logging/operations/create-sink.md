---
title: How to create a log sink in {{ cloud-logging-name }}
description: In this guide, you will learn how to create a log sink in {{ cloud-logging-name }}.
---

# Creating a log sink

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you want to create your log sink.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
    1. Go to the **{{ ui-key.yacloud.logging.label_sinks }}** tab.
    1. Click **{{ ui-key.yacloud.logging.button_create-sink }}**.
    1. (Optional) Enter a sink name and description. The name format is as follows:

        {% include [name-format](../../_includes/name-format.md) %}

    1. (Optional) Add labels.
    1. In the **{{ ui-key.yacloud.logging.label_destination }}** field, select `{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}`.
    1. Select the bucket to save logs to.
    1. (Optional) Specify a [folder](../../storage/concepts/object.md#folder).
    1. Select a service account authorized to upload objects to the bucket.
    1. Click **{{ ui-key.yacloud.logging.button_create-sink }}**.

- CLI {#cli}

    To create a log sink, run the following command:
    ```
    yc logging sink create \
      --name <sink_name> \
      --service-account-id <service_account_ID> \
      --s3 bucket=<bucket_name>
    ```

    Where:
    * `--name`: Log sink name. This is an optional parameter.
    * `--service-account-id`: ID of the service account authorized to upload objects to the bucket.
    * `bucket`: Name of the bucket to upload logs to.

    Result:
    ```
    id: e23s5s2jsr78********
    folder_id: b1gc1t4cb638********
    cloud_id: b1gvlrnlei4l********
    created_at: "2023-09-24T19:05:33.367058291Z"
    name: test
    service_account_id: aje07l4q4vmo********
    s3:
      bucket: bucket-name
    ```

- API {#api}

    To create a log sink, use the [create](../api-ref/Sink/create.md) REST API method for the [Sink](../api-ref/Sink/index.md) resource or the [SinkService/Create](../api-ref/grpc/sink_service.md#Create) gRPC API call.

{% endlist %}
