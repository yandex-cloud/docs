# {{ mpg-short-name }} cluster switches to `UNKNOWN` once created


## Issue description {#issue-description}

Trying to create a cluster with the `b1.nano` host class fails, and the cluster switches to the `UNKNOWN` status.

## Solution {#issue-resolution}

It may take a long time to deploy a cluster with this host type. This is because of too low percentage of guaranteed CPU uptime: 5% for `b1.nano`. Clusters with this host type have two vCPUs with the guaranteed uptime of 5% and 2 GB RAM.

One cannot consistently forecast the behavior for the guaranteed CPU uptime of less than 50%. Generally speaking, creating clusters with `b1.nano` host classes is a longer process because of limited resources used for deploying components to the hosts.

When creating your clusters, you might want to opt for choosing more powerful configurations with CPU uptime of more than 50%, such as `c3-c2-m4`. 

{% note alert %}

The `b1.nano` host class is currently being discontinued. You will not be able to create a new cluster with this host class.

You can view the up-to-date list of host classes [here](../../../managed-postgresql/concepts/instance-types.md#available-flavors).

{% endnote %}