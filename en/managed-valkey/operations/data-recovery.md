---
title: Restoring data from an available {{ mrd-full-name }} host
description: Replicate data from an available {{ mrd-name }} host to your self-hosted Valkey instance.
alternate:
  - href: en/managed-valkey/operations/data-recovery.md
    type: text/markdown
    title: Markdown version
---

# Restoring data from an available {{ mrd-name }} host

If you have an available {{ mrd-name }} host, you can copy its data to a self-hosted {{ VLK }} instance using replication. You can deploy this instance in a different availability zone or another cloud.

## Prepare the cluster {#prepare}

To establish a connection, you need a {{ mrd-name }} cluster with TLS enabled and a public IP address assigned to the available host. [Configure public access](../concepts/network.md#public-access-to-host) to this host.

## Create a configuration file {#configure-replication}

Create a configuration file for the new {{ VLK }} instance:

```text
replicaof <host_public_IP_address> {{ port-mrd-tls }}
tls-replication yes
tls-ca-cert-file /etc/valkey/tls/ca.crt
masteruser default
masterauth "<default_user_password>"
```

Specify the public IP address of the available host and the password for the source cluster `default` user.

**Additional step**. [Obtain the CA certificate](connect/index.md#get-ssl-cert) and save it to `/etc/valkey/tls/ca.crt`.

{% note info %}

**TLS requirements**. To initialize TLS in {{ VLK }}, you also need a certificate and a private key for the new instance. Generate them using your preferred method and add them to the configuration:

```text
tls-cert-file <path_to_certificate>
tls-key-file <private_key_path>
```

This requirement is described in the official [{{ VLK }} guides](https://valkey.io/topics/tls/).

{% endnote %}

## Deploy the new instance {#deploy}

Deploy {{ VLK }} using any preferred method. Use the same version as the source {{ mrd-name }} cluster and apply the configuration file you created.

## Test replication {#check-replication}

1. On the new instance, run the following command:

   ```bash
   valkey-cli INFO replication
   ```

   The output must show the following values:

   ```text
   role:slave
   master_link_status:up
   ```

1. On the source host, run `INFO replication`. **Connection note**. To connect to a host with TLS and authentication, run this command:

   ```bash
   valkey-cli --tls \
     -h <host_public_IP_address> -p {{ port-mrd-tls }} \
     --cacert /etc/valkey/tls/ca.crt \
     --user default --askpass \
     INFO replication
   ```

   Enter the `default` user password. If the new instance is the only connected replica, the output will display:

   ```text
   connected_slaves:1
   ```

   **Note on the replica count**. The `connected_slaves` field shows the total number of connected replicas. If the source already has replicas, this value will be greater than `1`. For more information, see the [`INFO` command description](https://valkey.io/commands/info/).