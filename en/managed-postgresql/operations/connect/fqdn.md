---
title: FQDNs of {{ mpg-full-name }} hosts
description: Follow this guide to get an FQDN of a {{ mpg-full-name }} host.
---

# FQDNs of {{ PG }} hosts

To connect to a host, you need its fully qualified domain name ([FQDN](../../concepts/network.md#hostname)). You can get it using one of the following methods:

* [Request a list of cluster hosts](../../operations/hosts.md#list-hosts).
* In the [management console]({{ link-console-main }}), copy the cluster connection command (it contains the host’s FQDN). To get the command, go to the cluster page and click **{{ ui-key.yacloud.mdb.clusters.button_action-connect }}**.
* Look up the FQDN in the management console:

   1. Navigate to the cluster page.
   1. Navigate to **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
   1. Copy the **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}** column value.

Cluster hosts also use [special FQDNs](#special-fqdns).

## Special FQDNs {#special-fqdns}

Alongside [regular FQDNs](#), {{ mpg-name }} offers special FQDNs that can be also used for cluster connections.

{% include [special-fqdns-info](../../../_includes/mdb/special-fqdns-info.md) %}

### Current master {#fqdn-master}

An FQDN in `c-<cluster_ID>.rw.{{ dns-zone }}` format always points to the current master host in the cluster. You can get the cluster ID from the [folder’s cluster list](../cluster-list.md#list-clusters).

When connecting to this FQDN, you can perform read and write operations.

{% include [special-fqdns-warning](../../../_includes/mdb/special-fqdns-warning.md) %}

### Most recent replica {#fqdn-replica}

An FQDN in `c-<cluster_ID>.ro.{{ dns-zone }}` format points to the [replica](../../concepts/replication.md) that is most up-to-date with the current master. You can get the cluster ID with the [list of clusters in the folder](../cluster-list.md#list-clusters).

**Specifics:**

* When connecting to this FQDN, you can only perform read operations.
* If there are no active replicas in the cluster, this FQDN will point to the current master host.
* Replicas with a [manually configured replication source](../../concepts/replication.md#replication-manual) cannot be selected as most up-to-date replicas when using this FQDN.

## Selecting an FQDN and cluster connection method {#automatic-master-host-selection}

You can connect to a cluster using its [host FQDNs](#) or [special FQDNs](#special-fqdns): If the cluster [consists of several hosts](../../concepts/planning-cluster-topology.md), keep in mind that the current master can become a replica at any moment, and vice versa.

{% note warning %}

If automatic failover promotes a host without public access to master or most up-to-date replica, that host will be unreachable from the internet. To avoid this, [enable public access](../hosts.md#update) for all cluster hosts.

{% endnote %}

Use one of the following methods to connect to the master host with read and write access:

* Connect using the [special FQDN](#fqdn-master) pointing to the current master.

    After a master failover, this FQDN may temporarily point to the previous master, now a replica, due to the time required for the DNS record to update.

    Therefore, applications using this FQDN must be designed to handle temporary master unavailability. For example, they should retry write requests after a short delay.

    {% cut "Connection example" %}

    In this example, we use the `c9qash3nb1v9********` cluster ID:

    ```bash
    psql "host=c-c9qash3nb1v9********.rw.{{ dns-zone }} \
          port={{ port-mpg }} \
          sslmode=verify-full \
          dbname=<DB_name> \
          user=<username>"
    ```

    {% endcut %}

* Connect by listing all cluster hosts and specifying `target_session_attrs=read-write`.

    {% cut "Connection example" %}

    Here, we list all the cluster’s hosts.

    The host IDs are `rc1a-be***.{{ dns-zone }}`, `rc1b-5r***.{{ dns-zone }}`, and `rc1d-t4***.{{ dns-zone }}`:

    ```bash
    psql "host=rc1a-be***.{{ dns-zone }},rc1b-5r***.{{ dns-zone }},rc1d-t4***.{{ dns-zone }} \
          port={{ port-mpg }} \
          sslmode=verify-full \
          dbname=<DB_name> \
          user=<username> \
          target_session_attrs=read-write"
    ```

    {% endcut %}

Use one of the following methods to connect to the host with read access:

* Connect using a [special FQDN](#fqdn-replica) pointing to the most up-to-date replica.

    {% cut "Connection example" %}

    In this example, we use the `c9qash3nb1v9********` cluster ID:

    ```bash
    psql "host=c-c9qash3nb1v9********.ro.{{ dns-zone }} \
          port={{ port-mpg }} \
          sslmode=verify-full \
          dbname=<DB_name> \
          user=<username>"
    ```

    {% endcut %}

* Connect by listing all cluster hosts and specifying `target_session_attrs=any`.

    {% cut "Connection example" %}

    Here, we list all the cluster’s hosts.

    The host IDs are `rc1a-be***.{{ dns-zone }}`, `rc1b-5r***.{{ dns-zone }}`, and `rc1d-t4***.{{ dns-zone }}`:

    ```bash
    psql "host=rc1a-be***.{{ dns-zone }},rc1b-5r***.{{ dns-zone }},rc1d-t4***.{{ dns-zone }} \
          port={{ port-mpg }} \
          sslmode=verify-full \
          dbname=<DB_name> \
          user=<username> \
          target_session_attrs=any"
    ```

    {% endcut %}

{% note info %}

You can use the `target_session_attrs` setting when connecting via a client utilizing the `libpq` library.

Support for the `read-write` value in this setting was introduced in `libpq` [version 10](https://www.postgresql.org/docs/10/static/libpq-connect.html).

{% cut "How to update the library version used by `psql`" %}

* For Debian-based Linux distributions, install the `postgresql-client-10` package or a newer version from the [official APT repository](https://www.postgresql.org/download/linux/ubuntu/) (or another source of your choice).
* For RPM-based operating systems, use the {{ PG }} distribution from the [yum repository](https://yum.postgresql.org/).

{% endcut %}

{% endnote %}
