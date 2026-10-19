---
title: Migrating from a public cloud to {{ managed-k8s-name }}
description: Guide on migrating {{ k8s }} workloads from a public cloud to {{ managed-k8s-name }}.
---

# Migrating from a public cloud to {{ managed-k8s-name }}

This guide explains how to migrate {{ k8s }} workloads from a managed service of another cloud provider to {{ managed-k8s-name }}.

The key strategy is to migrate step by step while keeping both the source and target clusters running in parallel. This minimizes the impact on production services and ensures a safe rollback path.

To migrate workloads to {{ managed-k8s-name }}:

1. [Develop a migration plan](#inventory).
1. [Set up your {{ yandex-cloud }} infrastructure](#infrastructure).
1. [Migrate container images](#images).
1. [Migrate stateful workloads](#stateful).
1. [Migrate stateless workloads](#stateless).
1. [Configure the load balancers and update your DNS records](#dns).
1. [Complete your migration](#finalization).


## Required paid resources {#paid-resources}

* {{ managed-k8s-name }} master (see [{{ managed-k8s-name }} pricing](../../../managed-kubernetes/pricing.md)).
* {{ managed-k8s-name }} cluster nodes: use of computing resources and storage (see [{{ compute-full-name }} pricing](../../../compute/pricing.md)).
* Public IP addresses for the {{ managed-k8s-name }} cluster's master and nodes with public access enabled (see [{{ vpc-full-name }} pricing](../../../vpc/pricing.md#prices-public-ip)).
* Each active L7 load balancer, if using the Gwin controller: use of computing resources (see [{{ alb-name }} pricing](../../../application-load-balancer/pricing.md)).
* Each network load balancer, if using the `LoadBalancer` service type: incoming and outgoing traffic processed by the load balancer (see [{{ network-load-balancer-full-name }} pricing](../../../network-load-balancer/pricing.md)).
* {{ container-registry-name }}: storage of migrated Docker images (see [{{ container-registry-name }} pricing](../../../container-registry/pricing.md)).
* {{ objstorage-name }} bucket: use of storage, data operations (see [{{ objstorage-full-name }} pricing](../../../storage/pricing.md)).
* {{ data-transfer-name }} transfers, if migrating managed databases (see [{{ data-transfer-full-name }} pricing](../../../data-transfer/pricing.md)).


## Getting started {#before-you-begin}

{% include [before-you-begin](../../../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Develop a migration plan {#inventory}

Before the migration, make sure to inventory your workloads and assess the compatibility between the source and target clusters. This helps you estimate migration complexity, map out the order in which to migrate your services, and develop a rollback plan in case of critical issues.

### Inventory your workloads {#workloads-inventory}

Get a list of source cluster resources for all namespaces: applications, versions, dependencies, and network rules. Review the full migration plan in advance to understand in what order you need to move your resources.

Make sure that all stateful workloads, including managed databases and StatefulSets with PersistentVolumes, have up-to-date backups.

Run this command to get a full list of your source cluster resources:

```bash
for ns in $(kubectl get ns --no-headers -o custom-columns=':metadata.name'); do
  echo "=== Namespace: $ns ==="
  kubectl get deploy,sts,ds,job,cronjob,svc,ingress,pvc,cm,secret,hpa,pdb -n $ns
done
```

Inventory checklist:

#|
|| **Resource** | **Details to collect** ||
|| Deployments, StatefulSets, DaemonSets, Jobs, CronJobs | Quantity, namespace, images ||
|| PersistentVolumeClaim | Size, StorageClass, access mode (RWO/RWX) ||
|| LoadBalancer-type services | External IPs, DNS names ||
|| Ingress / HTTPRoute | Hosts, TLS, IngressClass, or GatewayClass ||
|| ConfigMap and Secret | List ||
|| CustomResourceDefinitions and Operators | List of installed CRDs and operators ||
|#

### Assess compatibility {#compatibility-assessment}

To make sure your cluster components work correctly after the migration, assess their compatibility with the target cluster in advance. Create a list of changes you need to make to the manifests and plan how to replace incompatible source cluster components with their {{ yandex-cloud }} alternatives.

The scope of changes depends on the version gap between the source and target {{ k8s }} clusters. The wider the gap, the more changes you need to make, as both vendor-specific CRDs and standard {{ k8s }} API groups may differ. For supported versions, see [Support for {{ k8s }} versions](../../concepts/k8s-supported-versions.md).

{% note tip %}

Run the `kubectl api-resources` command on both the source and target clusters to compare API resources, or use the [kube-no-trouble (kubent)](https://github.com/doitintl/kube-no-trouble) utility to check manifest compatibility.

{% endnote %}

Key considerations to keep in mind:

* Check for vendor-specific CRDs in the source cluster that may not be available in {{ yandex-cloud }}. Replace the components with [{{ yandex-cloud }} services]({{ link-cloud-services }}) or [solutions from {{ marketplace-full-name }}](../../operations/applications/marketplace.md).
* Note that PodSecurityPolicy is removed in {{ k8s }} versions 1.25 and up. If using PodSecurityPolicy in the source cluster, [migrate to PodSecurity Admission](https://kubernetes.io/docs/tasks/configure-pod-container/migrate-from-psp).
* Replace the storage classes (`storageClassName`) in your manifests with those [supported in {{ managed-k8s-name }}](../../operations/volumes/manage-storage-class.md).
* We recommend using the [Gwin controller](../../alb-ref/gwin-index.md) for L7 load balancing.

### Develop the service migration plan {#planning}

Decide on the order for migrating your services: start with the least critical ones and finish with production workloads. To redirect traffic, use a zero-downtime [blue-green deployment](https://martinfowler.com/bliki/BlueGreenDeployment.html) strategy or a phased transition with a maintenance window.

Key considerations to keep in mind:

* Perform an end-to-end migration in a staging environment before migrating production workloads.
* Develop a rollback plan for critical issues and align it with your team in advance.
* Work closely with development and support teams at all stages.
* Choose off-peak hours to perform the migration.
* Monitor metrics before, during, and after the migration using [{{ monitoring-full-name }}](../../../monitoring/index.yaml).

## Set up your {{ yandex-cloud }} infrastructure {#infrastructure}

Prepare the target environment in {{ yandex-cloud }} for your workloads.

### Configure access and permissions {#access-and-permissions}

[Create service accounts](../../../iam/operations/sa/create.md) to manage cluster resources and worker nodes, and [assign roles to them](../../../iam/operations/sa/assign-role-for-sa.md).

{% cut "Roles you may need" %}

To manage the cluster:

* `k8s.clusters.agent`.
* `k8s.tunnelClusters.agent` instead of `k8s.clusters.agent`, if creating the cluster in tunneling mode.

Learn more about [roles in {{ managed-k8s-name }}](../../security/index.md).

To manage network resources:

* `vpc.publicAdmin`.
* `vpc.privateAdmin`.
* `vpc.user`.
* `vpc.bridgeAdmin` if the VPC resides in a different folder.

Learn more about [roles in {{ vpc-short-name }}](../../../vpc/security/index.md).

To work with images:

* `container-registry.images.puller`.
* `cloud-registry.artifacts.puller` if using {{ cloud-registry-name }} as an alternative to {{ container-registry-short-name }}.

Learn more about [roles in {{ container-registry-short-name }}](../../../container-registry/security/index.md) and [{{ cloud-registry-name }} roles](../../../cloud-registry/security/index.md).

If using secret encryption:

* `kms.keys.encrypterDecrypter`

Learn more about [roles in {{ kms-short-name }}](../../../kms/security/index.md).

If using {{ objstorage-short-name }} for backups:

* `storage.editor`

Learn more about [roles in {{ objstorage-short-name }}](../../../storage/security/index.md).

{% endcut %}

### Set up the network infrastructure {#network-infrastructure}

Set up a network infrastructure for the cluster: an isolated network with security rules for all types of cluster traffic:

1. Create a [VPC](../../../vpc/operations/network-create.md) and [subnets](../../../vpc/operations/subnet-create.md) in three zones to ensure high availability.
1. Create [security groups](../../operations/connect/security-groups.md) to isolate cluster traffic, node traffic, and inbound connections. You must create [five groups](../../operations/connect/security-groups.md#apply) in total.

### Create a {{ managed-k8s-name }} cluster {#cluster}

1. [Create](../../operations/kubernetes-cluster/kubernetes-cluster-create.md) a {{ managed-k8s-name }} cluster. Use the same {{ k8s }} version as in your source cluster or higher.
1. [Create a node group](../../operations/node-group/node-group-create.md) in each availability zone.

## Migrate container images {#images}

[Move container images](../../../container-registry/operations/docker-image/docker-image-push.md) to {{ container-registry-full-name }} one by one, keeping their tags and metadata.

You can also use [{{ cloud-registry-full-name }}](../../../cloud-registry/index.yaml) as an alternative storage for images. Unlike {{ container-registry-full-name }}, {{ cloud-registry-name }} supports not only Docker images but other artifact types as well.

## Migrate stateful workloads {#stateful}

Migrating stateful workloads, such as managed databases and StatefulSets with PersistentVolumes, is the most complex step of the migration. They store data and cannot be recreated with zero data loss.

{% note warning %}

Make sure that all stateful workloads, including managed databases and StatefulSets with PersistentVolumes, have up-to-date backups.

{% endnote %}

### Migrate managed databases {#managed-databases}

Use [{{ data-transfer-full-name }}](../../../data-transfer/index.yaml) to migrate managed databases. [{{ data-transfer-full-name }}](../../../data-transfer/index.yaml) allows you to migrate data while keeping your source online and minimizing the downtime of applications using the source.

Use the [transfer matrix](../../../data-transfer/transfer-matrix.md) to check that the [{{ dt-type-copy-repl }}](../../../data-transfer/concepts/transfer-lifecycle.md#copy-and-replication) transfer type is supported for your source and target, then refer to [your database guide](../../../data-transfer/tutorials/index.md#migration) to complete the migration.

{% note info %}

Make sure that {{ data-transfer-name }} has network access to the source database. For the current {{ data-transfer-name }} IP address ranges, see the [relevant guide](../../../data-transfer/concepts/network.md#source-external).

{% endnote %}

If {{ data-transfer-name }} does not support your source or you need more control, refer to your target database guides.

### Migrate StatefulSets with PersistentVolumes {#statefulsets-persistent-volumes}

To migrate StatefulSets with PersistentVolumes, use [Velero](https://velero.io/) with file system backups via `node-agent` (formerly kopia). This method works with any PVCs regardless of your CSI provider.

{% note tip %}

If you have less than 50 GB of data or cannot use Velero, you can migrate data manually via `rsync`. This requires direct network connectivity between your clusters.

{% endnote %}

Proceed as follows:

1. Create a bucket in [{{ objstorage-full-name }}](../../../storage/index.yaml) to store backups.

1. Create a file named `credentials-velero` containing the [static access key data](../../../iam/operations/authentication/manage-access-keys.md#create-access-key) for the [service account](../../../iam/operations/sa/create.md) that has access to the bucket:

   ```
   [default]
   aws_access_key_id = <key_ID>
   aws_secret_access_key = <secret_key>
   ```
   
1. [Install the Velero CLI](https://velero.io/docs/main/basic-install/) on the machine you will use to perform the migration. It must have `kubectl` access to the source and target clusters.

   {% note tip %}

   The `velero-plugin-for-aws` plugin version in the commands below may be outdated. For the latest version, refer to [this Velero article](https://velero.io/docs/main/supported-providers/).

   {% endnote %}

1. Install Velero in the source cluster:

   1. Make sure the source cluster context is active:

      ```bash
      kubectl config current-context
      ```

   1. Create a namespace for Velero:

      ```bash
      kubectl create namespace velero
      ```

   1. Install Velero:

      ```bash
      velero install \
        --provider aws \
        --plugins velero/velero-plugin-for-aws:v1.14.0 \
        --bucket <bucket_name> \
        --secret-file ./credentials-velero \
        --backup-location-config \
          region=ru-central1,s3ForcePathStyle=true,s3Url=https://storage.yandexcloud.net \
        --use-volume-snapshots=false \
        --use-node-agent \
        --uploader-type=kopia
      ```

      Where:

      * `--provider aws`: Uses an AWS plugin compatible with {{ objstorage-name }}.
      * `--use-node-agent`: Enables DaemonSet to perform file system backups.
      * `--uploader-type=kopia`: Recommended uploader, works faster than restic.
      * `--use-volume-snapshots=false`: Disables CSI snapshots to transfer data via kopia.

   1. Check component status:

      ```bash
      kubectl get pods -n velero
      kubectl get backupstoragelocation -n velero
      velero backup-location get
      ```

      `BackupStorageLocation` must switch to `Available`.

1. Create a backup of the required namespaces:

   ```bash
   velero backup create migration-backup \
     --include-namespaces <namespace> \
     --default-volumes-to-fs-backup \
     --wait
   ```

   You can check the status and logs using the following commands:

   ```bash
   velero backup describe migration-backup --details
   velero backup logs migration-backup
   ```

1. Install Velero in the target {{ managed-k8s-name }} cluster:

   1. Switch to the target cluster context:

      ```bash
      kubectl config use-context <target_cluster_context>
      ```

   1. Create a namespace for Velero:

      ```bash
      kubectl create namespace velero
      ```

   1. Install Velero with the same parameters as in the source cluster, specifying the same bucket:

      ```bash
      velero install \
        --provider aws \
        --plugins velero/velero-plugin-for-aws:v1.14.0 \
        --bucket <bucket_name> \
        --secret-file ./credentials-velero \
        --backup-location-config \
          region=ru-central1,s3ForcePathStyle=true,s3Url=https://storage.yandexcloud.net \
        --use-volume-snapshots=false \
        --use-node-agent \
        --uploader-type=kopia
      ```

   1. Confirm that the backup from the source cluster is visible in the target cluster:

      ```bash
      kubectl get pods -n velero
      velero backup-location get
      velero backup get
      ```

      `BackupStorageLocation` must switch to `Available`, and the `migration-backup`, to `Completed`.

1. Restore data from the backup:

   ```bash
   velero restore create \
     --from-backup migration-backup \
     --wait
   ```

   You can check the status and logs using the following commands:

   ```bash
   velero restore describe migration-backup --details
   velero restore logs migration-backup
   ```

   {% note tip %}

   If the StorageClass names in the source cluster and {{ managed-k8s-name }} cluster do not match, create a ConfigMap with the StorageClass mapping before initiating recovery:

   ```yaml
   apiVersion: v1
   kind: ConfigMap
   metadata:
     name: change-storage-class-config
     namespace: velero
     labels:
       velero.io/plugin-config: ""
       velero.io/change-storage-class: RestoreItemAction
   data:
     <source_storage_class>: yc-network-ssd
   ```

   {% endnote %}

## Migrate stateless workloads {#stateless}

To migrate stateless workloads, export your source cluster manifests, update them for {{ yandex-cloud }}, and apply to the target cluster.

Checklist for updating manifests:

* Replace vendor-specific CRDs with [{{ yandex-cloud }} services]({{ link-cloud-services }}) or [solutions from {{ marketplace-full-name }}](../../operations/applications/marketplace.md).
* For any deprecated `apiVersion`, update the version to make it compatible with the target Kubernetes version.
* Use the [Gwin controller](../../alb-ref/gwin-index.md) (`gwin-default`) in `ingressClassName` and `gatewayClassName`.
* Replace resource annotations used for configuring the load balancer with [{{ yandex-cloud }} annotations](../../alb-ref/index.md).
* Make sure image links lead to {{ container-registry-full-name }} (`cr.yandex/<id>/...`).

You can use [kubectl-neat](https://github.com/itaysk/kubectl-neat) to clean up manifests.

## Configure the load balancers and update your DNS records {#dns}

Reroute traffic to the new cluster.

{{ managed-k8s-name }} supports two load balancing methods:

* [Gwin](../../alb-ref/gwin-index.md).
* Network Load Balancer: Created automatically for a service of the `LoadBalancer` type.

Steps to switch traffic:

1. Deploy Gateway or Ingress resources in the {{ managed-k8s-name }} cluster.
1. Get the external IP addresses of the new load balancers.
1. Test your services using temporary DNS records.
1. Reduce the TTL of production DNS records in advance, then update them incrementally.
1. Monitor DNS propagation and TLS certificate updates.

{% note tip %}

If you face critical issues after updating DNS records, go back to using the old IP addresses. The source cluster must remain operational until all TTLs expire and you confirm a successful migration.

{% endnote %}

## Complete your migration {#finalization}

Take final steps and optimize your configuration:

1. Make sure all services work correctly in {{ managed-k8s-name }}.
1. Check metrics and performance in [{{ monitoring-full-name }}](../../../monitoring/index.yaml).
1. Disable your source cloud resources after confirming stable operation.
1. Optimize the cluster configuration to match your actual workload.
1. Delete temporary resources: the Velero bucket, {{ data-transfer-name }} pipelines, VPN tunnels, and temporary login credentials.
