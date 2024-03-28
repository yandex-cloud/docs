---
title: "{{ yandex-cloud }} role reference"
description: "The article provides a full reference and description of roles for {{ yandex-cloud }} services."
---

# {{ yandex-cloud }} role reference


## Primitive roles {#primitive-roles}

The chart below shows which primitive roles are available in {{ yandex-cloud }} and how they inherit each other's permissions. For example, the `{{ roles-editor }}` role includes all the permissions of the `{{ roles-viewer }}` role. You can find the description of each role under the chart.

![image](../_assets/iam/security/primitive-roles-hierarchy.svg)

#### {{ roles-auditor }} {#auditor}

{% include [auditor](../_roles/primitive-roles/auditor.md) %}

#### {{ roles-viewer }} {#viewer}

{% include [viewer](../_roles/primitive-roles/viewer.md) %}

#### {{ roles-editor }} {#editor}

{% include [editor](../_roles/primitive-roles/editor.md) %}

#### {{ roles-admin }} {#admin}

{% include [admin](../_roles/primitive-roles/admin.md) %}


## Service roles {#auxiliary-roles}

#### quota-manager.requestOperator {#quota-manager-requestoperator}

{% include [quota-manager.requestOperator](../_roles/quota-manager/requestOperator.md) %}


## AI services {#ai-services}

#### ai.auditor {#ai-auditor}

{% include [ai-auditor](../_roles/ai/auditor.md) %}

#### ai.viewer {#ai-viewer}

{% include [ai-viewer](../_roles/ai/viewer.md) %}

#### ai.editor {#ai-editor}

{% include [ai-editor](../_roles/ai/editor.md) %}

#### ai.admin {#ai-admin}

{% include [ai-admin](../_roles/ai/admin.md) %}


## {{ api-gw-full-name }} {#api-gateway-roles}

#### api-gateway.viewer {#api-gateway-viewer}

{% include [api-gateway.viewer](../_roles/api-gateway/viewer.md) %}

#### api-gateway.editor {#api-gateway-editor}

{% include [api-gateway.editor](../_roles/api-gateway/editor.md) %}

#### api-gateway.websocketWriter {#api-gateway-websocketwriter}

{% include [api-gateway.websocketWriter](../_roles/api-gateway/websocketWriter.md) %}

#### api-gateway.admin {#api-gateway-admin}

{% include [api-gateway.admin](../_roles/api-gateway/admin.md) %}

