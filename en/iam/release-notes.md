---
title: '{{ iam-full-name }} release notes'
description: This section contains the {{ iam-name }} release notes.
---

# {{ iam-full-name }} release notes

## May 2026 {#may-2026}

### {{ iam-name }} updates {#iam-may-2026}

* Added new [API key scopes](concepts/authorization/api-key.md#scoped-api-keys): to work with {{ cloud-registry-full-name }} and to run workflows in {{ sw-name }}.
* Updated [access policy](concepts/access-control/access-policies.md) templates: replaced the `serverless.restrictPrivateNetworkInvocation` and `serverless.restrictPublicInvocation` shared templates with separate templates for {{ serverless-containers-full-name }}, {{ sf-full-name }}, {{ mcp-hub-name }}, and {{ sw-name }}.

### New roles {#roles-may-2026}

{% cut "{{ cloud-apps-full-name }}" %}

   Role | Description
   --- | ---
   `cloudapps.admin` | Enables the user to view info on installed {{ cloud-apps-name }} applications, create, modify, and delete them.
   `cloudapps.auditor` | Enables the user to view the metadata of installed {{ cloud-apps-name }} applications.
   `cloudapps.editor` | Enables the user to view info on installed {{ cloud-apps-name }} applications, create, modify, and delete them.
   `cloudapps.viewer` | Enables the user to view info on installed {{ cloud-apps-name }} applications.

{% endcut %}

{% cut "{{ marketplace-full-name }}" %}

   Role | Description
   --- | ---
   `marketplace.productInstances.admin` | Enables the user to manage installed Marketplace products and access to them.
   `marketplace.productInstances.auditor` | Enables the user to view info on installed Marketplace products and access permissions for them and to view folder metadata.
   `marketplace.productInstances.editor` | Enables the user to manage installed Marketplace products.
   `marketplace.productInstances.saasSupervisor` | Enables the user to view info on installed Marketplace SaaS products and activate such products.
   `marketplace.productInstances.user` | Enables the user to view info on installed Marketplace products, activate and deactivate them, and view info on access permissions for them.
   `marketplace.productInstances.viewer` | Enables the user to view info on installed Marketplace products and access permissions for them.

{% endcut %}

{% cut "{{ postbox-full-name }}" %}

   Role | Description
   --- | ---
   `postbox.messages.reader` | Enables the user to view the sent emails info, including sender, recipients, subject, sending date, delivery and engagement metrics, complaints, and unsubscriptions.
   `postbox.statistics.reader` | Enables the user to view the sent emails statistics.

{% endcut %}

{% cut "{{ iam-full-name }}" %}

   Role | Description
   --- | ---
   `iam.serviceAccounts.ephemeralAccessKeyAdmin` | Enables the user to create [ephemeral access keys](concepts/authorization/ephemeral-keys.md) for service accounts.

{% endcut %}

{% cut "{{ mrd-full-name }}" %}

   Role | Description
   --- | ---
   `managed-redis.clusters.connector` | Enables {{ yandex-cloud }} users to connect to databases in {{ VLK }} clusters via {{ iam-full-name }}.

{% endcut %}

{% cut "{{ yandex-siem-full-name }}" %}

   Role | Description
   --- | ---
   `ycem.executor` | Enables the user to manage requests, investigations, datasets, and correlation rules.
   `ycem.inspector` | Enables the user to manage requests, investigations, and datasets.

{% endcut %}

## April 2026 {#april-2026}

### {{ iam-name }} updates {#iam-april-2026}

* Added the `MASKED KEY` field to display the last six characters of the secret part of the key in the API key list.

### New roles {#roles-april-2026}

{% cut "{{ cns-full-name }}" %}

   Role | Description
   --- | ---
   `notifications.admin` | Enables the user to manage all notification channels and topics and send notifications to all channels and topics.
   `notifications.auditor` | Enables the user to view metadata of all notification channels, metadata of topics, and info on quotas.
   `notifications.editor` | Enables the user to manage all notification channels and topics and send notifications to all channels and topics.
   `notifications.publisher` | Enables the user to send notifications to all channels and topics.
   `notifications.viewer` | Enables the user to view info on topics, notification channels, and quotas.

{% endcut %}

{% cut "{{ datalens-full-name }}" %}

   Role | Description
   --- | ---
   `datalens.metaReader` | Enables the user to execute requests from the _Audit_ section in the [DataLens Public API](../datalens/operations/api-start).

{% endcut %}

{% cut "{{ dns-full-name }}" %}

   Role | Description
   --- | ---
   `dns.firewallEditor` | Enables the user to manage DNS firewalls and use clouds, folders, and cloud networks as resources for them.
   `dns.firewallUser` | Enables the user to use clouds, folders, and cloud networks as resources for DNS firewalls and to view info on resources and quotas of the service.

{% endcut %}

{% cut "{{ org-full-name }}" %}

   Role | Description
   --- | ---
   `organization-manager.groups.viewer` | Enables the user to view info on user groups and access permissions granted to them, and to view the list of users and service accounts forming part of the group.

{% endcut %}

{% cut "{{ managed-k8s-full-name }}" %}

   Role | Description
   --- | ---
   `k8s.cluster-api.admin` | Grants the `yc:k8s-core-admin` group and the `admin` role in Kubernetes RBAC.

{% endcut %}

{% cut "Managed databases" %}

   Role | Description
   --- | ---
   `mdb.maintenanceTask.editor` | Enables the user to view info on maintenance tasks for managed database clusters and modify such tasks, view info on clusters and access permissions granted for them, hosts and cluster backups, quotas and operations with resources of the services.
   `mdb.maintenanceTask.viewer` | Enables the user to view info on maintenance tasks for managed database clusters, as well as info on such clusters and access permissions granted for them, hosts and cluster backups, quotas and operations with resources of the services.
   `mdb.switcher` | Enables the user to re-assign the master host in managed database clusters, view info on clusters, hosts, databases, and users, cluster logs, data on quotas and operations with resources of the services.

{% endcut %}

## March 2026 {#march-2026}

### New roles {#roles-march-2026}

{% cut "{{ ai-studio-full-name }}" %}

   Role | Description
   --- | ---
   `ai.guardrails.admin` | Enables the user to view info on model response guardrails, create, apply, modify, and delete such guardrails.
   `ai.guardrails.auditor` | Enables the user to view metadata on model response guardrails.
   `ai.guardrails.editor` | Enables the user to view info on model response guardrails, create, apply, modify, and delete such guardrails.
   `ai.guardrails.user` | Enables the user to apply model response guardrails and view their metadata.
   `ai.guardrails.viewer` | Enables the user to view info on model response guardrails.

{% endcut %}

{% cut "{{ mgp-full-name }}" %}

   Role | Description
   --- | ---
   `managed-greenplum.maintenanceTask.editor` | Enables the user to view info on maintenance tasks for {{ GP }} clusters and modify such tasks, view info on {{ GP }} clusters and access permissions granted for them, hosts and cluster backups, quotas and operations with resources of the service.
   `managed-greenplum.maintenanceTask.viewer` | Enables the user to view info on maintenance tasks for {{ GP }} clusters, such clusters themselves and access permissions granted for them, hosts and cluster backups, quotas and operations with resources of the service.
   `managed-greenplum.user` | Enables the use of {{ GP }} clusters.

{% endcut %}

{% cut "{{ maf-full-name }}" %}

   Role | Description
   --- | ---
   `managed-airflow.maintenanceTask.editor` | Enables the user to view info on maintenance tasks for {{ AF }} clusters and modify such tasks, view info on {{ AF }} clusters and access permissions granted for them, as well as quotas.
   `managed-airflow.maintenanceTask.viewer` | Enables the user to view info on {{ AF }} clusters and access permissions granted for them, their maintenance tasks, and quotas.

{% endcut %}

{% cut "{{ mkf-full-name }}" %}

   Role | Description
   --- | ---
   `managed-kafka.maintenanceTask.editor` | Enables the user to view info on maintenance tasks for {{ KF }} clusters and modify such tasks, view info on {{ KF }} clusters and access permissions granted for them, quotas and operations with resources of the service.
   `managed-kafka.maintenanceTask.viewer` | Enables the user to view info on {{ KF }} clusters and access permissions granted for them, their maintenance tasks, quotas and operations with resources of the service.
   `managed-kafka.user` | Enables the use of {{ KF }} clusters.

{% endcut %}

{% cut "{{ msp-full-name }}" %}

   Role | Description
   --- | ---
   `managed-spark.maintenanceTask.editor` | Enables the user to view info on maintenance tasks for {{ SPRK }} clusters and modify such tasks, view info on {{ SPRK }} clusters and access permissions granted for them, as well as quotas.
   `managed-spark.maintenanceTask.viewer` | Enables the user to view info on {{ SPRK }} clusters and access permissions granted for them, their maintenance tasks, and quotas.

{% endcut %}

{% cut "{{ mch-full-name }}" %}

   Role | Description
   --- | ---
   `managed-clickhouse.maintenanceTask.editor` | Enables the user to view info on maintenance tasks for {{ CH }} clusters and modify such tasks, view info on {{ CH }} clusters and access permissions granted for them, quotas and operations with resources of the service.
   `managed-clickhouse.maintenanceTask.viewer` | Enables the user to view info on maintenance tasks for {{ CH }} clusters, {{ CH }} clusters and access permissions granted for them, quotas and operations with resources of the service.
   `managed-clickhouse.user` | Enables the use of {{ CH }} clusters.

{% endcut %}

{% cut "{{ mmy-full-name }}" %}

   Role | Description
   --- | ---
   `managed-mysql.maintenanceTask.editor` | Enables the user to view info on maintenance tasks for {{ MY }} clusters and modify such tasks, view info on {{ MY }} clusters and access permissions granted for them, hosts and cluster backups, quotas and operations with resources of the service.
   `managed-mysql.maintenanceTask.viewer` | Enables the user to view info on maintenance tasks for {{ MY }} clusters, such clusters themselves and access permissions granted for them, hosts and cluster backups, quotas and operations with resources of the service.
   `managed-mysql.switcher` | Enables the user to re-assign the master host in {{ MY }} clusters, view info on {{ MY }} clusters, hosts, databases, and users, view cluster logs, data on quotas and operations with resources of the service.
   `managed-mysql.user` | Enables the use of {{ MY }} clusters.

{% endcut %}

{% cut "{{ mos-full-name }}" %}

   Role | Description
   --- | ---
   `managed-opensearch.maintenanceTask.editor` | Enables the user to view info on maintenance tasks for {{ OS }} clusters and modify such tasks, view info on {{ OS }} clusters and access permissions granted for them, quotas and operations with resources of the service.
   `managed-opensearch.maintenanceTask.viewer` | Enables the user to view info on {{ OS }} clusters and access permissions granted for them, their maintenance tasks, quotas and operations with resources of the service.
   `managed-opensearch.user` | Enables the use of {{ OS }} clusters.

{% endcut %}

{% cut "{{ mpg-full-name }}" %}

   Role | Description
   --- | ---
   `managed-postgresql.maintenanceTask.editor` | Enables the user to view info on maintenance tasks for {{ PG }} clusters and modify such tasks, view info on {{ PG }} clusters and access permissions granted for them, hosts and cluster backups, quotas and operations with resources of the service.
   `managed-postgresql.maintenanceTask.viewer` | Enables the user to view info on maintenance tasks for {{ PG }} clusters, such clusters themselves and access permissions granted for them, hosts and backups, quotas and operations with resources of the service.
   `managed-postgresql.switcher` | Enables the user to re-assign the master host in {{ PG }} clusters, view info on {{ PG }} clusters, hosts, databases, and users, view cluster logs, data on quotas and operations with resources of the service.
   `managed-postgresql.user` | Enables the use of {{ PG }} clusters.

{% endcut %}

{% cut "{{ mspqr-full-name }}" %}

   Role | Description
   --- | ---
   `managed-spqr.maintenanceTask.editor` | Enables the user to view info on maintenance tasks for {{ SPQR }} clusters and modify such tasks, view info on {{ SPQR }} clusters and access permissions granted for them, cluster hosts, quotas and operations with resources of the service.
   `managed-spqr.maintenanceTask.viewer` | Enables the user to view info on maintenance tasks for {{ SPQR }} clusters, such clusters themselves and access permissions granted for them, cluster hosts, quotas and operations with resources of the service.

{% endcut %}

{% cut "{{ mtr-full-name }}" %}

   Role | Description
   --- | ---
   `managed-trino.maintenanceTask.editor` | Enables the user to view info on maintenance tasks for {{ TR }} clusters and modify such tasks, view info on {{ TR }} clusters and access permissions granted for them, as well as quotas.
   `managed-trino.maintenanceTask.viewer` | Enables the user to view info on {{ TR }} clusters and access permissions granted for them, their maintenance tasks, and quotas.

{% endcut %}

{% cut "{{ mrd-full-name }}" %}

   Role | Description
   --- | ---
   `managed-redis.maintenanceTask.editor` | Enables the user to view info on maintenance tasks for {{ VLK }} clusters and modify such tasks, view info on {{ VLK }} clusters and access permissions granted for them, hosts and cluster backups, quotas and operations with resources of the service.
   `managed-redis.maintenanceTask.viewer` | Enables the user to view info on maintenance tasks for {{ VLK }} clusters, such clusters themselves and access permissions granted for them, hosts and cluster backups, quotas and operations with resources of the service.
   `managed-redis.switcher` | Enables the user to re-assign the master host in {{ VLK }} clusters, view info on {{ VLK }} hosts and clusters, their logs, view data on quotas and operations with resources of the service.
   `managed-redis.user` | Enables the use of {{ VLK }} clusters.

{% endcut %}

{% cut "{{ mmg-full-name }}" %}

   Role | Description
   --- | ---
   `managed-mongodb.maintenanceTask.editor` | Enables the user to view info on maintenance tasks for {{ SD }} clusters and modify such tasks, view info on {{ SD }} clusters and access permissions granted for them, hosts and cluster backups, quotas and operations with resources of the service.
   `managed-mongodb.maintenanceTask.viewer` | Enables the user to view info on maintenance tasks for {{ SD }} clusters, such clusters themselves and access permissions granted for them, hosts and cluster backups, quotas and operations with resources of the service.
   `managed-mongodb.switcher` | Enables the user to re-assign the master host in {{ SD }} clusters, view info on {{ SD }} clusters, hosts, shards, databases, and users, view cluster logs, data on quotas and operations with resources of the service.
   `managed-mongodb.user` | Enables the use of {{ SD }} clusters.

{% endcut %}

## February 2026 {#february-2026}

### {{ iam-name }} updates {#iam-february-2026}

* Added [access policies](concepts/access-control/access-policies.md).

### New roles {#roles-february-2026}

{% cut "Yandex Cloud Backup" %}

   Role | Description
   --- | ---
   `backup.auditor` | Enables the user to view info on {{ baremetal-name }} virtual machines and servers connected to {{ backup-short-name }}, backup policies and quotas of the service, cloud and folder.

{% endcut %}

## December 2025 {#december-2025}

### {{ iam-name }} updates {#iam-december-2025}

* Added [ephemeral keys](concepts/authorization/ephemeral-keys.md).
* In the `yandex_iam_oauth_client` {{ TF }} resource, fixed the comparison between the `scopes` and `redirect_uris` fields: now their type is `set` to avoid comparison conflicts.

### New roles {#roles-december-2025}

{% cut "{{ backup-full-name }}" %}

   Role | Description
   --- | ---
   `backup.user` | Enables the user to connect backup providers, connect {{ baremetal-full-name }} VMs and servers, link and unlink backup policies to {{ baremetal-full-name }} VMs and servers, and view info on resources and quotas of the service.

{% endcut %}

{% cut "{{ mmy-full-name }}" %}

   Role | Description
   --- | ---
   `managed-mysql.clusters.connector` | Enables {{ yandex-cloud }} users to connect to databases in {{ mmy-full-name }} clusters via {{ iam-full-name }}.

{% endcut %}

{% cut "{{ mpg-full-name }}" %}

   Role | Description
   --- | ---
   `managed-postgresql.clusters.connector` | Enables {{ yandex-cloud }} users to connect to databases in {{ mpg-full-name }} clusters via {{ iam-full-name }}.

{% endcut %}

{% cut "{{ monium-full-name }}" %}

   Role | Description
   --- | ---
   `monium.admin` | Enables the user to manage {{ monium-name }} resources, view and record all types of telemetry, manage projects and access to projects.
   `monium.editor` | Enables the user to manage {{ monium-name }} resources, view and record all types of telemetry.
   `monium.viewer` | Enables the user to view info on {{ monium-name }} resources and read all types of telemetry.
   `monium.auditor` | Enables the user to view details on {{ monium-name }} resources.
   `monium.alerts.editor` | Enables the user to view the list of alerts, their settings and trigger history, as well as to create, modify, and delete alerts.
   `monium.alerts.viewer` | Enables the user to view the list of alerts, their settings and trigger history.
   `monium.channels.editor` | Enables the user to view the list of alert notification channels and their info, as well as to create, modify, and delete such channels.
   `monium.channels.viewer` | Enables the user to view the list of alert notification channels and their info.
   `monium.contextLinks.editor` | Enables the user to view configured context links on dashboard charts, as well as to create, edit, and delete context links.
   `monium.contextLinks.viewer` | Enables the user to view configured context links on dashboard charts.
   `monium.dashboards.editor` | Enables the user to view dashboards and their widgets, as well as to create, edit, and delete dashboards.
   `monium.dashboards.viewer` | Enables the user to view dashboards and their widgets.
   `monium.escalationPolicies.editor` | Enables the user to view the list of alert escalation policies and their settings, as well as to create, update, and delete escalation policies.
   `monium.escalationPolicies.viewer` | Enables the user to view the list of alert escalation policies and their settings.
   `monium.escalations.editor` | Enables the user to view info on alert notifications and escalations, as well as to create, edit, and delete escalations.
   `monium.escalations.viewer` | Enables the user to view info on alert notifications and escalations.
   `monium.logErrorLabels.editor` | Enables the user to view, edit, and delete existing labels attached to errors in logs and to add new ones.
   `monium.logErrorLabels.viewer` | Enables the user to view labels attached to errors in logs.
   `monium.logs.reader` | Enables the user to read logs and view log error statistics.
   `monium.logs.writer` | Enables the user to write logs.
   `monium.metrics.reader` | Enables the user to read metrics, their values and labels.
   `monium.metrics.writer` | Enables the user to write metrics.
   `monium.mutes.editor` | Enables the user to view, create, edit, and delete mutes, i.e., rules for temporary muting of alert notifications.
   `monium.mutes.viewer` | Enables the user to view mutes, i.e., rules for temporary muting of alert notifications.
   `monium.quickLinks.editor` | Enables the user to view the list of configured quick links and their info in the project menu, as well as to create, edit, and delete such links.
   `monium.quickLinks.viewer` | Enables the user to view the list of configured quick links and their info in the project menu.
   `monium.serviceLevelObjectives.editor` | Enables the user to view configured service level objectives (SLOs), as well as to create, edit, and delete them.
   `monium.serviceLevelObjectives.viewer` | Enables the user to view configured service level objectives (SLOs).
   `monium.shards.editor` | Enables the user to view info on shards, clusters, services and their quotas, as well as to create, update, and delete shards.
   `monium.shards.viewer` | Enables the user to view info on shards, clusters, services and their quotas.
   `monium.telemetry.reader` | Enables the user to read all types of {{ monium-name }} telemetry: metrics, logs, and distributed tracing data.
   `monium.telemetry.writer` | Enables the user to write all types of {{ monium-name }} telemetry: metrics, logs, and distributed tracing data.
   `monium.traces.reader` | Enables the user to view distributed tracing data.
   `monium.traces.writer` | Enables the user to write distributed tracing data.

{% endcut %}

{% cut "{{ mgp-full-name }}" %}

   Role | Description
   --- | ---
   `managed-greenplum.clusters.connector` | Enables {{ yandex-cloud }} users to connect to databases in {{ mgp-full-name }} clusters via {{ iam-full-name }}.

{% endcut %}

{% cut "{{ sd-full-name }}" %}

   Role | Description
   --- | ---
   `security-deck.alertSinks.admin` | Enables the user to manage alert sinks, alerts, and access to them.
   `security-deck.alertSinks.editor` | Enables the user to manage alert sinks, alerts, and comments in them.
   `security-deck.alertSinks.user` | Enables the user to view info on alert sinks and use them.
   `security-deck.alertSinks.viewer` | Enables the user to view info on alerts, alert sinks, and access permissions granted for them.
   `security-deck.alertSinks.auditor` | Enables the user to view info on alert sinks and access permissions granted for them.

{% endcut %}

## November 2025 {#november-2025}

### {{ iam-name }} updates {#iam-november-2025}

* [Added](../organization/operations/view-subject-access-bindings.md) the ability to view a list of a subject's accesses.

### New roles {#roles-november-2025}

{% cut "{{ interconnect-full-name }}" %}

   Role | Description
   --- | ---
   `cic.admin` | Enables the user to manage {{ interconnect-name }} resources.

{% endcut %}

{% cut "{{ cr-full-name }}" %}

   Role | Description
   --- | ---
   `cloud-router.admin` | Enables the user to manage {{ cr-name }} resources.
   `cloud-router.prefixEditor` | Enables the user to manage IP prefixes of cloud subnets in routing instances and view info on {{ cr-name }} resources.

{% endcut %}

{% cut "{{ org-full-name }}" %}

   Role | Description
   --- | ---
   `organization-manager.idpInstances.billingAdmin` | Enables the user to manage subscription to paid {{ org-full-name }} features.
   `organization-manager.idpInstances.billingViewer` | Enables the user to view the list of users on {{ org-full-name }} authentication quota in the current reporting period, view info on subscription to paid {{ org-full-name }} features and statistics on the use of quotas under this subscription.

{% endcut %}

## October 2025 {#october-2025}

### {{ iam-name }} updates {#iam-october-2025}

* [Added](operations/service-control/enable-disable.md) the ability to manage the access of services to the user's resources.

### New roles {#roles-october-2025}

{% cut "Managed databases" %}

   Role | Description
   --- | ---
   `mdb.restorer` | Enables the user to restore managed database clusters from backups and grants read access to clusters and their logs.

{% endcut %}

{% cut "{{ org-full-name }}" %}

   Role | Description
   --- | ---
   `organization-manager.groups.externalConverter` | Enables the user to add an external group ID attribute to {{ org-full-name }} user groups when synchronizing with user groups in Active Directory or another external source.
   `organization-manager.groups.externalCreator` | Enables the user to create {{ org-full-name }} user groups when synchronizing with user groups in Active Directory or another external source.
   `organization-manager.userpools.syncAgent` | Enables the user to synchronize {{ org-full-name }} users and groups with users and groups in Active Directory or another external source.

{% endcut %}

{% cut "{{ mkf-full-name }}" %}

   Role | Description
   --- | ---
   `managed-kafka.restorer` | Enables the user to restore {{ KF }} clusters from backups, view cluster info and logs, as well as data on {{ mkf-name }} quotas and operations with resources.

{% endcut %}

{% cut "{{ mch-full-name }}" %}

   Role | Description
   --- | ---
   `managed-clickhouse.restorer` | Enables the user to restore {{ CH }} clusters from backups, view {{ CH }} cluster info and logs, as well as data on {{ mch-name }} quotas and operations with resources.

{% endcut %}


{% cut "{{ mmy-full-name }}" %}

   Role | Description
   --- | ---
   `managed-mysql.restorer` | Enables the user to restore {{ MY }} clusters from backups, view info on {{ MY }} clusters, hosts, databases, and users, view cluster logs, as well as data on {{ mmy-name }} quotas and operations with resources.

{% endcut %}

{% cut "{{ mos-full-name }}" %}

   Role | Description
   --- | ---
   `managed-opensearch.restorer` | Enables the user to restore {{ OS }} clusters from backups, view {{ OS }} cluster info and logs, as well as data on {{ mos-name }} quotas and operations with resources.

{% endcut %}

{% cut "{{ mpg-full-name }}" %}

   Role | Description
   --- | ---
   `managed-postgresql.restorer` | Enables the user to restore {{ PG }} clusters from backups, view info on {{ PG }} clusters, hosts, databases, and users, view cluster logs, as well as data on {{ mpg-name }} quotas and operations with resources.

{% endcut %}

{% cut "{{ mspqr-full-name }}" %}

   Role | Description
   --- | ---
   `managed-spqr.restorer` | Enables the user to restore {{ SPQR }} clusters from backups, view info on {{ SPQR }} clusters, hosts, databases, and users, view cluster logs, data on {{ mspqr-name }} quotas and operations with resources.

{% endcut %}


{% cut "{{ mrd-full-name }}" %}

   Role | Description
   --- | ---
   `managed-redis.restorer` | Enables the user to restore {{ VLK }} clusters from backups, view info on {{ VLK }} hosts and clusters, their logs, data on {{ mrd-name }} quotas and operations with resources.

{% endcut %}

{% cut "{{ mgp-full-name }}" %}

   User role | Description
   --- | ---
   `managed-greenplum.restorer` | Enables the user to restore {{ mgp-name }} clusters from backups, view info on clusters and hosts, their logs, as well as data on {{ mgp-name }} quotas and operations with resources.

{% endcut %}

{% cut "{{ mmg-full-name }}" %}

   Role | Description
   --- | ---
   `managed-mongodb.restorer` | Enables the user to restore {{ MG }} clusters from backups, view info on {{ MG }} clusters, hosts, shards, databases, and users, view cluster logs, as well as data on {{ mmg-name }} quotas and operations with resources.

{% endcut %}

## Q3 2025 {#q3-2025}

* Implemented management of OAuth client secrets using the [CLI](../cli/cli-ref/iam/cli-ref/oauth-client-secret/) and [API](../iam/api-ref/OAuthClientSecret/). {{ tag-cli }} {{ tag-api }}
* Added a group of commands for OAuth client management to the [CLI](../cli/cli-ref/iam/cli-ref/oauth-client/) and [API](../iam/api-ref/OAuthClient/). {{ tag-cli }} {{ tag-api }}

## Q2 2025 {#q2-2025}

* Enabled creating and using [refresh tokens](concepts/authorization/refresh-token.md). {{ tag-cli }}

## Q1 2025 {#q1-2025}

* [Added](./concepts/authorization/api-key.md#scoped-api-keys) new scopes for API keys and the ability to assign more than one scope per service. {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }}
* [Workload identity federations](./concepts/workload-identity.md) are now [available](../overview/concepts/launch-stages.md) to all users. {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }}
* [Added](../iam/concepts/authorization/id-token.md) creating an ID token for service account, a special short-lived token for authentication in third-party systems. {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }}


