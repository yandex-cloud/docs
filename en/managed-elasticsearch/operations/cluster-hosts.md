---
title: Managing Elasticsearch hosts
description: 'You can get a list of hosts in the Elasticsearch cluster, and add and remove hosts from the cluster. You can only manage hosts with the Data Node role.'
keywords:
  - management of Elasticsearch hosts
  - Elasticsearch hosts
  - Elasticsearch
---

# Managing hosts

You can get a list of {{ ES }} cluster hosts and add or delete them.

{% note info %}

You can only add or delete hosts with the [_Data node_](../concepts/index.md) role.

{% endnote %}

## Getting a list of cluster hosts {#list-hosts}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mes-name }}**.
  1. Click on the name of the cluster you need and select the **Hosts** tab.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get a list of cluster hosts, run the command:

    ```bash
    {{ yc-mdb-es }} host list --cluster-name <cluster name>
    ```

    You can query the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- API

  Use the `listHosts` API method: pass the ID of the desired cluster in the `clusterId` request parameter.

  To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Adding hosts to a cluster {#add-hosts}

{% list tabs %}

- Management console

    1. Go to the folder page and select **{{ mes-name }}**.
    1. Click on the name of the cluster you need and select the **Hosts** tab.
    1. Click **Add host**.
    1. Specify the host parameters:
        - Availability zone.
        - Subnet (if the necessary subnet is not in the list, [create it](../../vpc/operations/subnet-create.md).
        - Select the **Public access** option if the host must be accessible from outside {{ yandex-cloud }}.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To add hosts to a cluster, run the command:

    ```bash
    {{ yc-mdb-es }} host add \
       --cluster-name <cluster name>
       --host zone-id=<availability zone>,subnet-name=<subnet name>,assign-public-ip=<true or false>,type=<host role: datanode or masternode>
    ```

    You can query the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- API

  Use the `addHosts` API method: pass the ID of the required cluster in the `clusterId` request parameter.

  To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

  Add the required number of `hostSpecs` parameters with the host's settings (one parameter for each new host).

{% endlist %}

{% note warning %}

If you can't [connect](cluster-connect.md) to the added host, check that the cluster's [security group](../concepts/network.md#security-groups) is configured correctly for the subnet where you placed the host.

{% endnote %}

## Deleting hosts from a cluster {#delete-hosts}

The following restrictions apply when deleting hosts:

- You can't delete a single host with the _Data node_ role.
- If a cluster consists of multiple hosts with the _Data node_ role, you can't delete the last two hosts.

{% list tabs %}

- Management console

    1. Go to the folder page and select **{{ mes-name }}**.
    1. Click on the name of the cluster you need and select the **Hosts** tab.
    1. Click the ![image](../../_assets/vertical-ellipsis.svg) in the line of the necessary host and select **Delete**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To remove a host from the cluster, run:

    ```bash
    {{ yc-mdb-es }} host delete <hostname> --cluster-name <cluster name>
    ```

    The host name can be requested with a [list of cluster hosts](#list-hosts), and the cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

    Use the `deleteHosts` API method: pass the ID of the required cluster in the `clusterId` request parameter.

    To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

    In one or more `hostNames[]` parameters, specify the names of the hosts you wish to delete from the cluster.

{% endlist %}
