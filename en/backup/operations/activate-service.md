---
title: How to activate {{ backup-full-name }}
description: Follow this guide to activate {{ backup-name }}.
---

# Activating the service


{% include [activate-provider-roles](../../_includes/backup/activate-provider-roles.md) %}

{% include [agent-send-data](../../_includes/backup/agent-send-data.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a VM or {{ baremetal-full-name }} server with a {{ backup-name }} connection.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. Click **{{ ui-key.yacloud.backup.button_action-activate }}**.

      If there is no **{{ ui-key.yacloud.backup.button_action-activate }}** button, and you can create a VM connected to {{ backup-name }}, it means the service has already been activated.

  {% include [default-policies](../../_includes/backup/default-policies.md) %}

- CLI {#cli}

  {% include [cli-activate-service](../../_includes/backup/operations/cli-activate-service.md) %}

- API {#api}

  Use the [Activate](../backup/api-ref/Provider/activate.md) REST API method for the [Provider](../backup/api-ref/Provider/index.md) resource or the [ProviderService/Activate](../backup/api-ref/grpc/Provider/activate.md) gRPC API call.

{% endlist %}
