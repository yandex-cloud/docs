---
title: Updating an {{ TR }} cluster
description: After creating a {{ TR }} cluster, you can edit its basic and advanced settings.
keywords:
  - Updating an {{ TR }} cluster
  - '{{ TR }} cluster'
  - '{{ TR }}'
noIndex: true
---

# Updating an {{ TR }} cluster

{% include [preview](../../_includes/managed-trino/note-preview.md) %}

After creating a cluster, you can edit its basic and advanced settings.

{% list tabs group=instructions %}

- Management console {#console}

    To change the cluster settings:

    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
    1. Select the cluster and click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** in the top panel.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**:

        * Edit the cluster name and description.
        * Delete or add new [labels](../../resource-manager/concepts/labels.md).
        * Select a service account or [create a new one](../../iam/operations/sa/create.md#create-sa) with the `managed-trino.integrationProvider` and `storage.editor` roles. The cluster will thus get the permissions it needs to work with user resources.

            To change your service account in a {{ mtr-name }} cluster, [make sure](../../iam/operations/roles/get-assigned-roles.md) your {{ yandex-cloud }} account has the [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) role or higher.

            {% include [mdb-service-account-update](../../_includes/mdb/service-account-update.md) %}

    1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select the cluster security group.
    1. Change the configuration of the [coordinator](../concepts/index.md#coordinator) and [workers](../concepts/index.md#workers).
    1. Under **{{ ui-key.yacloud.mdb.forms.section_additional }}**, enable or disable cluster deletion protection.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_additional }}**, enable or disable logging. If logging is enabled, specify the log group or folder to write logs to and the minimum logging level.
    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

{% endlist %}
