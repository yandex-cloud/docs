# Updating {{ yt-name }} cluster settings

If the [{{ yt-name }} component](../../concepts/components/ytsaurus.md) is enabled, you can edit cluster settings through the `YTsaurusConfig main` resource. The platform allows only one instance of the resource; its name is fixed: `main`.

{% note warning %}

* Do not update multiple cluster subcomponents in a single edit: there is no guarantee that the cluster will return to `Ready` after such an update. Apply your updates one subcomponent at a time and wait till the cluster is ready before the next update.
* When you update resources, replicas, and the composition of subcomponents, the {{ YT }} operator restarts the relevant pods. While the new configuration is being applied, some requests get interrupted.
* `storage.size` for `primaryMasters`, `dataNodes`, and `execNodes` can be only increased. Kubernetes validation will reject downsizing.
* Storage class (`storage.storageClass`) is hardcoded into the PVC when the pod is first created. Once a PVC class is created, you cannot change it; to change to a different class, delete the group in question and recreate it with a new class: the group's data will be deleted.
* In the `dataNodes[]`, `execNodes[]`, and `tabletNodes[]` lists, the `name` field is the immutable group key. Changing `name` deletes the old group along with its data and creates a new group.
* The `execNodes` group named `default` is required; you cannot delete or rename it.
* To disable the entire component, see [Disabling {{ yt-name }}](disable.md).

{% endnote %}

## Using the CLI {#cli}

1. Upload the current `YTsaurusConfig main` resource to a file:

    ```bash
    kubectl get ytsaurusconfig main -o yaml > ytsaurusconfig.yaml
    ```

    An alternative option is to open the resource for interactive editing: `kubectl edit ytsaurusconfig main`.

1. Edit the settings in one of the sections below.

1. Apply the manifest:

    ```bash
    kubectl apply -f ytsaurusconfig.yaml
    ```

1. Wait for the component to enter the ready state:

    ```bash
    kubectl get componentinstallation ytsaurus-main -w
    ```

    While the new configuration is being applied, `status.phase` is `Updating`; after the configuration is successfully applied it turns to `Ready`. If there is an error, the diagnostic text is available in `status.message`.

1. Additionally, monitor the {{ YT }} cluster status:

    ```bash
    kubectl -n stackland-ytsaurus get ytsaurus cluster -w
    ```

    The resource name matches `spec.clusterName` in `YTsaurusConfig`. Major changes (such as increasing `primaryMasters.storage.size` or adding a new node group) take several minutes to complete: the operator restarts the components one by one.

## Basic configuration {#basic}

* `spec.enabled`: Component enabled flag. `false` disables the component and deletes the cluster together with its data. For more information, see [Enabling {{ yt-name }}](enable.md) and [Disabling {{ yt-name }}](disable.md).
* `spec.clusterName`: {{ YT }} cluster name; displayed in the web interface and used to address resources in the `stackland-ytsaurus` namespace.

## Cluster core resources and replicas {#core-resources}

For each block in `spec.cluster`, you can change the number of the `instanceCount` pods and `resources` (`cpu`, `memory`). The `instanceCount` ranges are set by the `YTsaurusConfig` validation schema.

* `spec.cluster.discovery.instanceCount`: 1–50.
* `spec.cluster.discovery.resources.cpu`, `spec.cluster.discovery.resources.memory`.
* `spec.cluster.primaryMasters.instanceCount`: 1–50.
* `spec.cluster.primaryMasters.resources.cpu`, `spec.cluster.primaryMasters.resources.memory`.
* `spec.cluster.primaryMasters.storage.size`: Metadata disk size. You can only increase this size.
* `spec.cluster.primaryMasters.storage.storageClass`: Storage class. Once a PVC is created, it cannot be changed.
* `spec.cluster.httpProxies.instanceCount`: 1–3.
* `spec.cluster.httpProxies.resources.cpu`, `spec.cluster.httpProxies.resources.memory`.
* `spec.cluster.schedulers.instanceCount`: 1–10.
* `spec.cluster.schedulers.resources.cpu`, `spec.cluster.schedulers.resources.memory`.
* `spec.cluster.controllerAgents.instanceCount`: 1–10.
* `spec.cluster.controllerAgents.resources.cpu`, `spec.cluster.controllerAgents.resources.memory`.
* `spec.cluster.queryTrackers.instanceCount`: 1–10.
* `spec.cluster.queryTrackers.resources.cpu`, `spec.cluster.queryTrackers.resources.memory`.
* `spec.cluster.queueAgents.instanceCount`: 1–10.
* `spec.cluster.queueAgents.resources.cpu`, `spec.cluster.queueAgents.resources.memory`.
* `spec.cluster.rpcProxies.instanceCount`: 1–3.
* `spec.cluster.rpcProxies.resources.cpu`, `spec.cluster.rpcProxies.resources.memory`.
* `spec.cluster.yqlAgents.instanceCount`: 1–3.
* `spec.cluster.yqlAgents.resources.cpu`, `spec.cluster.yqlAgents.resources.memory`.
* `spec.cluster.bundleController.enabled`: Flag enabling the tablet bundle controller.

## Updating data node groups {#data-nodes}

