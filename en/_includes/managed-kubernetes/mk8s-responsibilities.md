# Zones of control between the {{ managed-k8s-full-name }} users and {{ yandex-cloud }}

The shared responsibility model for {{ managed-k8s-name }} in {{ yandex-cloud }} splits the zones of control between the cloud provider and the user.

## {{ yandex-cloud }} control zone {#yandex-cloud-responsibility}

The {{ yandex-cloud }} control zone covers:

* [Managed control plane](#master-nodes)
* [Backup and recovery](#backup-restore)
* [Cluster maintenance](#maintenance)
* [Cluster infrastructure](#infrastructure)
* [System plugins](#system-plugins)

### Managed control plane {#master-nodes}

{{ yandex-cloud }} manages all control plane components in {{ k8s }} and ensures they work correctly. This enables the claimed functionality:

* Fault-tolerant cluster or control plane components if selecting the **Highly available** [master type](../../managed-kubernetes/concepts/index.md#master) with hosts across three availability zones.
* Automatic or user-initiated updates of control plane components if new versions are out.
* Monitoring of control plane components and response to {{ managed-k8s-name }} cluster alerts related to control plane level issues.
* Collection and storage of control plane logs when the **Write logs** setting is on.

{% note info %}

The user cannot modify the control plane component configuration directly. The extent of influence on configuration is limited to the options available when [creating](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) or [updating a cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-update.md). For example, the user can enable [workload identity federation integration](../../managed-kubernetes/tutorials/wlif-managed-k8s-integration.md) at the {{ managed-k8s-name }} cluster level.

{% endnote %}

[More on {{ k8s }} control plane components](https://kubernetes.io/docs/concepts/architecture/#control-plane-components).

### Backup and recovery {#backup-restore}

{{ yandex-cloud }} provides etcd monitoring, backup, and recovery.

### Cluster maintenance {#maintenance}

{{ yandex-cloud }} issues security updates for:

* Control plane components.
* Operating systems of master and node VMs when vulnerabilities are detected.
* System components on nodes.

### Cluster infrastructure {#infrastructure}

{{ yandex-cloud }} manages the following cluster infrastructure components:

* **Network**: {{ yandex-cloud }} provides [{{ network-load-balancer-full-name }}](../../managed-kubernetes/nlb-ref/index.md) creation, configuration, and deletion using the `LoadBalancer` type `Service` object.

* **Storage**: {{ yandex-cloud }} creates, configures, connects to pods, and deletes {{ yandex-cloud }} network disks using the `PersistentVolume` objects.

* **System components on nodes**: {{ yandex-cloud }} installs the following components on [nodes](../../managed-kubernetes/concepts/index.md#node-group):

   * `kubelet` and, optionally, `kube-proxy`.
   * Container runtime.
   * CNI network plugins, such as Calico or Cilium.
   * CSI drivers for cloud storage integration.
   * Guest OS (Ubuntu).

* **Computing and network infrastructure of virtual machines**: {{ yandex-cloud }} provides a VM infrastructure for the master and nodes.

* **Integration with other {{ yandex-cloud }} services**: There is interaction with [{{ iam-full-name }}](../../iam/index.yaml), [{{ vpc-full-name }}](../../vpc/index.yaml), and [{{ container-registry-full-name }}](../../container-registry/index.yaml), with encryption via [{{ kms-full-name }}](../../kms/index.yaml).

### System plugins {#system-plugins}

{% note info %}

The user cannot modify or delete system plugins.

{% endnote %}

{{ managed-k8s-name }} uses the following system plugins managed by {{ yandex-cloud }}:

* **csi-driver**: A `DaemonSet` resource deployed on all cluster nodes to enable [csi-driver](https://kubernetes-csi.github.io/docs/csi-driver-object.html).
* **[kube-proxy](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-proxy/)**: Maintains network rules on nodes. These rules allow network communication with pods both from inside and from outside the cluster.
* **[coreDNS](https://coredns.io/)**: Primary DNS server responsible for name resolution inside the {{ k8s }} cluster.
* **[cilium](https://cilium.io/)**: A [network policy](../../managed-kubernetes/concepts/network-policy.md) manager. It includes `cilium-cni`, `cilium-agent`, `cilium-operator`, and `hubble`. When deployed, replaces `kube-proxy`.
* **[cluster-autoscaler](https://github.com/kubernetes/autoscaler/tree/master/cluster-autoscaler)**: A node group [autoscaling](../../managed-kubernetes/concepts/autoscale.md#ca) manager.
* **[metrics-server](https://github.com/kubernetes-sigs/metrics-server)**: Collects resource (CPU, RAM) utilization metrics from nodes, pods, and, to a limited extent, masters.
* **node-problem-detector**: Detects and reports cluster node issues.
* **nvidia-device-plugin**: Enables cluster nodes to automatically allocate and manage GPUs for containerized applications.
* **ip-masq-agent**: Manages [IP masquerading](../../managed-kubernetes/concepts/index.md#pod-ip-masquerade) in the cluster for containers to communicate with external services, and cluster nodes to access external IP addresses.
* **metadata-server**: A `DaemonSet` resource you install on all cluster nodes for automatic exchange of the {{ k8s }} [service account](../../managed-kubernetes/concepts/index.md#service-accounts) JWT for the IAM token of the cloud service account.
* **bindings**: Roles for the system components of the cluster.

{% note info %}

The list of system plugins can be revised and expanded.

{% endnote %}

## {{ yandex-cloud }} customer control zone {#client-responsibility}

The {{ yandex-cloud }} customer control zone covers:

* [Cluster configuration](#cluster-config)
* [Cluster resources](#node-groups-config)
* [Configurable resources](#configured-resources)
* [Access management](#access-control)
* [Cluster performance analysis](#cluster-monitoring)
* [Self-managed software version upgrades](#software-updates)

### Cluster configuration {#cluster-config}

The user controls the cluster configuration, which comprises the following:

* Master host arrangement, i.e., basic or highly available master (in the same or different availability zones).
* {{ k8s }} version for the master and [release channel](../../managed-kubernetes/concepts/release-channels-and-updates.md).
* Network configuration (network, subnets, public IP address, security groups, network policies, tunnel mode, etc.).
* Service accounts with relevant permissions for resources and nodes.
* [Encryption keys](../../managed-kubernetes/concepts/encryption.md).
* [Master computing resources](../../managed-kubernetes/concepts/index.md#master-resources) (platform type, vCPUs, RAM).
* Cluster [update window](../../managed-kubernetes/operations/update-kubernetes.md) setup.
* Activation of control plane logging: [audit logs](../../managed-kubernetes/at-ref.md), [cluster autoscaler](../../managed-kubernetes/concepts/autoscale.md) logs, event logs, {{ k8s }} API server logs.

   {% note info %}

   If the user does not activate the delivery of control plane cluster logs to {{ cloud-logging-name }} or {{ at-name }}, service-side log storage will be subject to the following time and size limits in case of incidents or other events:

   * Audit logs are kept for a maximum of five days or until they reach 5 GB.
   * Other system logs are kept for a maximum of one day or until they reach 7 GB.

   {% endnote %}

### Cluster resources {#node-groups-config}

The user controls the configuration and content of the nodes:

* Node computing resources (platform type, vCPUs, RAM, disk type and size, etc.).
* Network configuration (public address, security groups, subnets, and availability zones).
* Scaling settings for node groups.
* {{ k8s }} version for node groups.
* Installing additional packages or agents.
* Setting up node access (SSH and [OS Login](../../organization/concepts/os-login.md)).
* Setting up metadata, `sysctl` variables, etc.
* Setting up the node group update window.

{% note warning %}

Users have full access to the {{ managed-k8s-name }} cluster nodes and can modify system components, packages, and their configurations. This may lead to unpredictable behavior and disrupt node operation. We do not recommend making such modifications for node groups.

{% endnote %}

### Configurable resources {#configured-resources}

The user can manage the following resources:

* Configuration of some plugins: Users can modify the `ConfigMap` resources in the **ip-masq-agent** and **coreDNS** plugins.

* Applications:

   * Deployment of objects like `Deployment`, `StatefulSet`, `DaemonSet`, etc., in {{ k8s }} clusters.
   * Ingress controller management, e.g., [NGINX Ingress](https://kubernetes.github.io/ingress-nginx/).

* Data:

   * Backup of application data ([Persistent Volumes](../../managed-kubernetes/concepts/volume.md#persistent-volume)).
   * Application-level [encryption of secrets](../../managed-kubernetes/concepts/encryption.md#k8s-secrets-encryption) and data.

### Access management {#access-control}

The user can manage access using {{ k8s }} RBAC:

* Configure `ServiceAccounts`, `ClusterRoles`, and other {{ k8s }} objects.
* Manage cluster access permissions.

### Cluster performance analysis {#cluster-monitoring}

The user can use the monitoring and logging functionality to analyze cluster performance:

* Configure alerts for application metrics.
* Analyze pod logs using [Fluent Bit](../../managed-kubernetes/operations/applications/fluentbit.md) or third-party tools.

### Self-managed software version upgrades {#software-updates}

The user can:

* Upgrade node groups to new minor {{ k8s }} versions supported by {{ managed-k8s-name }}, e.g., from 1.32 to 1.33.
* Monitor application-level cluster vulnerabilities, including:

   * Scan and update container images of user applications.
   * Fix vulnerabilities in user code and dependencies.
   * Apply pod security policies or equivalents to limit pod privileges.
