---
title: Resource relationships in {{ mpg-full-name }}
description: The main entity used in {{ mpg-name }} is a database cluster. Each cluster consists of one or more DB hosts, which are virtual machines with DBMS servers deployed. Cluster hosts may reside in different availability zones. A multi-host cluster is natively fault tolerant because one of its replica hosts will take on the master role should the current master host fail.
---

# Resource relationships in {{ mpg-name }}

The main entity used in {{ mpg-name }} is a _database cluster_.

Each cluster consists of one or more _DB hosts_, which are virtual machines with DBMS servers deployed. Cluster hosts may reside in different availability zones. You can learn more about {{ yandex-cloud }} availability zones in [Platform overview](../../overview/concepts/geo-scope.md).

A cluster of two or more hosts is natively [highly available](high-availability.md) because one of its replica hosts will assume the master role upon the current master host's failure. To learn more about how the number of hosts affects cluster availability, see the [relevant section](high-availability.md#host-configuration).

{% note info %}

A replica that has an explicitly specified replication thread source cannot take the master role. To learn more, see [Replication](replication.md).

{% endnote %}

The minimum number of hosts in a cluster depends on the selected [disk type](storage.md). The default cluster configuration offered in the management console includes two hosts.

{% note warning %}

We do not recommend creating a cluster having a single host. While being cheaper, such a cluster is anything but highly available.

{% endnote %}

A cluster's computing capacity depends on its _host class_, which is the virtual machine template used to deploy the cluster's hosts. For a list of available host classes and their specs, see [Host classes](instance-types.md).

To manage connections and balance the cluster load, the service architecture features the _Odyssey connection pooler_. For more information, see [Managing connections](pooling.md).


A cluster created in a folder can be accessed by all VMs connected to the same cloud network. For more information about networking, see the [{{ vpc-name }} documentation](../../vpc/).


{% include [monitoring-access](../../_includes/mdb/monitoring-access.md) %}

{% include [responsibilities-link](../../_includes/mdb/responsibilities-link.md) %}