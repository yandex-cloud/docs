# What's new in {{ stackland-name }} 26.2.1

{{ stackland-name }} 26.2.1 introduces cluster scaling, the {{ ai-studio-name }} component, and a new ingress controller named Contour.

## New features

### Scaling a cluster

Added support for adding and deleting nodes in an already installed {{ stackland-name }} cluster. For more information, see [{#T}](operations/cluster/scale-cluster.md).

### {{ ai-studio-name }}

Added the {{ ai-studio-name }} component that includes the [{{ model-gallery-name }}](concepts/components/overview.md#model-gallery) and [{{ agent-atelier-name }}](concepts/components/overview.md#agent-atelier) modules.

### Contour ingress controller

Added a new ingress controller, Contour, to replace older `ingress-nginx`. Please note the following:

* The `ingress-nginx` controller is no longer supported and will be fully removed in {{ stackland-name }} 27.
* In fresh installations of {{ stackland-name }} 26.2.1, both system and custom ingresses use the new Contour-based implementation.
* When upgrading to {{ stackland-name }} 26.2.1, existing custom ingress controllers based on the old implementation remain unchanged, while system ingress controllers migrate to Contour.
* Users planning to upgrade to {{ stackland-name }} 27 must proactively schedule migration of their custom ingresses to Contour. For more information, see [{#T}](operations/cluster/upgrade-cluster.md).

## Fixed issues

### Cluster installation and update

* Fixed a deadlock scenario where installation over an ongoing upgrade would freeze at the Cilium readiness stage.
* Restored support for the `available` image set: `sladm` now checks for the `full` image set in the registry and falls back to pulling `minimal` if missing the required images.
* Fixed image validation when working with TLS-enabled container registries: `sladm` now correctly provides TLS options to the Docker client.
* Resolved a potential air-gapped environment upgrade failure due to missing required images.
* Fixed the issue causing a cluster upgrade task to crash with the `bundle "ytsaurus" references unknown component(s): ytsaurus` error.
* Accelerated cluster recovery after node reboots.
* Fixed a startup failure affecting the `iam-uber` init-container following node reboot.

### {{ mch-name }}

* Automatic {{ CH }} parameter configuration now respects individual shard resources, ensuring correct behavior in heterogeneous clusters.
* The `ClickhouseBackup` finalizer is now properly freed up if S3 credentials are already absent during namespace deletion, thus preventing deletion freezes.

### {{ yt-name }}

* The container image registry for job environments and pause containers can now be overridden via `YTsaurusConfig`, now that `ImagePullBackOff` errors in custom registries have been resolved.
* The {{ yt-name }} image registry host is now dynamically injected during reconciliation, eliminating `ImagePullBackOff` errors in production clusters.

### {{ iam-name }}

* Fixed an infinite reconciliation loop in `AccessBinding`.
* Fixed a folder deletion issue in {{ iam-name }} during project resource cleanup.
* Fixed the `get-tree` method in resource-manager.
* Increased the YDB query limit for the `iam-role-list` method.

### Monitoring and logging

* Increased the Prometheus resources for stable operation under load.
* Reduced the default Prometheus disk size.
* {{ grafana-name }} now uses `prometheus.stackland.svc.cluster.local`, a stable DNS alias, instead of direct Thanos Query access.
* Added explicit mounting of the Thanos Object Storage secret into the `thanos-sidecar` container, resolving secret access issues in certain configurations.
* {{ grafana-name }} image version is now dynamically pulled from the component registry, preventing version desynchronization.
* Fixed a re-login issue in {{ grafana-name }} after session expiration.
* Added a network policy for the `logging` component to restrict Loki access exclusively through the proxy; fixed the {{ grafana-name }} OAuth client for {{ iam-name }} refresh-token policies.

### {{ objstorage-name }}

* Migrated the {{ objstorage-name }} dashboard to Thanos Querier, so now it correctly displays object sizes and counts.

### Interface

* Fixed access errors during bucket deletion, with deletion now possible even without read permissions.
* Improved the user password update form.
* {{ mtr-name }} access rules now use a card-based layout instead of tables, improving readability.
* The `sinceSeconds` parameter in the pod log filter is now correctly provided to the Kubernetes API: the invalid `-1` value is no longer sent.
* The stuck operations panel now displays in the correct color.

# What's new in {{ stackland-name }} 26.2.0

{{ stackland-name }} version 26.2.0 introduces new components for data analytics: {{ yt-name }}, {{ mtr-name }}, and {{ rest-catalog-name }}. It also offers more options for declarative user and database management in {{ mpg-name }} and {{ mch-name }}.

## Important updates

* Added the {{ yt-name }} component, a distributed platform for big data storage and processing.
* Added the {{ mtr-name }} component, a distributed SQL engine for analytical queries.
* Added the {{ rest-catalog-name }} component, a REST metadata catalog for Apache Iceberg tables.

## New features

### {{ yt-name }}

Added the {{ yt-name }} component, a platform for big data storage and distributed processing. It is configured via the custom `YTsaurusConfig` resource and offers the following features:

* Deployment of a single YTsaurus cluster with automatic subcomponent management.
* Web interface and HTTP proxy for cluster access.
* User authentication via {{ iam-name }}.
* Cluster state monitoring using {{ grafana-name }} dashboards.

### {{ mtr-name }}

Added the {{ mtr-name }} component, a distributed SQL engine for analytical queries to data from various sources. Main features:

* Ability to create Trino clusters with coordinators and workers via the custom `TrinoCluster` resource.
* Catalogs for data sources such as {{ PG }}, {{ CH }}, and Apache Iceberg.
* Support for both external S3 storage and native {{ objstorage-name }} for Iceberg catalogs.
* Ability to configure folder access rules.

### {{ rest-catalog-name }}

Added the {{ rest-catalog-name }} component, a REST metadata catalog for Apache Iceberg tables, compatible with the Iceberg REST Catalog API. Main features:

* Catalog management via the custom `RestCatalog` resource.
* Catalog user management via the custom `RestCatalogPrincipal` resource with OAuth2 credentials.
* Access control through user groups and catalog roles.

### {{ mpg-name }}: User and database management.

Added declarative management of users and databases via custom Kubernetes resources:

* `PostgresqlRole`: Managing users and their permissions. Supports generated passwords or passwords from secrets.
* `PostgresqlDatabase`: Managing databases, schemas, and locale providers: `libc`, `ICU`, and `builtin`.

### {{ mch-name }}: Managing users, roles, and databases.

Added declarative management of users, roles, and databases via custom Kubernetes resources:

* `ClickhouseDatabase`: Managing databases.
* `ClickhouseRole`: Managing roles with multiple privileges; the guides provide examples for the `reader` and `writer` roles.
* `ClickhouseUser`: Managing users with passwords stored in secrets.

### {{ mch-name }}: Automatic storage expansion

Added the ability to automatically increase disk space for {{ mch-name }} clusters when a specified usage threshold is reached. This is configured in the `autoScaling` section of the custom `ClickhouseCluster` resource:

* `enabled`: Enabling autoscaling.
* `maxSize`: Maximum storage size.
* `standardIncreasePercent`: Increment size for storage expansion.
* `resizeTriggerPercent`: Threshold to trigger expansion.
* `readOnlyTriggerPercent`: Threshold to switch the cluster to read-only mode.

### Installing {{ stackland-name }} on {{ baremetal-full-name }} via PXE

Added guides for installing {{ stackland-name }} on {{ baremetal-full-name }} servers using PXE boot.

### Installing {{ stackland-name }} on {{ yandex-cloud }} VMs

Added guides for installing {{ stackland-name }} on {{ compute-full-name }} VMs.

## Improvements

### Cluster upgrade

Updated the cluster upgrade form interface in the management console.

### Guides

* Added a guide for {{ yt-name }}.
* Added a guide for {{ mtr-name }}.
* Added a guide for {{ rest-catalog-name }}.
* Added sections on user and database management in {{ mpg-name }}.
* Added sections on user, role, and database management in {{ mch-name }}.
* Added a description of automatic storage expansion for {{ mch-name }}.
* Added new Secrets Store guides: described injection into ConfigMap, environment variables, and troubleshooting.
* Added guides for PXE installation on {{ baremetal-full-name }}.
* Added guides for installation on {{ yandex-cloud }} VMs.
* Added a page on Secrets Store troubleshooting.

## Fixed issues

### Cluster installation and update

* `sladm` now synchronizes `PlatformEnvironment` IP addresses when cluster size changes.
* Restored correct `endpointURL` behavior at the end of installation.
* Fixed `endpointURL` in the custom kubeconfig file.
* `sladm` now starts the kubelet only after images are loaded, preventing race conditions on node startup.
* Images are pushed to the local registry upon `sladm` restart.
* Fixed stale node detection during cluster upgrades.
* Improved TCP keepalive parameters in the Talos client.
* Refined preflight disk checks in `sladm`.
* Fixed CNI validation during upgrades.
* Host configuration is now stored using custom `StacklandHostConfig` resources.

### Component platform

* Migrated component resources from `corev1.ResourceRequirements` to `v1alpha1.ResourceRequirements`, with unified resource specification formats.
* Added {{ objstorage-name }} namespaces to the list of system namespaces, protecting them from accidental deletion.

### {{ iam-name }}

* Fixed the slow appearance of the folder-id annotation.
* Asynchronous folder deletion in {{ iam-name }} now works correctly.
* Fixed the removal of the service account finalizer when the namespace is in `Terminating` status.
* Multiple CRDs (`AccessBinding`, `ClusterAccessBinding`, `ProjectAccessBinding`, and `GizmoAccessBinding`) are now correctly unified into a single {{ iam-name }} `AccessBinding`.
* A dedicated `GizmoAccessBinding` is now used for the OAuth token exchange role, resolving naming conflicts with custom resources.
* Cluster access binding names now follow this template: `stackland-<chart_name>-<short_role>`.
* Removed an excessive default `iam-api` ingress.
* `iam-uber` now recovers from error states after node reboot.
* Fixed the {{ iam-name }} endpoint in the management console.

### Projects

* Fixed the deletion of `ProjectNamespace` and its associated namespace when manually removed via `kubectl`.
* Fixed namespace disappearance when toggling the `ownedByNamespace` flag and deleting a PNS.
* Prohibited using `project` as a project name.
* Fixed overflow in the `managed-by` field length.

### {{ mch-name }}

* Increased `max_concurrent_queries` for small clusters.
* Set default resources for sidecar containers.
* Restored the ability to delete a cluster without the superuser secret.
* Fixed Kyverno checks for {{ CH }} and Keeper installation.
* Removed an excessive port of the `accesscontroller` sidecar.
* Resolved cleanup errors when deleting a cluster, with excessive Jobs now removed properly.
* Consolidated {{ CH }} dashboards; fixed the backup dashboard.

### {{ mpg-name }}

* Raised the WAL-G operator limits that were previously too low.
* Fixed a {{ PG }} version labeling issue in images where those with tags 15 and 16 actually contained PostgreSQL 17. The actual database version remains unchanged. If your manifests specify version 15 or 16, update it to 17. For more information, see [{#T}](concepts/components/postgresql.md#pg-image-version).

### {{ datalens-name }}

* You now see a correctly displayed error when an access key's service accounts do not match.
* Removed deprecated `api-key-*` secret keys.
* The default configuration is one {{ PG }} instance for GA.

### {{ speechsense-name }}

* Fixed the password generator.
* Fixed bucket name generation when using external S3.

### Monitoring and logging

* Reduced `kube-state-metrics` memory usage, eliminating OOM crashes.
* Fixed the `retentionSize` configuration for Prometheus.
* Restored the HWM disabling feature.
* Updated default system metric alerts to working condition.
* {{ grafana-name }} now uses the correct Loki application version.
* Loki is sourced locally, with no external application download required.

### Interface

* Sanitized {{ CH }} resource names to comply with RFC 1123.
* Fixed WebSocket idle timeout in pod terminal.
* Expanded RBAC permissions for launching pod shell terminals to cover the required scope.
* `OwnerReference` on {{ CH }} user secrets is now set correctly.
* Restored shard override flags in the {{ CH }} cluster edit form.
* The {{ PG }} cluster creation form now correctly provides the `fromBackup` parameter.
* The backup creation button is now hidden for clusters without backup configuration.
* Restored the `withHeader` parameter in the S3 object table.
* Improved object sorting in buckets and refined S3 bucket tips and UX elements.
* The redirect after bucket editing now leads to the detail page, not the bucket list.
* The issuer URL validator error now displays a clear message.
* Revised the {{ rest-catalog-name }} catalog form validation for improved consistency.
* Fixed validation and saving issues in {{ rest-catalog-name }} and {{ mtr-name }} forms.
* Fixed handling of an unbounded `sinceSeconds` value in the pod log filter.
* In namespace forms, fixed texts and validation.
* The `scheduledBackupEnabled` toggle now works correctly for {{ PG }} clusters.
* The cluster creation form no longer leaves an orphaned superuser secret on failure.
* Improved Auth-UI error handling and localized messages.
* Updated the Kubeconfig page and refined texts in project and namespace forms.
* Unified breadcrumbs, `namespace-not-found` redirects, the favorites provider, and the project path/name display logic.

# What's new in {{ stackland-name }} 26.1.5

{{ stackland-name }} version 26.1.5 has fixed cluster installation and upgrade issues related to Talos release images and OS version checks.

## Fixed issues

### Cluster installation and update

Fixed Talos version check during update: `sladm` now compares the full version string, including Stackland kernel build, to correctly identify obsolete nodes.

# What's new in {{ stackland-name }} 26.1.4

Updated the base Talos build in {{ stackland-name }} 26.1.4.

## Improvements

### Cluster installation and update

Uses Linux kernel `6.12.85‑lvc19` with a fix for vulnerability CVE‑2026‑31431 (Copy Fail).

# What's new in {{ stackland-name }} 26.1.3

{{ stackland-name }} version 26.1.3 features improved cluster installation and upgrade stability, interface updates, and fixes in managed database services.

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
