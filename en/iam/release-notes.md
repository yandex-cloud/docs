---
title: '{{ iam-full-name }} release notes'
description: This section contains the {{ iam-name }} release notes.
---

# {{ iam-full-name }} release notes

## August 2026 {#august-2026}

### {{ iam-name }} updates {#iam-august-2026}

* The `compute.editor` and `compute.admin` roles in {{ compute-name }}, as well as the `baremetal.editor` and `baremetal.admin` in {{ baremetal-name }} now include permissions of the [`backup.user`](../backup/security/index.md#backup-user) role.

### New roles {#roles-august-2026}

{% cut "{{ billing-name }}" %}

#### billing.usagerecords.admin {#billing-usagerecords-admin}

{% include [billing.usagerecords.admin](../_roles/billing/usagerecords/admin.md) %}

{% endcut %}

{% cut "{{ mch-full-name }}" %}

#### managed-clickhouse.clusters.connector {#managed-clickhouse-clusters-connector}

{% include [managed-clickhouse.clusters.connector](../_roles/managed-clickhouse/clusters/connector.md) %}

{% endcut %}

{% cut "{{ mgl-full-name }}" %}

#### gitlab.backupAdmin {#gitlab-backupadmin}

{% include [gitlab.backupAdmin](../_roles/gitlab/backupAdmin.md) %}

#### gitlab.backupDownloader {#gitlab-backupdownloader}

{% include [gitlab.backupDownloader](../_roles/gitlab/backupDownloader.md) %}

#### gitlab.backupRestorer {#gitlab-backuprestorer}

{% include [gitlab.backupRestorer](../_roles/gitlab/backupRestorer.md) %}

{% endcut %}

## July 2026 {#july-2026}

### {{ iam-name }} updates {#iam-july-2026}

* Added the ability to suspend a service account and manage its lifetime.
* Added the `resourceManager.denyFolderRemoval` [authorization policy](concepts/access-control/access-policies.md#resourceManager-denyFolderRemoval) template that allows you to prohibit folder deletion.
* Added the `aistudio.responses.restrictNetworkAccess` [authorization policy](concepts/access-control/access-policies.md#aistudio-responses-restrictNetworkAccess) template that allows restricting access to the Responses API in {{ ai-studio-full-name }} by IP addresses and cloud networks.

### New roles {#roles-july-2026}

{% cut "{{ cloud-registry-full-name }}" %}

#### cloud-registry.artifacts.scanner {#cloud-registry-artifacts-scanner}

{% include [cloud-registry.artifacts.scanner](../_roles/cloud-registry/artifacts/scanner.md) %}

{% endcut %}

{% cut "{{ sd-full-name }}" %}

#### threat-detector.admin {#threat-detector-admin}

{% include [threat-detector.admin](../_roles/threat-detector/admin.md) %}

#### threat-detector.auditor {#threat-detector-auditor}

{% include [threat-detector.auditor](../_roles/threat-detector/auditor.md) %}

#### threat-detector.editor {#threat-detector-editor}

{% include [threat-detector.editor](../_roles/threat-detector/editor.md) %}

#### threat-detector.viewer {#threat-detector-viewer}

{% include [threat-detector.viewer](../_roles/threat-detector/viewer.md) %}

#### threat-detector.worker {#threat-detector-worker}

{% include [threat-detector.worker](../_roles/threat-detector/worker.md) %}

#### vulnerability-manager.admin {#vulnerability-manager-admin}

{% include [vulnerability-manager.admin](../_roles/vulnerability-manager/admin.md) %}

#### vulnerability-manager.auditor {#vulnerability-manager-auditor}

{% include [vulnerability-manager.auditor](../_roles/vulnerability-manager/auditor.md) %}

#### vulnerability-manager.editor {#vulnerability-manager-editor}

{% include [vulnerability-manager.editor](../_roles/vulnerability-manager/editor.md) %}

#### vulnerability-manager.viewer {#vulnerability-manager-viewer}

{% include [vulnerability-manager.viewer](../_roles/vulnerability-manager/viewer.md) %}

{% endcut %}

{% cut "{{ mmg-full-name }}" %}

#### managed-mongodb.clusters.connector {#managed-mongodb-clusters-connector}

{% include [managed-mongodb.clusters.connector](../_roles/managed-mongodb/clusters/connector.md) %}

{% endcut %}

## June 2026 {#june-2026}

### {{ iam-name }} updates {#iam-june-2026}

* Added the `resourceManager.denyCloudRemoval` [access policy](concepts/access-control/access-policies.md#resourceManager-denyCloudRemoval) template that allows you to prohibit cloud deletion.

### New roles {#roles-june-2026}

{% cut "{{ metastore-full-name }}" %}

#### managed-metastore.maintenanceTask.editor {#managed-metastore-maintenancetask-editor}

{% include [managed-metastore.maintenanceTask.editor](../_roles/managed-metastore/maintenanceTask/editor.md) %}

#### managed-metastore.maintenanceTask.viewer {#managed-metastore-maintenancetask-viewer}

{% include [managed-metastore.maintenanceTask.viewer](../_roles/managed-metastore/maintenanceTask/viewer.md) %}

{% endcut %}

{% cut "{{ datalens-full-name }}" %}

#### datalens.collections.creator {#datalens-collections-creator}

{% include [datalens.collections.creator](../_roles/datalens/collections/creator.md) %}

#### datalens.collections.entryBindingCreator {#datalens-collections-entrybindingcreator}

{% include [datalens.collections.entryBindingCreator](../_roles/datalens/collections/entryBindingCreator.md) %}

#### datalens.collections.limitedEntryBindingCreator {#datalens-collections-limitedentrybindingcreator}

{% include [datalens.collections.limitedEntryBindingCreator](../_roles/datalens/collections/limitedEntryBindingCreator.md) %}

#### datalens.collections.visitor {#datalens-collections-visitor}

{% include [datalens.collections.visitor](../_roles/datalens/collections/visitor.md) %}

#### datalens.sharedEntries.admin {#datalens-sharedentries-admin}

{% include [datalens.sharedEntries.admin](../_roles/datalens/sharedEntries/admin.md) %}

#### datalens.sharedEntries.editor {#datalens-sharedentries-editor}

{% include [datalens.sharedEntries.editor](../_roles/datalens/sharedEntries/editor.md) %}

#### datalens.sharedEntries.entryBindingCreator {#datalens-sharedentries-entrybindingcreator}

{% include [datalens.sharedEntries.entryBindingCreator](../_roles/datalens/sharedEntries/entryBindingCreator.md) %}

#### datalens.sharedEntries.limitedEntryBindingCreator {#datalens-sharedentries-limitedentrybindingcreator}

{% include [datalens.sharedEntries.limitedEntryBindingCreator](../_roles/datalens/sharedEntries/limitedEntryBindingCreator.md) %}

#### datalens.sharedEntries.limitedViewer {#datalens-sharedentries-limitedviewer}

{% include [datalens.sharedEntries.limitedViewer](../_roles/datalens/sharedEntries/limitedViewer.md) %}

#### datalens.sharedEntries.viewer {#datalens-sharedentries-viewer}

{% include [datalens.sharedEntries.viewer](../_roles/datalens/sharedEntries/viewer.md) %}

{% endcut %}

## May 2026 {#may-2026}

### {{ iam-name }} updates {#iam-may-2026}

* Added new [API key scopes](concepts/authorization/api-key.md#scoped-api-keys): to work with {{ cloud-registry-full-name }} and to run workflows in {{ sw-name }}.
* Updated [access policy](concepts/access-control/access-policies.md) templates: replaced the `serverless.restrictPrivateNetworkInvocation` and `serverless.restrictPublicInvocation` shared templates with separate templates for {{ serverless-containers-full-name }}, {{ sf-full-name }}, {{ mcp-hub-name }}, and {{ sw-name }}.

### New roles {#roles-may-2026}

{% cut "{{ cloud-apps-full-name }}" %}

#### cloudapps.admin {#cloudapps-admin}

{% include [cloudapps.admin](../_roles/cloudapps/admin.md) %}

#### cloudapps.auditor {#cloudapps-auditor}

{% include [cloudapps.auditor](../_roles/cloudapps/auditor.md) %}

#### cloudapps.editor {#cloudapps-editor}

{% include [cloudapps.editor](../_roles/cloudapps/editor.md) %}

#### cloudapps.viewer {#cloudapps-viewer}

{% include [cloudapps.viewer](../_roles/cloudapps/viewer.md) %}

{% endcut %}

{% cut "{{ marketplace-full-name }}" %}

#### marketplace.productInstances.admin {#marketplace-productinstances-admin}

{% include [marketplace.productInstances.admin](../_roles/marketplace/productInstances/admin.md) %}

#### marketplace.productInstances.auditor {#marketplace-productinstances-auditor}

{% include [marketplace.productInstances.auditor](../_roles/marketplace/productInstances/auditor.md) %}

#### marketplace.productInstances.editor {#marketplace-productinstances-editor}

{% include [marketplace.productInstances.editor](../_roles/marketplace/productInstances/editor.md) %}

#### marketplace.productInstances.saasSupervisor {#marketplace-productinstances-saassupervisor}

{% include [marketplace.productInstances.saasSupervisor](../_roles/marketplace/productInstances/saasSupervisor.md) %}

#### marketplace.productInstances.user {#marketplace-productinstances-user}

{% include [marketplace.productInstances.user](../_roles/marketplace/productInstances/user.md) %}

#### marketplace.productInstances.viewer {#marketplace-productinstances-viewer}

{% include [marketplace.productInstances.viewer](../_roles/marketplace/productInstances/viewer.md) %}

{% endcut %}

{% cut "{{ postbox-full-name }}" %}

#### postbox.messages.reader {#postbox-messages-reader}

{% include [postbox.messages.reader](../_roles/postbox/messages/reader.md) %}

#### postbox.statistics.reader {#postbox-statistics-reader}

{% include [postbox.statistics.reader](../_roles/postbox/statistics/reader.md) %}

{% endcut %}

{% cut "{{ iam-full-name }}" %}

#### iam.serviceAccounts.ephemeralAccessKeyAdmin {#iam-serviceaccounts-ephemeralaccesskeyadmin}

{% include [iam.serviceAccounts.ephemeralAccessKeyAdmin](../_roles/iam/serviceAccounts/ephemeralAccessKeyAdmin.md) %}

{% endcut %}

{% cut "{{ mrd-full-name }}" %}

#### managed-redis.clusters.connector {#managed-redis-clusters-connector}

{% include [managed-redis.clusters.connector](../_roles/managed-redis/clusters/connector.md) %}

{% endcut %}

{% cut "{{ yandex-siem-full-name }}" %}

#### ycem.executor {#ycem-executor}

{% include [ycem.executor](../_roles/ycem/executor.md) %}

#### ycem.inspector {#ycem-inspector}

{% include [ycem.inspector](../_roles/ycem/inspector.md) %}

{% endcut %}

## April 2026 {#april-2026}

### {{ iam-name }} updates {#iam-april-2026}

* Added the `MASKED KEY` field to display the last six characters of the secret part of the key in the API key list.

### New roles {#roles-april-2026}

{% cut "{{ cns-full-name }}" %}

#### notifications.admin {#notifications-admin}

{% include [notifications.admin](../_roles/notifications/admin.md) %}

#### notifications.auditor {#notifications-auditor}

{% include [notifications.auditor](../_roles/notifications/auditor.md) %}

#### notifications.editor {#notifications-editor}

{% include [notifications.editor](../_roles/notifications/editor.md) %}

#### notifications.publisher {#notifications-publisher}

{% include [notifications.publisher](../_roles/notifications/publisher.md) %}

#### notifications.viewer {#notifications-viewer}

{% include [notifications.viewer](../_roles/notifications/viewer.md) %}

{% endcut %}

{% cut "{{ datalens-full-name }}" %}

#### datalens.metaReader {#datalens-metareader}

{% include [datalens.metaReader](../_roles/datalens/metaReader.md) %}

{% endcut %}

{% cut "{{ dns-full-name }}" %}

#### dns.firewallEditor {#dns-firewalleditor}

{% include [dns.firewallEditor](../_roles/dns/firewallEditor.md) %}

#### dns.firewallUser {#dns-firewalluser}

{% include [dns.firewallUser](../_roles/dns/firewallUser.md) %}

{% endcut %}

{% cut "{{ org-full-name }}" %}

#### organization-manager.groups.viewer {#organization-manager-groups-viewer}

{% include [organization-manager.groups.viewer](../_roles/organization-manager/groups/viewer.md) %}

{% endcut %}

{% cut "{{ managed-k8s-full-name }}" %}

#### k8s.cluster-api.admin {#k8s-cluster-api-admin}

{% include [k8s.cluster-api.admin](../_roles/k8s/cluster-api/admin.md) %}

{% endcut %}

{% cut "Managed databases" %}

#### mdb.maintenanceTask.editor {#mdb-maintenancetask-editor}

{% include [mdb.maintenanceTask.editor](../_roles/mdb/maintenanceTask/editor.md) %}

#### mdb.maintenanceTask.viewer {#mdb-maintenancetask-viewer}

{% include [mdb.maintenanceTask.viewer](../_roles/mdb/maintenanceTask/viewer.md) %}

#### mdb.switcher {#mdb-switcher}

{% include [mdb.switcher](../_roles/mdb/switcher.md) %}

{% endcut %}

## March 2026 {#march-2026}

### New roles {#roles-march-2026}

{% cut "{{ ai-studio-full-name }}" %}

#### ai.guardrails.admin {#ai-guardrails-admin}

{% include [ai.guardrails.admin](../_roles/ai/guardrails/admin.md) %}

#### ai.guardrails.auditor {#ai-guardrails-auditor}

{% include [ai.guardrails.auditor](../_roles/ai/guardrails/auditor.md) %}

#### ai.guardrails.editor {#ai-guardrails-editor}

{% include [ai.guardrails.editor](../_roles/ai/guardrails/editor.md) %}

#### ai.guardrails.user {#ai-guardrails-user}

{% include [ai.guardrails.user](../_roles/ai/guardrails/user.md) %}

#### ai.guardrails.viewer {#ai-guardrails-viewer}

{% include [ai.guardrails.viewer](../_roles/ai/guardrails/viewer.md) %}

{% endcut %}

{% cut "{{ mgp-full-name }}" %}

#### managed-greenplum.maintenanceTask.editor {#managed-greenplum-maintenancetask-editor}

{% include [managed-greenplum.maintenanceTask.editor](../_roles/managed-greenplum/maintenanceTask/editor.md) %}

#### managed-greenplum.maintenanceTask.viewer {#managed-greenplum-maintenancetask-viewer}

{% include [managed-greenplum.maintenanceTask.viewer](../_roles/managed-greenplum/maintenanceTask/viewer.md) %}

#### managed-greenplum.user {#managed-greenplum-user}

{% include [managed-greenplum.user](../_roles/managed-greenplum/user.md) %}

{% endcut %}

{% cut "{{ maf-full-name }}" %}

#### managed-airflow.maintenanceTask.editor {#managed-airflow-maintenancetask-editor}

{% include [managed-airflow.maintenanceTask.editor](../_roles/managed-airflow/maintenanceTask/editor.md) %}

#### managed-airflow.maintenanceTask.viewer {#managed-airflow-maintenancetask-viewer}

{% include [managed-airflow.maintenanceTask.viewer](../_roles/managed-airflow/maintenanceTask/viewer.md) %}

{% endcut %}

{% cut "{{ mkf-full-name }}" %}

#### managed-kafka.maintenanceTask.editor {#managed-kafka-maintenancetask-editor}

{% include [managed-kafka.maintenanceTask.editor](../_roles/managed-kafka/maintenanceTask/editor.md) %}

#### managed-kafka.maintenanceTask.viewer {#managed-kafka-maintenancetask-viewer}

{% include [managed-kafka.maintenanceTask.viewer](../_roles/managed-kafka/maintenanceTask/viewer.md) %}

#### managed-kafka.user {#managed-kafka-user}

{% include [managed-kafka.user](../_roles/managed-kafka/user.md) %}

{% endcut %}

{% cut "{{ msp-full-name }}" %}

#### managed-spark.maintenanceTask.editor {#managed-spark-maintenancetask-editor}

{% include [managed-spark.maintenanceTask.editor](../_roles/managed-spark/maintenanceTask/editor.md) %}

#### managed-spark.maintenanceTask.viewer {#managed-spark-maintenancetask-viewer}

{% include [managed-spark.maintenanceTask.viewer](../_roles/managed-spark/maintenanceTask/viewer.md) %}

{% endcut %}

{% cut "{{ mch-full-name }}" %}

#### managed-clickhouse.maintenanceTask.editor {#managed-clickhouse-maintenancetask-editor}

{% include [managed-clickhouse.maintenanceTask.editor](../_roles/managed-clickhouse/maintenanceTask/editor.md) %}

#### managed-clickhouse.maintenanceTask.viewer {#managed-clickhouse-maintenancetask-viewer}

{% include [managed-clickhouse.maintenanceTask.viewer](../_roles/managed-clickhouse/maintenanceTask/viewer.md) %}

#### managed-clickhouse.user {#managed-clickhouse-user}

{% include [managed-clickhouse.user](../_roles/managed-clickhouse/user.md) %}

{% endcut %}

{% cut "{{ mmy-full-name }}" %}

#### managed-mysql.maintenanceTask.editor {#managed-mysql-maintenancetask-editor}

{% include [managed-mysql.maintenanceTask.editor](../_roles/managed-mysql/maintenanceTask/editor.md) %}

#### managed-mysql.maintenanceTask.viewer {#managed-mysql-maintenancetask-viewer}

{% include [managed-mysql.maintenanceTask.viewer](../_roles/managed-mysql/maintenanceTask/viewer.md) %}

#### managed-mysql.switcher {#managed-mysql-switcher}

{% include [managed-mysql.switcher](../_roles/managed-mysql/switcher.md) %}

#### managed-mysql.user {#managed-mysql-user}

{% include [managed-mysql.user](../_roles/managed-mysql/user.md) %}

{% endcut %}

{% cut "{{ mos-full-name }}" %}

#### managed-opensearch.maintenanceTask.editor {#managed-opensearch-maintenancetask-editor}

{% include [managed-opensearch.maintenanceTask.editor](../_roles/managed-opensearch/maintenanceTask/editor.md) %}

#### managed-opensearch.maintenanceTask.viewer {#managed-opensearch-maintenancetask-viewer}

{% include [managed-opensearch.maintenanceTask.viewer](../_roles/managed-opensearch/maintenanceTask/viewer.md) %}

#### managed-opensearch.user {#managed-opensearch-user}

{% include [managed-opensearch.user](../_roles/managed-opensearch/user.md) %}

{% endcut %}

{% cut "{{ mpg-full-name }}" %}

#### managed-postgresql.maintenanceTask.editor {#managed-postgresql-maintenancetask-editor}

{% include [managed-postgresql.maintenanceTask.editor](../_roles/managed-postgresql/maintenanceTask/editor.md) %}

#### managed-postgresql.maintenanceTask.viewer {#managed-postgresql-maintenancetask-viewer}

{% include [managed-postgresql.maintenanceTask.viewer](../_roles/managed-postgresql/maintenanceTask/viewer.md) %}

#### managed-postgresql.switcher {#managed-postgresql-switcher}

{% include [managed-postgresql.switcher](../_roles/managed-postgresql/switcher.md) %}

#### managed-postgresql.user {#managed-postgresql-user}

{% include [managed-postgresql.user](../_roles/managed-postgresql/user.md) %}

{% endcut %}

{% cut "{{ mspqr-full-name }}" %}

#### managed-spqr.maintenanceTask.editor {#managed-spqr-maintenancetask-editor}

{% include [managed-spqr.maintenanceTask.editor](../_roles/managed-spqr/maintenanceTask/editor.md) %}

#### managed-spqr.maintenanceTask.viewer {#managed-spqr-maintenancetask-viewer}

{% include [managed-spqr.maintenanceTask.viewer](../_roles/managed-spqr/maintenanceTask/viewer.md) %}

{% endcut %}

{% cut "{{ mtr-full-name }}" %}

#### managed-trino.maintenanceTask.editor {#managed-trino-maintenancetask-editor}

{% include [managed-trino.maintenanceTask.editor](../_roles/managed-trino/maintenanceTask/editor.md) %}

#### managed-trino.maintenanceTask.viewer {#managed-trino-maintenancetask-viewer}

{% include [managed-trino.maintenanceTask.viewer](../_roles/managed-trino/maintenanceTask/viewer.md) %}

{% endcut %}

{% cut "{{ mrd-full-name }}" %}

#### managed-redis.maintenanceTask.editor {#managed-redis-maintenancetask-editor}

{% include [managed-redis.maintenanceTask.editor](../_roles/managed-redis/maintenanceTask/editor.md) %}

#### managed-redis.maintenanceTask.viewer {#managed-redis-maintenancetask-viewer}

{% include [managed-redis.maintenanceTask.viewer](../_roles/managed-redis/maintenanceTask/viewer.md) %}

#### managed-redis.switcher {#managed-redis-switcher}

{% include [managed-redis.switcher](../_roles/managed-redis/switcher.md) %}

#### managed-redis.user {#managed-redis-user}

{% include [managed-redis.user](../_roles/managed-redis/user.md) %}

{% endcut %}

{% cut "{{ mmg-full-name }}" %}

#### managed-mongodb.maintenanceTask.editor {#managed-mongodb-maintenancetask-editor}

{% include [managed-mongodb.maintenanceTask.editor](../_roles/managed-mongodb/maintenanceTask/editor.md) %}

#### managed-mongodb.maintenanceTask.viewer {#managed-mongodb-maintenancetask-viewer}

{% include [managed-mongodb.maintenanceTask.viewer](../_roles/managed-mongodb/maintenanceTask/viewer.md) %}

#### managed-mongodb.switcher {#managed-mongodb-switcher}

{% include [managed-mongodb.switcher](../_roles/managed-mongodb/switcher.md) %}

#### managed-mongodb.user {#managed-mongodb-user}

{% include [managed-mongodb.user](../_roles/managed-mongodb/user.md) %}

{% endcut %}

## February 2026 {#february-2026}

### {{ iam-name }} updates {#iam-february-2026}

* Added [access policies](concepts/access-control/access-policies.md).

### New roles {#roles-february-2026}

{% cut "Yandex Cloud Backup" %}

#### backup.auditor {#backup-auditor}

{% include [backup.auditor](../_roles/backup/auditor.md) %}

{% endcut %}

## December 2025 {#december-2025}

### {{ iam-name }} updates {#iam-december-2025}

* Added [ephemeral keys](concepts/authorization/ephemeral-keys.md).
* In the `yandex_iam_oauth_client` {{ TF }} resource, fixed the comparison between the `scopes` and `redirect_uris` fields: now their type is `set` to avoid comparison conflicts.

### New roles {#roles-december-2025}

{% cut "{{ backup-full-name }}" %}

#### backup.user {#backup-user}

{% include [backup.user](../_roles/backup/user.md) %}

{% endcut %}

{% cut "{{ mmy-full-name }}" %}

#### managed-mysql.clusters.connector {#managed-mysql-clusters-connector}

{% include [managed-mysql.clusters.connector](../_roles/managed-mysql/clusters/connector.md) %}

{% endcut %}

{% cut "{{ mpg-full-name }}" %}

#### managed-postgresql.clusters.connector {#managed-postgresql-clusters-connector}

{% include [managed-postgresql.clusters.connector](../_roles/managed-postgresql/clusters/connector.md) %}

{% endcut %}

{% cut "{{ monium-full-name }}" %}

#### monium.admin {#monium-admin}

{% include [monium.admin](../_roles/monium/admin.md) %}

#### monium.editor {#monium-editor}

{% include [monium.editor](../_roles/monium/editor.md) %}

#### monium.viewer {#monium-viewer}

{% include [monium.viewer](../_roles/monium/viewer.md) %}

#### monium.auditor {#monium-auditor}

{% include [monium.auditor](../_roles/monium/auditor.md) %}

#### monium.alerts.editor {#monium-alerts-editor}

{% include [monium.alerts.editor](../_roles/monium/alerts/editor.md) %}

#### monium.alerts.viewer {#monium-alerts-viewer}

{% include [monium.alerts.viewer](../_roles/monium/alerts/viewer.md) %}

#### monium.channels.editor {#monium-channels-editor}

{% include [monium.channels.editor](../_roles/monium/channels/editor.md) %}

#### monium.channels.viewer {#monium-channels-viewer}

{% include [monium.channels.viewer](../_roles/monium/channels/viewer.md) %}

#### monium.contextLinks.editor {#monium-contextlinks-editor}

{% include [monium.contextLinks.editor](../_roles/monium/contextLinks/editor.md) %}

#### monium.contextLinks.viewer {#monium-contextlinks-viewer}

{% include [monium.contextLinks.viewer](../_roles/monium/contextLinks/viewer.md) %}

#### monium.dashboards.editor {#monium-dashboards-editor}

{% include [monium.dashboards.editor](../_roles/monium/dashboards/editor.md) %}

#### monium.dashboards.viewer {#monium-dashboards-viewer}

{% include [monium.dashboards.viewer](../_roles/monium/dashboards/viewer.md) %}

#### monium.escalationPolicies.editor {#monium-escalationpolicies-editor}

{% include [monium.escalationPolicies.editor](../_roles/monium/escalationPolicies/editor.md) %}

#### monium.escalationPolicies.viewer {#monium-escalationpolicies-viewer}

{% include [monium.escalationPolicies.viewer](../_roles/monium/escalationPolicies/viewer.md) %}

#### monium.escalations.editor {#monium-escalations-editor}

{% include [monium.escalations.editor](../_roles/monium/escalations/editor.md) %}

#### monium.escalations.viewer {#monium-escalations-viewer}

{% include [monium.escalations.viewer](../_roles/monium/escalations/viewer.md) %}

#### monium.logErrorLabels.editor {#monium-logerrorlabels-editor}

{% include [monium.logErrorLabels.editor](../_roles/monium/logErrorLabels/editor.md) %}

#### monium.logErrorLabels.viewer {#monium-logerrorlabels-viewer}

{% include [monium.logErrorLabels.viewer](../_roles/monium/logErrorLabels/viewer.md) %}

#### monium.logs.reader {#monium-logs-reader}

{% include [monium.logs.reader](../_roles/monium/logs/reader.md) %}

#### monium.logs.writer {#monium-logs-writer}

{% include [monium.logs.writer](../_roles/monium/logs/writer.md) %}

#### monium.metrics.reader {#monium-metrics-reader}

{% include [monium.metrics.reader](../_roles/monium/metrics/reader.md) %}

#### monium.metrics.writer {#monium-metrics-writer}

{% include [monium.metrics.writer](../_roles/monium/metrics/writer.md) %}

#### monium.mutes.editor {#monium-mutes-editor}

{% include [monium.mutes.editor](../_roles/monium/mutes/editor.md) %}

#### monium.mutes.viewer {#monium-mutes-viewer}

{% include [monium.mutes.viewer](../_roles/monium/mutes/viewer.md) %}

#### monium.quickLinks.editor {#monium-quicklinks-editor}

{% include [monium.quickLinks.editor](../_roles/monium/quickLinks/editor.md) %}

#### monium.quickLinks.viewer {#monium-quicklinks-viewer}

{% include [monium.quickLinks.viewer](../_roles/monium/quickLinks/viewer.md) %}

#### monium.serviceLevelObjectives.editor {#monium-servicelevelobjectives-editor}

{% include [monium.serviceLevelObjectives.editor](../_roles/monium/serviceLevelObjectives/editor.md) %}

#### monium.serviceLevelObjectives.viewer {#monium-servicelevelobjectives-viewer}

{% include [monium.serviceLevelObjectives.viewer](../_roles/monium/serviceLevelObjectives/viewer.md) %}

#### monium.shards.editor {#monium-shards-editor}

{% include [monium.shards.editor](../_roles/monium/shards/editor.md) %}

#### monium.shards.viewer {#monium-shards-viewer}

{% include [monium.shards.viewer](../_roles/monium/shards/viewer.md) %}

#### monium.telemetry.reader {#monium-telemetry-reader}

{% include [monium.telemetry.reader](../_roles/monium/telemetry/reader.md) %}

#### monium.telemetry.writer {#monium-telemetry-writer}

{% include [monium.telemetry.writer](../_roles/monium/telemetry/writer.md) %}

#### monium.traces.reader {#monium-traces-reader}

{% include [monium.traces.reader](../_roles/monium/traces/reader.md) %}

#### monium.traces.writer {#monium-traces-writer}

{% include [monium.traces.writer](../_roles/monium/traces/writer.md) %}

{% endcut %}

{% cut "{{ mgp-full-name }}" %}

#### managed-greenplum.clusters.connector {#managed-greenplum-clusters-connector}

{% include [managed-greenplum.clusters.connector](../_roles/managed-greenplum/clusters/connector.md) %}

{% endcut %}

{% cut "{{ sd-full-name }}" %}

#### security-deck.alertSinks.admin {#security-deck-alertsinks-admin}

{% include [security-deck.alertSinks.admin](../_roles/security-deck/alertSinks/admin.md) %}

#### security-deck.alertSinks.editor {#security-deck-alertsinks-editor}

{% include [security-deck.alertSinks.editor](../_roles/security-deck/alertSinks/editor.md) %}

#### security-deck.alertSinks.user {#security-deck-alertsinks-user}

{% include [security-deck.alertSinks.user](../_roles/security-deck/alertSinks/user.md) %}

#### security-deck.alertSinks.viewer {#security-deck-alertsinks-viewer}

{% include [security-deck.alertSinks.viewer](../_roles/security-deck/alertSinks/viewer.md) %}

#### security-deck.alertSinks.auditor {#security-deck-alertsinks-auditor}

{% include [security-deck.alertSinks.auditor](../_roles/security-deck/alertSinks/auditor.md) %}

{% endcut %}

## November 2025 {#november-2025}

### {{ iam-name }} updates {#iam-november-2025}

* [Added](../organization/operations/view-subject-access-bindings.md) the ability to view a list of a subject's accesses.

### New roles {#roles-november-2025}

{% cut "{{ interconnect-full-name }}" %}

#### cic.admin {#cic-admin}

{% include [cic.admin](../_roles/cic/admin.md) %}

{% endcut %}

{% cut "{{ cr-full-name }}" %}

#### cloud-router.admin {#cloud-router-admin}

{% include [cloud-router.admin](../_roles/cloud-router/admin.md) %}

#### cloud-router.prefixEditor {#cloud-router-prefixeditor}

{% include [cloud-router.prefixEditor](../_roles/cloud-router/prefixEditor.md) %}

{% endcut %}

{% cut "{{ org-full-name }}" %}

#### organization-manager.idpInstances.billingAdmin {#organization-manager-idpinstances-billingadmin}

{% include [organization-manager.idpInstances.billingAdmin](../_roles/organization-manager/idpInstances/billingAdmin.md) %}

#### organization-manager.idpInstances.billingViewer {#organization-manager-idpinstances-billingviewer}

{% include [organization-manager.idpInstances.billingViewer](../_roles/organization-manager/idpInstances/billingViewer.md) %}

{% endcut %}

## October 2025 {#october-2025}

### {{ iam-name }} updates {#iam-october-2025}

* [Added](operations/service-control/enable-disable.md) the ability to manage the access of services to the user's resources.

### New roles {#roles-october-2025}

{% cut "Managed databases" %}

#### mdb.restorer {#mdb-restorer}

{% include [mdb.restorer](../_roles/mdb/restorer.md) %}

{% endcut %}

{% cut "{{ org-full-name }}" %}

#### organization-manager.groups.externalConverter {#organization-manager-groups-externalconverter}

{% include [organization-manager.groups.externalConverter](../_roles/organization-manager/groups/externalConverter.md) %}

#### organization-manager.groups.externalCreator {#organization-manager-groups-externalcreator}

{% include [organization-manager.groups.externalCreator](../_roles/organization-manager/groups/externalCreator.md) %}

#### organization-manager.userpools.syncAgent {#organization-manager-userpools-syncagent}

{% include [organization-manager.userpools.syncAgent](../_roles/organization-manager/userpools/syncAgent.md) %}

{% endcut %}

{% cut "{{ mkf-full-name }}" %}

#### managed-kafka.restorer {#managed-kafka-restorer}

{% include [managed-kafka.restorer](../_roles/managed-kafka/restorer.md) %}

{% endcut %}

{% cut "{{ mch-full-name }}" %}

#### managed-clickhouse.restorer {#managed-clickhouse-restorer}

{% include [managed-clickhouse.restorer](../_roles/managed-clickhouse/restorer.md) %}

{% endcut %}


{% cut "{{ mmy-full-name }}" %}

#### managed-mysql.restorer {#managed-mysql-restorer}

{% include [managed-mysql.restorer](../_roles/managed-mysql/restorer.md) %}

{% endcut %}

{% cut "{{ mos-full-name }}" %}

#### managed-opensearch.restorer {#managed-opensearch-restorer}

{% include [managed-opensearch.restorer](../_roles/managed-opensearch/restorer.md) %}

{% endcut %}

{% cut "{{ mpg-full-name }}" %}

#### managed-postgresql.restorer {#managed-postgresql-restorer}

{% include [managed-postgresql.restorer](../_roles/managed-postgresql/restorer.md) %}

{% endcut %}

{% cut "{{ mspqr-full-name }}" %}

#### managed-spqr.restorer {#managed-spqr-restorer}

{% include [managed-spqr.restorer](../_roles/managed-spqr/restorer.md) %}

{% endcut %}


{% cut "{{ mrd-full-name }}" %}

#### managed-redis.restorer {#managed-redis-restorer}

{% include [managed-redis.restorer](../_roles/managed-redis/restorer.md) %}

{% endcut %}

{% cut "{{ mgp-full-name }}" %}

#### managed-greenplum.restorer {#managed-greenplum-restorer}

{% include [managed-greenplum.restorer](../_roles/managed-greenplum/restorer.md) %}

{% endcut %}

{% cut "{{ mmg-full-name }}" %}

#### managed-mongodb.restorer {#managed-mongodb-restorer}

{% include [managed-mongodb.restorer](../_roles/managed-mongodb/restorer.md) %}

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
