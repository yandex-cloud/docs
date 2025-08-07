---
title: Creating a {{ ytsaurus-name }} cluster
description: Every {{ mtr-name }} cluster consists of a set of {{ ytsaurus-name }} components, each of which can be represented in multiple instances. The instances may reside in different availability zones.
keywords:
  - creating an {{ ytsaurus-name }} cluster
  - '{{ ytsaurus-name }} cluster'
  - '{{ ytsaurus-name }}'
---

# Creating a {{ ytsaurus-name }} cluster

{% include [preview](../../_includes/managed-ytsaurus/note-preview.md) %}

Each {{ myt-name }} cluster consists of multiple {{ ytsaurus-name }} components.

Configurable components:
* Exec and tablet nodes
* Storages
* HTTP and RPC proxies

Non-configurable service components:
* Master nodes
* Storage nodes
* System nodes

## Roles for creating a cluster {#roles}

To create a {{ myt-name }} cluster, your {{ yandex-cloud }} account needs the following roles:

* [managed-ytsaurus.editor](../security/index.md#managed-ytsaurus-editor): To create a cluster.
* [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user): To use the cluster [network](../../vpc/concepts/network.md#network).

For more information about assigning roles, see the [{{ iam-full-name }} documentation](../../iam/operations/roles/grant.md).

## Creating a cluster {#create-cluster}

{% note info %}

Creating a {{ ytsaurus-name }} cluster takes a long time, e.g., an hour or more depending on the selected configuration.

{% endnote %}

In {{ myt-name }}, you can create a [{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.cluster-kind-card_demo_title_4B7zu }}](#demo-cluster) with the minimum functional configuration to test the service or a [{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.cluster-kind-card_production_title_dVEmq }}](#production-cluster) supporting manual cluster setup. 

### Demo cluster {#demo-cluster}

{% list tabs group=instructions %}

- Management console {#console}

  {% include notitle [demo-cluster-create](../../_includes/managed-ytsaurus/demo-cluster-create.md) %}

{% endlist %}

### Production cluster {#production-cluster}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you want to create a {{ myt-name }} cluster.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-ytsaurus }}**.
    1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
    1. Select **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.cluster-kind-card_production_title_dVEmq }}** to create a cluster with manual setup.
    1. Under **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.base-params-section_title_nfKo2 }}**:
        1. Give the cluster a name. The name must be unique within the folder.
        1. Optionally, enter a description for the cluster.
        1. Optionally, create [labels](../../resource-manager/concepts/labels.md):
            1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Enter a label in `key: value` format.
            1. Press **Enter**.

    1. Under **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.net-settings-section_title_wo42X }}**, select:
       * [Availability zone](../../overview/concepts/geo-scope.md) for the cluster.
       * [Subnet](../../vpc/operations/subnet-create.md).
       * [Security group](../../vpc/concepts/security-groups.md) for the cluster network traffic. This is an optional parameter.

       {% note warning %}
       
       You cannot edit any network settings after you create a cluster.
       
       {% endnote %}

    1. Under **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.filestore-section_title_tYMR7 }}**, click **{{ ui-key.yacloud.common.add }}** and select the disk type, size, and number.

       The selected type determines the increments in which you can change your disk size:
          * Network HDD and SSD storage: In increments of 1 GB.
          * Non-replicated SSD storage: In increments of 93 GB.

       The `HDD` storage is required and added by default. Edit the disk number and size as appropriate.

       {% note warning %}
       
       You cannot change the disk type or size for a {{ ytsaurus-name }} cluster once you create it.
       
       {% endnote %}
    
    1. Under **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.exec-node-configuration-section_title_mfa54 }}**, specify:
       * Number of nodes.
       * [Computing resource configuration](../concepts/component-types.md#exec-node).
       * Type and size of the storage you will use to run jobs.

    1. Under **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.tablet-node-configuration-section_title_fHZeX }}**, specify:
       * Number of nodes.
       * [Computing resource configuration](../concepts/component-types.md#tablet-node).

       To use tablet nodes, add an `SSD` or `non-replicated SSD` storage.

       {% note warning %}
       
       You cannot edit the number of tablet nodes after you create a cluster.
       
       {% endnote %}
    
    1. Under **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.http-config-section_title_kMdci }}** and **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.rpc-config-section_title_tGACF }}**, set the number of proxies.

       {% note warning %}
       
       You cannot edit the number of proxy nodes after you create a cluster.
       
       {% endnote %}

    1. Click **{{ ui-key.yacloud.common.create }}**.
    1. Wait until the cluster is ready: its status on the {{ myt-name }} dashboard will change to **Running**. This process can take a while.

{% endlist %}