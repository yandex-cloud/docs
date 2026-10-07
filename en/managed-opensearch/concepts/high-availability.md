---
title: High availability of a {{ mos-full-name }} cluster
description: High availability is the ability of a system to continue to operate when one or more of its components fail. High availability of a {{ mos-name }} cluster depends on the host configuration and other cluster parameters.
---

# High availability of a {{ mos-name }} cluster


[High availability](../../architecture/fault-tolerance.md#mdb-ha) of a {{ mos-name }} cluster depends on the number of `DATA` and `MANAGER` [hosts](#host-configuration).


## Cluster host configuration {#host-configuration}

A {{ mos-name }} cluster consists of one or more host groups where each host assumes a [specific role](host-roles.md).

Each `{{ OS }}` host group can include hosts with the [DATA](host-roles.md#data) or [MANAGER](host-roles.md#manager) roles. If a cluster has a single `{{ OS }}` group, its hosts will have both roles.

For a cluster to be highly available and covered by a [service level agreement (SLA)](https://yandex.com/legal/cloud_sla_mdb/en/), it must include:


1. Two or more hosts with the `DATA` role.
1. Three or more hosts with the `MANAGER` role.


{% note tip %}

To reduce load on hosts with the `DATA` role, we recommend you put hosts with the `MANAGER` role into a separate group.

{% endnote %}


## Protecting a cluster from risky changes {#protection}

{{ mos-name }} blocks certain requests to the {{ OS }} API to protect clusters from accidental downtime or data loss. Blocked requests fail and return an error message describing the reason.

These restrictions apply to all cluster users, including `admin`.

### Basic restrictions {#basic-protection}

These restrictions are enforced across all {{ mos-name }} clusters and block the following operations:

* Updating a cluster’s protected settings. This includes settings with the following prefixes:

    * `cluster.routing.allocation.disk.watermark.`
    * `cluster.fault_detection.follower_check.timeout`
    * `cluster.fault_detection.leader_check.timeout`
    * `cluster.follower_lag.timeout`
    * `cluster.publish.timeout`
    * `cluster.snapshot.info.max_concurrent_fetches`

    To update these settings, submit a request to [support]({{ link-console-support }}).

* Excluding `MANAGER` hosts from master election voting via the `POST /_cluster/voting_config_exclusions` request. To switch the master, use this {{ yandex-cloud }} CLI command: `yc managed-opensearch cluster switch-master`.

* Operations involving the `yc-automatic-backups` and `yc-automatic-restore` system [backup](backup.md) repositories, e.g., creating or deleting the repositories as well as creating or deleting snapshots inside them. The snapshot management policy of the same name, `yc-automatic-backups`, is also protected.


### Validating cluster settings {#analyze}

To find out which cluster and index settings violate high availability requirements, send the following request:

```bash
curl \
    --user <username>:<password> \
    --cacert ~/.opensearch/root.crt \
    --request POST \
    --header 'Content-Type: application/json' \
    --url 'https://<FQDN_of_{{ OS }}_host_with_public_access>:{{ port-mos }}/_plugins/_security/availability_guard/analyze' \
    --data '{}'
```

Provide an empty request body (`{}`) to check the current cluster state. To test the changes you plan to make, specify one or more of the following fields in the request body:

* `settings`: Cluster settings to check. They extend the current cluster configuration and override those settings that match. This allows you to test the results of a `PUT /_cluster/settings` request before running it.
* `excluding_hosts`: List of FQDNs of hosts to exclude from the check. Use this to simulate host removal or an availability zone failure.
* `excluding_indices`: List of index names to exclude from the check. The `*` wildcard is supported.
* `nodes`: Cluster host topology to check instead of the actual one. The key is the host name (the `name` field in the response to `GET /_cat/nodes?v`), and the value is an object with the following fields:

    * `roles`: List of {{ OS }} host roles: `data`, `cluster_manager`, `ingest`, `remote_cluster_client`, or `warm`. This is a required field.
    * `attributes`: Host attributes used in shard placement rules, e.g., an availability zone or host group. To get the current cluster host attributes, use the `GET /_cat/nodeattrs?v` request.
    * `disk_size`: Host storage size, e.g., `100gb`.

    If the `nodes` field is set, the `excluding_hosts` field is ignored.

For example, to simulate an availability zone failure, exclude all hosts within that zone from the check:

```bash
curl \
    --user <username>:<password> \
    --cacert ~/.opensearch/root.crt \
    --request POST \
    --header 'Content-Type: application/json' \
    --url 'https://<FQDN_of_{{ OS }}_host_with_public_access>:{{ port-mos }}/_plugins/_security/availability_guard/analyze' \
    --data '{
        "excluding_hosts": [
            "<host_1_FQDN>",
            "<host_2_FQDN>"
        ]
    }'
```

Detected issues are listed in the `allocation_impacts` array in the response; the reason for each issue is stated in the `reason` field. An empty array means no issues were found.

## Storage settings {#storage-settings}

When the storage is 95% full, cluster hosts automatically enter read-only mode. In this mode, data write requests fail. To prevent situations where the disk runs out of free space and the cluster becomes unavailable for writes:

* [Set up alerts in {{ monitoring-full-name }}](../operations/monitoring.md#monitoring-integration) to monitor storage utilization.
* [Configure automatic storage expansion](storage.md#auto-rescale).

[Learn more about managing disk space in {{ mos-name }}](storage.md#manage-storage-space).

## Maintenance settings {#maintenance-settings}

In multi-host clusters, hosts undergo [maintenance](maintenance.md) one by one. Any host that requires a restart during maintenance will be unavailable until maintenance is complete.

[Learn more about maintenance in {{ mos-name }}](maintenance.md).

## Other parameters and limitations {#other-settings}

Cluster availability may also be affected by:

* [Backup settings](backup.md).
* [Storage disk type](storage.md).
* [Host class](instance-types.md).
* [Quotas and limits](limits.md).


* [Security group settings](../operations/connect/index.md#security-groups).
