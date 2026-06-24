# What's new in {{ stackland-name }} 26.1.5

{{ stackland-name }} version 26.1.5 has fixed installation and cluster update issues related to Talos release images and OS version checks.

## Fixed issues

### Cluster installation and update

Fixed Talos version check during update: `sladm` now compares the full version string, including Stackland kernel build, to correctly identify obsolete nodes.

# What's new in {{ stackland-name }} 26.1.4

Updated the base Talos build in {{ stackland-name }} 26.1.4.

## Improvements

### Cluster installation and update

Uses Linux kernel `6.12.85‑lvc19` with a fix for vulnerability CVE‑2026‑31431 (Copy Fail).

# What's new in {{ stackland-name }} 26.1.3

{{ stackland-name }} version 26.1.3 features improved cluster installation and update stability, interface updates, and fixes in managed database services.

## Improvements

### {{ mpg-name }}

* Added support for {{ PG }} for 1C versions, which are now available in the cluster creation form.
* Unified the backup management interface between cluster creation and editing forms: the backup, schedule, and retention period toggles now work in the same way.
* In the cluster view form, the backup settings fields are read-only.
* Set resource requests and limits for {{ PG }} cluster containers.

### {{ mkf-name }}

Set resource requests and limits for UserOperator, TopicOperator, CruiseControl, and Exporter containers.

### {{ mch-name }}

Set default resources for sidecar containers.

### Cluster installation and update

* Disk checks now recognize that some block devices are LVM volumes and look for the total size of data disks, not that of each individual disk. For control-plane nodes, no total data disk size checks are performed.
* The update process uses local registry-based extension images instead of re-downloading them from an external registry.
* Migrated cluster host configuration to a new custom resource named `StacklandHostConfig`.

## Fixed issues

### Security

Further restricted the use of Pod Security Admission labels on namespaces: now the action is allowed only to cluster administrators.

### Projects

Fixed deletion of `ProjectNamespace` and the associated folder in {{ iam-name }} when deleting a namespace created manually via `kubectl`.

### Cluster installation and update

* Fixed Talos installation freeze when adding nodes to a baremetal cluster due to "half-open" TCP connections after node reboot.
* Fixed an intermittent cluster deployment fault at the node update stage (`Upgrade failed: system is still outdated`).
* Improved reconciliation error processing in `sladm`: reconciliation is no longer interrupted on recoverable errors.

### {{ mpg-name }}

* Fixed the superuser secret name in the Performance Diagnostics configuration.
* Fixed a port conflict between backup sidecars and Performance Diagnostics: now both functions can be used simultaneously.
* Fixed the resumption of the backup schedule when the schedule is returned to the cluster specification.
* Fixed the `fromBackup` parameter in the cluster creation form when restoring from a backup.
* Fixed the processing of the backup schedule toggle in the cluster creation form.
* Updated the `cloudnative-pg` and `pg-perfdiag` images.

### {{ mch-name }}

* Fixed the resumption of the backup schedule when the schedule is returned to the cluster specification.
* Removed an excessive port of the `accesscontroller` sidecar container.

# What's new in {{ stackland-name }} 26.1.0