## Q4 2024 {#q4-2024}

* [Added](../iam/at-ref.md#data-plane-events) sending the `CreateIamToken` data event when creating an IAM token.
* Expanded the scope of [limited lifetime API keys](./concepts/authorization/api-key.md#supported-services) to work with [{{ ydb-full-name }}](../ydb/) in compatibility mode with {{ PG }}, [{{ postbox-full-name }}](../postbox/), and [{{ serverless-containers-full-name }}](../serverless-containers/). {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }}
* You can now see the service account's last authentication date and time. You can get the information in the `last_authenticated_at` field using the `yc iam user-account get` [{{ yandex-cloud }} CLI](../cli/cli-ref/iam/cli-ref/user-account/get) command. {{ tag-cli }}


## Q3 2024 {#q3-2024}

* Added [Workload Identity Federations](./concepts/workload-identity.md) that allow you to grant access to external applications without using long-lived access keys. {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }}
* You can now create [API keys with limited scope and validity period](./concepts/authorization/api-key.md#scoped-api-keys). {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }}
* Added the [ResolveAgent](./api-ref/ServiceControl/resolveAgent.md) REST API method. {{ tag-api }}
* Added the ability to revoke an [IAM token](./concepts/authorization/iam-token.md) using the [{{ yandex-cloud }} CLI](../cli/cli-ref/iam/cli-ref/revoke-token.md). {{ tag-cli }}
* Added `All users in organization X` and `All users in federation N` [system groups](./concepts/access-control/system-group.md).
* Added the {{ TF }} data source used to get the [service agent](./concepts/service-control.md#service-agent) ID. {{ tag-tf }}


## Q2 2024 {#q2-2024}

* Added the last used date info for service account access keys. You can find this info on the service account page in the [management console]({{ link-console-main }}) or in the `last_used_at` field when using the API to invoke access key management methods. {{ tag-con }} {{ tag-api }}


## Q1 2024 {#q1-2024}

* Added the [{{ sts-name }}](./concepts/authorization/sts.md) component to get temporary access keys compatible with [AWS S3 API](../storage/s3/index.md). This feature is at the [Preview stage](../overview/concepts/launch-stages.md). {{ tag-cli }} {{ tag-api }}
* Added OAuth client authentication support by authenticating a service account token.
* Added the option of using masked token ID for {{ at-name }} logs.
* Improved the key rotation mechanism in [OpenID Connect](https://openid.net/).
