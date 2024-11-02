# 9. Security {{ k8s }}


#### Introduction {#intro}

[{{ managed-k8s-full-name }}](../../../managed-kubernetes/index.yaml) provides an environment for managing containerized applications in the {{ yandex-cloud }} infrastructure. Deploy, scale, and manage applications in containers using {{ k8s }}.

The user is responsible for all actions made inside the {{ k8s }} node. The user is responsible for the security of the nodes and their proper setup in accordance with PCI DSS requirements and other security standards.

{{ yandex-cloud }} is responsible for the {{ k8s }} API security.

The user is responsible for correctly choosing security settings in {{ managed-k8s-name }}, including selecting the [channel](../../../managed-kubernetes/concepts/release-channels-and-updates.md) and the update schedule.

#### 9.1 The use of sensitive data is limited {#not-use-critical-data}

To comply with PCI DSS or other security standards when using {{ managed-k8s-name }}, do not:

* Use sensitive data in names and descriptions of clusters, node groups, namespaces, services, and pods.
* Use sensitive data in [{{ k8s }}](../../../managed-kubernetes/concepts/index.md#node-labels) node labels and [{{ yandex-cloud }}](../../../resource-manager/concepts/labels.md) service resource labels.
* Use sensitive data in pod manifests.
* Use sensitive data in etcd in clear text.
* Write sensitive data to {{ managed-k8s-name }} logs.

{% list tabs group=instructions %}

- Manual check {#manual}

  * Make sure that names and descriptions of clusters, node groups, namespaces, services, and pods contain no sensitive data.
  * Check configuration files for critical data.

- Performing a check in the management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where your {{ managed-k8s-name }} instance is located.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Make sure that [{{ k8s }} node labels](../../../managed-kubernetes/concepts/index.md#node-labels) and [{{ yandex-cloud }} service resource labels](../../../resource-manager/concepts/labels.md) contain no sensitive data.

{% endlist %}

**Guides and solutions to use**:

Manually edit the names or contents of manifests and other configuration files if they use sensitive data.

#### 9.2 Resources are isolated from each other {#maximum-isolation}

Wherever possible, ensure maximum isolation between resources:

* Use a separate organization for each "big" project.
* Use a separate cloud for each development team.
* Use a separate {{ k8s }} cluster located in a separate folder for each service.
* Use a separate namespace for each microservice.
* Your clouds must have no shared resources. Cloud members must have access only to their clouds.

Less strict isolation models are also possible, e.g., where:

* Projects are deployed in different clouds.
* Development teams use independent folders.
* Services have separate {{ k8s }} clusters.
* Microservices use different namespaces.

{% list tabs group=instructions %}

- Manual check {#manual}

  Wherever possible, ensure maximum isolation between resources.

{% endlist %}

#### 9.3 There is no access to the {{ k8s }} API and node groups from untrusted networks {#api-security}

We do not recommend granting access to the {{ k8s }} API and node groups from non-trusted networks, e.g., from the internet. Use firewall protection where needed (for example, [security groups](../../../vpc/concepts/security-groups.md)).

**Guides and solutions to use**:

* [Guide on creating a cluster without internet access](../../../managed-kubernetes/tutorials/k8s-cluster-with-no-internet.md).
* [Security group setup guide](../../../managed-kubernetes/operations/connect/security-groups.md).
* Use network policy configuration tools via the [Calico](../../../managed-kubernetes/concepts/network-policy.md#calico) (basic) or [Cilium CNI](../../../managed-kubernetes/concepts/network-policy.md#cilium) (advanced) plugins in {{ yandex-cloud }}. By default, apply the `default deny` rules for incoming and outgoing traffic with only the relevant traffic allowed.
* For online endpoints, allocate an independent {{ k8s }} cluster or independent node groups (using such mechanisms as [Taints and Tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/#:~:text=Node%20affinity%20is%20a%20property,onto%20nodes%20with%20matching%20taints) + [Node affinity](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/)). By doing this, you establish a DMZ so that if your nodes are compromised online, your attack surface is small.
* To enable incoming network access to your workloads via HTTP/HTTPS, use the [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/) resource. There are at least two Ingress controller options that you can use in {{ yandex-cloud }}:

  * [NGINX Ingress Controller](../../../managed-kubernetes/tutorials/ingress-cert-manager.md).
  * [Application Load Balancer of an Ingress controller](../../../application-load-balancer/tools/k8s-ingress-controller/index.md).

#### 9.4 Authentication and access management are configured in {{ managed-k8s-name }} {#kubernetes-auth}

For the {{ k8s }} cluster to run, you need two service accounts: [the service account of the cluster and the service account of the node group](../../../managed-kubernetes/security/index.md#sa-annotation). The access of IAM accounts to {{ managed-k8s-name }} resources is managed at the following levels:

* {{ managed-k8s-name }} service roles (access to the {{ yandex-cloud }} API): These enable you to control clusters and node groups (for example, create a cluster, create/edit/delete a node group, and so on).
* Service roles to access the {{ k8s }} API: These let you control cluster resources via the {{ k8s }} API (for example, perform standard actions with {{ k8s }}: create, delete, view namespaces, work with pods, deployments, create roles, and so on). Only the basic global roles at the cluster level are available: `k8s.cluster-api.cluster-admin`, `k8s.cluster-api.editor`, and `k8s.cluster-api.viewer`.
* Primitive roles: These are global primitive IAM roles that include service roles (e.g., the primitive `admin` role includes both the service administration role and the administrative role to access the {{ k8s }} API).
* Standard {{ k8s }} roles: Inside the {{ k8s }} cluster itself, you can use {{ k8s }} tools to create both regular roles and cluster roles. Thus you can manage access for IAM accounts at the namespace level. To assign IAM roles at the namespace level, you can manually create RoleBinding objects in a relevant namespace stating the cloud user's IAM ID in the **subjects name** field.

{% list tabs group=instructions %}

- Manual check {#manual}

  Make sure the above recommendations are met.

{% endlist %}

#### 9.5 {{ managed-k8s-name }} uses a safe configuration {#kubernetes-safe-config}

In {{ managed-k8s-name }}, the user is fully in control of all node group settings, but only partially in control of the [master](../../../managed-kubernetes/concepts/index.md#master) settings. The user is responsible for the whole cluster's security.

The [CIS {{ k8s }} Benchmark](https://www.cisecurity.org/benchmark/kubernetes) standard is designed to build a secure {{ k8s }} configuration, including node configurations. In {{ yandex-cloud }}, the {{ k8s }} node groups are deployed by default with the configuration that complies with CIS {{ k8s }} Benchmark.

{% list tabs group=instructions %}

- Manual check {#manual}

  * Using the [kube-bench](https://github.com/aquasecurity/kube-bench) tool, check whether the node group configuration is compliant with CIS {{ k8s }} Benchmark. The tool officially supports the {{ yandex-cloud }} node groups.
  * [Starboard Operator](https://blog.aquasec.com/automate-kubernetes-compliance) is a free tool that helps you automate scanning of images for vulnerabilities and checking that the configuration is compliant with CIS {{ k8s }} Benchmark. Starboard Operator supports integration with kube-bench and is used for its automatic startup.

{% endlist %}

#### 9.6 Data encryption and {{ managed-k8s-name }} secret management are done in _ESO as a Service_ format {#data-encryption}

At the {{ k8s }} etcd level, encrypt secrets using an in-built [mechanism from {{ yandex-cloud }}](../../../managed-kubernetes/concepts/encryption.md).

We recommend that you use SecretManager solutions to work with {{ k8s }} secrets. [{{ lockbox-name }}](../../../lockbox/index.yaml) is such a solution in {{ yandex-cloud }}.

 {{ lockbox-name }} was integrated with {{ k8s }} using the [External Secrets](https://external-secrets.io/latest/) open-source project. In {{ marketplace-name }}, the solution is available in the basic simplified scenario: [External Secrets Operator with {{ lockbox-name }} support](/marketplace/products/yc/external-secrets).

The most secure recommended option for encrypting secrets is ESO as a Service (External Secrets Operator as a service). When using ESO, the global administrator has access to the namespace where ESO is installed, and administrators of individual namespaces create their own [SecretStore](https://external-secrets.io/latest/api/secretstore/) objects (where they specify IAM-authorized access keys for their {{ lockbox-short-name }} secrets). If this SecretStore object is compromised, only the authorized key of one specific namespace is compromised (rather than all of them, as in the case of Shared ClusterSecretStore).

**Guides and solutions to use**:

* [Guide on working with External Secrets and {{ lockbox-name }} from the project description](https://external-secrets.io/latest/provider/yandex-lockbox/).
* [Guide on working with External Secrets and {{ lockbox-name }} from the {{ yandex-cloud }} documentation](https://yandex.cloud/ru/docs/lockbox/tutorials/kubernetes-lockbox-secrets).

#### 9.7 Docker images are stored in a {{ container-registry-name }} registry configured for regular image scanning {#docker-images-periodic-scan}

To ensure effective security, we recommend using [{{ container-registry-name }}](../../../container-registry/index.yaml) to store Docker images to be deployed in {{ managed-k8s-name }}. This allows you to quickly respond to new vulnerabilities in images using built-in recurrent vulnerability scanning.

You should perform vulnerability scanning at least once a week. This will help you detect and eliminate vulnerabilities in images in a timely manner, which significantly reduces risks of unauthorized access to your resources and increases security level of your infrastructure.

Using {{ container-registry-name }} to store images will also provide centralized image version control for simpler updates and security management.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the registry with Docker images belongs to.
  1. Select the appropriate registry in **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Go to the **{{ ui-key.yacloud.cr.registry.label_vulnerabilities-scanner }}** tab and click **{{ ui-key.yacloud.cr.registry.button_change-scan-settings }}**.
  1. Make sure that scheduled Docker image scans are enabled with a frequency of at least once a week.

{% endlist %}

**Guides and solutions to use**:

* [Guide on scheduled scanning of Docker images](../../../container-registry/operations/scanning-docker-image.md#scheduled).

#### 9.8 One of the three latest {{ k8s }} versions is used with update monitoring {#version-update}

For {{ k8s }}, both automatic and manual updates are available for [clusters](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster) and [node groups](../../../managed-kubernetes/concepts/index.md#node-group). You can request a manual update of the {{ k8s }} cluster or its nodes to the latest supported [version](../../../managed-kubernetes/concepts/release-channels-and-updates.md) at any time. Manual updates bypass any configured maintenance windows and maintenance exceptions. {{ k8s }} issues updates in a regular manner. To meet the Information Security standards:

* Select a relevant update channel and enable either automatic installation of updates, or manual installation immediately after publication in the selected channel.
* Double-check that the ad settings meet the Information Security standards.
* Use one of the three latest {{ k8s }} versions, because updates (including security updates) are only released for these versions.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  To get a list of available versions for a {{ k8s }} cluster:
  1. Go to the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Click the name of the {{ k8s }} cluster.
  1. Click **{{ ui-key.yacloud.common.edit }}** in the top-right corner.
  1. View the list of available versions in the **{{ ui-key.yacloud.k8s.clusters.create.field_master-version }}** field under **{{ ui-key.yacloud.k8s.clusters.create.section_main-cluster }}**.

  To get a list of available versions for a {{ k8s }} node group:
  1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Click the name of the {{ k8s }} cluster you need and go to the **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}** tab.
  1. Select the {{ k8s }} node group from the list and click **{{ ui-key.yacloud.common.edit }}** in the top-right corner.
  1. Get a list of available versions in the **{{ ui-key.yacloud.k8s.node-groups.create.field_node-version }}** field.

- Performing a check via the CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  To get a list of available versions, run the following command:

  ```bash
  yc managed-kubernetes list-versions
  ```

- Performing a check via the API {#api}

  To get a list of available versions, use the [list](../../../managed-kubernetes/managed-kubernetes/api-ref/Version/list.md).

{% endlist %}

**Guides and solutions to use**:

* [Guide on how to update a cluster automatically](../../../managed-kubernetes/operations/update-kubernetes.md#cluster-upgrade).
* [Guide on how to update a cluster manually](../../../managed-kubernetes/operations/update-kubernetes.md#cluster-manual-upgrade).

#### 9.9 Backup is configured {#backup}

To ensure continuous operation and data protection, we recommend using backups in {{ managed-k8s-name }}. With backups, you can quickly recover the service without experiencing any data or time loss in the wake of a malfunction or accident. Data in [{{ k8s }}](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster) clusters is securely stored and replicated within the {{ yandex-cloud }} infrastructure. However, you can back up data from [{{ k8s }} cluster node groups](../../../managed-kubernetes/concepts/index.md#node-group) at any time and store them in [{{ objstorage-full-name }}](../../../storage/index.yaml) or other types of storage.

{% list tabs group=instructions %}

- Manual check {#manual}

  Make sure that you have backups of your data from node groups of {{ k8s }} clusters.

{% endlist %}

**Guides and solutions to use**:

You can create backups of {{ k8s }} cluster node group data using the [Velero](https://velero.io/) tool. It supports working with {{ yandex-cloud }} [disks](../../../compute/concepts/disk.md) using the {{ k8s }} CSI driver and helps create [snapshots of disks and volumes](../../../compute/concepts/snapshot.md).

When working with Velero that is installed manually, you can use [nfs](https://kubernetes.io/docs/concepts/storage/volumes/#nfs), [emptyDir](https://kubernetes.io/docs/concepts/storage/volumes/#emptydir), [local](https://kubernetes.io/docs/concepts/storage/volumes/#local), or any other type of volumes without built-in support for snapshots. To use such a volume type, install Velero with the [restic plugin](https://velero.io/docs/v1.8/restic/). Velero installed from [{{ marketplace-name }}](/marketplace/products/yc/velero-yc-csi) does not include the restic plugin.

* [Guide on {{ k8s }} cluster backup in {{ objstorage-name }}](../../../managed-kubernetes/tutorials/kubernetes-backup.md#backup).

#### 9.10 Check lists are in place for security when creating and using Docker images {#check-list}

Secure Docker image creation and operation practices ensure protection against potential vulnerabilities, malware, and unauthorized access to data. They ensure image integrity and security compliance while also preventing potential threats coming from its deployment in the infrastructure. Use these check lists to meet requirements for secure creation of images:

* [Dockerfile best practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/).
* [{{ k8s }} Security Checklist and Requirements](https://github.com/Vinum-Security/kubernetes-security-checklist/blob/main/README.md).

You can control Dockerfile in your [CI/CD](/blog/posts/2022/10/ci-cd) pipeline using the [Conftest](https://www.conftest.dev/) utility.

When using minimal images or distroless images without a shell, we recommend using [ephemeral containers](https://kubernetes.io/docs/concepts/workloads/pods/ephemeral-containers/).

{% list tabs group=instructions %}

- Manual check {#manual}

  Make sure you have the check lists in place to meet the requirements for secure creation of images.

{% endlist %}

#### 9.11 The {{ k8s }} security policy is in place {#security-standards}

The requirements listed in [{{ k8s }} Pod Security Standards](https://kubernetes.io/docs/concepts/security/pod-security-standards/) allow you to prevent threats related to {{ k8s }} objects, such as unauthorized access to confidential data and execution of malicious code.

These requirements allow you to ensure security and reliability of applications in a {{ k8s }} cluster. To achieve compliance, you can either use the built-in {{ k8s }} tool called [Pod Security Admission Controller](https://kubernetes.io/docs/setup/best-practices/enforcing-pod-security-standards/) or open-source software, e.g., [OPA Gatekeeper](https://github.com/open-policy-agent/gatekeeper) or [Kyverno](/marketplace/products/yc/kyverno).

{% list tabs group=instructions %}

- Manual check {#manual}

  Verify compliance with the {{ k8s }} Pod Security Standards.

{% endlist %}

**Guides and solutions to use**:

* You can also use the following tools within [CI/CD](/blog/posts/2022/10/ci-cd) to monitor compliance with the Pod Security Standards:

  * [Kyverno CLI](https://kyverno.io/docs/kyverno-cli/)
  * The gator CLI

* [Kubesec](https://kubesec.io/)

#### 9.12 Audit log collection is set up for incident investigation {#audit-logs}

Events available to the user in the {{ managed-k8s-name }} service can be classified as levels:

* {{ k8s }} API events ({{ k8s }} audit logging)
* {{ k8s }} node events
* {{ k8s }} pod events
* {{ k8s }} metrics
* {{ k8s }} flow logs

For more information about setting up audit event logging at various levels, see [{#T}](../../../security/domains/kubernetes.md#collection-monitoring-analysis-audit-logs).

In {{ managed-k8s-name }}, you can audit the current role model used in the service. To do this, open the {{ k8s }} cluster page in the [management console]({{ link-console-main }}), and go to the **{{ ui-key.yacloud.k8s.access.label_title }}** tab.

You can also use:

* [KubiScan](https://github.com/cyberark/KubiScan)
* [Krane](https://github.com/appvia/krane)
* {{ at-full-name }} [events](../../../managed-kubernetes/at-ref.md)

{% list tabs group=instructions %}

- Manual check {#manual}

  Make sure that audit logs are being collected.

{% endlist %}

