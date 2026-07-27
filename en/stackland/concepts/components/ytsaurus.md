# {{ yt-name }}

{{ yt-name }} is a distributed platform for storing and processing big data. Within {{ stackland-name }}, {{ yt-name }} deploys a single shared {{ YT }} cluster to the platform. The cluster includes a MapReduce engine, dynamic tables, the YQL query engine, a web UI, and {{ iam-name }} integration.

With {{ yt-name }}, you can:

* Deploy and maintain a {{ YT }} cluster within {{ stackland-name }}.
* Configure the composition of cluster subcomponents, such as `UI`, `CHYT`, `SPYT`, `Tutorial`, `Task Proxy`, and `Odin`, as well as node group sizes using a custom `YTsaurusConfig` resource.
* Access the cluster via the UI and HTTP proxy exposed through {{ stackland-name }} Ingress.

This article describes the Stackland wrapper. For more information about the {{ YT }} architecture, data format, CLI commands, and SDK, see [this official {{ YT }} page](https://ytsaurus.tech/docs/ru/).

## Component configuration {#ytsaurusconfig}

The component parameters are defined by the `YTsaurusConfig` resource. The resource works at the cluster level. The resource name must be `main`. The platform supports only a single instance.

Here is an example of a minimal configuration with the component enabled:

{% include notitle [YAML-file](../../_includes/yamls/components/ytsaurusconfig.md) %}

Where:

* `spec.enabled`: Enables and disables the component. The default value is `false`.
* `spec.clusterName`: {{ YT }} cluster name used for connection and displayed in the UI.
* `spec.cluster`: Composition and sizes of cluster subcomponents (see below).

All Kubernetes resources for the {{ YT }} cluster (pods, PVCs, secrets, and ingresses) are created in the `stackland-ytsaurus` system namespace.

## Cluster composition {#cluster-components}

The `spec.cluster` parameter of the `YTsaurusConfig` resource describes the required subcomponents of the {{ YT }} cluster. For each group, you can set the number of pods (`instanceCount`), compute `resources` (CPU and memory), and, optionally, `storage` settings (`storageClass` and `size`).

List of subcomponents:

* `discovery`: Discovery service that coordinates cluster components. The `instanceCount` range is 1–50.
* `primaryMasters`: List of cluster’s primary masters that store metadata. Requires the `storage` field. The `instanceCount` range is 1–50.
* `httpProxies`: HTTP proxy for user requests and UI access. The `instanceCount` range is 1–3.
* `dataNodes[]`: Data storage nodes as a list, with at least one group. Requires the `storage` field. Group names may include only lowercase Latin letters, digits, and hyphens. The `instanceCount` range per group is 3–10.
* `execNodes[]`: MapReduce execution nodes as a list that must include a group named `default`. Requires the `storage` field. Supports the `resources.gpu` field. The `instanceCount` range per group is 1–50.
* `schedulers`: MapReduce schedulers. The `instanceCount` range is 1–10.
* `controllerAgents`: Operation controller agents. The `instanceCount` range is 1–10.
* `spec.cluster.bundleController.enabled`: Tablet bundle controller. To enable, use the `enabled` flag.
* `queryTrackers`: YQL and CHYT query trackers. The `instanceCount` range is 1–10.
* `queueAgents`: Queue agents. The `instanceCount` range is 1–10.
* `rpcProxies`: RPC proxies for client SDKs. The `instanceCount` range is 1–3.
* `tabletNodes[]`: Dynamic table nodes as an optional list of groups. The `instanceCount` range per group is 1–50.
* `yqlAgents`: YQL agents. The `instanceCount` range is 1–3.

The minimum and maximum `instanceCount` values are defined by the validation schema of the `YTsaurusConfig` resource. If `instanceCount` is outside the allowed range, the operator rejects the resource when you create or update it.

## Extra subcomponents {#extras}

To enable additional subcomponents, set the `enabled` flag in the relevant `spec.cluster` field:

* `ui`: {{ YT }} web UI. If `ingressEnabled: true`, the system creates an Ingress at `ytsaurus.<system_domain>`. Authentication uses {{ iam-name }} with OAuth.
* `strawberry`: Strawberry controller to manage the lifecycle of CHYT and SPYT clicks.
* `chyt`: CHYT, a {{ CH }} engine on top of {{ YT }}. Requires `strawberry` to be enabled.
* `spyt`: SPYT, an {{ SPRK }} on top of {{ YT }}. Requires `strawberry` to be enabled.
* `taskProxy`: Task Proxy for running external tasks in {{ YT }}. The `instanceCount` range is 1–10.
* `tutorial`: Built-in {{ YT }} tutorial that creates the `//home/tutorial` directory with examples.
* `odin`: `Odin` monitoring service that checks the state of key cluster components.
* `cron.clear_tmp`: Regular cleanup of temporary data. The `interval` field supports values in `<number>h`, `<number>m`, or `<number>s`. The default value is `15m`.

## Cluster network access {#network-access}

Enabling the component creates two external endpoints:

* `ytsaurus.<system_domain>`: {{ YT }} web UI. It is only available if `spec.cluster.ui.enabled: true` and `spec.cluster.ui.ingressEnabled: true`.
* `api.ytsaurus.<system_domain>`: HTTP proxy for {{ YT }} CLI, SDK, and third-party client requests.

Both ingresses are exposed via the `stackland-system` class with forced HTTPS redirect. The TLS certificate is issued via {{ certificate-manager-name }}.

RPC proxies are available within the Kubernetes cluster; external access via a network load balancer is not supported.

## Authentication and secrets {#auth}

The {{ YT }} cluster administrator credentials are stored in the `ytadminsec` Secret in the `stackland-ytsaurus` namespace. This Secret is created when you enable the component and includes the following keys:

* `login`: Administrator login, `admin`.
* `password`: Admin password.
* `token`: Administrator token for accessing the API via the `yt` CLI and SDKs.

For more information on how to get these values, see [Getting an administrator password and token](../../operations/ytsaurus/get-admin-credentials.md).

The {{ YT }} web interface uses {{ iam-name }} with OAuth for authentication. OAuth client (`stackland.ytsaurus`) parameters and the authorization server address (`auth.<system_domain>`) are configured automatically by the component.

## Resources and storage {#resources}

Default minimum resource allocation for the component:

* CPU: 8 cores.
* RAM: 16 GiB.
* Storage: 100 GiB.

The {{ YT }} cluster is I/O-intensive and requires an SSD storage. Use `storage.storageClass` to define the storage class for `primaryMasters`, each `dataNodes` group, and each `execNodes` group. If the field is not set, the default storage class selected at component installation is used. For more information, see [Disk subsystem](disk-storage.md).

Once created, the subcomponent storage size can only be increased. For more information about updating cluster parameters, see [Updating {{ yt-name }} cluster settings](../../operations/ytsaurus/edit-cluster.md).

## Monitoring and alerts {#observability}

The component installs preconfigured dashboards and alerting rules for {{ YT }} in the cluster. The dashboards are published in {{ grafana-name }} by the [Monitoring](monitoring.md) component and cover:

* Cluster state and resources (`cluster-resources`).
* HTTP and RPC proxies.
* Masters: global and local metrics, and accounts.
* Scheduler: operations, pools, and internal metrics.
* Queues and consumers.
* Tablet bundles: CPU, RAM, network, storage, user load.

Alerts available after enabling the component:

* `cluster-alerts`: Key cluster health metrics.
* `odin-alerts`: `Odin` checks, which are active when `spec.cluster.odin.enabled: true`.

## Limits {#limits}

* The platforms supports only one {{ YT }} cluster. The `YTsaurusConfig` resource name must be `main`.
* The `dataNodes`, `execNodes`, and `tabletNodes` group names must start with a lowercase Latin letter and can only contain lowercase letters, digits, and hyphens.
* `execNodes` must contain a group named `default`.
* Once created, the node disk size can only be increased. Reducing the size is not supported.
* Disabling the component (`spec.enabled: false`) results in deletion of the {{ YT }} cluster along with its data. For more information, see [Disabling {{ yt-name }}](../../operations/ytsaurus/disable.md).