In version 26.1.0, {{ stackland-name }} enters the [General Availability](https://yandex.cloud/en/docs/overview/concepts/launch-stages) stage. We introduced new features and improvements that make the platform more user friendly and versatile.

## Important updates

* Added support for projects, i.e., logical resource organization units that help you manage namespaces, access, and quotas at the team or application level.
* Added the {{ datalens-name }} component for data visualization and analysis.
* Added the {{ speechsense-name }} component for voice and text communication analysis.
* Integrated {{ objstorage-full-name }}. Renamed `yandex-object-storage` to `storage`.
* Implemented updating an existing cluster.
* Implemented automatic creation of storage classes based on disk type (HDD, SSD, NVMe, other). All disks other than the installation ones get added to one of the classes and become available for data storage right after {{ stackland-name }} is installed.
* Changed the configuration installation file format.
* Upgraded the {{ nvidia }} driver to version 580.126.

## New features

### {{ iam-name }}: support for Active Directory

Added support for syncing Active Directory users and groups. Main features:

* Automatic creation of a user pool when setting up syncing.
* LDAPS support for secure connections to domain controller.
* Setting up user and group attribute mapping.
* Behavior management when deleting an AD user: blocking or deleting.

### {{ mpg-name }}: performance diagnostics

Implemented performance diagnostics for {{ mpg-name }} clusters. The feature collects and analyzes the performance statistics of your SQL queries and sessions. Its data is visualized on a {{ grafana-name }} dashboard.

### {{ datalens-name }}

Added the {{ datalens-name }} component for data visualization and analysis. Use it to create interactive dashboards and reports, connect to various data sources, and share your findings with your team.

### {{ speechsense-name }}

Added the {{ speechsense-name }} component for voice and text communication analysis. The component allows you to process conversations in audio and text formats for QoS assessment and debottlenecking.

### Cluster upgrade

The UI got a cluster upgrade form where you can select a version from the list of available releases. Added the `sladm validate` command to pre-check the configuration before an installation or upgrade. This command validates the configuration file and checks the nodes for availability. The installation of the cluster will not begin if it certain to fail.

## Improvements

### UI improvements

* The component management dialogs got meaningful names (displayName) instead of internal IDs.
* Added a feature for returning to the last viewed project.
* Added the pop-up window to confirm a logout.
* Added the projectMember access level.
* Blocked deletion of projects in _terminating_ status.
* Improved validation of the project creation form.
* Updated the Kubeconfig page theme.

### Guides

* Added the _Projects_ and _Resource model_ section to the concepts.
* Added a guide for {{ speechsense-name }}.
* Added a guide for {{ datalens-name }}.
* Added a guide on disk subsystem and its diagnostics.
* Added a guide on upgrading a cluster.
* Added a guide on {{ mpg-name }} performance diagnostics.
* Expanded guides on projects related to namespace management, roles, quotas.
* Updated the quick start section.
* Updated the _Access management_ section.

## Fixed issues

* Fixed the issue with AccessService cache in {{ iam-name }} when creating or updating OAuthClient.
* Fixed the sidecar manager's scope of monitoring in {{ mch-name }}. Now only the current cluster's pods are monitored.
* Fixed access permissions for the sidecar service account in {{ mch-name }}.
* Fixed the display of {{ objstorage-name }} name in the UI.
* Fixed the default storage class configuration in {{ mch-name }} manifests.
* Fixed the processing of blank values in numeric fields of UI forms.
* Changed the wording and validation in the project creation form.

# What's new in {{ stackland-name }} 0.5.0

{{ stackland-name }} 0.5.0 introduces new features and improvements that make the platform more user friendly and versatile.

## New features

{% note info %}

Installation may now take longer due to the large size of {{ stackland-name }} 0.5.0 components. We recommend increasing the default timeout in `sladm` to three hours by adding the `--installation-timeout 3h` key.

{% endnote %}

{% note warning %}

Before installation, remove LVM partitions on data storage disks. Use a command in this format:

```
nvme format -s 1 --force /dev/nvme0n1
```

{% endnote %}

### {{ gpu-operator }}

Added the {{ gpu-operator }} component, a tool that manages your GPU resources in a {{ stackland-name }} cluster. It automates deployment and configuration of {{ nvidia }} drivers, device plugins, and other components for GPU provisioning. Added Grafana dashboards for monitoring of GPU resources.

### {{ iam-name }}

Added the {{ iam-name }} component, which is a system for centralized management of users, groups, and access permissions. Its main features include:

* SAML federation support.
* AWS-compatible AccessKeys for software access to services.
* OAuth clients for integration with applications.
* {{ grafana-name }} integration with {{ iam-name }} OAuth for a single authentication point.

## Improvements

### Deletion protection

Added protection against accidental deletion for database clusters and resources:

* {{ mpg-name }} clusters
* {{ mkf-name }} clusters and topics
* {{ mch-name }} clusters

### {{ mch-name }}

* Added the autotuner for automatic optimization of cluster settings.
* Implemented storage availability checks before creating or deleting backups.

### {{ mkf-name }}

Simplified ACL role selection in the user creation and editing form.

### {{ mpg-name }}

Improved the UX of the dialog with cluster connection info.

### UI improvements

* Added the ability to adjust column width in tables.
* Component deactivation is now blocked if there are active resources.
* Improved the deletion confirmation dialog.
* Added a table for {{ iam-name }} group members.
* On the Policy Manager page, added the **Mutes** and **Reports** tab.

## Fixed issues

* Fixed the issue with the internal FQDN for {{ mch-name }}.
* Fixed name length validation of {{ mch-name }} clusters when restoring them from a backup.
* Fixed the critical IPv6 address handling error.
* Fixed the issue when deleting an iptables rule of a local VMware registry.
* Fixed the compatibility issue that made it impossible to deploy Cilium on certain ESXi / NSX configurations.

# What's new in {{ stackland-name }} 0.4

{{ stackland-name }} 0.4 introduces new features and improvements that make the platform more user friendly and versatile.

## New features

### {{ mch-name }}

Added the {{ mch-name }} component, a managed service for working with an open-source column-oriented {{ CH }} DBMS. It simplifies database cluster deployment and upgrades, ensures fault tolerance through replication and sharding, and provides tools for backup and monitoring. With {{ mch-name }}, you can create and restore cluster using the `ClickhouseCluster` custom resource, take one-off backups using the `ClickhouseBackup` custom resource, configure data replication between hosts to ensure high availability, and use sharding for horizontal scaling and load distribution.

### Policy Manager

* Added the Policy Manager component, a tool to check Kubernetes resources for compliance with security policies. The tool generates reports in OpenReports format. Policy Manager supports two policy presets: _baseline_, which is the basic Kubernetes security standard for pods, and _restricted_, which is the secure standard for critical applications. You can select a default cluster policy preset using the `PolicyManagerConfig` custom resource or activate an additional preset using the `ClusterPolicySet` resource. To temporarily or permanently disable violation notifications for certain policies, use the `ClusterPolicyMute` resource.
* Implemented the Policy Manager GUI which enables you to view reports, select policy presets to be used, use the interactive YAML editor, configure mutes and their duration.
* Optimized state handling and resource status updates in Policy Manager to improve performance and reduce cluster load.
* Updated the policy-reporter version, a component collecting and displaying policy violation reports.

### Hardware monitoring

Added a module for monitoring cluster hardware state. The module collects data from kernel logs, sysfs, and SMART data from drives. For hardware state metrics and notifications, see the **Hardware Monitoring** Grafana dashboard.

## Improvements

### Stackland Diagnostic Tool

Added the ability to collect information about the following entities:

* storageClass
* ingressClass
* clusterIssuer
* PVC
* statefulset
* ingress
* cert-manager certificates (without secrets)
* Webhook configurations

### Databases

* Added default resources for {{ mch-name }}, which automatically apply when you create a cluster.
* Added default resources for {{ mpg-name }} clusters and connection poolers.
* Fixed infinite reconciliation of the {{ mpg-name }} component.

### Message broker

Added default resources for {{ mkf-name }}, which automatically apply when you create a cluster.

## Fixed issues

* Fixed the issue with the internal FQDN for {{ mch-name }}.
* Improved {{ mpg-name }} status handling to prevent excessive update operations.
* Fixed a bug where refresh tokens expired prematurely, requiring frequent kubeconfig updates.
* Multiple minor fixes and improvements.

# What's new in {{ stackland-name }} 0.3

{{ stackland-name }} 0.3 introduces new features and improvements that make the platform more user friendly and versatile.

## Important updates

* Updated the Managed PostgreSQL specification. Use the examples from the current version of our guides.

## New features

* Added the {{ mkf-name }} component. It enables creating message queues for data exchange between services.
* Introduced the `combined` server role. It combines the `control-plane` and `worker` functions, reducing the minimum size of a fault-tolerant cluster to just three servers.
* Support for servers with a single disk for the `control-plane` role is now available. It is convenient for working with small clusters.
* Point-in-time recovery is now supported for the PostgreSQL clusters. The cluster now can be recovered from a specific moment in the past.

## Improvements

* Optimized naming system for platform components.
* New Grafana dashboards for Storage and Object Storage.

### UI improvements

* Added **Role bindings** and **Cluster role bindings** to the **Access management** section.
* New **Replicas**, **DaemonSets**, and **CronJobs** tabs in the **Workload** section.
* Implemented timeline filtering in the **System dashboard** section.
* You can now add projects to your favorites.
* You can select the UI language.
* The UI now displays information about the PostgreSQL cluster fault tolerance.

## Fixed issues

* Implemented static file compression, reducing the first load time by 0.3-0.4 seconds.
* Fixed the key name display on the overview page.
* Improved the error message display: now you will see a clear message when you try to create an access key without any buckets.
* Fixed the error where trying to delete a non-empty bucket incorrectly displayed a message about successful deletion.
