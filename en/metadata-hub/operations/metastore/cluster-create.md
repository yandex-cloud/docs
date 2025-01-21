---
title: How to create a {{ metastore-full-name }} cluster
description: Follow this guide to create a {{ metastore-full-name }} cluster.
---

# Creating a {{ metastore-full-name }} cluster

{% include [Preview](../../../_includes/note-preview.md) %}

To learn more about {{ metastore-name }} clusters in {{ metadata-hub-name }}, see [{#T}](../../concepts/metastore.md).

## Getting started {#before-you-begin}

1. To link your [service account](../../../iam/concepts/users/service-accounts.md) to a {{ metastore-name }} cluster, [make sure](../../../iam/operations/roles/get-assigned-roles.md) your {{ yandex-cloud }} account has the [iam.serviceAccounts.user](../../../iam/security/index.md#iam-serviceAccounts-user) role or higher.
1. [Set up a NAT gateway](../../../vpc/operations/create-nat-gateway.md) in the subnet the cluster will connect to. It is needed for the cluster to interact with {{ yandex-cloud }} services.
1. [Configure the security group](configure-security-group.md).
1. [Create a service account](../../../iam/operations/sa/create.md).
1. [Assign the `{{ roles.metastore.integrationProvider }}` role](../../../iam/operations/sa/assign-role-for-sa.md) to the service account. This role enables the cluster [to work with {{ yandex-cloud }} services](../../concepts/metastore-impersonation.md), e.g., {{ cloud-logging-full-name }} and {{ monitoring-full-name }}, under a service account.

    You can also add more roles. Their combination depends on your specific use case. To view the service roles, see the [{{ metastore-name }} section](../../security/metastore-roles.md), and for all available roles, see this [reference](../../../iam/roles-reference.md).

1. If you want to save cluster logs to a custom log group, [create one](../../../logging/operations/create-group.md).

    For more information, see [Transferring cluster logs](logging.md).

## Create a cluster {#create-cluster}

{% note warning %}

{{ metastore-name }} clusters cannot be edited. Once you create a cluster, you cannot change its settings.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you want to create a server.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
    1. In the left-hand panel, select the ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}** page.
    1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
    1. Enter a name for the cluster. It must be unique within the folder.
    1. (Optional) Enter a cluster description.
    1. (Optional) Add [{{ yandex-cloud }} labels](../../../resource-manager/concepts/labels.md) to break resources into logical groups.
    1. Specify the service account you created earlier.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select the network and subnet to host the {{ metastore-name }} cluster. Specify the security group you configured previously.
    1. Optionally, configure logging settings:

        1. Enable **{{ ui-key.yacloud.logging.field_logging }}**.
        1. Select where to write cluster logs to:

            * Default log group: Select **{{ ui-key.yacloud.common.folder }}** in the **{{ ui-key.yacloud.logging.label_destination }}** field and specify the folder. Logs will be stored in the selected folder's default log group.
            * Custom log group: Select **{{ ui-key.yacloud.logging.label_loggroup }}** in the **{{ ui-key.yacloud.logging.label_destination }}** field and specify the log group you created earlier.

        1. Select the minimum logging level.

            Logs of the specified level and higher will be written to the execution log. The available levels are `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, and `FATAL`. The default level is `INFO`.
    1. If required, enable protection of the cluster from accidental deletion by a user.

        {% include [Cluster deletion protection limits](../../../_includes/mdb/deletion-protection-limits-data.md) %}

    1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}
