# Migrating {{ managed-k8s-name }} resources to a different availability zone


{% note info %}

{% include [zone-c-deprecation](../../_includes/vpc/zone-c-deprecation.md) %}

{% endnote %}

To migrate {{ managed-k8s-name }} resources from one availability zone to another:

1. [Migrate a master host](#transfer-a-master).
1. [Migrate the node group and the pod workloads](#transfer-a-node-group).

## Getting started {#before-you-begin}

{% include [cli-install](../../_includes/cli-install.md) %}

{% include [default-catalogue](../../_includes/default-catalogue.md) %}

If you have already installed the CLI, update to its latest version.

```bash
yc components update
```

## Migrate your master host to a different availability zone {#transfer-a-master}

Migration of a [master host](../concepts/index.md#master) depends on its type: [zonal](#zonal) or [regional](#regional).

### Migrating a zonal master host {#zonal}

A zonal master is located in one availability zone. You can only migrate the master host from the `{{ region-id }}-c` zone to the `{{ region-id }}-d` zone. During migration, the master host is restarted, and the {{ k8s }} server API becomes briefly unavailable. Once migrated, the master host's public and private IP addresses remain the same; the cluster and node group are not recreated.

The zonal master is moved to the new subnet with the same internal IP address it had in the old subnet. This IP address remains reserved in the old subnet as well, so you cannot delete it. Later on, you will be able to [move](../../vpc/operations/subnet-relocate.md) such a subnet to a new availability zone, or it will be moved to the `{{ region-id }}-d` zone automatically as soon as the `{{ region-id }}-c` zone is closed.

To migrate a zonal master to a different availability zone:

{% list tabs group=instructions %}

- CLI {#cli}

   1. Create a subnet in the `{{ region-id }}-d` availability zone:

      ```bash
      yc vpc subnet create \
         --folder-id <folder_ID> \
         --name <subnet_name> \
         --zone {{ region-id }}-d \
         --network-id <network_ID> \
         --range <subnet_CIDR>
      ```

      In the command, specify the following subnet parameters:

      * `--folder-id`: [Folder ID](../../resource-manager/operations/folder/get-id.md).
      * `--name`: Subnet name.
      * `--zone`: Availability zone.
      * `--network-id`: ID of the network the new subnet belongs to.
      * `--range`: List of IPv4 addresses for outgoing and incoming traffic, e.g., `10.0.0.0/22` or `192.168.0.0/16`. Make sure the addresses are unique within the network. The minimum subnet size is `/28`, the maximum subnet size is `/16`. Only IPv4 is supported.

   1. Migrate your master host to a different availability zone:

      ```bash
      {{ yc-k8s }} cluster update \
         --folder-id <folder_ID> \
         --id <cluster_ID> \
         --master-location subnet-id=<new_subnet_ID>,zone={{ region-id }}-d
      ```

      Where:

      * `--folder-id`: Folder ID.
      * `--id`: [Cluster ID](../operations/kubernetes-cluster/kubernetes-cluster-list.md).
      * `--master-location`: Master hosting parameters:
         * `subnet-id`: New subnet ID.
         * `zone`: Availability zone.

- {{ TF }} {#tf}

   {% include [master-tf-mifration-warning](../../_includes/managed-kubernetes/master-tf-mifration-warning.md) %}

   1. In the cluster configuration file, update the format of the cluster location section (`zonal`), but do not change the parameter values:

      **Old format**:

      ```hcl
      resource "yandex_kubernetes_cluster" "<cluster_name>" {
         ...
         master {
            ...
            zonal {
               subnet_id = yandex_vpc_subnet.my-old-subnet.id
               zone      = "{{ region-id }}-c"
            }
         }
         ...
      }
      ```

      **New format**:

      ```hcl
      resource "yandex_kubernetes_cluster" "<cluster_name>" {
         ...
         master {
            ...
            master_location {
               subnet_id = yandex_vpc_subnet.my-old-subnet.id
               zone      = "{{ region-id }}-c"
            }
         }
         ...
      }
      ```

   1. Make sure no {{ TF }} resource parameter changes have been detected:

      ```bash
      terraform plan
      ```

      If {{ TF }} detects the changes, validate all cluster parameter values: they should match the current state.

   1. Add the new network's manifest to the cluster configuration file and change the cluster location:

      ```hcl
      resource "yandex_vpc_subnet" "my-new-subnet" {
         name           = "<network_name>"
         zone           = "{{ region-id }}-d"
         network_id     = yandex_vpc_network.k8s-network.id
         v4_cidr_blocks = ["<subnet_CIDR>"]
      }

      ...

      resource "yandex_kubernetes_cluster" "<cluster_name>" {
         ...
         master {
            ...
            master_location {
               subnet_id = yandex_vpc_subnet.my-new-subnet.id
               zone      = "{{ region-id }}-d"
            }
         }
         ...
      }
      ```

      The old subnet for the cluster, `my-old-subnet`, is replaced by `my-new-subnet` with these parameters:

      * `name`: Subnet name.
      * `zone`: `{{ region-id }}-d` availability zone.
      * `network_id`: ID of the network the new subnet belongs to.
      * `v4_cidr_blocks`: List of IPv4 addresses to deal with outgoing and incoming traffic, e.g., `10.0.0.0/22` or `192.168.0.0/16`. Make sure the addresses are unique within the network. The minimum subnet size is `/28`, the maximum subnet size is `/16`. Only IPv4 is supported.

   1. Check that the configuration file is correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

{% endlist %}

### Migrating a regional master host {#regional}

A regional master host is created and distributed across three subnets in different availability zones. You can change [only one availability zone](../../overview/concepts/ru-central1-c-deprecation.md) for a regional master host: from `{{ region-id }}-c` to `{{ region-id }}-d`. Three subnets and availability zones are specified for host migration. During migration, the master host keeps running, the cluster and node group not being recreated.

The internal IP address for the regional master host is assigned automatically in one of the three hosting subnets. After migration, the master retains its internal IP address. If this IP address was allocated in the `{{ region-id }}-c` zone subnet, the master is moved to the `{{ region-id }}-d` zone with the previous IP address reserved in the old subnet. You cannot delete such a subnet, but later on you will be able to [move](../../vpc/operations/subnet-relocate.md) it to a new availability zone, or it will be moved to the `{{ region-id }}-d` zone automatically as soon as the `{{ region-id }}-c` zone is closed.

To migrate a regional master host to a different set of availability zones:

{% list tabs group=instructions %}

- CLI {#cli}

   1. Create a subnet in the `{{ region-id }}-d` availability zone:

      ```bash
      yc vpc subnet create \
         --folder-id <folder_ID> \
         --name <subnet_name> \
         --zone {{ region-id }}-d \
         --network-id <network_ID> \
         --range <subnet_CIDR>
      ```

      In the command, specify the following subnet parameters:

      * `--folder-id`: [Folder ID](../../resource-manager/operations/folder/get-id.md).
      * `--name`: Subnet name.
      * `--zone`: Availability zone.
      * `--network-id`: ID of the network the new subnet belongs to.
      * `--range`: List of IPv4 addresses for outgoing and incoming traffic, e.g., `10.0.0.0/22` or `192.168.0.0/16`. Make sure the addresses are unique within the network. The minimum subnet size is `/28`, the maximum subnet size is `/16`. Only IPv4 is supported.

   1. Migrate your master host to a different set of availability zones:

      ```bash
      {{ yc-k8s }} cluster update \
         --folder-id <folder_ID> \
         --id <cluster_ID> \
         --master-location subnet-id=<subnet_ID>,zone={{ region-id }}-a \
         --master-location subnet-id=<subnet_ID>,zone={{ region-id }}-b \
         --master-location subnet-id=<new_subnet_ID>,zone={{ region-id }}-d
      ```

      Where:

      * `--folder-id`: Folder ID.
      * `--id`: [Cluster ID](../operations/kubernetes-cluster/kubernetes-cluster-list.md).
      * `--master-location`: Master hosting parameters:
         * `subnet-id`: Subnet ID.
         * `zone`: Availability zone.

         Specify the appropriate subnet for each availability zone.

- {{ TF }} {#tf}

   {% include [master-tf-mifration-warning](../../_includes/managed-kubernetes/master-tf-mifration-warning.md) %}

   1. In the cluster configuration file, update the format of the cluster location section (`regional`), but do not change the parameter values:

      **Old format**:

      ```hcl
      resource "yandex_kubernetes_cluster" "<cluster_name>" {
         ...
         master {
            ...
            regional {
               region = "{{ region-id }}"
               location {
                  subnet_id = yandex_vpc_subnet.my-subnet-a.id
                  zone      = yandex_vpc_subnet.my-subnet-a.zone
               }
               location {
                  subnet_id = yandex_vpc_subnet.my-subnet-b.id
                  zone      = yandex_vpc_subnet.my-subnet-b.zone
               }
               location {
                  subnet_id = yandex_vpc_subnet.my-subnet-c.id
                  zone      = yandex_vpc_subnet.my-subnet-c.zone
               }
            }
         }
         ...
      }
      ```

      **New format**:

      ```hcl
      resource "yandex_kubernetes_cluster" "<cluster_name>" {
         ...
         master {
            ...
            master_location {
               subnet_id = yandex_vpc_subnet.my-subnet-a.id
               zone      = yandex_vpc_subnet.my-subnet-a.zone
            }
            master_location {
               subnet_id = yandex_vpc_subnet.my-subnet-b.id
               zone      = yandex_vpc_subnet.my-subnet-b.zone
            }
            master_location {
               subnet_id = yandex_vpc_subnet.my-subnet-c.id
               zone      = yandex_vpc_subnet.my-subnet-c.zone
            }
         }
         ...
      }
      ```

   1. Make sure no {{ TF }} resource parameter changes have been detected:

      ```bash
      terraform plan
      ```

      If {{ TF }} detects changes, validate all cluster parameter values: they should match the current state.

   1. Add the new subnet's manifest to the cluster configuration file and change the cluster location:

      ```hcl
      resource "yandex_vpc_subnet" "my-subnet-d" {
         name           = "<network_name>"
         zone           = "{{ region-id }}-d"
         network_id     = yandex_vpc_network.k8s-network.id
         v4_cidr_blocks = ["<subnet_CIDR>"]
      }

      ...

      resource "yandex_kubernetes_cluster" "k8s-cluster" {
         ...
         master {
            ...
            master_location {
               subnet_id = yandex_vpc_subnet.my-subnet-a.id
               zone      = yandex_vpc_subnet.my-subnet-a.zone
            }
            master_location {
               subnet_id = yandex_vpc_subnet.my-subnet-b.id
               zone      = yandex_vpc_subnet.my-subnet-b.zone
            }
            master_location {
               subnet_id = yandex_vpc_subnet.my-subnet-d.id
               zone      = yandex_vpc_subnet.my-subnet-d.zone
            }
            ...
         }
      ...
      }
      ```

      The cluster's subnet named `my-subnet-c` is replaced with `my-subnet-d` that has the following parameters:

      * `name`: Subnet name.
      * `zone`: Availability zone.
      * `network_id`: ID of the network the new subnet belongs to.
      * `v4_cidr_blocks`: List of IPv4 addresses to deal with outgoing and incoming traffic, e.g., `10.0.0.0/22` or `192.168.0.0/16`. Make sure the addresses are unique within the network. The minimum subnet size is `/28`, the maximum subnet size is `/16`. Only IPv4 is supported.

   1. Check that the configuration file is correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

{% endlist %}

## Migrate the node group and the pod workloads to a different availability zone {#transfer-a-node-group}

[Prepare a node group](#prepare) and proceed to migration using one of the following methods:

* Migrating a node group directly to the new availability zone. It depends on the type of workload in the pods:

   * [Stateless workload](#stateless): The functioning of applications in the pods during migration depends on how the workload is distributed among the cluster nodes. If the pods reside both in the node group you are migrating and the groups for which the availability zone remains the same, the applications will continue to run. If the pods only reside in the group you are migrating, both the pods and the applications in them will have to be stopped for a short while.

      Examples of stateless workloads include the web server, {{ alb-full-name }} [Ingress controller](../../application-load-balancer/tools/k8s-ingress-controller/index.md), and REST API applications.

   * [Stateful workloads](#stateful): The pods and applications will have to be stopped for a short while, regardless of how the workload is distributed among the cluster nodes.

      Examples of stateful workloads include databases and storages.

* [Gradually migrating a stateless and stateful workload](#gradual-migration) to the new node group. It involves creating a new node group in the new availability zone and gradually discontinuing the old nodes. This way, you can monitor the workload transfer.

### Getting started {#prepare}

1. Check if the `nodeSelector`, `affinity`, or `topology spread constraints` strategies are being used to assign the pods to the group's nodes. For more information on strategies, see [{#T}](../concepts/usage-recommendations.md#high-availability) and the [{{ k8s }} documentation](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/). To check how a pod is assigned to its associated node and unlink them:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder with your {{ managed-k8s-name }} cluster.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
      1. Go to the cluster page and find the **{{ ui-key.yacloud.k8s.cluster.switch_workloads }}** section.
      1. On the **{{ ui-key.yacloud.k8s.workloads.label_pods }}** tab, open the pod's page.
      1. Go to the **{{ ui-key.yacloud.k8s.workloads.label_tab-yaml }}** tab.
      1. Check if the pod manifest contains the following parameters and {{ k8s }} labels in them:

         * Parameters:

            * `spec.nodeSelector`
            * `spec.affinity`
            * `spec.topologySpreadConstraints`

         * {{ k8s }} labels set in the parameters:

            * `failure-domain.beta.kubernetes.io/zone`: `<availability_zone>`
            * `topology.kubernetes.io/zone`: `<availability_zone>`

         If a configuration has at least one of these parameters and that parameter contains at least one of the listed {{ k8s }} labels, that configuration prevents node group and workload migration.

      1. Check if the pod manifest has any dependencies from:

         * Availability zone you are migrating resources from.
         * Specific nodes within the group.

      1. If you find any of these settings, assignments, or dependencies, remove them from the pod configuration:

         1. Copy the YAML configuration from the management console.
         1. Create a local YAML file and paste the configuration into it.
         1. Remove any availability zone assignments from the configuration. For example, if the `spec.affinity` parameter sets the `failure-domain.beta.kubernetes.io/zone` {{ k8s }} label, remove it.
         1. Apply the new configuration:

            ```bash
            kubectl apply -f <path_to_YAML_file>
            ```

         1. Make sure the pod status changed to `Running`:

            ```bash
            kubectl get pods
            ```

      1. Check and update the configuration of each pod by repeating these steps.

   {% endlist %}

1. Transfer persistent data, such as databases, message queues, monitoring and log servers, to the new availability zone.

### Migrating a stateless workload {#stateless}

1. Create a subnet in the new availability zone and migrate the node group:

   {% include [node-group-migration](../../_includes/managed-kubernetes/node-group-migration.md) %}

1. Make sure the pods are running in the migrated node group:

   ```bash
   kubectl get po --output wide
   ```

   The output of this command displays the nodes on which your pods are currently running.

### Migrating a stateful workload {#stateful}

The migration process is based on scaling the `StatefulSet` controller. To migrate a stateful workload:

1. Get a list of `StatefulSet` controllers to find the name of the one you need:

   ```bash
   kubectl get statefulsets
   ```

1. Get the number of pods managed by the controller:

   ```bash
   kubectl get statefulsets <controller_name> \
      -n default -o=jsonpath='{.status.replicas}'
   ```

   Save the obtained value. You will need it to scale the StatefulSet controller once the migration of your stateful workload is complete.

1. Reduce the number of pods to zero:

   ```bash
   kubectl scale statefulset <controller_name> --replicas=0
   ```

   This way, you will disable the pods that use disks. In addition, running this command saves a [PersistentVolumeClaim](../concepts/volume.md#persistent-volume) (PVC) {{ k8s }} API object.

1. For the [PersistentVolume](../concepts/volume.md#persistent-volume) object (PV) associated with `PersistentVolumeClaim`, change the value of the `persistentVolumeReclaimPolicy` parameter from `Delete` to `Retain` to prevent accidental data loss.

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

1. Create a snapshot representing a point-in-time copy of the `PersistentVolume` disk. For more information about snapshots, see the [Kubernetes documentation](https://kubernetes.io/docs/concepts/storage/volume-snapshots/).

   1. Get the name of the `PersistentVolumeClaim`:

      ```bash
      kubectl get pvc
      ```

   1. Create a `snapshot.yaml` file with the snapshot manifest and specify the `PersistentVolumeClaim` name in it:

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

      If you are creating several snapshots for different `PersistentVolumeClaim` objects, specify the `<number>` (consecutive number) to make a unique `metadata.name` value for each snapshot.

   1. Create a snapshot:

      ```bash
      kubectl apply -f snapshot.yaml
      ```

   1. Check that the snapshot has been created:

      ```bash
      kubectl get volumesnapshots.snapshot.storage.k8s.io
      ```

   1. Make sure the [VolumeSnapshotContent](https://kubernetes.io/docs/concepts/storage/volume-snapshots/#introduction) {{ k8s }} API object has been created:

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

   In the command, specify the availability zone to which the {{ managed-k8s-name }} node group is being migrated.

   Save the following parameters from the command's output:
   * Disk ID from the `id` field.
   * Disk type from the `type_id` field.
   * Disk size from the `size` field.

1. Create a `PersistentVolume` {{ k8s }} API object from the new disk:

   1. Create a `persistent-volume.yaml` file with the `PersistentVolume` manifest:

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
      * `spec.storageClassName`: Disk type. Specify the type in accordance with the following table:

         | Type of the disk created from the snapshot | Disk type for the YAML file |
         | ----------- | ----------- |
         | `network-ssd` | `yc-network-ssd` |
         | `network-ssd-nonreplicated` | `yc-network-ssd-nonreplicated` |
         | `network-nvme` | `yc-network-nvme` |
         | `network-hdd` | `yc-network-hdd` |

      If you are creating several `PersistentVolume` objects, specify the `<number>` (consecutive number) to make a unique `metadata.name` value for each snapshot.

      If you saved the `spec.nodeAffinity` parameter earlier, add it to the manifest and specify the availability zone to which the {{ managed-k8s-name }} node group is being migrated. If you omit this parameter, the workload can run in a different availability zone where `PersistentVolume` is not available. This will result in a run error.

      Example of the `spec.nodeAffinity` parameter:

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

   1. Make sure the `PersistentVolume` has been created:

      ```bash
      kubectl get pv
      ```

      The `new-pv-test-<number>` object will appear in the command's output.

   1. If you specified the `spec.nodeAffinity` parameter in the manifest, make sure to apply it for the `PersistentVolume` object:

      {% list tabs group=instructions %}

      - Management console {#console}

         1. In the [management console]({{ link-console-main }}), select the folder with your {{ managed-k8s-name }} cluster.
         1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
         1. Go to the cluster page and find the **{{ ui-key.yacloud.k8s.cluster.switch_storage }}** section.
         1. On the **{{ ui-key.yacloud.k8s.storage.label_pv }}** tab, find the `new-pv-test-<number>` object and look up the **{{ ui-key.yacloud.k8s.pv.overview.label_zone }}** field value. It must specify an availability zone. A dash means there is no assignment to an availability zone.

      {% endlist %}

   1. If you omitted the `spec.nodeAffinity` parameter in the manifest, you can add it by editing the `PersistentVolume` object:

      ```bash
      kubectl edit pv new-pv-test-<number>
      ```

1. Create a `PersistentVolumeClaim` object from the new `PersistentVolume`:

   1. Create a `persistent-volume-claim.yaml` file with the `PersistentVolumeClaim` manifest:

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

      * `metadata.name`: Name of the `PersistentVolumeClaim` that you used to create the snapshot. You can get this name by running the `kubectl get pvc` command.
      * `spec.resources.requests.storage`: Size of the `PersistentVolume`; matches the size of the created disk.
      * `spec.storageClassName`: Disk type of the `PersistentVolume`; matches the disk type of the new `PersistentVolume`.
      * `spec.volumeName`: Name of the `PersistentVolume` object based on which the `PersistentVolumeClaim` object is created. You can get this name by running the `kubectl get pv` command.

   1. Delete the original `PersistentVolumeClaim` so you can replace it:

      ```bash
      kubectl delete pvc <PVC_name>
      ```

   1. Create a `PersistentVolumeClaim`:

      ```bash
      kubectl apply -f persistent-volume-claim.yaml
      ```

   1. Make sure the `PersistentVolumeClaim` has been created:

      ```bash
      kubectl get pvc
      ```

      The output of the `PersistentVolumeClaim` command will contain the size you specified in the YAML file.

1. Create a subnet in the new availability zone and migrate the node group:

   {% include [node-group-migration](../../_includes/managed-kubernetes/node-group-migration.md) %}

1. Restore the original number of pods managed by the `StatefulSet` controller:

   ```bash
   kubectl scale statefulset <controller_name> --replicas=<pod_count>
   ```

   The pods will be launched in the migrated node group.

   In the command, specify the following parameters:

   * Name of the `StatefulSet` controller. You can get it by running the `kubectl get statefulsets` command.
   * Number of pods prior to scaling down the controller.

1. Make sure the pods are running in the migrated node group:

   ```bash
   kubectl get po --output wide
   ```

   The output of this command displays the nodes on which your pods are currently running.

1. Delete the unused `PersistentVolume` object (having the `Released` status).

   1. Get the name of the `PersistentVolume` object:

      ```bash
      kubectl get pv
      ```

   1. Delete the `PersistentVolume` object:

      ```bash
      kubectl delete pv <PV_name>
      ```

### Gradually migrating a stateless and stateful workload {#gradual-migration}

See below how to gradually migrate a workload from the old node group to the new one. For instructions on migrating the `PersistentVolume` and `PersistentVolumeClaim` objects, see the [Migrating a stateful workload](#stateful) subsection.

1. [Create a new {{ managed-k8s-name }} node group](../operations/node-group/node-group-create.md#node-group-create) in the new availability zone.

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

1. [Delete the old node group](../operations/node-group/node-group-delete.md).
