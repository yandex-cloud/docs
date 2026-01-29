---
title: '{{ iam-full-name }} release notes'
description: This section contains the {{ iam-name }} release notes.
---


# {{ iam-full-name }} release notes

{% include [Tags-nosql](../_includes/release-notes-tags-nosql.md) %}

## December 2025 {#december-2025}

* Added the `yc iam access-key issue-ephemeral` command for issuing ephemeral keys. {{ tag-cli }}
* Added support for the `yandex_iam_oauth_client_secret` resource to manage OAuth client secrets. {{ tag-tf }}
* Added the `labels` field to the `yandex_iam_service_account` resource to work with labels. {{ tag-tf }}
* For the `yandex_iam_oauth_client` resource, changed the `scopes` and `redirect_uris` fields to the _set_ type to prevent comparison collisions. {{ tag-tf }}
* Added the following [roles](roles-reference.md):

   {% cut "{{ backup-full-name }}" %}

     User role | Description
     --- | ---
     `backup.user` | Enables connecting backup providers, connecting VMs and {{ baremetal-full-name }} servers to Cloud Backup, associating and disassociating backup policies with VMs and {{ baremetal-full-name }} servers, and viewing Cloud Backup resource and quota details.

   {% endcut %}

   {% cut "{{ mmy-full-name }}" %}

     User role | Description
     --- | ---
     `managed-mysql.clusters.connector` | Enables {{ yandex-cloud }} users to connect to databases in {{ mmy-full-name }} clusters via {{ iam-full-name }}.

   {% endcut %}

   {% cut "{{ mpg-full-name }}" %}

     User role | Description
     --- | ---
     `managed-postgresql.clusters.connector` | Enables {{ yandex-cloud }} users to connect to databases in {{ mpg-full-name }} clusters via {{ iam-full-name }}.

   {% endcut %}

   {% cut "{{ monium-full-name }}" %}

     User role | Description
     --- | ---
     `monium.admin` | Enables managing {{ monium-name }} resources, viewing and writing all types of telemetry data, and managing projects and access to projects.
     `monium.editor` | Enables managing {{ monium-name }} resources, viewing and writing all types of telemetry data.
     `monium.viewer` | Enables viewing details on {{ monium-name }} resources and reading all types of telemetry data.
     `monium.auditor` | Enables viewing details on {{ monium-name }} resources.
     `monium.alerts.editor` | Enables viewing the list of alerts, their settings, and trigger history, as well as creating, modifying, and deleting alerts.
     `monium.alerts.viewer` | Enables viewing the list of alerts, their settings, and trigger history.
     `monium.channels.editor` | Enables viewing the list of alert notification channels and their details, as well as creating, modifying, and deleting such channels.
     `monium.channels.viewer` | Enables viewing the list of alert notification channels and their details.
     `monium.contextLinks.editor` | Enables viewing configured context links on dashboard charts, as well as creating, editing, and deleting such links.
     `monium.contextLinks.viewer` | Enables viewing configured context links on dashboard charts.
     `monium.dashboards.editor` | Enables viewing dashboards and their widgets, as well as creating, editing, and deleting dashboards.
     `monium.dashboards.viewer` | Enables viewing dashboards and their widgets.
     `monium.escalationPolicies.editor` | Enables viewing the list of alert escalation policies and their settings, as well as creating, updating, and deleting such policies.
     `monium.escalationPolicies.viewer` | Enables viewing the list of alert escalation policies and their settings.
     `monium.escalations.editor` | Enables viewing details on alert notifications and escalations, as well as creating, editing, and deleting escalations.
     `monium.escalations.viewer` | Enables viewing details on alert notifications and escalations.
     `monium.logErrorLabels.editor` | Enables viewing, editing, and deleting the existing labels as well as adding new ones to errors in logs.
     `monium.logErrorLabels.viewer` | Enables viewing labels for log errors.
     `monium.logs.reader` | Enables reading logs and viewing log error statistics.
     `monium.logs.writer` | Enables writing logs.
     `monium.metrics.reader` | Enables reading metrics, their values, and labels.
     `monium.metrics.writer` | Enables writing metrics.
     `monium.mutes.editor` | Enables viewing, creating, editing, and deleting mutes, i.e., rules for temporarily disabling alert notifications.
     `monium.mutes.viewer` | Enables viewing mutes, i.e., rules for temporarily disabling alert notifications.
     `monium.quickLinks.editor` | Enables viewing the list of configured quick links and their details in the project menu, as well as creating, editing, and deleting such links.
     `monium.quickLinks.viewer` | Enables viewing the list of configured quick links and their details in the project menu.
     `monium.serviceLevelObjectives.editor` | Enables viewing configured service level objectives (SLOs), as well as creating, editing, and deleting them.
     `monium.serviceLevelObjectives.viewer` | Enables viewing configured service level objectives (SLOs).
     `monium.shards.editor` | Enables viewing details on shards, clusters, services and their quotas, as well as creating, updating, and deleting shards.
     `monium.shards.viewer` | Enables viewing details on shards, clusters, services and their quotas.
     `monium.telemetry.reader` | Enables reading all types of {{ monium-name }} telemetry data, such as metrics, logs, and distributed tracing data.
     `monium.telemetry.writer` | Enables writing all types of {{ monium-name }} telemetry data, such as metrics, logs, and distributed tracing data.
     `monium.traces.reader` | Enables viewing distributed tracing data.
     `monium.traces.writer` | Enables writing distributed tracing data.

   {% endcut %}

   {% cut "{{ mgp-full-name }}" %}

     User role | Description
     --- | ---
     `managed-greenplum.clusters.connector` | Enables {{ yandex-cloud }} users to connect to databases in {{ mgp-full-name }} clusters via {{ iam-full-name }}.

   {% endcut %}

   {% cut "{{ sd-full-name }}" %}

     User role | Description
     --- | ---
     `security-deck.alertSinks.admin` | Enables managing alert sinks and alerts, as well as access to them.
     `security-deck.alertSinks.editor` | Enables managing alert sinks, alerts, and comments in them.
     `security-deck.alertSinks.user` | Enables viewing details on alert sinks and using them.
     `security-deck.alertSinks.viewer` | Enables viewing details on alerts and alert sinks as well as on access permissions granted for them.
     `security-deck.alertSinks.auditor` | Enables viewing details on alert sinks and access permissions granted for them.

   {% endcut %}


