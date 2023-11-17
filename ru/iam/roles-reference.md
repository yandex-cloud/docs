---
title: "Справочник ролей {{ yandex-cloud }}"
description: "В статье приведен полный справочник и описание ролей, действующих в сервисах {{ yandex-cloud }}."
---

# Справочник ролей {{ yandex-cloud }}


## Служебные роли {#auxiliary-roles}

#### quota-manager.requestOperator {#quota-manager-requestoperator}

{% include [quota-manager.requestOperator](../_roles/auxiliary/quotamanager-requestoperator.md) %}


## Управляемые базы данных {#mdb}

#### mdb.auditor {#mdb-auditor}

{% include [mdb-auditor](../_roles/mdb/mdb-auditor.md) %}

#### mdb.viewer {#mdb-viewer}

{% include [mdb-viewer](../_roles/mdb/mdb-viewer.md) %}

#### mdb.admin {#mdb-admin}

{% include [mdb-admin](../_roles/mdb/mdb-admin.md) %}


## Сервисы искусственного интеллекта {#ai-services}

#### ai.auditor {#ai-auditor}

{% include [ai-auditor](../_roles/ai/ai-auditor.md) %}

#### ai.viewer {#ai-viewer}

{% include [ai-viewer](../_roles/ai/ai-viewer.md) %}

#### ai.editor {#ai-editor}

{% include [ai-editor](../_roles/ai/ai-editor.md) %}

#### ai.admin {#ai-admin}

{% include [ai-admin](../_roles/ai/ai-admin.md) %}


## {{ api-gw-full-name }} {#api-gateway-roles}

#### api-gateway.viewer {#api-gateway-viewer}

{% include [api-gateway.viewer](../_roles/apigateway/apigateway-viewer.md) %}

#### api-gateway.editor {#api-gateway-editor}

{% include [api-gateway.editor](../_roles/apigateway/apigateway-editor.md) %}

#### api-gateway.websocketWriter {#api-gateway-websocketwriter}

{% include [api-gateway.websocketWriter](../_roles/apigateway/apigateway-websocketwriter.md) %}

#### api-gateway.admin {#api-gateway-admin}

{% include [api-gateway.admin](../_roles/apigateway/apigateway-admin.md) %}

