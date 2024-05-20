---
title: "How to export logs from {{ cloud-logging-name }} to {{ objstorage-name }}"
description: "In this tutorial, you will learn how to export logs from {{ cloud-logging-name }} to {{ objstorage-name }}."
---

# Exporting logs to {{ objstorage-name }}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), go to the folder containing your log group and log sink.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
    1. Select a log group to export logs from.
    1. Go to the **{{ ui-key.yacloud.common.logs }}** tab.
    1. To the right of the **{{ ui-key.yacloud.logging.button_execute }}** button, click ![image](../../_assets/console-icons/chevron-down.svg) → **{{ ui-key.yacloud.logging.label_export }}**.
    1. In the window that opens:
        1. Specify the export period.
        1. Select a log sink.
        1. Enter a name for the export file.
        1. Click **{{ ui-key.yacloud.logging.label_export }}**.

    The file will be saved to the bucket specified in the settings of the selected log sink.

- API {#api}

    To export logs, use the [run](../api-ref/Export/run.md) REST API method for the [Export](../api-ref/Export/index.md) resource or the [ExportService/Run](../api-ref/grpc/export_service.md#Run) gRPC API call.

{% endlist %}