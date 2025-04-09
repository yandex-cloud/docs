---
title: Creating a {{ TR }} cluster
description: Every {{ mtr-name }} cluster consists of a set of {{ TR }} components, each of which can be represented in multiple instances. The instances may reside in different availability zones.
keywords:
  - creating an {{ TR }} cluster
  - '{{ TR }} cluster'
  - '{{ TR }}'
noIndex: true
---

# Creating a {{ TR }} cluster

{% include [preview](../../_includes/managed-trino/note-preview.md) %}

Each {{ mtr-name }} cluster comprises a set of {{ TR }} components: coordinator and workers, which can be represented in multiple instances.

## Roles for creating a cluster {#roles}

To create a {{ mtr-name }} cluster, your {{ yandex-cloud }} account needs the following roles:

* [managed-trino.admin](../security.md#managed-trino-admin): To create a cluster.
* [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user): To use the cluster [network](../../vpc/concepts/network.md#network).
* [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user): To link a service account to the cluster.

Make sure to assign the `managed-trino.integrationProvider` and `storage.editor` roles to the cluster service account. The cluster will thus get the permissions it needs to work with user resources.

For more information about assigning roles, see the [{{ iam-full-name }}](../../iam/operations/roles/grant.md) documentation.

## Creating a cluster {#create-cluster}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the management console, select the folder where you want to create a {{ mtr-name }} cluster.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
    1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**:

        1. Specify a name for the cluster. The name must be unique within the folder.
        1. (Optional) Enter a cluster description.
        1. Optionally, create [labels](../../resource-manager/concepts/labels.md):

            1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Enter a label in `key: value` format.
            1. Press **Enter**.

        1. Select an existing [service account](../../iam/concepts/users/service-accounts.md) or [create a new one](../../iam/operations/sa/create.md).

            Make sure to assign the `managed-trino.integrationProvider` and `storage.editor` to the service account.

    1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select a [network](../../vpc/operations/network-create.md), [subnet](../../vpc/operations/subnet-create.md), and [security group](../../vpc/concepts/security-groups.md) for the cluster.
    1. Configure the coordinator and workers.
    1. Under **{{ ui-key.yacloud.trino.title_catalogs }}**, add the required folders. You can do this either when creating the cluster or later.

        1. Specify a name for the folder. The name must be unique within the cloud.
        1. Select **{{ ui-key.yacloud.trino.catalogs.field_catalog-type }}**.
        1. Under **{{ ui-key.yacloud.trino.catalogs.section_catalog }}**, set the parameters depending on the selected type:

            * For Hive, Iceberg, and Delta Lake connectors:

                * **{{ ui-key.yacloud.trino.catalogs.label_uri }}** to connect to the Metastore cluster in this format: `thrift://<IP_address>:<port>`.
                * **{{ ui-key.yacloud.trino.catalogs.label_filesystem }}**: Select the file storage type: **{{ ui-key.yacloud.trino.catalogs.label_s3 }}** or **{{ ui-key.yacloud.trino.catalogs.label_external-s3 }}**. For external storage, specify the following settings:
                    * AWS-compatible static access key ID.
                    * AWS-compatible static access key secret key.
                    * File storage endpoint, such as `{{ s3-storage-host }}`.
                    * File storage region, such as `{{ region-id }}`.

            * For {{ PG }} and {{ CH }} connectors:

                * **{{ ui-key.yacloud.trino.catalogs.label_url }}** to connect to a cluster in this format: `jdbc:<DBMS>://<host_address>:<port>/<DB_name>`, where `DBMS` is `postgresql` or `clickhouse`.
                * **{{ ui-key.yacloud.trino.catalogs.label_userName }}** to connect to a cluster.
                * User **{{ ui-key.yacloud.trino.catalogs.label_password }}**.

            * [TPC-H](https://trino.io/docs/current/connector/tpch.html) and [TPC-DS](https://trino.io/docs/current/connector/tpcds.html) connectors provide access to test data and do not require configuration.

        1. Optionally, specify additional folder settings in `key:value` format.

    1. Under **{{ ui-key.yacloud.mdb.forms.section_additional }}**:

        1. Optionally, enable cluster deletion protection.
        1. Optionally, configure logging:

            1. Enable the **{{ ui-key.yacloud.logging.field_logging }}** setting.
            1. Select where the logs will be stored:
                * **{{ ui-key.yacloud.common.folder }}**: Select a folder from the list.
                * **{{ ui-key.yacloud.logging.label_group }}**: Select a [log group](../../logging/concepts/log-group.md) from the list or create a new one.
            1. Select **{{ ui-key.yacloud.logging.label_minlevel }}** from the list.

    1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}
