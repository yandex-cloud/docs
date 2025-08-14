---
title: Creating a {{ SPQR }} cluster
description: Follow this guide to create a {{ SPQR }} cluster with standard or advanced sharding.
keywords:
  - creating an {{ SPQR }} cluster
  - '{{ SPQR }} cluster'
  - '{{ SPQR }}'
---

# Creating a {{ SPQR }} cluster

{% include notitle [preview](../../_includes/note-preview.md) %}

## Creating a cluster {#create-cluster}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you want to create a {{ SPQR }} cluster.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
    1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**:

        1. Give the cluster a name. The name must be unique within the folder.
        1. Optionally, enter a description for the cluster.
        1. Optionally, create [labels](../../resource-manager/concepts/labels.md):

            1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Enter a label in `key: value` format.
            1. Press **Enter**.

        1. Select the environment where you want to create the cluster (you cannot change the environment once the cluster is created):

            * `PRODUCTION`: For stable versions of your apps.
            * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by the SLA, but it is the first to get new functionalities, improvements, and bug fixes. In the prestable environment, you can test the compatibility of new versions with your application.

        1. Select the sharding type:

            * `{{ ui-key.yacloud.spqr.section_sharding-type-standard }}`: Cluster will consist only of infrastructure hosts.
            * `{{ ui-key.yacloud.spqr.section_sharding-type-advanced }}`: Cluster will consist only of router hosts and, optionally, coordinator hosts.

    1. Under **{{ ui-key.yacloud.mdb.forms.section_network }}**, select a [network](../../vpc/operations/network-create.md) and [security groups](../../vpc/concepts/security-groups.md) for the cluster.

    1. Specify the computing resource configuration:

        * For standard sharding, specify the infrastructure host configuration under **{{ ui-key.yacloud.spqr.section_infra }}**.
        * For advanced sharding, specify the router host configuration under **{{ ui-key.yacloud.spqr.section_router }}**.

            Optionally, under **{{ ui-key.yacloud.spqr.section_coordinator }}**, enable **{{ ui-key.yacloud.spqr.field_coordinator }}** and specify the coordinator host configuration.

        To specify your computing resource configuration:

        1. Select a platform in the **{{ ui-key.yacloud.mdb.forms.resource_presets_field-generation }}** field.
        1. Specify the **{{ ui-key.yacloud.mdb.forms.resource_presets_field-type }}** of the VM to deploy hosts on.
        1. Select **{{ ui-key.yacloud.mdb.forms.section_resource }}**.
        1. Under **{{ ui-key.yacloud.mdb.forms.section_storage }}**, select the disk type and specify the [storage](../concepts/storage.md) size.
        1. Under **{{ ui-key.yacloud.spqr.section_hosts }}**:

            1. Click **{{ ui-key.yacloud.mdb.hosts.dialog.label_title }}** to add the required number of hosts to create together with the {{ SPQR }} cluster.
            1. Click ![image](../../_assets/console-icons/pencil.svg) and specify the following for each host:

                * [Availability zone](../../overview/concepts/geo-scope.md).
                * [Subnet](../../vpc/concepts/network.md#subnet): By default, each host is created in a separate subnet.
                * Select **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** if the host must be accessible from outside {{ yandex-cloud }}.

            After creating a {{ SPQR }} cluster, you can add extra hosts to it if there are enough [folder resources](../concepts/limits.md) available.

    1. Under **{{ ui-key.yacloud.mdb.forms.section_database }}**, specify the database parameters:

        * DB name. Acceptable length is from 1 to 63 characters. Can contain lowercase and uppercase Latin letters, numbers, underscores, and hyphens.

        * Username. Acceptable length is from 1 to 63 characters. Can contain lowercase and uppercase Latin letters, numbers, underscores, and hyphens, but can't start with a hyphen.

        * User password. It may be from 8 to 128 characters long.

    1. Configure additional cluster settings, if required:

        {% include [extra-settings](../../_includes/mdb/mspqr/console/extra-settings.md) %}

    1. Click **{{ ui-key.yacloud.mdb.forms.button_create }}**.

{% endlist %}
