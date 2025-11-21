# Working with snapshots


{{ managed-k8s-name }} supports snapshots, which are point-in-time [PersistentVolume](../../managed-kubernetes/concepts/volume.md#provisioning-volumes) copies. For more information about snapshots, see [this Kubernetes article](https://kubernetes.io/docs/concepts/storage/volume-snapshots/).

To create a snapshot and then use it for restoring:

1. [Set up a test environment](#create-pvc-pod).
1. [Create a snapshot](#create-snapshot).
1. [Restore objects from the snapshot](#restore-from-snapshot).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost for this solution includes:

* Fee for using the master and outgoing traffic in a {{ managed-k8s-name }} cluster (see [{{ managed-k8s-name }} pricing](../../managed-kubernetes/pricing.md)).
* Fee for using computing resources, OS, and storage in cluster nodes (VMs) (see [{{ compute-name }} pricing](../../compute/pricing.md)).
* Fee for a public IP address assigned to cluster nodes (see [{{ vpc-name }} pricing](../../vpc/pricing.md#prices-public-ip)).


## Getting started {#before-you-begin}

1. Create {{ k8s }} resources:

   {% list tabs group=instructions %}

   - Manually {#manual}

     1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

        {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

     1. [Create a {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) and [node group](../../managed-kubernetes/operations/node-group/node-group-create.md) with any suitable configuration. When creating, specify the preconfigured security groups.

   - {{ TF }} {#tf}

     1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
     1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
     1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
     1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

     1. Download the [k8s-cluster.tf](https://github.com/yandex-cloud-examples/yc-mk8s-cluster-infrastructure/blob/main/k8s-cluster.tf) cluster configuration file to the same working directory. This file describes:
        * Network.
        * Subnet.
        * {{ managed-k8s-name }} cluster.
        * Service account required to create the {{ managed-k8s-name }} cluster and node group.
        * {% include [configure-sg-terraform](../../_includes/managed-kubernetes/security-groups/configure-sg-tf-lvl3.md) %}

            {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

     1. Specify the [folder ID](../../resource-manager/operations/folder/get-id.md) in the configuration file:
     1. Make sure the {{ TF }} configuration files are correct using this command:

        ```bash
        terraform validate
        ```

        {{ TF }} will show any errors found in your configuration files.
     1. Create the required infrastructure:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

   {% endlist %}

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

## Set up a test environment {#create-pvc-pod}

To test snapshots, you will create a [PersistentVolumeClaim](../../managed-kubernetes/concepts/volume.md#persistent-volume) and a [pod](../../managed-kubernetes/concepts/index.md#pod) to simulate the workload.
1. Create the `01-pvc.yaml` file with the `PersistentVolumeClaim` manifest:

   ```yaml
   ---
   apiVersion: v1
   kind: PersistentVolumeClaim
   metadata:
     name: pvc-dynamic
   spec:
     accessModes:
       - ReadWriteOnce
     storageClassName: yc-network-hdd
     resources:
       requests:
         storage: 5Gi
   ```

1. Create a `PersistentVolumeClaim`:

   ```bash
   kubectl apply -f 01-pvc.yaml
   ```

1. Make sure the `PersistentVolumeClaim` was created and is `Pending`:

   ```bash
   kubectl get pvc pvc-dynamic
   ```

1. Create the `02-pod.yaml` file with the `pod-source` pod manifest:

   ```yaml
   ---
   apiVersion: v1
   kind: Pod
   metadata:
     name: pod-source
   spec:
     containers:
       - name: app
         image: ubuntu
         command: ["/bin/sh"]
         args:
           ["-c", "while true; do echo $(date -u) >> /data/out.txt; sleep 5; done"]
         volumeMounts:
           - name: persistent-storage
             mountPath: /data
     volumes:
       - name: persistent-storage
         persistentVolumeClaim:
           claimName: pvc-dynamic
   ```

   The pod container will write the current date and time to the `/data/out.txt` file.

1. Create a pod named `pod-source`:

   ```bash
   kubectl apply -f 02-pod.yaml
   ```

1. Make sure the pod status changed to `Running`:

   ```bash
   kubectl get pod pod-source
   ```

1. Check that `/data/out.txt` shows lines with date and time: For this, [run the following command](https://kubernetes.io/docs/tasks/debug-application-cluster/get-shell-running-container/) on the pod:

   ```bash
   kubectl exec pod-source -- tail /data/out.txt
   ```

   Result:

   ```text
   Thu Feb 3 04:55:21 UTC 2022
   Thu Feb 3 04:55:26 UTC 2022
   ...
   ```

## Create a snapshot {#create-snapshot}

1. Create the `03-snapshot.yaml` file with the [snapshot](https://kubernetes.io/docs/concepts/storage/volume-snapshots/#volumesnapshots) manifest:

   ```yaml
   ---
   apiVersion: snapshot.storage.k8s.io/v1
   kind: VolumeSnapshot
   metadata:
     name: new-snapshot-test
   spec:
     volumeSnapshotClassName: yc-csi-snapclass
     source:
       persistentVolumeClaimName: pvc-dynamic
   ```

1. Create a snapshot:

   ```bash
   kubectl apply -f 03-snapshot.yaml
   ```

1. Make sure the snapshot was created:

   ```bash
   kubectl get volumesnapshots.snapshot.storage.k8s.io
   ```

1. Make sure the [VolumeSnapshotContent](https://kubernetes.io/docs/concepts/storage/volume-snapshots/#introduction) was created:

   ```bash
   kubectl get volumesnapshotcontents.snapshot.storage.k8s.io
   ```

## Restore objects from the snapshot {#restore-from-snapshot}

When [restoring objects from the snapshot](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#volume-snapshot-and-restore-volume-from-snapshot-support), the cluster will create:
* `PersistentVolumeClaim` object named `pvc-restore`.
* Pod named `pod-restore` with entries in `/data/out.txt`.

To restore from the snapshot:
1. Create the `04-restore-snapshot.yaml` file with the new `PersistentVolumeClaim` manifest:

   ```yaml
   ---
   apiVersion: v1
   kind: PersistentVolumeClaim
   metadata:
     name: pvc-restore
   spec:
     storageClassName: yc-network-hdd
     dataSource:
       name: new-snapshot-test
       kind: VolumeSnapshot
       apiGroup: snapshot.storage.k8s.io
     accessModes:
       - ReadWriteOnce
     resources:
       requests:
         storage: 10Gi
   ```

   {% note tip %}

   You can resize the `PersistentVolumeClaim` being created. To do this, specify its new size in the `spec.resources.requests.storage` setting.

   {% endnote %}

1. Create the new `PersistentVolumeClaim`:

   ```bash
   kubectl apply -f 04-restore-snapshot.yaml
   ```

1. Make sure the `PersistentVolumeClaim` was created and is `Pending`:

   ```bash
   kubectl get pvc pvc-restore
   ```

1. Create the `05-pod-restore.yaml` file with the new `pod-restore` pod manifest:

   ```yaml
   ---
   apiVersion: v1
   kind: Pod
   metadata:
     name: pod-restore
   spec:
     containers:
       - name: app-restore
         image: ubuntu
         command: ["/bin/sh"]
         args: ["-c", "while true; do sleep 5; done"]
         volumeMounts:
           - name: persistent-storage-r
             mountPath: /data
     volumes:
       - name: persistent-storage-r
         persistentVolumeClaim:
           claimName: pvc-restore
   ```

   The new pod container will not perform any actions with `/data/out.txt`.

1. Create a pod named `pod-restore`:

   ```bash
   kubectl apply -f 05-pod-restore.yaml
   ```

1. Make sure the pod status changed to `Running`:

   ```bash
   kubectl get pod pod-restore
   ```

1. Make sure the new `PersistentVolumeClaim` status changed to `Bound`:

   ```bash
   kubectl get pvc pvc-restore
   ```

1. Make sure `/data/out.txt` on the new pod contains all entries [added](#create-pvc-pod) by `pod-source` container before creating the snapshot:

   ```bash
   kubectl exec pod-restore -- tail /data/out.txt
   ```

   Result:

   ```text
   Thu Feb 3 04:55:21 UTC 2022
   Thu Feb 3 04:55:26 UTC 2022
   ...
   ```

## Delete the resources you created {#clear-out}

Delete the resources you no longer need to avoid paying for them:

1. Delete the {{ managed-k8s-name }} cluster:

   {% list tabs group=instructions %}

   - Manually {#manual}

     [Delete the {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).

   - {{ TF }} {#tf}

     {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

   {% endlist %}

1. [Delete](../../vpc/operations/address-delete.md) the cluster public static IP address if you reserved one.
1. [Delete the disk snapshot](../../compute/operations/snapshot-control/delete.md).
