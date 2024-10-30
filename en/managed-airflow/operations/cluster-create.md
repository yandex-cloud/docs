---
title: Creating an {{ AF }} cluster
description: Every {{ maf-name }} cluster consists of a set of {{ AF }} components, each of which can be represented in multiple instances. The instances may reside in different availability zones.
keywords:
  - creating an {{ AF }} cluster
  - '{{ AF }} cluster'
  - '{{ AF }}'
  - Airflow
---

# Creating an {{ AF }} cluster

Every {{ maf-name }} cluster consists of a set of {{ AF }} components, each of which can be represented in multiple instances. The instances may reside in different availability zones.

## Creating a cluster {#create-cluster}

To create a {{ maf-name }} cluster, you need the [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user) role and the [{{ roles.maf.editor }} role or higher](../security/index.md#roles-list). For more information on assigning roles, see the [{{ iam-name }} documentation](../../iam/operations/roles/grant.md).

{% list tabs group=instructions %}

- Management console {#console}


  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a cluster.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-airflow }}**.
  1. Click **{{ ui-key.yacloud.airflow.button_create-cluster }}**.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**:

        1. Enter a name for the cluster. The name must be unique within the folder.
        1. (Optional) Enter a cluster description.
        1. (Optional) Create [labels](../../resource-manager/concepts/labels.md):
            1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Enter a label in `key: value` format.
            1. Click **Enter**.

  1. Under **{{ ui-key.yacloud.airflow.section_accesses }}**:

        * Set a password for the admin user. The password must be not less than 8 characters long and contain at least:
            * One uppercase letter
            * One lowercase letter
            * One digit
            * One special character

           {% note info %}

           Save the password locally or memorize it. The service does not show passwords after the registry is created.

           {% endnote %}

        * Select an existing service account or create a new one.

           Make sure to assign the `managed-airflow.integrationProvider` [role](../../iam/concepts/access-control/roles.md) to the service account:

  1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select:

      * [Availability zones](../../overview/concepts/geo-scope) for the cluster
      * Cloud network
      * Subnet in each of the selected availability zones

        {{ yandex-cloud }} manages {{ maf-name }} cluster components in the auxiliary subnet. Make sure the IP address range of the subnets you selected does not overlap with the `{{ airflow-service-address }}` auxiliary subnet address range. Otherwise, you will get an error when creating a cluster.

      * [Security group](../../vpc/concepts/security-groups.md) for the cluster network traffic

        {% include [sg-ui-access](../../_includes/mdb/maf/note-sg-ui-access.md) %}

  1. Set the number of instances and resources for the {{ maf-name }} [components](../concepts/index.md#components):

      * Web server
      * Scheduler
      * Workers

        {% note info %}

        If the issue queue is empty, the number of workers will be the minimum value. When issues appear, the number of workers will increase up to the maximum value.

        {% endnote %}

      * (Optional) Triggerer services

  1. (Optional) Under **{{ ui-key.yacloud.airflow.section_dependencies }}**, specify pip and deb package names to install additional libraries and applications in the cluster to run DAG files.

      To specify multiples packages, click **{{ ui-key.yacloud.common.add }}**.

      If required, you can set version restrictions for the installed packages, for example:

      ```text
      pandas==2.0.2
      scikit-learn>=1.0.0
      clickhouse-driver~=0.2.0
      ```

      The package name format and version are defined by the install command: `pip install` for pip packages and `apt install` for deb packages.

      {% note warning %}

      To install pip and deb packages from public repositories, specify a network with configured [egress NAT under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**](../../vpc/operations/create-nat-gateway.md).

      {% endnote %}

  1. Under **{{ ui-key.yacloud.airflow.section_storage }}**, select a bucket or create a new one. This bucket will store DAG files.

      Make sure to [grant the `READ` permission](../../storage/operations/buckets/edit-acl.md) for this bucket to the cluster service account.

  1. (Optional) Under **{{ ui-key.yacloud.mdb.forms.section_additional }}**, enable cluster deletion protection.

  1. Optionally, under **{{ ui-key.yacloud.airflow.section_airflow-configuration }}**:
  
      * Specify [{{ AF }} additional properties](https://airflow.apache.org/docs/apache-airflow/2.2.4/configurations-ref.html) additional properties, e.g., `api.maximum_page_limit` as a key and `150` as its value.

        Fill in the fields manually or import the settings from a configuration file (see [configuration file example](https://{{ s3-storage-host }}/doc-files/managed-airflow/airflow.cfg)).

      * Enable the **{{ ui-key.yacloud.airflow.field_lockbox }}** option to use secrets in [{{ lockbox-full-name }}](../../lockbox/concepts/index.md) to [store {{ AF }} configuration data, variables, and connection parameters](../concepts/impersonation.md#lockbox-integration).

        {% include [sa-roles-for-lockbox](../../_includes/managed-airflow/sa-roles-for-lockbox.md) %}

  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}