## November 2025 {#november-2025}

* [Added](../organization/operations/view-subject-access-bindings.md) the ability to view a list of subject’s accesses using the [CLI](../cli/cli-ref/iam/cli-ref/access-analyzer/) and [API](../iam/api-ref/AccessAnalyzer/). {{ tag-con }} {{ tag-cli }} {{ tag-api }}

* Added the following [roles](roles-reference.md):

   {% cut "{{ interconnect-full-name }}" %}

     User role | Description
     --- | ---
     `cic.admin` | Enables managing {{ interconnect-name }} resources.

   {% endcut %}

   {% cut "{{ cr-full-name }}" %}

     User role | Description
     --- | ---
     `cloud-router.admin` | Enables managing {{ cr-name }} resources.
     `cloud-router.prefixEditor` | Enables managing IP prefixes of cloud subnets in routing instances, as well as viewing info on {{ cr-name }} resources.

   {% endcut %}

   {% cut "{{ org-full-name }}" %}

     User role | Description
     --- | ---
     `organization-manager.idpInstances.billingAdmin` | Enables managing your subscription to the paid {{ org-name }} features.
     `organization-manager.idpInstances.billingViewer` | Enables viewing the list of users who employ the {{ org-name }} authentication quota in the current reporting period, as well as viewing info on a subscription to the paid-for {{ org-name }} features and stats regarding the use of the quotas within this subscription.

   {% endcut %}