For more information, see [{#T}](../api-gateway/security/index.md).


## {{ alb-full-name }} {#alb-roles}

#### alb.auditor {#alb-auditor}

{% include [alb.auditor](../_roles/alb/auditor.md) %}

#### alb.viewer {#alb-viewer}

{% include [alb.viewer](../_roles/alb/viewer.md) %}

#### alb.user {#alb-user}

{% include [alb.user](../_roles/alb/user.md) %}

#### alb.editor {#alb-editor}

{% include [alb.editor](../_roles/alb/editor.md) %}

#### alb.admin {#alb-admin}

{% include [alb.admin](../_roles/alb/admin.md) %}

For more information, see [{#T}](../application-load-balancer/security/index.md).


## {{ at-full-name }} {#at-roles}

#### audit-trails.auditor {#at-auditor}

{% include [audit-trails.auditor](../_roles/audit-trails/auditor.md) %}

#### audit-trails.viewer {#at-viewer}

{% include [audit-trails.viewer](../_roles/audit-trails/viewer.md) %}

#### audit-trails.editor {#at-editor}

{% include [audit-trails.editor](../_roles/audit-trails/editor.md) %}

#### audit-trails.admin {#at-admin}

{% include [audit-trails.admin](../_roles/audit-trails/admin.md) %}

#### audit-trails.configViewer {#at-configviewer}

{% include [audit-trails.configviewer](../_roles/audit-trails/configViewer.md) %}

For more information, see [{#T}](../audit-trails/security/index.md).


## {{ certificate-manager-full-name }} {#certificate-manager-roles}

#### certificate-manager.auditor {#certificate-manager-auditor}

{% include [certificate-manager.auditor](../_roles/certificate-manager/auditor.md) %}

#### certificate-manager.viewer {#certificate-manager-viewer}

{% include [certificate-manager.viewer](../_roles/certificate-manager/viewer.md) %}

#### certificate-manager.editor {#certificate-manager.editor}

{% include [certificate-manager.editor](../_roles/certificate-manager/editor.md) %}

#### certificate-manager.admin {#certificate-manager-admin}

{% include [certificate-manager.admin](../_roles/certificate-manager/admin.md) %}

#### certificate-manager.certificates.downloader {#certificate-manager-certificates-downloader}

{% include [certificate-manager.certificates.downloader](../_roles/certificate-manager/certificates/downloader.md) %}

For more information, see [{#T}](../certificate-manager/security/index.md).


## {{ backup-full-name }} {#backup-roles}

#### backup.viewer {#backup-viewer}

{% include [backup.viewer](../_roles/backup/viewer.md) %}

#### backup.editor {#backup-editor}

{% include [backup.editor](../_roles/backup/editor.md) %}

#### backup.admin {#backup-admin}

{% include [backup.admin](../_roles/backup/admin.md) %}

For more information, see [{#T}](../backup/security/index.md).


## {{ billing-name }} {#billing-roles}

#### billing.accounts.member {#billing-accounts-member}

{% include [billing.accounts.member](../_roles/billing/accounts/member.md) %}

#### billing.accounts.owner {#billing-accounts-owner}

{% include [billing.accounts.owner](../_roles/billing/accounts/owner.md) %}

#### billing.accounts.viewer {#billing-accounts-viewer}

{% include [billing.accounts.viewer](../_roles/billing/accounts/viewer.md) %}

#### billing.accounts.accountant {#billing-accounts-accountant}

{% include [billing.accounts.accountant](../_roles/billing/accounts/accountant.md) %}

#### billing.accounts.editor {#billing-accounts-editor}

{% include [billing.accounts.editor](../_roles/billing/accounts/editor.md) %}

#### billing.accounts.admin {#billing-accounts-admin}

{% include [billing.accounts.admin](../_roles/billing/accounts/admin.md) %}

#### billing.accounts.varWithoutDiscounts {#billing-accounts-var-without-discounts}

{% include [billing.accounts.varwithoutdiscounts](../_roles/billing/accounts/varWithoutDiscounts.md) %}

#### billing.partners.editor {#billing-partners-editor}

{% include [billing.partners.editor](../_roles/billing/partners/editor.md) %}

For more information, see [{#T}](../billing/security/index.md).


## {{ cdn-full-name }} {#cdn-roles}

#### cdn.viewer {#cdn-viewer}

{% include [cdn-viewer](../_roles/cdn/viewer.md) %}

#### cdn.editor {#cdn-editor}

{% include [cdn-editor](../_roles/cdn/editor.md) %}

#### cdn.admin {#cdn-admin}

{% include [cdn-admin](../_roles/cdn/admin.md) %}

For more information, see [{#T}](../cdn/security/index.md).


## {{ dns-full-name }} {#dns-roles}

#### dns.auditor {#dns-auditor}

{% include [roles-dns-auditor](../_roles/dns/auditor.md) %}

#### dns.viewer {#dns-viewer}

{% include [roles-dns-viewer](../_roles/dns/viewer.md) %}

#### dns.editor {#dns-editor}

{% include [roles-dns-editor](../_roles/dns/editor.md) %}

#### dns.admin {#dns-admin}

{% include [roles-dns-admin](../_roles/dns/admin.md) %}

For more information, see [{#T}](../dns/security/index.md).


## {{ sf-full-name }} {#functions-roles}

#### functions.auditor {#functions-auditor}

{% include [functions.auditor](../_roles/functions/auditor.md) %}

#### functions.viewer {#functions-viewer}

{% include [functions.viewer](../_roles/functions/viewer.md) %}

#### functions.functionInvoker {#functions-functionInvoker}

{% include [functions.functionInvoker](../_roles/functions/functionInvoker.md) %}

#### functions.editor {#functions-editor}

{% include [functions.editor](../_roles/functions/editor.md) %}

#### functions.mdbProxiesUser {#functions-mdbProxiesUser}

{% include [functions.mdbProxiesUser](../_roles/functions/mdbProxiesUser.md) %}

#### functions.admin {#functions-admin}

{% include [functions.admin](../_roles/functions/admin.md) %}

For more information, see [{#T}](../functions/security/index.md).


## {{ cloud-logging-full-name }} {#logging-roles}

#### logging.viewer {#logging-viewer}

{% include [logging.viewer](../_roles/logging/viewer.md) %}

#### logging.editor {#logging-editor}

{% include [logging.editor](../_roles/logging/editor.md) %}

#### logging.reader {#logging-reader}

{% include [logging.reader](../_roles/logging/reader.md) %}

#### logging.writer {#logging-writer}

{% include [logging.writer](../_roles/logging/writer.md) %}

#### logging.admin {#logging-admin}

{% include [logging.admin](../_roles/logging/admin.md) %}

For more information, see [{#T}](../logging/security/index.md).


## {{ marketplace-full-name }} {#marketplace-roles}

#### marketplace.meteringAgent {#marketplace-meteringagent}

{% include [marketplace.meteringAgent](../_roles/marketplace/meteringAgent.md) %}

#### license-manager.auditor {#license-manager-auditor}

{% include [license-manager.auditor](../_roles/license-manager/auditor.md) %}

#### license-manager.viewer {#license-manager-viewer}

{% include [license-manager.viewer](../_roles/license-manager/viewer.md) %}

#### license-manager.user {#license-manager-user}

{% include [license-manager.user](../_roles/license-manager/user.md) %}

For more information, see [{#T}](../marketplace/security/index.md).


## {{ org-full-name }} {#organization-roles}

#### organization-manager.viewer {#organization-manager-viewer}

{% include [organizationmanager-viewer](../_roles/organization-manager/viewer.md) %}

#### organization-manager.admin {#organization-manager-admin}

{% include [organizationmanager-admin](../_roles/organization-manager/admin.md) %}

#### organization-manager.organizations.owner {#organization-manager-organizations-owner}

{% include [organizationmanager-organizations-owner](../_roles/organization-manager/organizations/owner.md) %}

#### organization-manager.federations.viewer {#organization-manager-federations-viewer}

{% include [organization-manager.federations.viewer](../_roles/organization-manager/federations/viewer.md) %}

#### organization-manager.federations.admin {#organization-manager-federations-admin}

{% include [organization-manager.federations.admin](../_roles/organization-manager/federations/admin.md) %}

#### organization-manager.osLogins.viewer {#organization-manager-osLogins-viewer}

{% include [organizationmanager-oslogins-viewer](../_roles/organization-manager/osLogins/viewer.md) %}

#### organization-manager.osLogins.admin {#organization-manager-osLogins-admin}

{% include [organizationmanager-oslogins-admin](../_roles/organization-manager/osLogins/admin.md) %}

#### organization-manager.groups.memberAdmin {#organization-manager-groups-memberAdmin}

{% include [organizationmanager-groups-memberAdmin](../_roles/organization-manager/groups/memberAdmin.md) %}

For more information, see [{#T}](../organization/security/index.md).


## {{ postbox-full-name }} {#postbox-roles}

#### postbox.sender {#postbox-sender}

{% include [postbox.sender](../_roles/postbox/sender.md) %}

#### postbox.auditor {#postbox-auditor}

{% include [postbox.auditor](../_roles/postbox/auditor.md) %}

#### postbox.viewer {#postbox-viewer}

{% include [postbox.viewer](../_roles/postbox/viewer.md) %}

#### postbox.editor {#postbox-editor}

{% include [postbox.editor](../_roles/postbox/editor.md) %}

#### postbox.admin {#postbox-admin}

{% include [postbox.admin](../_roles/postbox/admin.md) %}

For more information, see [{#T}](../postbox/security/index.md).


## {{ compute-full-name }} {#compute-roles}

#### compute.auditor {#compute-auditor}

{% include [compute.auditor](../_roles/compute/auditor.md) %}

#### compute.viewer {#compute-viewer}

{% include [compute.viewer](../_roles/compute/viewer.md) %}

#### compute.editor {#compute-editor}

{% include [compute.editor](../_roles/compute/editor.md) %}

#### compute.admin {#compute-admin}

{% include [compute.admin](../_roles/compute/admin.md) %}

#### compute.osLogin {#compute-oslogin}

{% include [compute.oslogin](../_roles/compute/osLogin.md) %}

#### compute.osAdminLogin {#compute-osadminlogin}

{% include [compute.osadminlogin](../_roles/compute/osAdminLogin.md) %}

#### compute.disks.user {#compute-disks-user}

{% include [compute.disks.user](../_roles/compute/disks/user.md) %}

#### compute.images.user {#compute-images-user}

{% include [compute.images.user](../_roles/compute/images/user.md) %}

#### compute.operator {#compute-operator}

{% include [compute.operator](../_roles/compute/operator.md) %}

#### compute.snapshotSchedules.viewer {#compute-snapshotSchedules-viewer}

{% include [compute.snapshotSchedules.viewer](../_roles/compute/snapshotSchedules/viewer.md) %}

#### compute.snapshotSchedules.editor {#compute-snapshotSchedules-editor}

{% include [compute.snapshotSchedules.editor](../_roles/compute/snapshotSchedules/editor.md) %}

For more information, see [{#T}](../compute/security/index.md).


## {{ container-registry-full-name }} {#cr-roles}

#### container-registry.viewer {#container-registry.viewer}

{% include [container-registry.viewer](../_roles/container-registry/viewer.md) %}

#### container-registry.editor {#container-registry.editor}

{% include [container-registry.editor](../_roles/container-registry/editor.md) %}

#### container-registry.admin {#container-registry.admin}

{% include [container-registry.admin](../_roles/container-registry/admin.md) %}

#### container-registry.images.pusher {#container-registry-images-pusher}

{% include [container-registry.images.pusher](../_roles/container-registry/images/pusher.md) %}

#### container-registry.images.puller {#container-registry-images-puller}

{% include [container-registry.images.puller](../_roles/container-registry/images/puller.md) %}

#### container-registry.images.scanner {#container-registry-images-scanner}

{% include [container-registry.images.scanner](../_roles/container-registry/images/scanner.md) %}

For more information, see [{#T}](../container-registry/security/index.md).


## {{ datalens-full-name }} {#datalens-roles}

#### datalens.visitor {#datalens-visitor}

{% include [datalens-visitor](../_roles/datalens/visitor.md) %}

#### datalens.creator {#datalens-creator}

{% include [datalens-creator](../_roles/datalens/creator.md) %}

#### datalens.admin {#datalens-admin}

{% include [datalens-admin](../_roles/datalens/admin.md) %}

#### datalens.instances.user {#datalens-instances-user}

{% include [datalens-instances-user](../_roles/datalens/instances/user.md) %}

#### datalens.instances.admin {#datalens-instances-admin}

{% include [datalens-instances-admin](../_roles/datalens/instances/admin.md) %}

For more information, see [{#T}](../datalens/security/roles.md).


## {{ dataproc-full-name }} {#dataproc-roles}

#### dataproc.agent {#dataproc-agent}

{% include [dataproc.agent](../_roles/dataproc/agent.md) %}

#### mdb.dataproc.agent {#mdb-dataproc-agent}

{% include [mdb.dataproc.agent](../_roles/mdb/dataproc/agent.md) %}

#### dataproc.auditor {#dataproc-auditor}

{% include [dataproc.auditor](../_roles/dataproc/auditor.md) %}

#### dataproc.viewer {#dataproc-viewer}

{% include [dataproc.viewer](../_roles/dataproc/viewer.md) %}

#### dataproc.user {#dataproc-user}

{% include [dataproc.user](../_roles/dataproc/user.md) %}

#### dataproc.provisioner {#dataproc-provisioner}

{% include [dataproc.provisioner](../_roles/dataproc/provisioner.md) %}

#### dataproc.editor {#dataproc-editor}

{% include [dataproc.editor](../_roles/dataproc/editor.md) %}

#### dataproc.admin {#dataproc-admin}

{% include [dataproc.admin](../_roles/dataproc/admin.md) %}

#### managed-metastore.auditor {#managed-metastore-auditor}

{% include [managed-metastore.auditor](../_roles/managed-metastore/auditor.md) %}

#### managed-metastore.viewer {#managed-metastore-viewer}

{% include [managed-metastore.viewer](../_roles/managed-metastore/viewer.md) %}

#### managed-metastore.editor {#managed-metastore-editor}

{% include [managed-metastore.editor](../_roles/managed-metastore/editor.md) %}

#### managed-metastore.admin {#managed-metastore-admin}

{% include [managed-metastore.admin](../_roles/managed-metastore/admin.md) %}

For more information, see [{#T}](../data-proc/security/index.md).


## {{ ml-platform-full-name }} {#datasphere-roles}

#### datasphere.community-projects.viewer {#datasphere-communityprojects-viewer}

{% include [datasphere.community-projects.viewer](../_roles/datasphere/community-projects/viewer.md) %}

#### datasphere.community-projects.developer {#datasphere-communityprojects-developer}

{% include [datasphere.community-projects.developer](../_roles/datasphere/community-projects/developer.md) %}

#### datasphere.community-projects.editor {#datasphere-communityprojects-editor}

{% include [datasphere.community-projects.editor](../_roles/datasphere/community-projects/editor.md) %}

#### datasphere.community-projects.admin {#datasphere-communityprojects-admin}

{% include [datasphere.community-projects.admin](../_roles/datasphere/community-projects/admin.md) %}

#### datasphere.communities.viewer {#datasphere-communities-viewer}

{% include [datasphere.communities.viewer](../_roles/datasphere/communities/viewer.md) %}

#### datasphere.communities.developer {#datasphere-communities-developer}

{% include [datasphere.communities.developer](../_roles/datasphere/communities/developer.md) %}

#### datasphere.communities.editor {#datasphere-communities-editor}

{% include [datasphere.communities.editor](../_roles/datasphere/communities/editor.md) %}

#### datasphere.communities.admin {#datasphere-communities-admin}

{% include [datasphere.communities.admin](../_roles/datasphere/communities/admin.md) %}

#### datasphere.user {#datasphere-user}

{% include [datasphere.user](../_roles/datasphere/user.md) %}

#### datasphere.admin {#datasphere-admin}

{% include [datasphere.admin](../_roles/datasphere/admin.md) %}

For more information, see [{#T}](../datasphere/security/index.md).


## {{ yds-full-name }} {#yds-roles}

#### yds.viewer {#yds-viewer}

{% include [yds.viewer](../_roles/yds/viewer.md) %}

#### yds.writer {#yds-writer}

{% include [yds.writer](../_roles/yds/writer.md) %}

#### yds.editor {#yds-editor}

{% include [yds.editor](../_roles/yds/editor.md) %}

#### yds.admin {#yds-admin}

{% include [yds.admin](../_roles/yds/admin.md) %}

For more information, see [{#T}](../data-streams/security/index.md).


## {{ data-transfer-full-name }} {#data-transfer-roles}

#### data-transfer.auditor {#data-transfer-auditor}

{% include [data-transfer.auditor](../_roles/data-transfer/auditor.md) %}

#### data-transfer.viewer {#data-transfer-viewer}

{% include [data-transfer.viewer](../_roles/data-transfer/viewer.md) %}

#### data-transfer.privateAdmin {#data-transfer-privateadmin}

{% include [data-transfer.privateadmin](../_roles/data-transfer/privateAdmin.md) %}

#### data-transfer.admin {#data-transfer-admin}

{% include [data-transfer.admin](../_roles/data-transfer/admin.md) %}

For more information, see [{#T}](../data-transfer/security/index.md).


## {{ yagpt-full-name }} {#yagpt-roles}

#### ai.languageModels.user {#languageModels-user}

{% include [yandexgpt-user](../_roles/ai/languageModels/user.md) %}

For more information, see [{#T}](../yandexgpt/security/index.md).


## {{ iam-full-name }} {#iam-roles}

#### iam.serviceAccounts.user {#iam-serviceAccounts-user}

{% include [iam.serviceAccounts.user](../_roles/iam/serviceAccounts/user.md) %}

#### iam.serviceAccounts.admin {#iam-serviceAccounts-admin}

{% include [iam.serviceAccounts.admin](../_roles/iam/serviceAccounts/admin.md) %}

#### iam.serviceAccounts.accessKeyAdmin {#iam-serviceAccounts-accessKeyAdmin}

{% include [iam.serviceAccounts.accessKeyAdmin](../_roles/iam/serviceAccounts/accessKeyAdmin.md) %}

#### iam.serviceAccounts.apiKeyAdmin {#iam-serviceAccounts-apiKeyAdmin}

{% include [iam.serviceAccounts.apiKeyAdmin](../_roles/iam/serviceAccounts/apiKeyAdmin.md) %}

#### iam.serviceAccounts.authorizedKeyAdmin {#iam-serviceAccounts-authorizedKeyAdmin}

{% include [iam.serviceAccounts.authorizedKeyAdmin](../_roles/iam/serviceAccounts/authorizedKeyAdmin.md) %}

#### iam.serviceAccounts.keyAdmin {#iam-serviceAccounts-keyAdmin}

{% include [iam.serviceAccounts.keyAdmin](../_roles/iam/serviceAccounts/keyAdmin.md) %}

#### iam.serviceAccounts.tokenCreator {#iam-serviceAccounts-tokenCreator}

{% include [iam.serviceAccounts.tokenCreator](../_roles/iam/serviceAccounts/tokenCreator.md) %}

#### iam.auditor {#iam-auditor}

{% include [iam.auditor](../_roles/iam/auditor.md) %}

#### iam.viewer {#iam-viewer}

{% include [iam.viewer](../_roles/iam/viewer.md) %}

#### iam.editor {#iam-editor}

{% include [iam.editor](../_roles/iam/editor.md) %}

#### iam.admin {#iam-admin}

{% include [iam.admin](../_roles/iam/admin.md) %}

For more information, see [{#T}](../iam/security/index.md).


## {{ iot-full-name }} {#iot-core-roles}

#### iot.devices.writer {#iot-devices-writer}

{% include [iot-devices-writer](../_roles/iot/devices/writer.md) %}

#### iot.registries.writer {#iot-registries-writer}

{% include [iot-registries-writer](../_roles/iot/registries/writer.md) %}

#### iot.auditor {#iot-auditor}

{% include [iot-auditor](../_roles/iot/auditor.md) %}

#### iot.viewer {#iot-viewer}

{% include [iot-viewer](../_roles/iot/viewer.md) %}

#### iot.editor {#iot-editor}

{% include [iot-editor](../_roles/iot/editor.md) %}

For more information, see [{#T}](../iot-core/security/index.md).


## {{ kms-full-name }} {#kms-roles}

#### kms.keys.encrypter {#kms-keys-encrypter}

{% include [kms.keys.encrypter](../_roles/kms/keys/encrypter.md) %}

#### kms.keys.decrypter {#kms-keys-decrypter}

{% include [kms.keys.decrypter](../_roles/kms/keys/decrypter.md) %}

#### kms.keys.encrypterDecrypter {#kms-keys-encrypterDecrypter}

{% include [kms.keys.encrypterDecrypter](../_roles/kms/keys/encrypterDecrypter.md) %}

#### kms.asymmetricEncryptionKeys.publicKeyViewer {#kms-asymmetricEncryptionKeys-publicKeyViewer}

{% include [kms.asymmetricEncryptionKeys.publicKeyViewer](../_roles/kms/asymmetricEncryptionKeys/publicKeyViewer.md) %}

#### kms.asymmetricSignatureKeys.publicKeyViewer {#kms-asymmetricSignatureKeys-publicKeyViewer}

{% include [kms.asymmetricSignatureKeys.publicKeyViewer](../_roles/kms/asymmetricSignatureKeys/publicKeyViewer.md) %}

#### kms.asymmetricSignatureKeys.signer {#kms-asymmetricSignatureKeys-signer}

{% include [kms.asymmetricSignatureKeys.signer](../_roles/kms/asymmetricSignatureKeys/signer.md) %}

#### kms.asymmetricEncryptionKeys.decrypter {#kms-asymmetricEncryptionKeys-decrypter}

{% include [kms.asymmetricEncryptionKeys.decrypter](../_roles/kms/asymmetricEncryptionKeys/decrypter.md) %}

#### kms.auditor {#kms-auditor}

{% include [kms.auditor](../_roles/kms/auditor.md) %}

#### kms.viewer {#kms-viewer}

{% include [kms.viewer](../_roles/kms/viewer.md) %}

#### kms.editor {#kms-editor}

{% include [kms.editor](../_roles/kms/editor.md) %}

#### kms.admin {#kms-admin}

{% include [kms.admin](../_roles/kms/admin.md) %}

For more information, see [{#T}](../kms/security/index.md).


## {{ load-testing-full-name }} {#load-testing-roles}

#### loadtesting.viewer {#loadtesting-viewer}

{% include [loadtesting.viewer](../_roles/loadtesting/viewer.md) %}

#### loadtesting.editor {#loadtesting-editor}

{% include [loadtesting.editor](../_roles/loadtesting/editor.md) %}

#### loadtesting.admin {#loadtesting-admin}

{% include [loadtesting.admin](../_roles/loadtesting/admin.md) %}

#### loadtesting.loadTester {#loadtesting-loadtester}

{% include [loadtesting.loadtester](../_roles/loadtesting/loadTester.md) %}

#### loadtesting.generatorClient {#loadtesting-generatorclient}

{% include [loadtesting.generatorclient](../_roles/loadtesting/generatorClient.md) %}

#### loadtesting.externalAgent {#loadtesting-externalagent}

{% include [loadtesting.externalagent](../_roles/loadtesting/externalAgent.md) %}

For more information, see [{#T}](../load-testing/security/index.md).


## {{ lockbox-full-name }} {#lockbox-roles}

#### lockbox.auditor {#lockbox-auditor}

{% include [lockbox.auditor](../_roles/lockbox/auditor.md) %}

#### lockbox.viewer {#lockbox-viewer}

{% include [lockbox.viewer](../_roles/lockbox/viewer.md) %}

#### lockbox.editor {#lockbox-editor}

{% include [lockbox.editor](../_roles/lockbox/editor.md) %}

#### lockbox.admin {#lockbox-admin}

{% include [lockbox.admin](../_roles/lockbox/admin.md) %}

#### lockbox.payloadViewer {#lockbox-payloadViewer}

{% include [lockbox.payloadViewer](../_roles/lockbox/payloadViewer.md) %}

For more information, see [{#T}](../lockbox/security/index.md).


## Managed databases {#mdb}

#### mdb.auditor {#mdb-auditor}

{% include [mdb-auditor](../_roles/mdb/auditor.md) %}

#### mdb.viewer {#mdb-viewer}

{% include [mdb-viewer](../_roles/mdb/viewer.md) %}

#### mdb.admin {#mdb-admin}

{% include [mdb-admin](../_roles/mdb/admin.md) %}


## {{ maf-full-name }} {#managed-airflow-roles}

#### managed-airflow.viewer {#managed-airflow-viewer}

{% include [managed-airflow.viewer](../_roles/managed-airflow/viewer.md) %}

#### managed-airflow.editor {#managed-airflow-editor}

{% include [managed-airflow.editor](../_roles/managed-airflow/editor.md) %}

#### managed-airflow.admin {#managed-airflow-admin}

{% include [managed-airflow.admin](../_roles/managed-airflow/admin.md) %}

For more information, see [{#T}](../managed-airflow/security/index.md).


## {{ mkf-full-name }} {#managed-kafka-roles}

#### managed-kafka.auditor {#managed-kafka-auditor}

{% include [managed-kafka.auditor](../_roles/managed-kafka/auditor.md) %}

#### managed-kafka.viewer {#managed-kafka-viewer}

{% include [managed-kafka.viewer](../_roles/managed-kafka/viewer.md) %}

#### managed-kafka.editor {#managed-kafka-editor}

{% include [managed-kafka.editor](../_roles/managed-kafka/editor.md) %}

#### managed-kafka.admin {#managed-kafka-admin}

{% include [managed-kafka.admin](../_roles/managed-kafka/admin.md) %}

For more information, see [{#T}](../managed-kafka/security/index.md).


## {{ mch-full-name }} {#managed-clickhouse-roles}

#### managed-clickhouse.auditor {#managed-clickhouse-auditor}

{% include [managed-clickhouse.auditor](../_roles/managed-clickhouse/auditor.md) %}

#### managed-clickhouse.viewer {#managed-clickhouse-viewer}

{% include [managed-clickhouse.viewer](../_roles/managed-clickhouse/viewer.md) %}

#### managed-clickhouse.editor {#managed-clickhouse-editor}

{% include [managed-clickhouse.editor](../_roles/managed-clickhouse/editor.md) %}

#### managed-clickhouse.admin {#managed-clickhouse-admin}

{% include [managed-clickhouse.admin](../_roles/managed-clickhouse/admin.md) %}

For more information, see [{#T}](../managed-clickhouse/security/index.md).


## {{ mes-full-name }} {#managed-elasticsearch-roles}

#### managed-elasticsearch.viewer {#managed-elasticsearch-viewer}

{% include [managed-elasticsearch.viewer](../_roles/managed-elasticsearch/viewer.md) %}

#### managed-elasticsearch.editor {#managed-elasticsearch-editor}

{% include [managed-elasticsearch.editor](../_roles/managed-elasticsearch/editor.md) %}

#### managed-elasticsearch.admin {#managed-elasticsearch-admin}

{% include [managed-elasticsearch.admin](../_roles/managed-elasticsearch/admin.md) %}

For more information, see [{#T}](../managed-elasticsearch/security/index.md).


## {{ mgl-full-name }} {#managed-gitlab-roles}

#### gitlab.auditor {#gitlab-auditor}

{% include [gitlab.auditor](../_roles/gitlab/auditor.md) %}

#### gitlab.viewer {#gitlab-viewer}

{% include [gitlab.viewer](../_roles/gitlab/viewer.md) %}

#### gitlab.editor {#gitlab-editor}

{% include [gitlab.editor](../_roles/gitlab/editor.md) %}

#### gitlab.admin {#gitlab-admin}

{% include [gitlab.admin](../_roles/gitlab/admin.md) %}

For more information, see [{#T}](../managed-gitlab/security/index.md).


## {{ mgp-full-name }} {#managed-greenplum-roles}

#### managed-greenplum.auditor {#managed-greenplum-auditor}

{% include [managed-greenplum.auditor](../_roles/managed-greenplum/auditor.md) %}

#### managed-greenplum.viewer {#managed-greenplum-viewer}

{% include [managed-greenplum.viewer](../_roles/managed-greenplum/viewer.md) %}

#### managed-greenplum.editor {#managed-greenplum-editor}

{% include [managed-greenplum.editor](../_roles/managed-greenplum/editor.md) %}

#### managed-greenplum.admin {#managed-greenplum-admin}

{% include [managed-greenplum.admin](../_roles/managed-greenplum/admin.md) %}

For more information, see [{#T}](../managed-greenplum/security/index.md).


## {{ managed-k8s-full-name }} {#managed-kubernetes-roles}

#### k8s.viewer {#k8s-viewer}

{% include [k8s.viewer](../_roles/k8s/viewer.md) %}

#### k8s.editor {#k8s-editor}

{% include [k8s.editor](../_roles/k8s/editor.md) %}

#### k8s.admin {#k8s-admin}

{% include [k8s.admin](../_roles/k8s/admin.md) %}

#### k8s.cluster-api.viewer {#k8s-cluster-api-viewer}

{% include [k8s.cluster-api.viewer](../_roles/k8s/cluster-api/viewer.md) %}

#### k8s.cluster-api.editor {#k8s-cluster-api-editor}

{% include [k8s.cluster-api.editor](../_roles/k8s/cluster-api/editor.md) %}

#### k8s.cluster-api.cluster-admin {#k8s-cluster-api-cluster-admin}

{% include [k8s.cluster-api.cluster-admin](../_roles/k8s/cluster-api/cluster-admin.md) %}

#### k8s.tunnelClusters.agent {#k8s-tunnelclusters-agent}

{% include [k8s.tunnelClusters.agent](../_roles/k8s/tunnelClusters/agent.md) %}

#### k8s.clusters.agent {#k8s-clusters-agent}

{% include [k8s.clusters.agent](../_roles/k8s/clusters/agent.md) %}

For more information, see [{#T}](../managed-kubernetes/security/index.md).


## {{ mmg-full-name }} {#managed-mongodb-roles}

#### managed-mongodb.auditor {#managed-mongodb-auditor}

{% include [managed-mongodb.auditor](../_roles/managed-mongodb/auditor.md) %}

#### managed-mongodb.viewer {#managed-mongodb-viewer}

{% include [managed-mongodb.viewer](../_roles/managed-mongodb/viewer.md) %}

#### managed-mongodb.editor {#managed-mongodb-editor}

{% include [managed-mongodb.editor](../_roles/managed-mongodb/editor.md) %}

#### managed-mongodb.admin {#managed-mongodb-admin}

{% include [managed-mongodb.admin](../_roles/managed-mongodb/admin.md) %}

For more information, see [{#T}](../managed-mongodb/security/index.md).


## {{ mmy-full-name }} {#managed-mysql-roles}

#### managed-mysql.auditor {#managed-mysql-auditor}

{% include [managed-mysql.auditor](../_roles/managed-mysql/auditor.md) %}

#### managed-mysql.viewer {#managed-mysql-viewer}

{% include [managed-mysql.viewer](../_roles/managed-mysql/viewer.md) %}

#### managed-mysql.editor {#managed-mysql-editor}

{% include [managed-mysql.editor](../_roles/managed-mysql/editor.md) %}

#### managed-mysql.admin {#managed-mysql-admin}

{% include [managed-mysql.admin](../_roles/managed-mysql/admin.md) %}

For more information, see [{#T}](../managed-mysql/security/index.md).


## {{ mos-full-name }} {#opensearch-roles}

#### managed-opensearch.auditor {#managed-opensearch-auditor}

{% include [opensearch.auditor](../_roles/managed-opensearch/auditor.md) %}

#### managed-opensearch.viewer {#managed-opensearch-viewer}

{% include [opensearch.viewer](../_roles/managed-opensearch/viewer.md) %}

#### managed-opensearch.editor {#managed-opensearch-editor}

{% include [opensearch.editor](../_roles/managed-opensearch/editor.md) %}

#### managed-opensearch.admin {#managed-opensearch-admin}

{% include [opensearch.admin](../_roles/managed-opensearch/admin.md) %}

For more information, see [{#T}](../managed-opensearch/security/index.md).


## {{ mpg-full-name }} {#mpg-roles}

#### managed-postgresql.auditor {#managed-postgresql-auditor}

{% include [managed-postgresql.auditor](../_roles/managed-postgresql/auditor.md) %}

#### managed-postgresql.viewer {#managed-postgresql-viewer}

{% include [managed-postgresql.viewer](../_roles/managed-postgresql/viewer.md) %}

#### managed-postgresql.editor {#managed-postgresql-editor}

{% include [managed-postgresql.editor](../_roles/managed-postgresql/editor.md) %}

#### managed-postgresql.admin {#managed-postgresql-admin}

{% include [managed-postgresql.admin](../_roles/managed-postgresql/admin.md) %}

For more information, see [{#T}](../managed-postgresql/security/index.md).


## {{ mrd-full-name }} {#mrd-roles}

#### managed-redis.auditor {#managed-redis-auditor}

{% include [managed-redis.auditor](../_roles/managed-redis/auditor.md) %}

#### managed-redis.viewer {#managed-redis-viewer}

{% include [managed-redis.viewer](../_roles/managed-redis/viewer.md) %}

#### managed-redis.editor {#managed-redis-editor}

{% include [managed-redis.editor](../_roles/managed-redis/editor.md) %}

#### managed-redis.admin {#managed-redis-admin}

{% include [managed-redis.admin](../_roles/managed-redis/admin.md) %}

For more information, see [{#T}](../managed-redis/security/index.md).


## {{ ydb-full-name }} {#ydb-roles}

#### ydb.viewer {#ydb-viewer}

{% include [ydb.viewer](../_roles/ydb/viewer.md) %}

#### ydb.editor {#ydb-editor}

{% include [ydb.editor](../_roles/ydb/editor.md) %}

#### ydb.admin {#ydb-admin}

{% include [ydb.admin](../_roles/ydb/admin.md) %}

#### ydb.kafkaApi.client {#ydb-kafkaapi-client}

{% include [ydb.kafkaApi.client](../_roles/ydb/kafkaApi/client.md) %}

For more information, see [{#T}](../ydb/security/index.md).


## {{ message-queue-full-name }} {#message-queue-roles}

#### ymq.reader {#ymq-reader}

{% include [ymq.reader](../_roles/ymq/reader.md) %}

#### ymq.writer {#ymq-writer}

{% include [ymq.writer](../_roles/ymq/writer.md) %}

#### ymq.admin {#ymq-admin}

{% include [ymq.admin](../_roles/ymq/admin.md) %}

For more information, see [{#T}](../message-queue/security/index.md).


## {{ monitoring-full-name }} {#monitoring-roles}

#### monitoring.viewer {#monitoring-viewer}

{% include [monitoring.viewer](../_roles/monitoring/viewer.md) %}

#### monitoring.editor {#monitoring-editor}

{% include [monitoring.editor](../_roles/monitoring/editor.md) %}

#### monitoring.admin {#monitoring-admin}

{% include [monitoring.admin](../_roles/monitoring/admin.md) %}

For more information, see [{#T}](../monitoring/security/index.md).


## {{ network-load-balancer-full-name }} {#network-load-balancer-roles}

#### load-balancer.auditor {#load-balancer-auditor}

{% include [load-balancer.auditor](../_roles/load-balancer/auditor.md) %}

#### load-balancer.viewer {#load-balancer-viewer}

{% include [loadbalancer-viewer](../_roles/load-balancer/viewer.md) %}

#### load-balancer.privateAdmin {#load-balancer-private-admin}

{% include [loadbalancer-privateadmin](../_roles/load-balancer/privateAdmin.md) %}

#### load-balancer.admin {#load-balancer-admin}

{% include [loadbalancer-admin](../_roles/load-balancer/admin.md) %}

For more information, see [{#T}](../network-load-balancer/security/index.md).


## {{ objstorage-full-name }} {#storage-roles}

#### storage.viewer {#storage-viewer}

{% include [storage-viewer](../_roles/storage/viewer.md) %}

#### storage.configViewer {#storage-config-viewer}

{% include [storage-configviewer](../_roles/storage/configViewer.md) %}

#### storage.configurer {#storage-configurer}

{% include [storage-configurer](../_roles/storage/configurer.md) %}

#### storage.uploader {#storage-uploader}

{% include [storage-uploader](../_roles/storage/uploader.md) %}

#### storage.editor {#storage-editor}

{% include [storage-editor](../_roles/storage/editor.md) %}

#### storage.admin {#storage-admin}

{% include [storage-admin](../_roles/storage/admin.md) %}

For more information, see [{#T}](../storage/security/index.md).


## {{ yq-full-name }} {#query-roles}

#### yq.viewer {#query-viewer}

{% include [query.viewer](../_roles/yq/viewer.md) %}

#### yq.editor {#query-editor}

{% include [query.editor](../_roles/yq/editor.md) %}

#### yq.admin {#query-admin}

{% include [query.admin](../_roles/yq/admin.md) %}

#### yq.invoker {#query-invoker}

{% include [query.invoker](../_roles/yq/invoker.md) %}

For more information, see [{#T}](../query/security/index.md).


## {{ resmgr-full-name }} {#resource-manager-roles}

#### resource-manager.auditor {#resource-manager-auditor}

{% include [resourcemanager-auditor](../_roles/resource-manager/auditor.md) %}

#### resource-manager.viewer {#resource-manager-viewer}

{% include [resourcemanager-viewer](../_roles/resource-manager/viewer.md) %}

#### resource-manager.editor {#resource-manager-editor}

{% include [resourcemanager-editor](../_roles/resource-manager/editor.md) %}

#### resource-manager.admin {#resource-manager-admin}

{% include [resourcemanager-admin](../_roles/resource-manager/admin.md) %}

#### resource-manager.clouds.member {#resource-manager-clouds-member}

{% include [resourcemanager-clouds-member](../_roles/resource-manager/clouds/member.md) %}

#### resource-manager.clouds.owner {#resource-manager-clouds-owner}

{% include [resourcemanager-clouds-owner](../_roles/resource-manager/clouds/owner.md) %}

For more information, see [{#T}](../resource-manager/security/index.md).


## {{ search-api-full-name }} {#search-api-roles}

#### search-api.executor {#search-api-executor}

{% include [searchapi-executor](../_roles/search-api/executor.md) %}

For more information, see [{#T}](../search-api/security/index.md).


## {{ serverless-containers-full-name }} {#serverless-containers-roles}

#### serverless-containers.auditor {#serverless-containers-auditor}

{% include [containers-auditor](../_roles/serverless-containers/auditor.md) %}

#### serverless-containers.viewer {#serverless-containers-viewer}

{% include [containers-viewer](../_roles/serverless-containers/viewer.md) %}

#### serverless-containers.editor {#serverless-containers-editor}

{% include [containers-editor](../_roles/serverless-containers/editor.md) %}

#### serverless-containers.admin {#serverless-containers-admin}

{% include [containers-admin](../_roles/serverless-containers/admin.md) %}

#### serverless-containers.containerInvoker {#serverless-containers-containerinvoker}

{% include [containers-containerinvoker](../_roles/serverless-containers/containerInvoker.md) %}

For more information, see [{#T}](../serverless-containers/security/index.md).


## {{ captcha-full-name }} {#captcha-roles}

#### smart-captcha.auditor {#smart-captcha-auditor}

{% include [smart-captcha.auditor](../_roles/smart-captcha/auditor.md) %}

#### smart-captcha.viewer {#smart-captcha-viewer}

{% include [smartcaptcha-viewer](../_roles/smart-captcha/viewer.md) %}

#### smart-captcha.editor {#smart-captcha-editor}

{% include [smartcaptcha-editor](../_roles/smart-captcha/editor.md) %}

#### smart-captcha.admin {#smart-captcha-admin}

{% include [smartcaptcha-admin](../_roles/smart-captcha/admin.md) %}

For more information, see [{#T}](../smartcaptcha/security/index.md).


## {{ sws-full-name }} {#sws-roles}

#### smart-web-security.auditor {#smart-web-security-auditor}

{% include [sws-auditor](../_roles/smart-web-security/auditor.md) %}

#### smart-web-security.viewer {#smart-web-security-viewer}

{% include [sws-viewer](../_roles/smart-web-security/viewer.md) %}

#### smart-web-security.user {#smart-web-security-user}

{% include [sws-user](../_roles/smart-web-security/user.md) %}

#### smart-web-security.editor {#smart-web-security-editor}

{% include [sws-editor](../_roles/smart-web-security/editor.md) %}

#### smart-web-security.admin {#smart-web-security-admin}

{% include [sws-admin](../_roles/smart-web-security/admin.md) %}

For more information, see [{#T}](../smartwebsecurity/security/index.md).


## {{ speechkit-full-name }} {#speechkit-roles}

#### ai.speechkit-stt.user {#ai-speechkit-stt-user}

{% include [speechkit-stt-user](../_roles/ai/speechkit-stt/user.md) %}

#### ai.speechkit-tts.user {#ai-speechkit-tts-user}

{% include [speechkit-tts-user](../_roles/ai/speechkit-tts/user.md) %}

For more information, see [{#T}](../speechkit/security/index.md).


## {{ speechsense-full-name }} {#speechsense-roles}

#### speech-sense.auditor {#speechsense-auditor}

{% include [speechsense-auditor](../_roles/speech-sense/auditor.md) %}

#### speech-sense.viewer {#speechsense-viewer}

{% include [speechsense-viewer](../_roles/speech-sense/viewer.md) %}

#### speech-sense.editor {#speechsense-editor}

{% include [speechsense-editor](../_roles/speech-sense/editor.md) %}

#### speech-sense.admin {#speechsense-admin}

{% include [speechsense-admin](../_roles/speech-sense/admin.md) %}

#### speech-sense.spaces.creator {#speechsense-spaces-creator}

{% include [speechsense-spaces-creator](../_roles/speech-sense/spaces/creator.md) %}

#### speech-sense.data.viewer {#speechsense-data-viewer}

{% include [speechsense-data-viewer](../_roles/speech-sense/data/viewer.md) %}

#### speech-sense.data.editor {#speechsense-data-editor}

{% include [speechsense-data-editor](../_roles/speech-sense/data/editor.md) %}

For more information, see [{#T}](../speechsense/security/index.md).


## {{ translate-full-name }} {#translate-roles}

#### ai.translate.user {#translate-user}

{% include [translate-user](../_roles/ai/translate/user.md) %}

For more information, see [{#T}](../translate/security/index.md).


## {{ vpc-full-name }} {#vpc-roles}

#### vpc.auditor {#vpc-auditor}

{% include [vpc.auditor](../_roles/vpc/auditor.md) %}

#### vpc.viewer {#vpc-viewer}

{% include [vpc-viewer](../_roles/vpc/viewer.md) %}

#### vpc.user {#vpc-user}

{% include [vpc-user](../_roles/vpc/user.md) %}

#### vpc.admin {#vpc-admin}

{% include [vpc-admin](../_roles/vpc/admin.md) %}

#### vpc.bridgeAdmin {#vpc-bridge-admin}

{% include [vpc.bridgeAdmin](../_roles/vpc/bridgeAdmin.md) %}

#### vpc.privateAdmin {#vpc-private-admin}

{% include [vpc-privateadmin](../_roles/vpc/privateAdmin.md) %}

#### vpc.publicAdmin {#vpc-public-admin}

{% include [vpc-publicadmin](../_roles/vpc/publicAdmin.md) %}

#### vpc.gateways.viewer {#vpc-gw-viewer}

{% include [vpc.gateways.viewer](../_roles/vpc/gateways/viewer.md) %}

#### vpc.gateways.user {#vpc-gw-user}

{% include [vpc-gateways-user](../_roles/vpc/gateways/user.md) %}

#### vpc.gateways.editor {#vpc-gw-editor}

{% include [vpc-gateways-editor](../_roles/vpc/gateways/editor.md) %}

#### vpc.securityGroups.user {#vpc-sg-user}

{% include [vpc.securityGroups.user](../_roles/vpc/securityGroups/user.md) %}

#### vpc.securityGroups.admin {#vpc-sg-admin}

{% include [vpc-securitygroups-admin](../_roles/vpc/securityGroups/admin.md) %}

For more information, see [{#T}](../vpc/security/index.md).


## {{ vision-full-name }} {#vision-roles}

#### ai.vision.user {#vision-user}

{% include [vision-user](../_roles/ai/vision/user.md) %}

For more information, see [{#T}](../vision/security/index.md).


## {{ wiki-full-name }} {#wiki-roles}

#### wiki.viewer {#wiki-viewer}

{% include [wiki-viewer](../_roles/wiki/viewer.md) %}

#### wiki.admin {#wiki-admin}

{% include [wiki-admin](../_roles/wiki/admin.md) %}

{% include [clickhouse-disclaimer](../_includes/clickhouse-disclaimer.md) %}