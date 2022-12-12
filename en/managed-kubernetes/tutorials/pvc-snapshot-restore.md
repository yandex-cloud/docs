# Working with snapshots

{{ managed-k8s-name }} supports [snapshots](https://kubernetes.io/docs/concepts/storage/volume-snapshots/) that represent a point-in-time copy of a [PersistentVolume](../concepts/volume.md#provisioning-volumes).

To create a snapshot and then restore it:
1. [{#T}](#create-pvc-pod).
1. [{#T}](#create-snapshot).
1. [{#T}](#restore-from-snapshot).

If you no longer need these resources, [delete them](#clear-out).

## Before you begin {#before-you-begin}

1. Create {{ k8s }} resources:

   {% list tabs %}

   - Manually

     [Create a {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) and a [node group](../../managed-kubernetes/operations/node-group/node-group-create.md) in any suitable configuration with {{ k8s }} version 1.20 or higher.

   - Using {{ TF }}

     1. If you don't have {{ TF }}, [install it](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
     1. Download [the file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
     1. Download the cluster configuration file [k8s-cluster.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/managed-kubernetes/k8s-cluster.tf) to the same working directory. The file describes:
        * Network.
        * Subnet.
        * Default security group and rules needed to run the cluster:
          * Rules for service traffic.
          * Rules for accessing the {{ k8s }} API and managing the cluster with `kubectl` (through ports 443 and 6443).
        * {{ managed-k8s-name }} cluster.
        * Service account required to create a {{ managed-k8s-name }} cluster and node group.
     1. Specify the [folder ID](../../resource-manager/operations/folder/get-id.md) in the configuration file:
     1. Run the `terraform init` command in the directory with the configuration files. This command initializes the provider specified in the configuration files and enables you to use the provider resources and data sources.
     1. Make sure the {{ TF }} configuration files are correct using the command:

        ```bash
        terraform validate
        ```

        If there are errors in the configuration files, {{ TF }} will point to them.
     1. Create the required infrastructure:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

  {% endlist %}

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

## Prepare a test environment {#create-pvc-pod}

To test snapshots, a [PersistentVolumeClaim](../concepts/volume.md#persistent-volume) and [pod](../concepts/index.md#pod) are created to simulate the workload.
1. Create a file named `01-pvc.yaml` with the `PersistentVolumeClaim` manifest:

   {% if product == "yandex-cloud" %}

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

   {% endif %}

   {% if product == "cloud-il" %}

   ```yaml
   ---
   apiVersion: v1
   kind: PersistentVolumeClaim
   metadata:
     name: pvc-dynamic
   spec:
     accessModes:
       - ReadWriteOnce
     storageClassName: yc-network-ssd
     resources:
       requests:
         storage: 5Gi
   ```

   {% endif %}

1. Create a `PersistentVolumeClaim`:

   ```bash
   kubectl apply -f 01-pvc.yaml
   ```

1. Make sure that the `PersistentVolumeClaim` is created and its status is `Pending`:

   ```bash
   kubectl get pvc pvc-dynamic
   ```

1. Create a file named `02-pod.yaml` with the `pod-source` manifest:

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

1. Make sure the date and time are written to the `/data/out.txt` file. For this, [run the command](https://kubernetes.io/docs/tasks/debug-application-cluster/get-shell-running-container/) on the pod:

   ```bash
   kubectl exec pod -- tail /data/out.txt
   ```

   Result:

   ```text
   Thu Feb 3 04:55:21 UTC 2022
   Thu Feb 3 04:55:26 UTC 2022
   ...
   ```

## Create a snapshot {#create-snapshot}

1. Create a file named `03-snapshot.yaml` with the [snapshot](https://kubernetes.io/docs/concepts/storage/volume-snapshots/#volumesnapshots) manifest:

   ```yaml
   ---
   apiVersion: snapshot.storage.k8s.io/v1beta1
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

1. Make sure the snapshot is created:

   ```bash
   kubectl get volumesnapshots.snapshot.storage.k8s.io
   ```

1. Make sure the [VolumeSnapshotContent](https://kubernetes.io/docs/concepts/storage/volume-snapshots/#introduction) is created:

   ```bash
   kubectl get volumesnapshotcontents.snapshot.storage.k8s.io
   ```

## Restore objects from the snapshot {#restore-from-snapshot}

When [restoring objects from the snapshot](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#volume-snapshot-and-restore-volume-from-snapshot-support) the following are created in the cluster:
* A `PersistentVolumeClaim` object named `pvc-restore`.
* A pod named `pod-restore` with entries in the `/data/out.txt` file.

To restore the snapshot:
1. Create a file named `04-restore-snapshot.yaml` with a manifest of a new `PersistentVolumeClaim`:

   {% if product == "yandex-cloud" %}

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

   {% endif %}

   {% if product == "cloud-il" %}

   ```yaml
   ---
   apiVersion: v1
   kind: PersistentVolumeClaim
   metadata:
     name: pvc-restore
   spec:
     storageClassName: yc-network-ssd
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

   {% endif %}

   {% note tip %}

   You can change the size of the `PersistentVolumeClaim` being created. To do this, specify the desired size in the `spec.resources.requests.storage` setting value.

   {% endnote %}

1. Create a new `PersistentVolumeClaim`:

   ```bash
   kubectl apply -f 04-restore-snapshot.yaml
   ```

1. Make sure that the `PersistentVolumeClaim` is created and its status is `Pending`:

   ```bash
   kubectl get pvc pvc-restore
   ```

1. Create a file named `05-pod-restore.yaml` with a manifest of a new `pod-restore` pod:

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

   The new pod container won't perform any actions with the `/data/out.txt` file.

1. Create a pod named `pod-restore`:

   ```bash
   kubectl apply -f 05-pod-restore.yaml
   ```

1. Make sure the pod status changed to `Running`:

   ```bash
   kubectl get pod pod-restore
   ```

1. Make sure that the new `PersistentVolumeClaim` switched to the `Bound` status:

   ```bash
   kubectl get pvc pvc-restore
   ```

1. Make sure the `/data/out.txt` file on the new pod contains records that the `pod-source` pod container [added to the file](#create-pvc-pod) before creating the snapshot:

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

If you no longer need these resources, delete them:
1. Delete a {{ managed-k8s-name }} cluster:

   {% list tabs %}

   - Manually

     [Delete the {{ managed-k8s-name }} cluster](../operations/kubernetes-cluster/kubernetes-cluster-delete.md).

   - Using {{ TF }}

     1. In the command line, go to the folder with the current {{ TF }} configuration file with an infrastructure plan.
     1. Delete resources using the command:

        ```bash
        terraform destroy
        ```

        {% note alert %}

        {{ TF }} will delete all the resources that you created using it, such as clusters, networks, subnets, and VMs.

        {% endnote %}

     1. Confirm the deletion of resources.

  {% endlist %}

1. If you reserved a public static IP address for the cluster, [delete it](../../vpc/operations/address-delete.md).
1. [Delete the disk snapshot](../../compute/operations/snapshot-control/delete.md).