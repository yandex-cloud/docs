# Configuring {{ dns-full-name }} for access to managed database clusters from other cloud networks

{% include [mdb-peering-intro](./mdb-dns-peering/intro.md) %}

## Before you start {#before-you-begin}

### Assign roles {#assign-roles}

{% include [mdb-peering-check-roles](./mdb-dns-peering/check-roles.md) %}

### Create a cluster {#create-cluster}

1. Using the command line, navigate to the folder that will contain the {{ TF }} configuration files with an infrastructure plan for the example. Create the directory if it does not exist.

1. Create a multi-host cluster using {{ TF }} by following the examples for the desired cluster:
    * [{{ mch-full-name }}](../../../managed-clickhouse/operations/cluster-create.md#creating-a-multi-host-cluster)

### Create other resources {#create-other-resources}

{% include [mdb-peering-create-resources](./mdb-dns-peering/create-resources.md) %}

### Configure routing between the cloud networks {#configure-routing}

{% include [mdb-peering-configure-routing](./mdb-dns-peering/configure-routing.md) %}

### Check cluster availability (optional step) {#check-cluster-availability-without-dns}

1. [Connect](../../../compute/operations/vm-connect/ssh.md#vm-connect) to the `cluster-vm` and `other-vm` virtual machines over SSH.

    {% include [mdb-peering-vm-user](./mdb-dns-peering/vm-user-warning.md) %}

1. Try connecting to the cluster:

    {% include [mdb-peering-check-availability-1](./mdb-dns-peering/check-availability-1.md) %}

    {% include [mdb-peering-connect-all-in-one](./mdb-dns-peering/mdb-connect-all-in-one.md) %}

## Create a zone in {{ dns-full-name }} {#create-peering-zone}

{% include [mdb-peering-create-zone](./mdb-dns-peering/create-zone.md) %}

## Make sure the DNS records migrate to the zone {#do-actions-for-migration}

{% include [mdb-peering-migrate-to-zone](./mdb-dns-peering/migrate-to-zone.md) %}

## Check cluster availability {#check-cluster-availability}

1. [Connect](../../../compute/operations/vm-connect/ssh.md#vm-connect) to the `cluster-vm` and `other-vm` virtual machines over SSH.

    {% include [mdb-peering-vm-user](./mdb-dns-peering/vm-user-warning.md) %}

1. Try connecting to the cluster:

    {% include [mdb-peering-check-availability-2](./mdb-dns-peering/check-availability-2.md) %}

    {% include [mdb-peering-connect-all-in-one](./mdb-dns-peering/mdb-connect-all-in-one.md) %}

## Delete the resources you created {#clear-out}

{% include [mdb-peering-destroy-resources](./mdb-dns-peering/destroy-resources.md) %}

