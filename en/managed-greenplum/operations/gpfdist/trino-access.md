---
title: Access from {{ TR }}
description: How to enable a secure connection between {{ mgp-name }} and {{ mtr-name }} using the management console and CLI.
---

# Access from {{ TR }}

Enable **Trino access** in the {{ mgp-name }} cluster settings to work with the {{ mgp-name }} cluster's data from {{ mtr-name }}. This setting enables encrypted data transmission between {{ GP }} segments and {{ TR }} workers via the GPFDIST protocol.

{% note info %}

**Access from Trino** is a required configuration for reading data from {{ mgp-name }} via GPFDIST in {{ mtr-name }}. Encryption is used automatically; you do not need to configure it additionally.

{% endnote %}

## Getting started {#before-you-begin}

1. [Configure security groups](../connect/index.md#sg-for-trino) for interaction between the {{ mgp-name }} and {{ mtr-name }} clusters. Security groups determine which network connections are allowed.
1. Prepare the {{ GP }} user and [{{ TR }} catalog with the {{ GP }}/Cloudberry connector](../../../managed-trino/operations/catalog-create.md#gp-clouberry). To read data via GPFDIST, the user requires permissions to create writable external tables.

## Enabling access from {{ TR }} {#enable-trino-access}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder containing your cluster.
    1. [Navigate]({{ link-console-main }}/link/managed-greenplum) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Select your cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** at the top of the page.
    1. In the additional settings, enable **Access from Trino**.
    1. Click **{{ ui-key.yacloud.common.save }}** and wait for the cluster modification to complete.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    1. View the description of the following cluster modification command:

        ```bash
        {{ yc-mdb-gp }} cluster update --help
        ```

    1. Enable access from {{ TR }}:

        ```bash
        {{ yc-mdb-gp }} cluster update <cluster_name_or_ID> \
            --trino-access=true
        ```

        The `--trino-access=true` parameter enables access from {{ TR }} with data encryption during transmission.

    1. Wait for the operation to complete and check the cluster settings:

        ```bash
        {{ yc-mdb-gp }} cluster get <cluster_name_or_ID>
        ```

        Under `config.access`, the `trino` parameter must have the `true` value.

{% endlist %}

You can also enable access from {{ TR }} when [creating a cluster](../cluster-create.md): use the **Access from Trino** setting in the management console, or the `--trino-access=true` parameter of the `{{ yc-mdb-gp }} cluster create`command in the CLI.

## Configuring data reading {#configure-reading}

In the {{ TR }} catalog with the {{ GP }}/Cloudberry connector, [configure the settings](../../../managed-trino/operations/catalog-update.md) for reading via GPFDIST:

* `greenplum.gpfdist.server.enabled`: `true`
* `greenplum.gpfdist.read.enabled`: `true`

The connector will create external tables and orchestrate data transfer from {{ GP }} segments to {{ TR }} workers. There is no need to create these external tables manually.

## Limitations {#limitations}

* Reading via GPFDIST with encryption requires a {{ mtr-name }} cluster running version 476 that supports connector-side encryption.
* This setting is intended solely for integration with {{ mtr-name }}.
* Access management from {{ TR }} via {{ TF }} is not yet supported. Use the management console or CLI.
* Enabling access from {{ TR }} does not replace configuring security groups, database user permissions, and the {{ TR }} catalog.
* Configuring applies to data transfer via GPFDIST between {{ GP }} segments and {{ TR }} workers. Database connection parameters are specified separately in the {{ TR }} catalog.
* [Limitations on reading data via GPFDIST](../../../managed-trino/concepts/greenplum-connector.md#gpfdist-reading) remain in effect.

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}

{% include [cloudberry-trademark](../../../_includes/mdb/mgp/trademark-cloudberry.md) %}
