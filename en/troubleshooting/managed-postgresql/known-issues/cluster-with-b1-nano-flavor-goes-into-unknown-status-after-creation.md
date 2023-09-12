# Managed Service for PostgreSQL cluster switches to the Unknown state immediately after creation

## Issue description {#issue-description}

Trying to create a cluster with the `b1.nano` host class fails, and the cluster switches to the `Unknown` status.

## Solution {#issue-resolution}

It may take a long time to deploy a cluster with this host type. This is because of too low a percentage of guaranteed CPU uptime: 5% for `b1.nano`.
Clusters with this host type have two vCPUs with the guaranteed uptime of 5% and 2 GB RAM.

We cannot consistently forecast the behavior for the guaranteed CPU uptime of less than 50%. Generally speaking, creating clusters with `b1.nano` host classes is a longer process because of limited resources used for deploying components to the hosts.

When creating your clusters, better select more powerful configurations with CPU uptime of more than 50%, for example, `c3-c2-m4`.

{% note alert %}

The `b1.nano` host class is being phased out.
You will not be able to create a new cluster with this host class.

For an up-to-date list of host classes, see the [documentation section](https://cloud.yandex.ru/docs/managed-postgresql/concepts/instance-types#available-flavors).

{% endnote %}