## October 2025 {#october-2025}

* [Supported](operations/service-control/enable-disable.md) managing service access to user resources via the [management console]({{ link-console-main }}). {{ tag-con }}
* Added the following [roles](roles-reference.md):

   {% cut "Managed databases" %}

     User role | Description
     --- | ---
     `mdb.restorer` | Enables restoring managed database clusters from backups and grants read access to such clusters and their logs.

   {% endcut %}

   {% cut "{{ org-full-name }}" %}

     User role | Description
     --- | ---
     `organization-manager.groups.externalConverter` | Enables adding an attribute with an external group ID to {{ org-name }} user groups when synchronizing with user groups in Active Directory or another external source.
     `organization-manager.groups.externalCreator` | Enables creating {{ org-name }} user groups when synchronizing with user groups in Active Directory or another external source.
     `organization-manager.userpools.syncAgent` | Enables synchronizing {{ org-name }} users and groups with users and groups in Active Directory or another external source.

   {% endcut %}

   {% cut "{{ mkf-full-name }}" %}

     User role | Description
     --- | ---
     `managed-kafka.restorer` | Enables restoring {{ KF }} clusters from backups, viewing information about such clusters and their logs, as well as information about {{ mkf-name }} quotas and resource operations.

   {% endcut %}

   {% cut "{{ mch-full-name }}" %}

     User role | Description
     --- | ---
     `managed-clickhouse.restorer` | Enables restoring {{ CH }} clusters from backups, viewing information about {{ CH }} clusters and their logs, as well as information about {{ mch-name }} quotas and resource operations.

   {% endcut %}


   {% cut "{{ mmy-full-name }}" %}

     User role | Description
     --- | ---
     `managed-mysql.restorer` | Enables restoring {{ MY }} clusters from backups, viewing information about {{ MY }} clusters, hosts, databases, and users, cluster logs, as well as information about {{ mmy-name }} quotas and resource operations.

   {% endcut %}

   {% cut "{{ mos-full-name }}" %}

     User role | Description
     --- | ---
     `managed-opensearch.restorer` | Enables restoring {{ OS }} clusters from backups, viewing information about {{ OS }} clusters and their logs, as well as information about {{ mos-name }} quotas and resource operations.

   {% endcut %}

   {% cut "{{ mpg-full-name }}" %}

     User role | Description
     --- | ---
     `managed-postgresql.restorer` | Enables restoring {{ PG }} clusters from backups, viewing information about {{ PG }} clusters, hosts, databases, and users, cluster logs, as well as information about {{ mpg-name }} quotas and resource operations.

   {% endcut %}

   {% cut "{{ mspqr-full-name }}" %}

     User role | Description
     --- | ---
     `managed-spqr.restorer` | Enables restoring {{ SPQR }} clusters from backups, viewing information about {{ SPQR }} clusters, hosts, databases, and users, cluster logs, as well as information about {{ mspqr-name }} quotas and resource operations.

   {% endcut %}


   {% cut "{{ mrd-full-name }}" %}

     User role | Description
     --- | ---
     `managed-redis.restorer` | Enables restoring {{ VLK }} clusters from backups, viewing information about {{ VLK }} hosts and clusters, their logs, as well as information about {{ mrd-name }} quotas and resource operations.

   {% endcut %}

   {% cut "{{ mgp-full-name }}" %}

     User role | Description
     --- | ---
     `managed-greenplum.restorer` | Enables restoring {{ GP }} clusters from backups, viewing information about {{ GP }} clusters and hosts, their logs, as well as information about {{ mgp-name }} quotas and resource operations.

   {% endcut %}

   {% cut "{{ mmg-full-name }}" %}

     User role | Description
     --- | ---
     `managed-mongodb.restorer` | Enables restoring {{ MG }} clusters from backups, viewing information about {{ MG }} clusters, hosts, shards, databases, and users, cluster logs, as well as information about {{ mmg-name }} quotas and resource operations.

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