Подробнее см. [{#T}](../api-gateway/security/index.md).


## {{ alb-full-name }} {#alb-roles}

#### alb.viewer {#alb-viewer}

{% include [alb.viewer](../_roles/apploadbalancer/apploadbalancer-viewer.md) %}

#### alb.editor {#alb-editor}

{% include [alb.editor](../_roles/apploadbalancer/apploadbalancer-editor.md) %}

#### alb.admin {#alb-admin}

{% include [alb.admin](../_roles/apploadbalancer/apploadbalancer-admin.md) %}

Подробнее см. [{#T}](../application-load-balancer/security/index.md).


## {{ at-full-name }} {#at-roles}

#### audit-trails.auditor {#at-auditor}

{% include [audit-trails.auditor](../_roles/audittrails/audittrails-auditor.md) %}

#### audit-trails.viewer {#at-viewer}

{% include [audit-trails.viewer](../_roles/audittrails/audittrails-viewer.md) %}

#### audit-trails.editor {#at-editor}

{% include [audit-trails.editor](../_roles/audittrails/audittrails-editor.md) %}

#### audit-trails.admin {#at-admin}

{% include [audit-trails.admin](../_roles/audittrails/audittrails-admin.md) %}

#### audit-trails.configViewer {#at-configviewer}

{% include [audit-trails.configviewer](../_roles/audittrails/audittrails-configviewer.md) %}

Подробнее см. [{#T}](../audit-trails/security/index.md).


## {{ certificate-manager-full-name }} {#certificate-manager-roles}

#### certificate-manager.admin {#certificate-manager-admin}

{% include [certificate-manager.admin](../_roles/certificatemanager/certificatemanager-admin.md) %}

#### certificate-manager.certificates.downloader {#certificate-manager-certificates-downloader}

{% include [certificate-manager.certificates.downloader](../_roles/certificatemanager/certificatemanager-certificates-downloader.md) %}

Подробнее см. [{#T}](../certificate-manager/security/index.md).


## {{ backup-full-name }} {#backup-roles}

#### backup.viewer {#backup-viewer}

{% include [backup.viewer](../_roles/backup/backup-viewer.md) %}

#### backup.editor {#backup-editor}

{% include [backup.editor](../_roles/backup/backup-editor.md) %}

#### backup.admin {#backup-admin}

{% include [backup.admin](../_roles/backup/backup-admin.md) %}

Подробнее см. [{#T}](../backup/security/index.md).


## {{ billing-name }} {#billing-roles}

#### billing.accounts.member {#billing-accounts-member}

{% include [billing.accounts.member](../_roles/billing/billing-accounts-member.md) %}

#### billing.accounts.owner {#billing-accounts-owner}

{% include [billing.accounts.owner](../_roles/billing/billing-accounts-owner.md) %}

#### billing.accounts.viewer {#billing-accounts-viewer}

{% include [billing.accounts.viewer](../_roles/billing/billing-accounts-viewer.md) %}

#### billing.accounts.editor {#billing-accounts-editor}

{% include [billing.accounts.editor](../_roles/billing/billing-accounts-editor.md) %}

#### billing.accounts.admin {#billing-accounts-admin}

{% include [billing.accounts.admin](../_roles/billing/billing-accounts-admin.md) %}

#### billing.accounts.varWithoutDiscounts {#billing-accounts-var-without-discounts}

{% include [billing.accounts.varwithoutdiscounts](../_roles/billing/billing-accounts-varWithoutDiscounts.md) %}

#### billing.partners.editor {#billing-partners-editor}

{% include [billing.partners.editor](../_roles/billing/billing-partners-editor.md) %}

Подробнее см. [{#T}](../billing/security/index.md).


## {{ cdn-full-name }} {#cdn-roles}

#### cdn.viewer {#cdn-viewer}

{% include [cdn-viewer](../_roles/cdn/cdn-viewer.md) %}

#### cdn.editor {#cdn-editor}

{% include [cdn-editor](../_roles/cdn/cdn-editor.md) %}

#### cdn.admin {#cdn-admin}

{% include [cdn-admin](../_roles/cdn/cdn-admin.md) %}

Подробнее см. [{#T}](../cdn/security/index.md).


## {{ dns-full-name }} {#dns-roles}

#### dns.auditor {#dns-auditor}

{% include [roles-dns-auditor](../_roles/dns/dns-auditor.md) %}

#### dns.viewer {#dns-viewer}

{% include [roles-dns-viewer](../_roles/dns/dns-viewer.md) %}

#### dns.editor {#dns-editor}

{% include [roles-dns-editor](../_roles/dns/dns-editor.md) %}

#### dns.admin {#dns-admin}

{% include [roles-dns-admin](../_roles/dns/dns-admin.md) %}

Подробнее см. [{#T}](../dns/security/index.md).


## {{ sf-full-name }} {#functions-roles}

#### functions.auditor {#functions-auditor}

{% include [functions.auditor](../_roles/functions/functions-auditor.md) %}

#### functions.viewer {#functions-viewer}

{% include [functions.viewer](../_roles/functions/functions-viewer.md) %}

#### functions.functionInvoker {#functions-functionInvoker}

{% include [functions.functionInvoker](../_roles/functions/functions-functioninvoker.md) %}

#### functions.editor {#functions-editor}

{% include [functions.editor](../_roles/functions/functions-editor.md) %}

#### functions.mdbProxiesUser {#functions-mdbProxiesUser}

{% include [functions.mdbProxiesUser](../_roles/functions/functions-mdbproxiesuser.md) %}

#### functions.admin {#functions-admin}

{% include [functions.admin](../_roles/functions/functions-admin.md) %}

Подробнее см. [{#T}](../functions/security/index.md).


## {{ cloud-logging-full-name }} {#logging-roles}

#### logging.viewer {#logging-viewer}

{% include [logging.viewer](../_roles/logging/logging-viewer.md) %}

#### logging.editor {#logging-editor}

{% include [logging.editor](../_roles/logging/logging-editor.md) %}

#### logging.reader {#logging-reader}

{% include [logging.reader](../_roles/logging/logging-reader.md) %}

#### logging.writer {#logging-writer}

{% include [logging.writer](../_roles/logging/logging-writer.md) %}

#### logging.admin {#logging-admin}

{% include [logging.admin](../_roles/logging/logging-admin.md) %}

Подробнее см. [{#T}](../logging/security/index.md).


## {{ org-full-name }} {#organization-roles}

#### organization-manager.viewer {#organization-manager-viewer}

{% include [organizationmanager-viewer](../_roles/organizationmanager/organizationmanager-viewer.md) %}

#### organization-manager.admin {#organization-manager-admin}

{% include [organizationmanager-admin](../_roles/organizationmanager/organizationmanager-admin.md) %}

#### organization-manager.organizations.owner {#organization-manager-organizations-owner}

{% include [organizationmanager-organizations-owner](../_roles/organizationmanager/organizationmanager-organizations-owner.md) %}

#### organization-manager.osLogins.viewer {#organization-manager-osLogins-viewer}

{% include [organizationmanager-oslogins-viewer](../_roles/organizationmanager/organizationmanager-oslogins-viewer.md) %}

#### organization-manager.osLogins.admin {#organization-manager-osLogins-admin}

{% include [organizationmanager-oslogins-admin](../_roles/organizationmanager/organizationmanager-oslogins-admin.md) %}

#### organization-manager.groups.memberAdmin {#organization-manager-groups-memberAdmin}

{% include [organizationmanager-groups-memberAdmin](../_roles/organizationmanager/organizationmanager-groups-memberAdmin.md) %}

Подробнее см. [{#T}](../organization/security/index.md).


## {{ compute-full-name }} {#compute-roles}

#### compute.viewer {#compute-viewer}

{% include [compute.viewer](../_roles/compute/compute-viewer.md) %}

#### compute.editor {#compute-editor}

{% include [compute.editor](../_roles/compute/compute-editor.md) %}

#### compute.admin {#compute-admin}

{% include [compute.admin](../_roles/compute/compute-admin.md) %}

#### compute.osLogin {#compute-oslogin}

{% include [compute.oslogin](../_roles/compute/compute-oslogin.md) %}

#### compute.osAdminLogin {#compute-osadminlogin}

{% include [compute.osadminlogin](../_roles/compute/compute-osadminlogin.md) %}

#### compute.disks.user {#compute-disks-user}

{% include [compute.disks.user](../_roles/compute/compute-disks-user.md) %}

#### compute.images.user {#compute-images-user}

{% include [compute.images.user](../_roles/compute/compute-images-user.md) %}

#### compute.operator {#compute-operator}

{% include [compute.operator](../_roles/compute/compute-operator.md) %}

#### compute.snapshotSchedules.viewer {#compute-snapshotSchedules-viewer}

{% include [compute.snapshotSchedules.viewer](../_roles/compute/compute-snapshotschedules-viewer.md) %}

#### compute.snapshotSchedules.editor {#compute-snapshotSchedules-editor}

{% include [compute.snapshotSchedules.editor](../_roles/compute/compute-snapshotschedules-editor.md) %}

Подробнее см. [{#T}](../compute/security/index.md).


## {{ container-registry-full-name }} {#cr-roles}

#### container-registry.viewer {#container-registry.viewer}

{% include [container-registry.viewer](../_roles/containerregistry/containerregistry-viewer.md) %}

#### container-registry.editor {#container-registry.editor}

{% include [container-registry.editor](../_roles/containerregistry/containerregistry-editor.md) %}

#### container-registry.admin {#container-registry.admin}

{% include [container-registry.admin](../_roles/containerregistry/containerregistry-admin.md) %}

#### container-registry.images.pusher {#container-registry-images-pusher}

{% include [container-registry.images.pusher](../_roles/containerregistry/containerregistry-images-pusher.md) %}

#### container-registry.images.puller {#container-registry-images-puller}

{% include [container-registry.images.puller](../_roles/containerregistry/containerregistry-images-puller.md) %}

#### container-registry.images.scanner {#container-registry-images-scanner}

{% include [container-registry.images.scanner](../_roles/containerregistry/containerregistry-images-scanner.md) %}

Подробнее см. [{#T}](../container-registry/security/index.md).


## {{ datalens-full-name }} {#datalens-roles}

#### datalens.visitor {#datalens-visitor}

{% include [datalens-visitor](../_roles/datalens/datalens-visitor.md) %}

#### datalens.creator {#datalens-creator}

{% include [datalens-creator](../_roles/datalens/datalens-creator.md) %}

#### datalens.admin {#datalens-admin}

{% include [datalens-admin](../_roles/datalens/datalens-admin.md) %}

#### datalens.instances.user {#datalens-instances-user}

{% include [datalens-instances-user](../_roles/datalens/datalens-instances-user.md) %}

#### datalens.instances.admin {#datalens-instances-admin}

{% include [datalens-instances-admin](../_roles/datalens/datalens-instances-admin.md) %}

Подробнее см. [{#T}](../datalens/security/roles.md).


## {{ dataproc-full-name }} {#dataproc-roles}

#### dataproc.agent {#dataproc-agent}

{% include [dataproc.agent](../_roles/dataproc/dataproc-agent.md) %}

#### mdb.dataproc.agent {#mdb-dataproc-agent}

{% include [mdb.dataproc.agent](../_roles/dataproc/mdb-dataproc-agent.md) %}

#### dataproc.auditor {#dataproc-auditor}

{% include [dataproc.auditor](../_roles/dataproc/dataproc-auditor.md) %}

#### dataproc.viewer {#dataproc-viewer}

{% include [dataproc.viewer](../_roles/dataproc/dataproc-viewer.md) %}

#### dataproc.user {#dataproc-user}

{% include [dataproc.user](../_roles/dataproc/dataproc-user.md) %}

#### dataproc.provisioner {#dataproc-provisioner}

{% include [dataproc.provisioner](../_roles/dataproc/dataproc-provisioner.md) %}

#### dataproc.editor {#dataproc-editor}

{% include [dataproc.editor](../_roles/dataproc/dataproc-editor.md) %}

#### dataproc.admin {#dataproc-admin}

{% include [dataproc.admin](../_roles/dataproc/dataproc-admin.md) %}

#### managed-metastore.auditor {#managed-metastore-auditor}

{% include [managed-metastore.auditor](../_roles/dataproc/managedmetastore-auditor.md) %}

#### managed-metastore.viewer {#managed-metastore-viewer}

{% include [managed-metastore.viewer](../_roles/dataproc/managedmetastore-viewer.md) %}

#### managed-metastore.editor {#managed-metastore-editor}

{% include [managed-metastore.editor](../_roles/dataproc/managedmetastore-editor.md) %}

#### managed-metastore.admin {#managed-metastore-admin}

{% include [managed-metastore.admin](../_roles/dataproc/managedmetastore-admin.md) %}

Подробнее см. [{#T}](../data-proc/security/index.md).


## {{ ml-platform-full-name }} {#datasphere-roles}

#### datasphere.community-projects.viewer {#datasphere-communityprojects-viewer}

{% include [datasphere.community-projects.viewer](../_roles/datasphere/datasphere-communityprojects-viewer.md) %}

#### datasphere.community-projects.developer {#datasphere-communityprojects-developer}

{% include [datasphere.community-projects.developer](../_roles/datasphere/datasphere-communityprojects-developer.md) %}

#### datasphere.community-projects.editor {#datasphere-communityprojects-editor}

{% include [datasphere.community-projects.editor](../_roles/datasphere/datasphere-communityprojects-editor.md) %}

#### datasphere.community-projects.admin {#datasphere-communityprojects-admin}

{% include [datasphere.community-projects.admin](../_roles/datasphere/datasphere-communityprojects-admin.md) %}

#### datasphere.communities.viewer {#datasphere-communities-viewer}

{% include [datasphere.communities.viewer](../_roles/datasphere/datasphere-communities-viewer.md) %}

#### datasphere.communities.developer {#datasphere-communities-developer}

{% include [datasphere.communities.developer](../_roles/datasphere/datasphere-communities-developer.md) %}

#### datasphere.communities.editor {#datasphere-communities-editor}

{% include [datasphere.communities.editor](../_roles/datasphere/datasphere-communities-editor.md) %}

#### datasphere.communities.admin {#datasphere-communities-admin}

{% include [datasphere.communities.admin](../_roles/datasphere/datasphere-communities-admin.md) %}

#### datasphere.user {#datasphere-user}

{% include [datasphere.user](../_roles/datasphere/datasphere-user.md) %}

#### datasphere.admin {#datasphere-admin}

{% include [datasphere.admin](../_roles/datasphere/datasphere-admin.md) %}

Подробнее см. [{#T}](../datasphere/security/index.md).


## {{ yds-full-name }} {#yds-roles}

#### yds.viewer {#yds-viewer}

{% include [yds.viewer](../_roles/yds/yds-viewer.md) %}

#### yds.writer {#yds-writer}

{% include [yds.writer](../_roles/yds/yds-writer.md) %}

#### yds.editor {#yds-editor}

{% include [yds.editor](../_roles/yds/yds-editor.md) %}

#### yds.admin {#yds-admin}

{% include [yds.admin](../_roles/yds/yds-admin.md) %}

Подробнее см. [{#T}](../data-streams/security/index.md).


## {{ data-transfer-full-name }} {#data-transfer-roles}

#### data-transfer.auditor {#data-transfer-auditor}

{% include [data-transfer.auditor](../_roles/datatransfer/datatransfer-auditor.md) %}

#### data-transfer.viewer {#data-transfer-viewer}

{% include [data-transfer.viewer](../_roles/datatransfer/datatransfer-viewer.md) %}

#### data-transfer.privateAdmin {#data-transfer-privateadmin}

{% include [data-transfer.privateadmin](../_roles/datatransfer/datatransfer-privateadmin.md) %}

#### data-transfer.admin {#data-transfer-admin}

{% include [data-transfer.admin](../_roles/datatransfer/datatransfer-admin.md) %}

Подробнее см. [{#T}](../data-transfer/security/index.md).


## {{ yagpt-full-name }} {#yagpt-roles}

#### ai.languageModels.user {#languageModels-user}

{% include [yandexgpt-user](../_roles/llm/llm-user.md) %}

Подробнее см. [{#T}](../yandexgpt/security/index.md).


## {{ iam-full-name }} {#iam-roles}

#### iam.serviceAccounts.user {#iam-serviceAccounts-user}

{% include [iam.serviceAccounts.user](../_roles/iam/iam-serviceAccounts-user.md) %}

#### iam.serviceAccounts.admin {#iam-serviceAccounts-admin}

{% include [iam.serviceAccounts.admin](../_roles/iam/iam-serviceAccounts-admin.md) %}

#### iam.serviceAccounts.accessKeyAdmin {#iam-serviceAccounts-accessKeyAdmin}

{% include [iam.serviceAccounts.accessKeyAdmin](../_roles/iam/iam-serviceAccounts-accessKeyAdmin.md) %}

#### iam.serviceAccounts.apiKeyAdmin {#iam-serviceAccounts-apiKeyAdmin}

{% include [iam.serviceAccounts.apiKeyAdmin](../_roles/iam/iam-serviceAccounts-apiKeyAdmin.md) %}

#### iam.serviceAccounts.authorizedKeyAdmin {#iam-serviceAccounts-authorizedKeyAdmin}

{% include [iam.serviceAccounts.authorizedKeyAdmin](../_roles/iam/iam-serviceAccounts-authorizedKeyAdmin.md) %}

#### iam.serviceAccounts.keyAdmin {#iam-serviceAccounts-keyAdmin}

{% include [iam.serviceAccounts.keyAdmin](../_roles/iam/iam-serviceAccounts-keyAdmin.md) %}

#### iam.serviceAccounts.tokenCreator {#iam-serviceAccounts-tokenCreator}

{% include [iam.serviceAccounts.tokenCreator](../_roles/iam/iam-serviceAccounts-tokenCreator.md) %}

#### iam.auditor {#iam-auditor}

{% include [iam.auditor](../_roles/iam/iam-auditor.md) %}

#### iam.viewer {#iam-viewer}

{% include [iam.viewer](../_roles/iam/iam-viewer.md) %}

#### iam.editor {#iam-editor}

{% include [iam.editor](../_roles/iam/iam-editor.md) %}

#### iam.admin {#iam-admin}

{% include [iam.admin](../_roles/iam/iam-admin.md) %}

Подробнее см. [{#T}](../iam/security/index.md).


## {{ iot-full-name }} {#iot-core-roles}

#### iot.devices.writer {#iot-devices-writer}

{% include [iot-devices-writer](../_roles/iot/iot-devices-writer.md) %}

#### iot.registries.writer {#iot-registries-writer}

{% include [iot-registries-writer](../_roles/iot/iot-registries-writer.md) %}

#### iot.auditor {#iot-auditor}

{% include [iot-auditor](../_roles/iot/iot-auditor.md) %}

#### iot.viewer {#iot-viewer}

{% include [iot-viewer](../_roles/iot/iot-viewer.md) %}

#### iot.editor {#iot-editor}

{% include [iot-editor](../_roles/iot/iot-editor.md) %}

Подробнее см. [{#T}](../iot-core/security/index.md).


## {{ kms-full-name }} {#kms-roles}

#### kms.keys.encrypter {#kms-keys-encrypter}

{% include [kms.keys.encrypter](../_roles/kms/kms-keys-encrypter.md) %}

#### kms.keys.decrypter {#kms-keys-decrypter}

{% include [kms.keys.decrypter](../_roles/kms/kms-keys-decrypter.md) %}

#### kms.keys.encrypterDecrypter {#kms-keys-encrypterDecrypter}

{% include [kms.keys.encrypterDecrypter](../_roles/kms/kms-keys-encrypterdecrypter.md) %}

#### kms.asymmetricEncryptionKeys.publicKeyViewer {#kms-asymmetricEncryptionKeys-publicKeyViewer}

{% include [kms.asymmetricEncryptionKeys.publicKeyViewer](../_roles/kms/kms-asymmetricEncryptionKeys-publicKeyViewer.md) %}

#### kms.asymmetricSignatureKeys.publicKeyViewer {#kms-asymmetricSignatureKeys-publicKeyViewer}

{% include [kms.asymmetricSignatureKeys.publicKeyViewer](../_roles/kms/kms-asymmetricSignatureKeys-publicKeyViewer.md) %}

#### kms.asymmetricSignatureKeys.signer {#kms-asymmetricSignatureKeys-signer}

{% include [kms.asymmetricSignatureKeys.signer](../_roles/kms/kms-asymmetricSignatureKeys-signer.md) %}

#### kms.asymmetricEncryptionKeys.decrypter {#kms-asymmetricEncryptionKeys-decrypter}

{% include [kms.asymmetricEncryptionKeys.decrypter](../_roles/kms/kms-asymmetricEncryptionKeys-decrypter.md) %}

#### kms.auditor {#kms-auditor}

{% include [kms.auditor](../_roles/kms/kms-auditor.md) %}

#### kms.viewer {#kms-viewer}

{% include [kms.viewer](../_roles/kms/kms-viewer.md) %}

#### kms.editor {#kms-editor}

{% include [kms.editor](../_roles/kms/kms-editor.md) %}

#### kms.admin {#kms-admin}

{% include [kms.admin](../_roles/kms/kms-admin.md) %}

Подробнее см. [{#T}](../kms/security/index.md).


## {{ load-testing-full-name }} {#load-testing-roles}

#### loadtesting.viewer {#loadtesting-viewer}

{% include [loadtesting.viewer](../_roles/loadtesting/loadtesting-viewer.md) %}

#### loadtesting.editor {#loadtesting-editor}

{% include [loadtesting.editor](../_roles/loadtesting/loadtesting-editor.md) %}

#### loadtesting.admin {#loadtesting-admin}

{% include [loadtesting.admin](../_roles/loadtesting/loadtesting-admin.md) %}

#### loadtesting.loadTester {#loadtesting-loadtester}

{% include [loadtesting.loadtester](../_roles/loadtesting/loadtesting-loadtester.md) %}

#### loadtesting.generatorClient {#loadtesting-generatorclient}

{% include [loadtesting.generatorclient](../_roles/loadtesting/loadtesting-generatorclient.md) %}

Подробнее см. [{#T}](../load-testing/security/index.md).


## {{ lockbox-full-name }} {#lockbox-roles}

#### lockbox.viewer {#lockbox-viewer}

{% include [lockbox.viewer](../_roles/lockbox/lockbox-viewer.md) %}

#### lockbox.editor {#lockbox-editor}

{% include [lockbox.editor](../_roles/lockbox/lockbox-editor.md) %}

#### lockbox.admin {#lockbox-admin}

{% include [lockbox.admin](../_roles/lockbox/lockbox-admin.md) %}

#### lockbox.payloadViewer {#lockbox-payloadViewer}

{% include [lockbox.payloadViewer](../_roles/lockbox/lockbox-payloadViewer.md) %}

Подробнее см. [{#T}](../lockbox/security/index.md).


## {{ maf-full-name }} {#managed-airflow-roles}

#### managed-airflow.viewer {#managed-airflow-viewer}

{% include [managed-airflow.viewer](../_roles/airflow/airflow-viewer.md) %}

#### managed-airflow.editor {#managed-airflow-editor}

{% include [managed-airflow.editor](../_roles/airflow/airflow-editor.md) %}

#### managed-airflow.admin {#managed-airflow-admin}

{% include [managed-airflow.admin](../_roles/airflow/airflow-admin.md) %}

Подробнее см. [{#T}](../managed-airflow/security/index.md).


## {{ mkf-full-name }} {#managed-kafka-roles}

#### managed-kafka.auditor {#managed-kafka-auditor}

{% include [managed-kafka.auditor](../_roles/kafka/kafka-auditor.md) %}

#### managed-kafka.viewer {#managed-kafka-viewer}

{% include [managed-kafka.viewer](../_roles/kafka/kafka-viewer.md) %}

#### managed-kafka.editor {#managed-kafka-editor}

{% include [managed-kafka.editor](../_roles/kafka/kafka-editor.md) %}

#### managed-kafka.admin {#managed-kafka-admin}

{% include [managed-kafka.admin](../_roles/kafka/kafka-admin.md) %}

Подробнее см. [{#T}](../managed-kafka/security/index.md).


## {{ mch-full-name }} {#managed-clickhouse-roles}

#### managed-clickhouse.auditor {#managed-clickhouse-auditor}

{% include [managed-clickhouse.auditor](../_roles/clickhouse/clickhouse-auditor.md) %}

#### managed-clickhouse.viewer {#managed-clickhouse-viewer}

{% include [managed-clickhouse.viewer](../_roles/clickhouse/clickhouse-viewer.md) %}

#### managed-clickhouse.editor {#managed-clickhouse-editor}

{% include [managed-clickhouse.editor](../_roles/clickhouse/clickhouse-editor.md) %}

#### managed-clickhouse.admin {#managed-clickhouse-admin}

{% include [managed-clickhouse.admin](../_roles/clickhouse/clickhouse-admin.md) %}

Подробнее см. [{#T}](../managed-clickhouse/security/index.md).


## {{ mes-full-name }} {#managed-elasticsearch-roles}

#### managed-elasticsearch.viewer {#managed-elasticsearch-viewer}

{% include [managed-elasticsearch.viewer](../_roles/elasticsearch/elasticsearch-viewer.md) %}

#### managed-elasticsearch.editor {#managed-elasticsearch-editor}

{% include [managed-elasticsearch.editor](../_roles/elasticsearch/elasticsearch-editor.md) %}

#### managed-elasticsearch.admin {#managed-elasticsearch-admin}

{% include [managed-elasticsearch.admin](../_roles/elasticsearch/elasticsearch-admin.md) %}

Подробнее см. [{#T}](../managed-elasticsearch/security/index.md).


## {{ mgl-full-name }} {#managed-gitlab-roles}

#### gitlab.viewer {#gitlab-viewer}

{% include [gitlab.viewer](../_roles/gitlab/gitlab-viewer.md) %}

#### gitlab.editor {#gitlab-editor}

{% include [gitlab.editor](../_roles/gitlab/gitlab-editor.md) %}

#### gitlab.admin {#gitlab-admin}

{% include [gitlab.admin](../_roles/gitlab/gitlab-admin.md) %}

Подробнее см. [{#T}](../managed-gitlab/security/index.md).


## {{ mgp-full-name }} {#managed-greenplum-roles}

#### managed-greenplum.auditor {#managed-greenplum-auditor}

{% include [managed-greenplum.auditor](../_roles/greenplum/greenplum-auditor.md) %}

#### managed-greenplum.viewer {#managed-greenplum-viewer}

{% include [managed-greenplum.viewer](../_roles/greenplum/greenplum-viewer.md) %}

#### managed-greenplum.editor {#managed-greenplum-editor}

{% include [managed-greenplum.editor](../_roles/greenplum/greenplum-editor.md) %}

#### managed-greenplum.admin {#managed-greenplum-admin}

{% include [managed-greenplum.admin](../_roles/greenplum/greenplum-admin.md) %}

Подробнее см. [{#T}](../managed-greenplum/security/index.md).


## {{ managed-k8s-full-name }} {#managed-kubernetes-roles}

#### k8s.viewer {#k8s-viewer}

{% include [k8s.viewer](../_roles/k8s/k8s-viewer.md) %}

#### k8s.editor {#k8s-editor}

{% include [k8s.editor](../_roles/k8s/k8s-editor.md) %}

#### k8s.admin {#k8s-admin}

{% include [k8s.admin](../_roles/k8s/k8s-admin.md) %}

#### k8s.cluster-api.viewer {#k8s-cluster-api-viewer}

{% include [k8s.cluster-api.viewer](../_roles/k8s/k8s-clusterapi-viewer.md) %}

#### k8s.cluster-api.editor {#k8s-cluster-api-editor}

{% include [k8s.cluster-api.editor](../_roles/k8s/k8s-clusterapi-editor.md) %}

#### k8s.cluster-api.cluster-admin {#k8s-cluster-api-cluster-admin}

{% include [k8s.cluster-api.cluster-admin](../_roles/k8s/k8s-clusterapi-clusteradmin.md) %}

#### k8s.tunnelClusters.agent {#k8s-tunnelclusters-agent}

{% include [k8s.tunnelClusters.agent](../_roles/k8s/k8s-tunnelclusters-agent.md) %}

#### k8s.clusters.agent {#k8s-clusters-agent}

{% include [k8s.clusters.agent](../_roles/k8s/k8s-clusters-agent.md) %}

Подробнее см. [{#T}](../managed-kubernetes/security/index.md).


## {{ mmg-full-name }} {#managed-mongodb-roles}

#### managed-mongodb.auditor {#managed-mongodb-auditor}

{% include [managed-mongodb.auditor](../_roles/mongodb/mongodb-auditor.md) %}

#### managed-mongodb.viewer {#managed-mongodb-viewer}

{% include [managed-mongodb.viewer](../_roles/mongodb/mongodb-viewer.md) %}

#### managed-mongodb.editor {#managed-mongodb-editor}

{% include [managed-mongodb.editor](../_roles/mongodb/mongodb-editor.md) %}

#### managed-mongodb.admin {#managed-mongodb-admin}

{% include [managed-mongodb.admin](../_roles/mongodb/mongodb-admin.md) %}

Подробнее см. [{#T}](../managed-mongodb/security/index.md).


## {{ mmy-full-name }} {#managed-mysql-roles}

#### managed-mysql.auditor {managed-mysql-auditor}

{% include [managed-mysql.auditor](../_roles/mysql/mysql-auditor.md) %}

#### managed-mysql.viewer {managed-mysql-viewer}

{% include [managed-mysql.viewer](../_roles/mysql/mysql-viewer.md) %}

#### managed-mysql.editor {managed-mysql-editor}

{% include [managed-mysql.editor](../_roles/mysql/mysql-editor.md) %}

#### managed-mysql.admin {managed-mysql-admin}

{% include [managed-mysql.admin](../_roles/mysql/mysql-admin.md) %}

Подробнее см. [{#T}](../managed-mysql/security/index.md).


## {{ mos-full-name }} {#opensearch-roles}

#### managed-opensearch.auditor {#managed-opensearch-auditor}

{% include [opensearch.auditor](../_roles/opensearch/opensearch-auditor.md) %}

#### managed-opensearch.viewer {#managed-opensearch-viewer}

{% include [opensearch.viewer](../_roles/opensearch/opensearch-viewer.md) %}

#### managed-opensearch.editor {#managed-opensearch-editor}

{% include [opensearch.editor](../_roles/opensearch/opensearch-editor.md) %}

#### managed-opensearch.admin {#managed-opensearch-admin}

{% include [opensearch.admin](../_roles/opensearch/opensearch-admin.md) %}

Подробнее см. [{#T}](../managed-opensearch/security/index.md).


## {{ mpg-full-name }} {#mpg-roles}

#### managed-postgresql.auditor {#managed-postgresql-auditor}

{% include [managed-postgresql.auditor](../_roles/postgresql/postgresql-auditor.md) %}

#### managed-postgresql.viewer {#managed-postgresql-viewer}

{% include [managed-postgresql.viewer](../_roles/postgresql/postgresql-viewer.md) %}

#### managed-postgresql.editor {#managed-postgresql-editor}

{% include [managed-postgresql.editor](../_roles/postgresql/postgresql-editor.md) %}

#### managed-postgresql.admin {#managed-postgresql-admin}

{% include [managed-postgresql.admin](../_roles/postgresql/postgresql-admin.md) %}

Подробнее см. [{#T}](../managed-postgresql/security/index.md).


## {{ mrd-full-name }} {#mrd-roles}

#### managed-redis.auditor {#managed-redis-auditor}

{% include [managed-redis.auditor](../_roles/redis/redis-auditor.md) %}

#### managed-redis.viewer {#managed-redis-viewer}

{% include [managed-redis.viewer](../_roles/redis/redis-viewer.md) %}

#### managed-redis.editor {#managed-redis-editor}

{% include [managed-redis.editor](../_roles/redis/redis-editor.md) %}

#### managed-redis.admin {#managed-redis-admin}

{% include [managed-redis.admin](../_roles/redis/redis-admin.md) %}

Подробнее см. [{#T}](../managed-redis/security/index.md).


## {{ ydb-full-name }} {#ydb-roles}

#### ydb.viewer {#ydb-viewer}

{% include [ydb.viewer](../_roles/ydb/ydb-viewer.md) %}

#### ydb.editor {#ydb-editor}

{% include [ydb.editor](../_roles/ydb/ydb-editor.md) %}

#### ydb.admin {#ydb-admin}

{% include [ydb.admin](../_roles/ydb/ydb-admin.md) %}

#### ydb.kafkaApi.client {#ydb-kafkaapi-client}

{% include [ydb.kafkaApi.client](../_roles/ydb/ydb-kafkaapi-client.md) %}

Подробнее см. [{#T}](../ydb/security/index.md).


## {{ message-queue-full-name }} {#message-queue-roles}

#### ymq.reader {#ymq-reader}

{% include [ymq.reader](../_roles/ymq/ymq-reader.md) %}

#### ymq.writer {#ymq-writer}

{% include [ymq.writer](../_roles/ymq/ymq-writer.md) %}

#### ymq.admin {#ymq-admin}

{% include [ymq.admin](../_roles/ymq/ymq-admin.md) %}

Подробнее см. [{#T}](../message-queue/security/index.md).


## {{ monitoring-full-name }} {#monitoring-roles}

#### monitoring.viewer {#monitoring-viewer}

{% include [monitoring.viewer](../_roles/monitoring/monitoring-viewer.md) %}

#### monitoring.editor {#monitoring-editor}

{% include [monitoring.editor](../_roles/monitoring/monitoring-editor.md) %}

#### monitoring.admin {#monitoring-admin}

{% include [monitoring.admin](../_roles/monitoring/monitoring-admin.md) %}

Подробнее см. [{#T}](../monitoring/security/index.md).


## {{ network-load-balancer-full-name }} {#network-load-balancer-roles}

#### load-balancer.viewer {#load-balancer-viewer}

{% include [loadbalancer-viewer](../_roles/loadbalancer/loadbalancer-viewer.md) %}

#### load-balancer.privateAdmin {#load-balancer-private-admin}

{% include [loadbalancer-privateadmin](../_roles/loadbalancer/loadbalancer-privateadmin.md) %}

#### load-balancer.admin {#load-balancer-admin}

{% include [loadbalancer-admin](../_roles/loadbalancer/loadbalancer-admin.md) %}

Подробнее см. [{#T}](../network-load-balancer/security/index.md).


## {{ objstorage-full-name }} {#storage-roles}

#### storage.viewer {#storage-viewer}

{% include [storage-viewer](../_roles/storage/storage-viewer.md) %}

#### storage.configViewer {#storage-config-viewer}

{% include [storage-configviewer](../_roles/storage/storage-configviewer.md) %}

#### storage.configurer {#storage-configurer}

{% include [storage-configurer](../_roles/storage/storage-configurer.md) %}

#### storage.uploader {#storage-uploader}

{% include [storage-uploader](../_roles/storage/storage-uploader.md) %}

#### storage.editor {#storage-editor}

{% include [storage-editor](../_roles/storage/storage-editor.md) %}

#### storage.admin {#storage-admin}

{% include [storage-admin](../_roles/storage/storage-admin.md) %}

Подробнее см. [{#T}](../storage/security/index.md).


## {{ yq-full-name }} {#query-roles}

#### yq.viewer {#query-viewer}

{% include [query.viewer](../_roles/yq/yq-viewer.md) %}

#### yq.editor {#query-editor}

{% include [query.editor](../_roles/yq/yq-editor.md) %}

#### yq.admin {#query-admin}

{% include [query.admin](../_roles/yq/yq-admin.md) %}

#### yq.invoker {#query-invoker}

{% include [query.invoker](../_roles/yq/yq-invoker.md) %}

Подробнее см. [{#T}](../query/security/index.md).


## {{ resmgr-full-name }} {#resource-manager-roles}

#### resource-manager.auditor {#resource-manager-auditor}

{% include [resourcemanager-auditor](../_roles/resourcemanager/resourcemanager-auditor.md) %}

#### resource-manager.viewer {#resource-manager-viewer}

{% include [resourcemanager-viewer](../_roles/resourcemanager/resourcemanager-viewer.md) %}

#### resource-manager.editor {#resource-manager-editor}

{% include [resourcemanager-editor](../_roles/resourcemanager/resourcemanager-editor.md) %}

#### resource-manager.admin {#resource-manager-admin}

{% include [resourcemanager-admin](../_roles/resourcemanager/resourcemanager-admin.md) %}

#### resource-manager.clouds.member {#resource-manager-clouds-member}

{% include [resourcemanager-clouds-member](../_roles/resourcemanager/resourcemanager-clouds-member.md) %}

#### resource-manager.clouds.owner {#resource-manager-clouds-owner}

{% include [resourcemanager-clouds-owner](../_roles/resourcemanager/resourcemanager-clouds-owner.md) %}

Подробнее см. [{#T}](../resource-manager/security/index.md).


## {{ search-api-full-name }} {#search-api-roles}

#### search-api.executor {#search-api-executor}

{% include [searchapi-executor](../_roles/searchapi/searchapi-executor.md) %}

Подробнее см. [{#T}](../search-api/security/index.md).


## {{ serverless-containers-full-name }} {#serverless-containers-roles}

#### serverless-containers.auditor {#serverless-containers-auditor}

{% include [containers-auditor](../_roles/containers/containers-auditor.md) %}

#### serverless-containers.viewer {#serverless-containers-viewer}

{% include [containers-viewer](../_roles/containers/containers-viewer.md) %}

#### serverless-containers.editor {#serverless-containers-editor}

{% include [containers-editor](../_roles/containers/containers-editor.md) %}

#### serverless-containers.admin {#serverless-containers-admin}

{% include [containers-admin](../_roles/containers/containers-admin.md) %}

#### serverless-containers.containerInvoker {#serverless-containers-containerinvoker}

{% include [containers-containerinvoker](../_roles/containers/containers-containerinvoker.md) %}

Подробнее см. [{#T}](../serverless-containers/security/index.md).


## {{ captcha-full-name }} {#captcha-roles}

#### smart-captcha.viewer {#smart-captcha-viewer}

{% include [smartcaptcha-viewer](../_roles/smartcaptcha/smartcaptcha-viewer.md) %}

#### smart-captcha.editor {#smart-captcha-editor}

{% include [smartcaptcha-editor](../_roles/smartcaptcha/smartcaptcha-editor.md) %}

#### smart-captcha.admin {#smart-captcha-admin}

{% include [smartcaptcha-admin](../_roles/smartcaptcha/smartcaptcha-admin.md) %}

Подробнее см. [{#T}](../smartcaptcha/security/index.md).


## {{ sws-full-name }} {#sws-roles}

#### smart-web-security.auditor {#smart-web-security-auditor}

{% include [sws-auditor](../_roles/sws/sws-auditor.md) %}

#### smart-web-security.viewer {#smart-web-security-viewer}

{% include [sws-viewer](../_roles/sws/sws-viewer.md) %}

#### smart-web-security.user {#smart-web-security-user}

{% include [sws-user](../_roles/sws/sws-user.md) %}

#### smart-web-security.editor {#smart-web-security-editor}

{% include [sws-editor](../_roles/sws/sws-editor.md) %}

#### smart-web-security.admin {#smart-web-security-admin}

{% include [sws-admin](../_roles/sws/sws-admin.md) %}

Подробнее см. [{#T}](../smartwebsecurity/security/index.md).


## {{ speechkit-full-name }} {#speechkit-roles}

#### ai.speechkit-stt.user {#ai-speechkit-stt-user}

{% include [speechkit-stt-user](../_roles/speechkit/speechkit-stt-user.md) %}

#### ai.speechkit-tts.user {#ai-speechkit-tts-user}

{% include [speechkit-tts-user](../_roles/speechkit/speechkit-tts-user.md) %}

Подробнее см. [{#T}](../speechkit/security/index.md).


## {{ speechsense-full-name }} {#speechsense-roles}

#### speech-sense.auditor {#speechsense-auditor}

{% include [speechsense-auditor](../_roles/speechsense/speechsense-auditor.md) %}

#### speech-sense.viewer {#speechsense-viewer}

{% include [speechsense-viewer](../_roles/speechsense/speechsense-viewer.md) %}

#### speech-sense.editor {#speechsense-editor}

{% include [speechsense-editor](../_roles/speechsense/speechsense-editor.md) %}

#### speech-sense.admin {#speechsense-admin}

{% include [speechsense-admin](../_roles/speechsense/speechsense-admin.md) %}

#### speech-sense.spaces.creator {#speechsense-spaces-creator}

{% include [speechsense-spaces-creator](../_roles/speechsense/speechsense-spaces-creator.md) %}

#### speech-sense.data.viewer {#speechsense-data-viewer}

{% include [speechsense-data-viewer](../_roles/speechsense/speechsense-data-viewer.md) %}

#### speech-sense.data.editor {#speechsense-data-editor}

{% include [speechsense-data-editor](../_roles/speechsense/speechsense-data-editor.md) %}

Подробнее см. [{#T}](../speechsense/security/index.md).


## {{ translate-full-name }} {#translate-roles}

#### ai.translate.user {#translate-user}

{% include [translate-user](../_roles/translate/translate-user.md) %}

Подробнее см. [{#T}](../translate/security/index.md).


## {{ vpc-full-name }} {#vpc-roles}

#### vpc.viewer {#vpc-viewer}

{% include [vpc-viewer](../_roles/vpc/vpc-viewer.md) %}

#### vpc.user {#vpc-user}

{% include [vpc-user](../_roles/vpc/vpc-user.md) %}

#### vpc.admin {#vpc-admin}

{% include [vpc-admin](../_roles/vpc/vpc-admin.md) %}

#### vpc.privateAdmin {#vpc-private-admin}

{% include [vpc-privateadmin](../_roles/vpc/vpc-privateadmin.md) %}

#### vpc.publicAdmin {#vpc-public-admin}

{% include [vpc-publicadmin](../_roles/vpc/vpc-publicadmin.md) %}

#### vpc.gateways.user {#vpc-gw-user}

{% include [vpc-gateways-user](../_roles/vpc/vpc-gateways-user.md) %}

#### vpc.gateways.editor {#vpc-gw-editor}

{% include [vpc-gateways-editor](../_roles/vpc/vpc-gateways-editor.md) %}

#### vpc.securityGroups.admin {#vpc-sg-admin}

{% include [vpc-securitygroups-admin](../_roles/vpc/vpc-securitygroups-admin.md) %}

Подробнее см. [{#T}](../vpc/security/index.md).


## {{ vision-full-name }} {#vision-roles}

#### ai.vision.user {#vision-user}

{% include [vision-user](../_roles/vision/vision-user.md) %}

Подробнее см. [{#T}](../vision/security/index.md).


## {{ wiki-full-name }} {#wiki-roles}

#### wiki.viewer {#wiki-viewer}

{% include [wiki-viewer](../_roles/wiki/wiki-viewer.md) %}

#### wiki.admin {#wiki-admin}

{% include [wiki-admin](../_roles/wiki/wiki-admin.md) %}