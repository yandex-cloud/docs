#### What services are available in {{ managed-k8s-name }} clusters by default? {#defaults}

The following services are available by default:
* [Metrics Server](https://github.com/kubernetes-sigs/metrics-server) for aggregating data on resource usage in a [{{ k8s }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster).
* [{{ k8s }} plugin for CoreDNS](https://coredns.io/plugins/kubernetes/) for name resolution in a cluster.
* [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) supporting [CSI plugins](https://github.com/container-storage-interface/spec) to work with [persistent volumes](../../managed-kubernetes/concepts/volume.md) (`PersistentVolume`).

#### Which {{ k8s }} CLI (kubectl) version do I need to install for comprehensive cluster management? {#kubectl-version}

We recommend using the latest official version of [kubectl]({{ k8s-docs }}/tasks/tools/install-kubectl/) to avoid compatibility issues.

#### Can {{ yandex-cloud }} restore the health of my cluster if I configure it incorrectly? {#tech-support-cases}

The [master](../../managed-kubernetes/concepts/index.md#master) is fully managed by {{ yandex-cloud }}, so you cannot damage it. If you have issues with {{ k8s }} cluster components, contact [support]({{ link-console-support }}).

#### Who will be monitoring the cluster health? {#health-check}

{{ yandex-cloud }}. We will monitor your cluster for corrupted file system, kernel deadlock, lost internet connection, and {{ k8s }} component issues. We are also developing a solution to automatically restore faulty components.

#### How quickly does {{ yandex-cloud }} address vulnerabilities discovered in the security system? What should I do if an attacker has taken advantage of a vulnerability and my data is compromised? {#security-updates}

{{ yandex-cloud }} services, images and master configuration undergo [various security and compliance checks](../../security) from the start.

Users can set the [update frequency](../../managed-kubernetes/concepts/release-channels-and-updates.md#updates) depending on their workloads and cluster configuration. It is important to consider attack vectors and the vulnerabilities of applications deployed in the {{ k8s }} cluster. Such factors as [network security policies](../../managed-kubernetes/concepts/network-policy.md) between applications, Docker container vulnerabilities, and improper container runtime configuration in the cluster may affect application security.

#### Can I connect to a cluster node via {{ oslogin }}, similar to a {{ yandex-cloud }} VM? {#connect-via-oslogin}

Yes, you can. To do this, [follow this guide](../../managed-kubernetes/operations/node-connect-oslogin.md).
