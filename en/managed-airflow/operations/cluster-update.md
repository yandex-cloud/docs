---
title: Updating an {{ AF }} cluster
description: After creating a cluster, you can change its basic and advanced settings.
keywords:
  - Updating an {{ AF }} cluster
  - '{{ AF }} cluster'
  - '{{ AF }}'
  - Airflow
---

# Updating an {{ AF }} cluster

After creating a cluster, you can change its basic and advanced settings.

{% list tabs group=instructions %}

- Management console {#console}

    1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-airflow }}**.

    1. Select the cluster and click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** in the top panel.

    1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**, edit the cluster name and description, delete labels, or add new ones.

    1. Under **{{ ui-key.yacloud.airflow.section_accesses }}**, select a service account or [create a new one](../../iam/operations/sa/create.md#create-sa) with the `managed-airflow.integrationProvider` role. Thus the cluster will get the permissions required for working with user resources. For more information, see [Impersonation](../concepts/impersonation.md).
    1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select a [security group](../../vpc/concepts/security-groups.md) for cluster network traffic or create a new group.

       {% include [sg-ui-access](../../_includes/mdb/maf/note-sg-ui-access.md) %}

    1. Under the settings of {{ maf-name }} [components](../concepts/index.md#components), such as **{{ ui-key.yacloud.airflow.section_webserver }}**, **{{ ui-key.yacloud.airflow.section_scheduler }}**, and **{{ ui-key.yacloud.airflow.section_workers }}**, specify the number of instances and resources.

    1. Under **{{ ui-key.yacloud.airflow.section_triggerer }}**, enable or disable the `Triggerer` service. If it is enabled, specify the number of instances and resources.

    1. Under **{{ ui-key.yacloud.airflow.section_dependencies }}**, delete or add names of pip and deb packages.

    1. Under **{{ ui-key.yacloud.mdb.forms.section_additional }}**, enable or disable deletion protection.

    1. Under **{{ ui-key.yacloud.airflow.section_airflow-configuration }}**:

        * Add, edit, or delete [{{ AF }} additional properties](https://airflow.apache.org/docs/apache-airflow/2.2.4/configurations-ref.html), e.g., the `api.maximum_page_limit` key with `150` for its value.

            Populate the fields manually or import a configuration from a file (see [sample configuration file](https://{{ s3-storage-host }}/doc-files/managed-airflow/airflow.cfg)).

        * Enable or disable the **{{ ui-key.yacloud.airflow.field_lockbox }}** option allowing you to use secrets in [{{ lockbox-full-name }}](../../lockbox/concepts/index.md) to [store {{ AF }} configuration data, variables, and connection parameters](../concepts/impersonation.md#lockbox-integration).

            {% include [sa-roles-for-lockbox](../../_includes/managed-airflow/sa-roles-for-lockbox.md) %}

    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

{% endlist %}
