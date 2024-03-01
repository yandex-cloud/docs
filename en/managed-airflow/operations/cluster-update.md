---
title: "Updating an {{ AF }} cluster"
description: "After creating a cluster, you can change its basic and advanced settings."
keywords:
  - "Updating an {{ AF }} cluster"
  - "{{ AF }} cluster"
  - "{{ AF }}"
  - Airflow
---

# Updating {{ AF }} clusters

After creating a cluster, you can change its basic and advanced settings.

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-airflow }}**.

   1. Select the cluster and click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** in the top panel.

   1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**, edit the cluster name and description, delete labels, or add new ones.

   1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select a [security group](../../vpc/concepts/security-groups.md) for cluster network traffic or create a new group.

      {% include [sg-ui-access](../../_includes/mdb/maf/note-sg-ui-access.md) %}

   1. Under the settings of {{ maf-name }} [components](../concepts/index.md#components), such as **{{ ui-key.yacloud.airflow.section_webserver }}**, **{{ ui-key.yacloud.airflow.section_scheduler }}**, and **{{ ui-key.yacloud.airflow.section_workers }}**, specify the number of instances and resources.

   1. Under **{{ ui-key.yacloud.airflow.section_triggerer }}**, enable or disable the Triggerer service. If it is enabled, specify the number of instances and resources.

   1. Under **{{ ui-key.yacloud.mdb.forms.section_storage }}**, paste the [static access key](../../iam/concepts/authorization/access-key.md) values for your [service account](../../iam/concepts/users/service-accounts.md).

   1. Under **{{ ui-key.yacloud.mdb.forms.section_additional }}**, enable or disable deletion protection.

   1. Under **{{ ui-key.yacloud.airflow.section_airflow-configuration }}**, edit, delete, or add [{{ AF }} additional properties](https://airflow.apache.org/docs/apache-airflow/2.2.4/configurations-ref.html), e.g., `api.maximum_page_limit` as a key and `150` as its value. Fill out the fields manually or import the settings from a configuration file (see [sample configuration file](https://{{ s3-storage-host }}/doc-files/managed-airflow/airflow.cfg)).

   1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

{% endlist %}
