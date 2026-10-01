# Licensing

In {{ stackland-name }}, licenses are metered by the total number of vCPUs within a cluster. A dedicated component called *License Server* provides information about limits. The cluster regularly sends resource usage data to License Server, gets active limits in response, and uses them to generate the license status.

License Server is also used by other {{ yandex-cloud }} on-premises products, such as {{ datalens-name }}, {{ ai-studio-name }}, and {{ speechsense-name }}. When deployed as a standalone service (see [License Server as a standalone service](#standalone)), a single License Server instance can be used across multiple product.

## Architecture {#architecture}

License Server operates as a dedicated service that:

* Stores license limits signed by {{ yandex-cloud }}.
* Collects and stores resource utilization data.
* When connectivity with {{ yandex-cloud }} is available, synchronizes with the cloud API to fetch updated limits and send aggregated usage reports.

A {{ stackland-name }} cluster functions as a License Server client. A licensing agent regularly synchronizes actual usage data, retrieves limits, and publishes results in the `PlatformConfig` resource as:

* `status.licensing` section: Indicates your active license, limit, current cluster usage, global usage across all license installations, and time of the last successful synchronization.
* `LicenseSynced` condition: Generalized property indicating that the license status is up-to-date.

## Cloud connectivity modes {#connectivity-modes}

License Server supports two operation modes.

### Online {#online-mode}

License Server is connected to the {{ yandex-cloud }} API:

* Periodically fetches updated signed licenses from the cloud and validates their signatures.
* Sends aggregated usage data to the cloud for billing and analytics.

This mode is suitable for infrastructures with outbound access to the {{ yandex-cloud }} API, usually via DMZ.

### Offline (air-gapped) {#offline-mode}

License Server operates without cloud connectivity:

* Limits are delivered as a signed license file received by the installation owner from their vendor and hosted on the server.
* Usage data is not sent to the cloud automatically. Instead, you must export it from the administrative License Server API as an encrypted file and manually provide to {{ yandex-cloud }}. For more information, see [{#T}](#export-usage).

This mode is designed for isolated infrastructures without internet access. This mode adds no complexity to the {{ stackland-name }} cluster operation: in both modes, the licensing agent interacts with License Server in the same way.

## License Server deployment {#deployment}

License Server supports two deployment options. The choice depends on your installation size, availability requirements, and security policies.

### License Server as a {{ stackland-name }} component {#in-cluster}

License Server is deployed inside a {{ stackland-name }} cluster as a platform component. A {{ mpg-name }} cluster is used as storage.

This option works best for installations that do not require dedicated infrastructure: License Server works as a platform component and leverages Kubernetes self-healing mechanisms, which makes it as robust as a standalone deployment.

Advantages:

* No dedicated infrastructure for License Server is required.
* Installation, update, and monitoring cycle integrated with that of {{ stackland-name }}.
* Quick deployment from a standard distribution.

Limitations:

* License Server availability is tied to your cluster health: if your cluster is unavailable, so is License Server.
* In the current version, a single License Server instance can only serve one {{ stackland-name }} cluster.

### License Server as a standalone service {#standalone}

License Server is deployed as a standalone service inside a Docker container with external PostgreSQL, usually on a dedicated host within a DMZ.

This deployment model is optimal for production environments and scenarios where a single License Server instance must serve multiple {{ stackland-name }} clusters, e.g., `test` and `prod`.

Advantages:

* Operates independently of any particular {{ stackland-name }} cluster state.
* Suitable for DMZ deployment: you can isolate your production infrastructure from the cloud API.
* One instance can be used with multiple products and installations.

Limitations:

* Requires a dedicated host and external PostgreSQL.
* Installed and updated separately from {{ stackland-name }}.

In both deployment models, a {{ stackland-name }} cluster interacts with License Server in the same way and only uses a different endpoint in the connection settings.

## Limits and usage {#limits-and-usage}

{{ stackland-name }} licenses are metered by the `stackland.vcpu.cores` metric. Usage is the sum of `capacity.cpu` across all cluster nodes in the `Ready` status. This includes all Kubernetes API nodes, regardless of their role (`control-plane`, `worker`, or `combined`).

The licensing agent regularly recalculates local usage, sends this data to License Server, and publishes the obtained license status in `PlatformConfig.status.licensing`.

The license limit applies to all your deployed clusters, not just the current one.

### Temporary limit overuse {#overuse}

The cluster does not disable running nodes if total usage exceeds the limit. This enables your infrastructure to handle peak loads or perform disaster recovery without any application downtime.

Yet, temporary capacity overuse is not a norm. The platform registers every overuse event, writes it to the license status, and in case of extended or major violations, restricts further scaling (see [License enforcement](#enforcement)). To restore cluster normal operation, you need to either scale down your resource usage or contact the vendor to update your license.

## License enforcement {#enforcement}

In case of a license violation, {{ stackland-name }} does the following:

* `PlatformConfig.status.licensing` indicates either `state=WARNING` or `state=CRITICAL` and lists the root causes in `reasons`, e.g., capacity overuse, expired license, or outdated status.
* `LicenseSynced` condition switches to `False` and displays the reason for considering your license invalid.
* Prolonged or severe violations restrict cluster scaling, and new `StacklandHostConfig` resources are no longer created. Existing nodes continue to run workloads.

The following features remain available:

* Node evacuation or deletion via `StacklandHostConfig` resources or the management console. For more information, see [{#T}](../operations/cluster/scale-cluster.md).
* Standard operations with user workloads.
* Access to the management console, Kubernetes API, and platform components.

To remove the restrictions, you need to either decommission excess nodes to align your consumption with your licensed capacity, or update the license with your vendor and synchronize with License Server.

## Outdated license status {#stale-status}

If License Server fails to communicate with the cloud, the most recently retrieved limits will continue to apply for a preset duration. After this period ends, the system will flag the license as outdated: `state` will switch to `WARNING` or `CRITICAL`, and the `LicenseSynced` condition will indicate `False` and state the reason.

In offline mode, license status is obtained from a local signed license file, so cloud connectivity failures do not cause outdated status errors. A license may become outdated only if the local licensing agent fails to connect to License Server for a long time, e.g., if License Server stops or becomes inaccessible over the network.

## Administrator actions {#admin-actions}

### Viewing the current license status {#check-status}

To view your cluster’s current license status, run this command:

```bash
kubectl get platformconfig default -o jsonpath='{.status.licensing}'
```

To get only the global status, run this command:

```bash
kubectl get platformconfig default \
  -o jsonpath='{.status.conditions[?(@.type=="LicenseSynced")]}'
```

The `state` field shows the global license status:

* `OK`: License is valid, usage remains within limits.
* `WARNING`: Usage exceeds the limit, or license status is about to expire. The cluster continues to operate, but administrator attention is required.
* `CRITICAL`: License has expired, its status is outdated, or usage has hit a critical limit. Scaling restrictions may apply.

The `reasons` field indicates root causes if your license status is different from `OK`.

### Exporting usage data in an air-gapped installation {#export-usage}

The `ExportUsage` method of the administrative License Server API generates an encrypted usage data file and saves it to an export folder on the server side. The method is available in any connectivity mode, but it is the only way to deliver usage data to {{ yandex-cloud }} for an air-gapped installation. In online mode, data is sent automatically during cloud synchronization.

To start an export, run this command:

```bash
curl \
  -H "Authorization: Bearer <admin_token>" \
  'https://<license_server_address>:<port>/api/v1/admin/usage/export'
```

Additional query parameters:

* `from` and `to`: Time range boundaries in RFC 3339 format. You must always provide both values. To export all available records, leave both parameters empty.
* `filename`: File name without extension. If not specified, the name is generated automatically: `usage_export_<export_id>.json.enc`.

The response will return metadata of the generated file: `export_id`, `file_path`, `file_size`, `record_count`, `checksum` (SHA-256), and `signature` (ECDSA, base64). You need to retrieve the file manually from the License Server host using `file_path` and provide it to {{ yandex-cloud }} via a vendor-approved channel.

Regular exports are required to ensure correct billing and analytics on the {{ yandex-cloud }} side.

#### Useful links {#see-also}

* [{#T}](../quickstart.md)
* [{#T}](cluster-scaling.md)
* [{#T}](../operations/cluster/scale-cluster.md)