Storage node groups are described by the `spec.cluster.dataNodes` array. Each array entry is identified by the `name` field (`^[a-z][a-z0-9-]*$` pattern).

* `spec.cluster.dataNodes[].instanceCount`: 3–10. Minimum three nodes per group.
* `spec.cluster.dataNodes[].storage.size`: Disk size. You can only increase this size.
* `spec.cluster.dataNodes[].storage.storageClass`: Storage class. Once a PVC is created, it cannot be changed.
* `spec.cluster.dataNodes[].resources.cpu`, `spec.cluster.dataNodes[].resources.memory`.

To **add a new group**, add an element to the array with a unique `name`. The operator will create new pods and PVCs for the group.

To **delete a group**, remove the relevant element from the array. This deletes the group's pods; the PVCs and the data stored in them get deleted together with the pod because they are originally created from `volumeClaimTemplates`. Delete the group only if you no longer need the data.

## Updating exec nodes groups {#exec-nodes}

Execution node groups are described by the `spec.cluster.execNodes` array. This array must contain an entry with `name: default`, otherwise the operator will reject the configuration without this group.

* `spec.cluster.execNodes[].name`: `^[a-z][a-z0-9-]*$` pattern. Immutable group key.
* `spec.cluster.execNodes[].instanceCount`: 1–50.
* `spec.cluster.execNodes[].storage.size`: Disk size for slots and caches. You can only increase this size.
* `spec.cluster.execNodes[].storage.storageClass`: Storage class. Once a PVC is created, it cannot be changed.
* `spec.cluster.execNodes[].resources.cpu`, `spec.cluster.execNodes[].resources.memory`.
* `spec.cluster.execNodes[].resources.gpu`: Number of GPUs per pod. The [NVIDIA® GPU Support](../../concepts/components/gpu.md) component must be enabled, and the cluster nodes must have a GPU.

The rules for adding and removing groups are the same as for `dataNodes`. You cannot delete the `default` group.

## Updating tablet nodes groups {#tablet-nodes}

The `spec.cluster.tabletNodes` list is optional; you can leave it empty if not using dynamic tables.

* `spec.cluster.tabletNodes[].name`: `^[a-z][a-z0-9-]*$` pattern. Immutable group key.
* `spec.cluster.tabletNodes[].instanceCount`: 1–50.
* `spec.cluster.tabletNodes[].resources.cpu`, `spec.cluster.tabletNodes[].resources.memory`.

Dynamic table nodes do not use individual PVCs, so deleting a group only deletes the pods.

## Managing additional subcomponents {#extras}

Additional subcomponents are enabled and disabled via the `enabled` flags in relevant `spec.cluster` fields. When you change a flag, the operator creates or deletes the helm release and associated Kubernetes resources.

* `spec.cluster.ui.enabled`: {{ YT }} web UI.
* `spec.cluster.ui.ingressEnabled`: Publishing an Ingress at `ytsaurus.<system_domain>`. Makes sense only if `ui.enabled: true`.
* `spec.cluster.ui.resources.cpu`, `spec.cluster.ui.resources.memory`: Web interface pod resources.
* `spec.cluster.strawberry.enabled`: Strawberry controller. Required if you plan to use CHYT or SPYT.
* `spec.cluster.strawberry.resources.cpu`, `spec.cluster.strawberry.resources.memory`.
* `spec.cluster.chyt.enabled`: CHYT, a {{ CH }} engine on top of {{ YT }}. Before turning it on, make sure `strawberry` is on.
* `spec.cluster.spyt.enabled`: SPYT, an {{ SPRK }} engine on top of {{ YT }}. Before turning it on, make sure `strawberry` is on.
* `spec.cluster.taskProxy.enabled`: Task Proxy used to run external tasks.
* `spec.cluster.taskProxy.instanceCount`: 1–10.
* `spec.cluster.tutorial.enabled`: Built-in {{ YT }} tutorial. Creates a folder named `//home/tutorial` with examples.
* `spec.cluster.odin.enabled`: Odin monitoring service. Once enabled, `odin-alerts` rules are activated.

## Cron jobs {#cron}

You can set up regular `//tmp` folder cleanup in `spec.cluster.cron.clear_tmp`:

* `spec.cluster.cron.clear_tmp.enabled`: Cleanup enabled flag.
* `spec.cluster.cron.clear_tmp.interval`: Cleanup frequency. `^[0-9]+[hms]$` format, e.g., `15m`, `1h`, `30s`. The default value is `15m`.
* `spec.cluster.cron.clear_tmp.account_usage_percent_save_total`: Total account quota usage threshold up to which cleanup is performed. From 0 to 100. The default value is `50`.
* `spec.cluster.cron.clear_tmp.account_usage_percent_save_per_owner`: Quota usage threshold per owner. From 0 to 100. The default value is `10`.
* `spec.cluster.cron.clear_tmp.max_dir_node_count`: Maximum number of nodes in the `//tmp` folder to activate cleanup. The default value is `100000`.

## What's next {#what-is-next}

* [Getting an administrator password and token](get-admin-credentials.md)
* [Opening the {{ YT }} web UI](connect-ui.md)
* [Connecting to the {{ YT }} HTTP proxy](connect-api.md)
* [Disabling {{ yt-name }}](disable.md)
