# Migrating {{ k8s }} resources to a different availability zone


In a {{ managed-k8s-name }} cluster, you can [migrate a node group and pod workload](#transfer-a-node-group) from one availability zone to another.

## Getting started {#before-you-begin}

{% include [cli-install](../../_includes/cli-install.md) %}

{% include [default-catalogue](../../_includes/default-catalogue.md) %}

If you have already installed the CLI, update to its latest version:

```bash
yc components update
```


## Migrate the node group and pod workload to a different availability zone {#transfer-a-node-group}

[Set up the node group](#prepare) and proceed with migration using one of the following methods:

* Migrating a node group directly to the new availability zone. It depends on the type of workload in the pods:

   * [Stateless workload](#stateless): Application functioning in pods during migration depends on how workload is distributed between cluster nodes. If the pods reside both in the node group you are migrating and the groups for which the availability zone remains unchanged, the applications keep running. If the pods only reside in the group you are migrating, both the pods and the applications in them must be briefly stopped.

      Stateless workload examples include the web server, {{ alb-full-name }} [ingress controller](../../application-load-balancer/tools/k8s-ingress-controller/index.md), and REST API apps.

   * [Stateful workloads](#stateful): Pods and applications must be briefly stopped, regardless of how workload is distributed between cluster nodes.

      Stateful workload examples include databases and storages.

* [Gradually migrating stateless and stateful workloads](#gradual-migration) to a new node group: It involves creating a new node group in the new availability zone and gradually discontinuing the old nodes. This enables you to manage workload transfer.

### Getting started {#prepare}

1. Check if the `nodeSelector`, `affinity`, or `topology spread constraints` strategies are used to assign the pods to the group's nodes. For more information on strategies, see [this {{ k8s }} article](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/) and [{#T}](../../managed-kubernetes/concepts/usage-recommendations.md#high-availability). To check a pod's assignment to nodes and remove it:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder with your {{ managed-k8s-name }} cluster.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
      1. Open the cluster page and navigate to **{{ ui-key.yacloud.k8s.cluster.switch_workloads }}**.
      1. On the **{{ ui-key.yacloud.k8s.workloads.label_pods }}** tab, open the pod page.
      1. Navigate to the **{{ ui-key.yacloud.k8s.workloads.label_tab-yaml }}** tab.
      1. Check if the pod manifest contains the following parameters and {{ k8s }} labels in them:

         * Parameters:

            * `spec.nodeSelector`
            * `spec.affinity`
            * `spec.topologySpreadConstraints`

         * {{ k8s }} labels set in the parameters:

            * `failure-domain.beta.kubernetes.io/zone`: `<availability_zone>`
            * `topology.kubernetes.io/zone`: `<availability_zone>`

         When the configuration includes at least one of these parameters containing at least one of the listed {{ k8s }} labels, node group and workload migration will not proceed.

      1. Check the pod manifest for dependencies on the following entities:

         * Availability zone you are migrating your resources from.
         * Specific nodes within the group.

      1. If you find any of the parameters, assignments, or dependencies listed above, remove them from the pod configuration:

         1. Copy the YAML configuration from the management console.
         1. Create a local YAML file and paste the copied configuration into it.
         1. Remove any availability zone assignments from the configuration. For example, if the `spec.affinity` parameter includes the `failure-domain.beta.kubernetes.io/zone` {{ k8s }} label, remove it.
         1. Apply the new configuration:

            ```bash
            kubectl apply -f <YAML_file_path>
            ```

         1. Make sure the pod status changed to `Running`:

            ```bash
            kubectl get pods
            ```

      1. Repeat these steps for each pod to check and update its configuration.

   {% endlist %}

1. Transfer persistent data, such as databases, message queues, monitoring servers, and log servers, to the new availability zone.

### Migrating stateless workloads {#stateless}

1. Create a subnet in the new availability zone and migrate the node group:

   {% include [node-group-migration](../../_includes/managed-kubernetes/node-group-migration.md) %}

1. Make sure the pods are running in the migrated node group:

   ```bash
   kubectl get po --output wide
   ```

   The output of this command shows the nodes on which your pods are currently running.

### Migrating stateful workloads {#stateful}

The migration is based on scaling the `StatefulSet` controller. To migrate stateful workloads:

1. Get a list of `StatefulSet` controllers to find the name of the one you need:

   ```bash
   kubectl get statefulsets
   ```

1. Get the number of pods managed by the controller:

   ```bash
   kubectl get statefulsets <controller_name> \
      -n default -o=jsonpath='{.status.replicas}'
   ```

   Save this value. You will need it to scale the `StatefulSet` controller once the migration of your stateful workloads is complete.

1. Reduce the number of pods to zero:

   ```bash
   kubectl scale statefulset <controller_name> --replicas=0
   ```

   This will stop the pods that are using disks, while retaining the [PersistentVolumeClaim](../../managed-kubernetes/concepts/volume.md#persistent-volume) {{ k8s }} API object (PVC).

1. For the [PersistentVolume](../../managed-kubernetes/concepts/volume.md#persistent-volume) object (PV) associated with `PersistentVolumeClaim`, change the `persistentVolumeReclaimPolicy` value from `Delete` to `Retain` to prevent accidental data loss.

   1. Get the name of the `PersistentVolume` object:

      ```bash
      kubectl get pv
      ```

   1. Edit the `PersistentVolume` object:

      ```bash
      kubectl edit pv <PV_name>
      ```

1. Check if the `PersistentVolume` object manifest contains the `spec.nodeAffinity` parameter:

    ```bash
    kubectl get pv <PV_name> --output='yaml'
    ```

    If the manifest contains the `spec.nodeAffinity` parameter with an availability zone specified in it, save this parameter. You will need to specify it in a new `PersistentVolume` object.

1. Create a `PersistentVolume` snapshot. For more information about snapshots, see [this Kubernetes article](https://kubernetes.io/docs/concepts/storage/volume-snapshots/).

   1. Get the name of the `PersistentVolumeClaim` object:

      ```bash
      kubectl get pvc
      ```

   1. Create the `snapshot.yaml` with the snapshot manifest and specify the `PersistentVolumeClaim` name in it:

      ```yaml
      apiVersion: snapshot.storage.k8s.io/v1
      kind: VolumeSnapshot
      metadata:
         name: new-snapshot-test-<number>
      spec:
         volumeSnapshotClassName: yc-csi-snapclass
         source:
            persistentVolumeClaimName: <PVC_name>
      ```

      If you are creating several snapshots for different `PersistentVolumeClaim` objects, specify the `<number>` (consecutive) to make sure each snapshot gets a unique `metadata.name` value.

   1. Create a snapshot:

      ```bash
      kubectl apply -f snapshot.yaml
      ```

   1. Make sure the snapshot was created:

      ```bash
      kubectl get volumesnapshots.snapshot.storage.k8s.io
      ```

   1. Make sure the [VolumeSnapshotContent](https://kubernetes.io/docs/concepts/storage/volume-snapshots/#introduction) {{ k8s }} API object was created:

      ```bash
      kubectl get volumesnapshotcontents.snapshot.storage.k8s.io
      ```

1. Get the snapshot ID:

   ```bash
   yc compute snapshot list
   ```

1. Create a [VM disk](../../compute/concepts/disk.md) from the snapshot:

   ```bash
   yc compute disk create \
      --source-snapshot-id <snapshot_ID> \
      --zone <availability_zone>
   ```

   In the command, specify the availability zone to which you are migrating your {{ managed-k8s-name }} node group.

   Save the following parameters from the command output:
   * Disk ID from the `id` field.
   * Disk type from the `type_id` field.
   * Disk size from the `size` field.

1. Create a `PersistentVolume` {{ k8s }} API object from the new disk:

   1. Create the `persistent-volume.yaml` file with the `PersistentVolume` manifest:

      ```yaml
      apiVersion: v1
      kind: PersistentVolume
      metadata:
         name: new-pv-test-<number>
      spec:
         capacity:
            storage: <PersistentVolume_size>
         accessModes:
            - ReadWriteOnce
         csi:
            driver: disk-csi-driver.mks.ycloud.io
            fsType: ext4
            volumeHandle: <disk_ID>
         storageClassName: <disk_type>
      ```

      In the file, specify the parameters of the disk created from the snapshot:

      * `spec.capacity.storage`: Disk size.
      * `spec.csi.volumeHandle`: Disk ID.
      * `spec.storageClassName`: Disk type. Specify it in accordance with the following table:

         | Snapshot-based disk type | Disk type for the YAML file |
         | ----------- | ----------- |
         | `network-ssd` | `yc-network-ssd` |
         | `network-ssd-nonreplicated` | `yc-network-ssd-nonreplicated` |
         | `network-nvme` | `yc-network-nvme` |
         | `network-hdd` | `yc-network-hdd` |

      If you are creating several `PersistentVolume` objects, specify the `<number>` (consecutive) to make sure each gets a unique `metadata.name` value.

      Add the previously saved `spec.nodeAffinity` parameter to the manifest and specify the availability zone to which you are migrating your {{ managed-k8s-name }} node group. If you skip it, the workload may run in a different availability zone where `PersistentVolume` is not available, causing an error.

      Here is an example of the `spec.nodeAffinity` parameter:

      ```yaml
      spec:
         ...
         nodeAffinity:
            required:
               nodeSelectorTerms:
               - matchExpressions:
                  - key: failure-domain.beta.kubernetes.io/zone
                    operator: In
                    values:
                       - ru-central1-d
      ```

   1. Create a `PersistentVolume` object:

      ```bash
      kubectl apply -f persistent-volume.yaml
      ```

   1. Make sure `PersistentVolume` was created:

      ```bash
      kubectl get pv
      ```

      The command output will display the `new-pv-test<number>` object.

   1. If you specified the `spec.nodeAffinity` parameter in the manifest, make sure to apply it for the `PersistentVolume` object:

       {% list tabs group=instructions %}

       - Management console {#console}

          1. In the [management console]({{ link-console-main }}), select the folder with your {{ managed-k8s-name }} cluster.
          1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
          1. Open the cluster page and navigate to **{{ ui-key.yacloud.k8s.cluster.switch_storage }}**.
          1. On the **{{ ui-key.yacloud.k8s.storage.label_pv }}** tab, find the `new-pv-test-<number>` object and check the **{{ ui-key.yacloud.k8s.pv.overview.label_zone }}** field value. It should specify an availability zone. A dash means there is no assignment to an availability zone.

       {% endlist %}

   1. If you skipped the `spec.nodeAffinity` parameter in the manifest, you can add it by editing the `PersistentVolume` object:

      ```bash
      kubectl edit pv new-pv-test-<number>
      ```

1. Create a `PersistentVolumeClaim` object from the new `PersistentVolume`:

   1. Create the `persistent-volume-claim.yaml` file with the `PersistentVolumeClaim` manifest:

      ```yaml
      apiVersion: v1
      kind: PersistentVolumeClaim
      metadata:
         name: <PVC_name>
      spec:
         accessModes:
            - ReadWriteOnce
         resources:
            requests:
               storage: <PV_size>
         storageClassName: <disk_type>
         volumeName: new-pv-test-<number>
      ```

      In the file, set the following parameters:

      * `metadata.name`: Name of the `PersistentVolumeClaim` object you used to create the snapshot. You can get this name by running the `kubectl get pvc` command.
      * `spec.resources.requests.storage`: `PersistentVolume` size, which matches the size of the created disk.
      * `spec.storageClassName`: `PersistentVolume` disk type, which matches the disk type of the new `PersistentVolume`.
      * `spec.volumeName`: Name of the `PersistentVolume` object to base `PersistentVolumeClaim` on. You can get this name by running the `kubectl get pv` command.

   1. Delete the original `PersistentVolumeClaim` so you can replace it:

      ```bash
      kubectl delete pvc <PVC_name>
      ```

   1. Create a `PersistentVolumeClaim` object:

      ```bash
      kubectl apply -f persistent-volume-claim.yaml
      ```

   1. Make sure `PersistentVolumeClaim` was created:

      ```bash
      kubectl get pvc
      ```

      The command output will return the `PersistentVolumeClaim` size you specified in the YAML file.

1. Create a subnet in the new availability zone and migrate the node group:

   {% include [node-group-migration](../../_includes/managed-kubernetes/node-group-migration.md) %}

1. Restore the original number of pods managed by the `StatefulSet` controller:

   ```bash
   kubectl scale statefulset <controller_name> --replicas=<number_of_pods>
   ```

   This will start the pods in the migrated node group.

   In the command, specify the following parameters:

   * Name of the `StatefulSet` controller. You can get it by running the `kubectl get statefulsets` command.
   * Number of pods prior to scaling down the controller.

1. Make sure the pods are running in the migrated node group:

   ```bash
   kubectl get po --output wide
   ```

   The output of this command shows the nodes on which your pods are currently running.

1. Delete the unused `PersistentVolume` object, i.e., the one with the `Released` status.

   1. Get the name of the `PersistentVolume` object:

      ```bash
      kubectl get pv
      ```

   1. Delete the `PersistentVolume` object:

      ```bash
      kubectl delete pv <PV_name>
      ```

### Gradually migrating stateless and stateful workloads {#gradual-migration}

See below how to gradually migrate workloads from the old node group to the new one. For `PersistentVolume` and `PersistentVolumeClaim` migration steps, see [Migrating stateful workloads](#stateful).

1. [Create a new {{ managed-k8s-name }} node group](../../managed-kubernetes/operations/node-group/node-group-create.md) in the new availability zone.

1. Disable running new pods in the old node group:

   ```bash
   kubectl cordon -l yandex.cloud/node-group-id=<old_node_group_ID>
   ```

1. For each node in the old node group, run the following command:

   ```bash
   kubectl drain <node_name> --ignore-daemonsets --delete-emptydir-data
   ```

   The pods will gradually move to the new node group.

1. Make sure the pods are running in the new node group:

   ```bash
   kubectl get po --output wide
   ```

1. [Delete the old node group](../../managed-kubernetes/operations/node-group/node-group-delete.md).
