---
title: Справочник ролей {{ yandex-cloud }}
description: В статье приведен полный справочник и описание ролей, действующих в сервисах {{ yandex-cloud }}.
---

# Справочник ролей {{ yandex-cloud }}


## Примитивные роли {#primitive-roles}

На диаграмме показано, какие примитивные роли есть в {{ yandex-cloud }} и как они наследуют разрешения друг друга. Например, в роль `{{ roles-editor }}` входят все разрешения роли `{{ roles-viewer }}`. После диаграммы дано описание каждой роли.

![image](../_assets/iam/security/primitive-roles-hierarchy.svg)

{% include [roles-primitive](../_includes/roles-primitive.md) %}


## Служебные роли {#auxiliary-roles}

#### quota-manager.viewer {#quota-manager-viewer}

{% include [quota-manager.viewer](../_roles/quota-manager/viewer.md) %}

#### quota-manager.requestOperator {#quota-manager-requestoperator}

{% include [quota-manager.requestOperator](../_roles/quota-manager/requestOperator.md) %}


## Сервисы искусственного интеллекта {#ai-services}

#### ai.auditor {#ai-auditor}

{% include [ai-auditor](../_roles/ai/auditor.md) %}

#### ai.viewer {#ai-viewer}

{% include [ai-viewer](../_roles/ai/viewer.md) %}

#### ai.editor {#ai-editor}

{% include [ai-editor](../_roles/ai/editor.md) %}

#### ai.admin {#ai-admin}

{% include [ai-admin](../_roles/ai/admin.md) %}


## Партнерская программа {{ yandex-cloud }} {#partner-program}

#### billing.accounts.owner {#billing-accounts-owner}


{% include [billing.accounts.owner](../_roles/billing/accounts/owner.md) %}


#### billing.accounts.viewer {#billing-accounts-viewer}


{% include [billing.accounts.viewer](../_roles/billing/accounts/viewer.md) %}


#### billing.accounts.accountant {#billing-accounts-accountant}


{% include [billing.accounts.accountant](../_roles/billing/accounts/accountant.md) %}


#### billing.accounts.editor {#billing-accounts-editor}


{% include [billing.accounts.editor](../_roles/billing/accounts/editor.md) %}


#### billing.accounts.varWithoutDiscounts {#billing-accounts-var-without-discounts}


{% include [billing.accounts.varwithoutdiscounts](../_roles/billing/accounts/varWithoutDiscounts.md) %}


#### billing.accounts.admin {#billing-accounts-admin}


{% include [billing.accounts.admin](../_roles/billing/accounts/admin.md) %}


#### billing.accounts.partnerViewer {#billing-accounts-partnerViewer}

{% include [billing.accounts.partnerViewer](../_roles/billing/accounts/partnerViewer.md) %}

#### billing.accounts.piiPartnerViewer {#billing-accounts-piiPartnerViewer}

{% include [billing.accounts.piiPartnerViewer](../_roles/billing/accounts/piiPartnerViewer.md) %}

#### billing.accounts.partnerEditor {#billing-accounts-partnerEditor}

{% include [billing.accounts.partnerEditor](../_roles/billing/accounts/partnerEditor.md) %}

#### billing.accounts.piiPartnerEditor {#billing-accounts-piiPartnerEditor}

{% include [billing.accounts.piiPartnerEditor](../_roles/billing/accounts/piiPartnerEditor.md) %}

#### billing.accounts.partnerAdmin {#billing-accounts-partnerAdmin}

{% include [billing.accounts.partnerAdmin](../_roles/billing/accounts/partnerAdmin.md) %}

Подробнее см. [Управление доступом в партнерской программе {{ yandex-cloud }}](../partner/security/index.md).


## {{ api-gw-full-name }} {#api-gateway-roles}

#### api-gateway.auditor {#api-gateway-auditor}

{% include [api-gateway.auditor](../_roles/api-gateway/auditor.md) %}

#### api-gateway.viewer {#api-gateway-viewer}

{% include [api-gateway.viewer](../_roles/api-gateway/viewer.md) %}

#### api-gateway.editor {#api-gateway-editor}

{% include [api-gateway.editor](../_roles/api-gateway/editor.md) %}

#### api-gateway.websocketWriter {#api-gateway-websocketwriter}

{% include [api-gateway.websocketWriter](../_roles/api-gateway/websocketWriter.md) %}

#### api-gateway.websocketBroadcaster {#api-gateway-websocketBroadcaster}

{% include [api-gateway.websocketBroadcaster](../_roles/api-gateway/websocketBroadcaster.md) %}

#### api-gateway.admin {#api-gateway-admin}

{% include [api-gateway.admin](../_roles/api-gateway/admin.md) %}

Подробнее см. [{#T}](../api-gateway/security/index.md).


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

Подробнее см. [{#T}](../application-load-balancer/security/index.md).


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

Подробнее см. [{#T}](../audit-trails/security/index.md).


## {{ baremetal-full-name }} {#baremetal-roles}

#### baremetal.auditor {#baremetal-auditor}

{% include [baremetal-auditor](../_roles/baremetal/auditor.md) %}

#### baremetal.viewer {#baremetal-viewer}

{% include [baremetal-viewer](../_roles/baremetal/viewer.md) %}

#### baremetal.operator {#baremetal-operator}

{% include [baremetal-operator](../_roles/baremetal/operator.md) %}

#### baremetal.editor {#baremetal-editor}

{% include [baremetal-editor](../_roles/baremetal/editor.md) %}

#### baremetal.admin {#baremetal-admin}

{% include [baremetal-admin](../_roles/baremetal/admin.md) %}

Подробнее см. [{#T}](../baremetal/security/index.md).


## {{ interconnect-full-name }} {#interconnect-roles}

#### cic.auditor {#cic-auditor}

{% include [cic.auditor](../_roles/cic/auditor.md) %}

#### cic.viewer {#cic-viewer}

{% include [cic.viewer](../_roles/cic/viewer.md) %}

#### cic.editor {#cic-editor}

{% include [cic.editor](../_roles/cic/editor.md) %}

#### cic.secretViewer {#cic-secretviewer}

{% include [cic.secretViewer](../_roles/cic/secretViewer.md) %}

#### cic.secretEditor {#cic-secreteditor}

{% include [cic.secretEditor](../_roles/cic/secretEditor.md) %}

Подробнее см. [{#T}](../interconnect/security/index.md).


## {{ cr-full-name }} {#cloudrouter-roles}

#### cloud-router.auditor {#cloudrouter-auditor}

{% include [cloud-router.auditor](../_roles/cloud-router/auditor.md) %}

#### cloud-router.viewer {#cloudrouter-viewer}

{% include [cloud-router.viewer](../_roles/cloud-router/viewer.md) %}

#### cloud-router.editor {#cloudrouter-editor}

{% include [cloud-router.editor](../_roles/cloud-router/editor.md) %}

Подробнее см. [{#T}](../cloud-router/security/index.md).


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

Подробнее см. [{#T}](../certificate-manager/security/index.md).


## {{ backup-full-name }} {#backup-roles}

#### backup.viewer {#backup-viewer}

{% include [backup.viewer](../_roles/backup/viewer.md) %}

#### backup.editor {#backup-editor}

{% include [backup.editor](../_roles/backup/editor.md) %}

#### backup.admin {#backup-admin}

{% include [backup.admin](../_roles/backup/admin.md) %}

Подробнее см. [{#T}](../backup/security/index.md).


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

Подробнее см. [{#T}](../billing/security/index.md).


## {{ cdn-full-name }} {#cdn-roles}

#### cdn.viewer {#cdn-viewer}

{% include [cdn-viewer](../_roles/cdn/viewer.md) %}

#### cdn.editor {#cdn-editor}

{% include [cdn-editor](../_roles/cdn/editor.md) %}

#### cdn.admin {#cdn-admin}

{% include [cdn-admin](../_roles/cdn/admin.md) %}

Подробнее см. [{#T}](../cdn/security/index.md).


## {{ cloud-desktop-full-name }} {#desktop-roles}

#### vdi.viewer {#vdi-viewer}

{% include [vdi.viewer](../_roles/vdi/viewer.md) %}

#### vdi.desktopGroups.maintainer {#vdi-desktopGroups-maintainer}

{% include [vdi.desktopGroups.maintainer](../_roles/vdi/desktopGroups/maintainer.md) %}

#### vdi.desktopGroups.user {#vdi-desktopGroups-user}

{% include [vdi.desktopGroups.maintainer](../_roles/vdi/desktopGroups/user.md) %}

#### vdi.editor {#vdi-editor}

{% include [vdi.editor](../_roles/vdi/editor.md) %}

#### vdi.admin {#vdi-admin}

{% include [vdi.admin](../_roles/vdi/admin.md) %}

Подробнее см. [{#T}](../cloud-desktop/security/index.md).


## {{ dns-full-name }} {#dns-roles}

#### dns.auditor {#dns-auditor}

{% include [roles-dns-auditor](../_roles/dns/auditor.md) %}

#### dns.viewer {#dns-viewer}

{% include [roles-dns-viewer](../_roles/dns/viewer.md) %}

#### dns.editor {#dns-editor}

{% include [roles-dns-editor](../_roles/dns/editor.md) %}

#### dns.admin {#dns-admin}

{% include [roles-dns-admin](../_roles/dns/admin.md) %}

Подробнее см. [{#T}](../dns/security/index.md).


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

#### serverless.mdbProxies.user {#serverless-mdbProxies-user}

{% include [serverless.mdbProxies.user](../_roles/serverless/mdbProxies/user.md) %}

#### serverless.functions.invoker {#serverless-functions-invoker}

{% include [serverless.functions.invoker](../_roles/serverless/functions/invoker.md) %}

#### serverless.functions.admin {#serverless-functions-admin}

{% include [serverless.functions.admin](../_roles/serverless/functions/admin.md) %}

Подробнее см. [{#T}](../functions/security/index.md).


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

Подробнее см. [{#T}](../logging/security/index.md).


## {{ marketplace-full-name }} {#marketplace-roles}

### Роли партнера {#marketplace-partner-roles}

#### marketplace.meteringAgent {#marketplace-meteringagent}

{% include [marketplace.meteringAgent](../_roles/marketplace/meteringAgent.md) %}

#### license-manager.saasSubscriptionSupervisor {#license-manager-saasSubscriptionSupervisor}

{% include [license-manager.saasSubscriptionSupervisor](../_roles/license-manager/saasSubscriptionSupervisor.md) %}

#### marketplace.product.creator {#marketplace-product-creator}

{% include [marketplace.product.creator](../_roles/marketplace/product/creator.md) %}

#### marketplace.product.admin {#marketplace-product-admin}

{% include [marketplace.product.admin](../_roles/marketplace/product/admin.md) %}

#### marketplace.publishers.reportViewer {#marketplace-publishers-reportViewer}

{% include [marketplace.publishers.reportViewer](../_roles/marketplace/publishers/reportViewer.md) %}

#### marketplace.publishers.viewer {#marketplace-publishers-viewer}

{% include [marketplace.publishers.viewer](../_roles/marketplace/publishers/viewer.md) %}

#### marketplace.publishers.editor {#marketplace-publishers-editor}

{% include [marketplace.publishers.editor](../_roles/marketplace/publishers/editor.md) %}

#### marketplace.publishers.admin {#marketplace-publishers-admin}

{% include [marketplace.publishers.admin](../_roles/marketplace/publishers/admin.md) %}

#### marketplace.publishers.owner {#marketplace-publishers-owner}

{% include [marketplace.publishers.owner](../_roles/marketplace/publishers/owner.md) %}

#### marketplace.publishers.member {#marketplace-publishers-member}

{% include [marketplace.publishers.member](../_roles/marketplace/publishers/member.md) %}

Подробнее см. [{#T}](../marketplace/security/partners.md).


### Роли пользователя {#marketplace-user-roles}

#### license-manager.auditor {#license-manager-auditor}

{% include [license-manager.auditor](../_roles/license-manager/auditor.md) %}

#### license-manager.viewer {#license-manager-viewer}

{% include [license-manager.viewer](../_roles/license-manager/viewer.md) %}

#### license-manager.user {#license-manager-user}

{% include [license-manager.user](../_roles/license-manager/user.md) %}

#### license-manager.subscriptionAgent {#license-manager-subscriptionAgent}

{% include [license-manager.subscriptionAgent](../_roles/license-manager/subscriptionAgent.md) %}

Подробнее см. [{#T}](../marketplace/security/index.md).


## {{ org-full-name }} {#organization-roles}

#### organization-manager.auditor {#organization-manager-auditor}

{% include [organizationmanager-auditor](../_roles/organization-manager/auditor.md) %}

#### organization-manager.viewer {#organization-manager-viewer}

{% include [organizationmanager-viewer](../_roles/organization-manager/viewer.md) %}

#### organization-manager.editor {#organization-manager-editor}

{% include [organizationmanager-editor](../_roles/organization-manager/editor.md) %}

#### organization-manager.admin {#organization-manager-admin}

{% include [organizationmanager-admin](../_roles/organization-manager/admin.md) %}

#### organization-manager.organizations.owner {#organization-manager-organizations-owner}

{% include [organizationmanager-organizations-owner](../_roles/organization-manager/organizations/owner.md) %}

#### organization-manager.federations.auditor {#organization-manager-federations-auditor}

{% include [organization-manager.federations.auditor](../_roles/organization-manager/federations/auditor.md) %}

#### organization-manager.federations.viewer {#organization-manager-federations-viewer}

{% include [organization-manager.federations.viewer](../_roles/organization-manager/federations/viewer.md) %}

#### organization-manager.federations.editor {#organization-manager-federations-editor}

{% include [organization-manager.federations.editor](../_roles/organization-manager/federations/editor.md) %}

#### organization-manager.federations.userAdmin {#organization-manager-federations-userAdmin}

{% include [organization-manager.federations.userAdmin](../_roles/organization-manager/federations/userAdmin.md) %}

#### organization-manager.federations.admin {#organization-manager-federations-admin}

{% include [organization-manager.federations.admin](../_roles/organization-manager/federations/admin.md) %}

#### organization-manager.osLogins.viewer {#organization-manager-osLogins-viewer}

{% include [organizationmanager-oslogins-viewer](../_roles/organization-manager/osLogins/viewer.md) %}

#### organization-manager.osLogins.admin {#organization-manager-osLogins-admin}

{% include [organizationmanager-oslogins-admin](../_roles/organization-manager/osLogins/admin.md) %}

#### organization-manager.groups.editor {#organization-manager-groups-editor}

{% include [organization-manager-groups-editor](../_roles/organization-manager/groups/editor.md) %}

#### organization-manager.groups.memberAdmin {#organization-manager-groups-memberAdmin}

{% include [organizationmanager-groups-memberAdmin](../_roles/organization-manager/groups/memberAdmin.md) %}

#### organization-manager.groups.admin {#organization-manager-groups-admin}

{% include [organization-manager-groups-admin](../_roles/organization-manager/groups/admin.md) %}

#### organization-manager.users.viewer {#organization-manager-users-viewer}

{% include [organizationmanager-users-viewer](../_roles/organization-manager/users/viewer.md) %}

#### organization-manager.passportUserAdmin {#organization-manager-passportUserAdmin}

{% include [organizationmanager-passportUserAdmin](../_roles/organization-manager/passportUserAdmin.md) %}

#### organization-manager.oauthApplications.auditor {#organization-manager-oauthApplications-auditor}

{% include [organizationmanager-oauthApplications-auditor](../_roles/organization-manager/oauthApplications/auditor.md) %}

#### organization-manager.oauthApplications.viewer {#organization-manager-oauthApplications-viewer}

{% include [organizationmanager-oauthApplications-viewer](../_roles/organization-manager/oauthApplications/viewer.md) %}

#### organization-manager.oauthApplications.editor {#organization-manager-oauthApplications-editor}

{% include [organizationmanager-oauthApplications-editor](../_roles/organization-manager/oauthApplications/editor.md) %}

#### organization-manager.oauthApplications.userAdmin {#organization-manager-oauthApplications-userAdmin}

{% include [organizationmanager-oauthApplications-userAdmin](../_roles/organization-manager/oauthApplications/userAdmin.md) %}

#### organization-manager.oauthApplications.admin {#organization-manager-oauthApplications-admin}

{% include [organizationmanager-oauthApplications-admin](../_roles/organization-manager/oauthApplications/admin.md) %}

#### organization-manager.samlApplications.auditor {#organization-manager-samlApplications-auditor}

{% include [organizationmanager-samlApplications-auditor](../_roles/organization-manager/samlApplications/auditor.md) %}

#### organization-manager.samlApplications.viewer {#organization-manager-samlApplications-viewer}

{% include [organizationmanager-samlApplications-viewer](../_roles/organization-manager/samlApplications/viewer.md) %}

#### organization-manager.samlApplications.editor {#organization-manager-samlApplications-editor}

{% include [organizationmanager-samlApplications-editor](../_roles/organization-manager/samlApplications/editor.md) %}

#### organization-manager.samlApplications.userAdmin {#organization-manager-samlApplications-userAdmin}

{% include [organizationmanager-samlApplications-userAdmin](../_roles/organization-manager/samlApplications/userAdmin.md) %}

#### organization-manager.samlApplications.admin {#organization-manager-samlApplications-admin}

{% include [organizationmanager-samlApplications-admin](../_roles/organization-manager/samlApplications/admin.md) %}

#### organization-manager.userpools.auditor {#organization-manager-userpools-auditor}

{% include [organizationmanager-userpools-auditor](../_roles/organization-manager/userpools/auditor.md) %}

#### organization-manager.userpools.viewer {#organization-manager-userpools-viewer}

{% include [organizationmanager-userpools-viewer](../_roles/organization-manager/userpools/viewer.md) %}

#### organization-manager.userpools.editor {#organization-manager-userpools-editor}

{% include [organizationmanager-userpools-editor](../_roles/organization-manager/userpools/editor.md) %}

#### organization-manager.userpools.userAdmin {#organization-manager-userpools-userAdmin}

{% include [organizationmanager-userpools-userAdmin](../_roles/organization-manager/userpools/userAdmin.md) %}

#### organization-manager.userpools.admin {#organization-manager-userpools-admin}

{% include [organizationmanager-userpools-admin](../_roles/organization-manager/userpools/admin.md) %}

Подробнее см. [{#T}](../organization/security/index.md).


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

Подробнее см. [{#T}](../postbox/security/index.md).


## {{ cloud-registry-full-name }} {#cloud-registry-roles}

#### cloud-registry.auditor {#cloud-registry-auditor}

{% include [cloud-registry-auditor](../_roles/cloud-registry/auditor.md) %}

#### cloud-registry.viewer {#cloud-registry-viewer}

{% include [cloud-registry-viewer](../_roles/cloud-registry/viewer.md) %}

#### cloud-registry.editor {#cloud-registry-editor}

{% include [cloud-registry-editor](../_roles/cloud-registry/editor.md) %}

#### cloud-registry.admin {#cloud-registry-admin}

{% include [cloud-registry-admin](../_roles/cloud-registry/admin.md) %}

#### cloud-registry.artifacts.puller {#cloud-registry-artifacts-puller}

{% include [cloud-registry-artifacts-puller](../_roles/cloud-registry/artifacts/puller.md) %}

#### cloud-registry.artifacts.pusher {#cloud-registry-artifacts-pusher}

{% include [cloud-registry-artifacts-pusher](../_roles/cloud-registry/artifacts/pusher.md) %}

Подробнее см. [{#T}](../cloud-registry/security/index.md).


## {{ video-full-name }} {#video-roles}

#### video.auditor {#video-auditor}

{% include [video.auditor](../_roles/video/auditor.md) %}

#### video.viewer {#video-viewer}

{% include [video.viewer](../_roles/video/viewer.md) %}

#### video.editor {#video-editor}

{% include [video.editor](../_roles/video/editor.md) %}

#### video.admin {#video-admin}

{% include [video.admin](../_roles/video/admin.md) %}


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

Подробнее см. [{#T}](../compute/security/index.md).


## {{ connection-manager-full-name }} {#connection-manager-roles}

#### connection-manager.auditor {#connection-manager-auditor}

{% include [connection-manager.auditor](../_roles/connection-manager/auditor.md) %}

#### connection-manager.viewer {#connection-manager-viewer}

{% include [connection-manager.viewer](../_roles/connection-manager/viewer.md) %}

#### connection-manager.editor {#connection-manager-editor}

{% include [connection-manager.editor](../_roles/connection-manager/editor.md) %}

#### connection-manager.admin {#connection-manager-admin}

{% include [connection-manager.admin](../_roles/connection-manager/admin.md) %}

Подробнее см. [Управление доступом в {{ connection-manager-name }}](../metadata-hub/security/index.md).


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

Подробнее см. [{#T}](../container-registry/security/index.md).


## {{ datalens-full-name }} {#datalens-roles}

#### datalens.workbooks.limitedViewer {#datalens-workbooks-limitedViewer}

{% include [datalens.workbooks.limitedViewer](../_roles/datalens/workbooks/limitedViewer.md) %}

#### datalens.workbooks.viewer {#datalens-workbooks-viewer}

{% include [datalens.workbooks.viewer](../_roles/datalens/workbooks/viewer.md) %}

#### datalens.workbooks.editor {#datalens-workbooks-editor}

{% include [datalens.workbooks.editor](../_roles/datalens/workbooks/editor.md) %}

#### datalens.workbooks.admin {#datalens-workbooks-admin}

{% include [datalens.workbooks.admin](../_roles/datalens/workbooks/admin.md) %}

#### datalens.collections.limitedViewer {#datalens-collections-limitedViewer}

{% include [datalens.collections.limitedViewer](../_roles/datalens/collections/limitedViewer.md) %}

#### datalens.collections.viewer {#datalens-collections-viewer}

{% include [datalens.collections.viewer](../_roles/datalens/collections/viewer.md) %}

#### datalens.collections.editor {#datalens-collections-editor}

{% include [datalens.collections.editor](../_roles/datalens/collections/editor.md) %}

#### datalens.collections.admin {#datalens-collections-admin}

{% include [datalens.collections.admin](../_roles/datalens/collections/admin.md) %}

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

Подробнее см. [{#T}](../datalens/security/roles.md).


## {{ dataproc-full-name }} {#dataproc-roles}

#### dataproc.agent {#dataproc-agent}

{% include [dataproc.agent](../_roles/data-processing/agent.md) %}

#### dataproc.auditor {#dataproc-auditor}

{% include [dataproc.auditor](../_roles/data-processing/auditor.md) %}

#### dataproc.viewer {#dataproc-viewer}

{% include [dataproc.viewer](../_roles/data-processing/viewer.md) %}

#### dataproc.user {#dataproc-user}

{% include [dataproc.user](../_roles/data-processing/user.md) %}

#### dataproc.provisioner {#dataproc-provisioner}

{% include [dataproc.provisioner](../_roles/data-processing/provisioner.md) %}

#### dataproc.editor {#dataproc-editor}

{% include [dataproc.editor](../_roles/data-processing/editor.md) %}

#### dataproc.admin {#dataproc-admin}

{% include [dataproc.admin](../_roles/data-processing/admin.md) %}

#### mdb.dataproc.agent {#mdb-dataproc-agent}

{% include [mdb.dataproc.agent](../_roles/mdb/dataproc/agent.md) %}

#### {{ roles.metastore.auditor }} {#managed-metastore-auditor}

{% include [managed-metastore.auditor](../_roles/managed-metastore/auditor.md) %}

#### {{ roles.metastore.viewer }} {#managed-metastore-viewer}

{% include [managed-metastore.viewer](../_roles/managed-metastore/viewer.md) %}

#### {{ roles.metastore.editor }} {#managed-metastore-editor}

{% include [managed-metastore.editor](../_roles/managed-metastore/editor.md) %}

#### {{ roles.metastore.admin }} {#managed-metastore-admin}

{% include [managed-metastore.admin](../_roles/managed-metastore/admin.md) %}

#### {{ roles.metastore.integrationProvider }} {#managed-metastore-integrationProvider}

{% include [managed-metastore.integrationProvider](../_roles/managed-metastore/integrationProvider.md) %}

Подробнее см. [{#T}](../data-proc/security/index.md).


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

#### data-sphere.user {#data-sphere-user}

{% include [data-sphere.user](../_roles/data-sphere/user.md) %}

#### datasphere.admin {#datasphere-admin}

{% include [datasphere.admin](../_roles/datasphere/admin.md) %}

#### data-sphere.admin {#data-sphere-admin}

{% include [data-sphere.admin](../_roles/data-sphere/admin.md) %}

Подробнее см. [{#T}](../datasphere/security/index.md).


## {{ yds-full-name }} {#yds-roles}

#### yds.auditor {#yds-auditor}

{% include [yds.auditor](../_roles/yds/auditor.md) %}

#### yds.viewer {#yds-viewer}

{% include [yds.viewer](../_roles/yds/viewer.md) %}

#### yds.writer {#yds-writer}

{% include [yds.writer](../_roles/yds/writer.md) %}

#### yds.editor {#yds-editor}

{% include [yds.editor](../_roles/yds/editor.md) %}

#### yds.admin {#yds-admin}

{% include [yds.admin](../_roles/yds/admin.md) %}

Подробнее см. [{#T}](../data-streams/security/index.md).


## {{ data-transfer-full-name }} {#data-transfer-roles}

#### data-transfer.auditor {#data-transfer-auditor}

{% include [data-transfer.auditor](../_roles/data-transfer/auditor.md) %}

#### data-transfer.viewer {#data-transfer-viewer}

{% include [data-transfer.viewer](../_roles/data-transfer/viewer.md) %}

#### data-transfer.privateAdmin {#data-transfer-privateadmin}

{% include [data-transfer.privateadmin](../_roles/data-transfer/privateAdmin.md) %}

#### data-transfer.admin {#data-transfer-admin}

{% include [data-transfer.admin](../_roles/data-transfer/admin.md) %}

Подробнее см. [{#T}](../data-transfer/security/index.md).


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

#### iam.serviceAccounts.federatedCredentialViewer {#iam-serviceAccounts-federatedCredentialViewer}

{% include [iam.serviceAccounts.federatedCredentialViewer](../_roles/iam/serviceAccounts/federatedCredentialViewer.md) %}

#### iam.serviceAccounts.federatedCredentialEditor {#iam-serviceAccounts-federatedCredentialEditor}

{% include [iam.serviceAccounts.federatedCredentialEditor](../_roles/iam/serviceAccounts/federatedCredentialEditor.md) %}

#### iam.workloadIdentityFederations.auditor {#iam-workloadIdentityFederations-auditor}

{% include [iam.workloadIdentityFederations.auditor](../_roles/iam/workloadIdentityFederations/auditor.md) %}

#### iam.workloadIdentityFederations.viewer {#iam-workloadIdentityFederations-viewer}

{% include [iam.workloadIdentityFederations.viewer](../_roles/iam/workloadIdentityFederations/viewer.md) %}

#### iam.workloadIdentityFederations.user {#iam-workloadIdentityFederations-user}

{% include [iam.workloadIdentityFederations.user](../_roles/iam/workloadIdentityFederations/user.md) %}

#### iam.workloadIdentityFederations.editor {#iam-workloadIdentityFederations-editor}

{% include [iam.workloadIdentityFederations.editor](../_roles/iam/workloadIdentityFederations/editor.md) %}

#### iam.workloadIdentityFederations.admin {#iam-workloadIdentityFederations-admin}

{% include [iam.workloadIdentityFederations.admin](../_roles/iam/workloadIdentityFederations/admin.md) %}

#### iam.userAccounts.refreshTokenViewer {#iam-userAccounts-refreshTokenViewer}

{% include [iam.userAccounts.refreshTokenViewer](../_roles/iam/userAccounts/refreshTokenViewer.md) %}

#### iam.userAccounts.refreshTokenRevoker {#iam-userAccounts-refreshTokenRevoker}

{% include [iam.userAccounts.refreshTokenRevoker](../_roles/iam/userAccounts/refreshTokenRevoker.md) %}

#### iam.auditor {#iam-auditor}

{% include [iam.auditor](../_roles/iam/auditor.md) %}

#### iam.viewer {#iam-viewer}

{% include [iam.viewer](../_roles/iam/viewer.md) %}

#### iam.editor {#iam-editor}

{% include [iam.editor](../_roles/iam/editor.md) %}

#### iam.admin {#iam-admin}

{% include [iam.admin](../_roles/iam/admin.md) %}

Подробнее см. [{#T}](../iam/security/index.md).


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

Подробнее см. [{#T}](../iot-core/security/index.md).


## {{ foundation-models-full-name }} {#fm-roles}

#### ai.playground.user {#ai-playground-user}

{% include [ai-playground-user](../_roles/ai/playground/user.md) %}

#### ai.languageModels.user {#languageModels-user}

{% include [yandexgpt-user](../_roles/ai/languageModels/user.md) %}

#### ai.imageGeneration.user {#imageGeneration-user}

{% include [yandexart-user](../_roles/ai/imageGeneration/user.md) %}

#### ai.assistants.auditor {#ai-assistants-auditor}

{% include [assistants-auditor](../_roles/ai/assistants/auditor.md) %}

#### ai.assistants.viewer {#ai-assistants-viewer}

{% include [assistants-viewer](../_roles/ai/assistants/viewer.md) %}

#### ai.assistants.editor {#ai-assistants-editor}

{% include [assistants-editor](../_roles/ai/assistants/editor.md) %}

#### ai.assistants.admin {#ai-assistants-admin}

{% include [assistants-admin](../_roles/ai/assistants/admin.md) %}

#### ai.datasets.auditor {#ai-datasets-auditor}

{% include [ai-datasets-auditor](../_roles/ai/datasets/auditor.md) %}

#### ai.datasets.viewer {#ai-datasets-viewer}

{% include [ai-datasets-viewer](../_roles/ai/datasets/viewer.md) %}

#### ai.datasets.user {#ai-datasets-user}

{% include [ai-datasets-user](../_roles/ai/datasets/user.md) %}

#### ai.datasets.editor {#ai-datasets-editor}

{% include [ai-datasets-editor](../_roles/ai/datasets/editor.md) %}

#### ai.datasets.admin {#ai-datasets-admin}

{% include [ai-datasets-admin](../_roles/ai/datasets/admin.md) %}

#### ai.models.auditor {#ai-models-auditor}

{% include [ai-models-auditor](../_roles/ai/models/auditor.md) %}

#### ai.models.viewer {#ai-models-viewer}

{% include [ai-models-viewer](../_roles/ai/models/viewer.md) %}

#### ai.models.user {#ai-models-user}

{% include [ai-models-user](../_roles/ai/models/user.md) %}

#### ai.models.editor {#ai-models-editor}

{% include [ai-models-editor](../_roles/ai/models/editor.md) %}

#### ai.models.admin {#ai-models-admin}

{% include [ai-models-admin](../_roles/ai/models/admin.md) %}

Подробнее см. [{#T}](../foundation-models/security/index.md).


## {{ kms-full-name }} {#kms-roles}

#### kms.keys.user {#kms-keys-user}

{% include [kms.keys.user](../_roles/kms/keys/user.md) %}

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

Подробнее см. [{#T}](../kms/security/index.md).


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

Подробнее см. [{#T}](../load-testing/security/index.md).


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

Подробнее см. [{#T}](../lockbox/security/index.md).


## Управляемые базы данных {#mdb}

#### mdb.auditor {#mdb-auditor}

{% include [mdb-auditor](../_roles/mdb/auditor.md) %}

#### mdb.viewer {#mdb-viewer}

{% include [mdb-viewer](../_roles/mdb/viewer.md) %}

#### mdb.admin {#mdb-admin}

{% include [mdb-admin](../_roles/mdb/admin.md) %}


## {{ maf-full-name }} {#managed-airflow-roles}

#### managed-airflow.auditor {#managed-airflow-auditor}

{% include [managed-airflow.auditor](../_roles/managed-airflow/auditor.md) %}

#### managed-airflow.viewer {#managed-airflow-viewer}

{% include [managed-airflow.viewer](../_roles/managed-airflow/viewer.md) %}

#### managed-airflow.user {#managed-airflow-user}

{% include [managed-airflow.user](../_roles/managed-airflow/user.md) %}

#### managed-airflow.editor {#managed-airflow-editor}

{% include [managed-airflow.editor](../_roles/managed-airflow/editor.md) %}

#### managed-airflow.admin {#managed-airflow-admin}

{% include [managed-airflow.admin](../_roles/managed-airflow/admin.md) %}

#### managed-airflow.integrationProvider {#managed-airflow-integrationProvider}

{% include [managed-airflow.integrationProvider](../_roles/managed-airflow/integrationProvider.md) %}

Подробнее см. [{#T}](../managed-airflow/security/index.md).


## {{ mkf-full-name }} {#managed-kafka-roles}

#### managed-kafka.auditor {#managed-kafka-auditor}

{% include [managed-kafka.auditor](../_roles/managed-kafka/auditor.md) %}

#### managed-kafka.viewer {#managed-kafka-viewer}

{% include [managed-kafka.viewer](../_roles/managed-kafka/viewer.md) %}

#### managed-kafka.editor {#managed-kafka-editor}

{% include [managed-kafka.editor](../_roles/managed-kafka/editor.md) %}

#### managed-kafka.admin {#managed-kafka-admin}

{% include [managed-kafka.admin](../_roles/managed-kafka/admin.md) %}

Подробнее см. [{#T}](../managed-kafka/security/index.md).


## {{ msp-full-name }} {#msp-roles}

#### managed-spark.auditor {#managed-spark-auditor}

{% include [managed-spark.auditor](../_roles/managed-spark/auditor.md) %}

#### managed-spark.viewer {#managed-spark-viewer}

{% include [managed-spark.viewer](../_roles/managed-spark/viewer.md) %}

#### managed-spark.user {#managed-spark-user}

{% include [managed-spark.user](../_roles/managed-spark/user.md) %}

#### managed-spark.editor {#managed-spark-editor}

{% include [managed-spark.editor](../_roles/managed-spark/editor.md) %}

#### managed-spark.admin {#managed-spark-admin}

{% include [managed-spark.admin](../_roles/managed-spark/admin.md) %}

#### managed-spark.integrationProvider {#managed-spark-integrationProvider}

{% include [managed-spark.integrationProvider](../_roles/managed-spark/integrationProvider.md) %}

Подробнее см. [{#T}](../managed-spark/security.md).


## {{ mch-full-name }} {#managed-clickhouse-roles}

#### managed-clickhouse.auditor {#managed-clickhouse-auditor}

{% include [managed-clickhouse.auditor](../_roles/managed-clickhouse/auditor.md) %}

#### managed-clickhouse.viewer {#managed-clickhouse-viewer}

{% include [managed-clickhouse.viewer](../_roles/managed-clickhouse/viewer.md) %}

#### managed-clickhouse.editor {#managed-clickhouse-editor}

{% include [managed-clickhouse.editor](../_roles/managed-clickhouse/editor.md) %}

#### managed-clickhouse.admin {#managed-clickhouse-admin}

{% include [managed-clickhouse.admin](../_roles/managed-clickhouse/admin.md) %}

Подробнее см. [{#T}](../managed-clickhouse/security.md).




## {{ mgl-full-name }} {#managed-gitlab-roles}

#### gitlab.auditor {#gitlab-auditor}

{% include [gitlab.auditor](../_roles/gitlab/auditor.md) %}

#### gitlab.viewer {#gitlab-viewer}

{% include [gitlab.viewer](../_roles/gitlab/viewer.md) %}

#### gitlab.editor {#gitlab-editor}

{% include [gitlab.editor](../_roles/gitlab/editor.md) %}

#### gitlab.admin {#gitlab-admin}

{% include [gitlab.admin](../_roles/gitlab/admin.md) %}

Подробнее см. [{#T}](../managed-gitlab/security/index.md).


## {{ mgp-full-name }} {#managed-greenplum-roles}

#### managed-greenplum.auditor {#managed-greenplum-auditor}

{% include [managed-greenplum.auditor](../_roles/managed-greenplum/auditor.md) %}

#### managed-greenplum.viewer {#managed-greenplum-viewer}

{% include [managed-greenplum.viewer](../_roles/managed-greenplum/viewer.md) %}

#### managed-greenplum.editor {#managed-greenplum-editor}

{% include [managed-greenplum.editor](../_roles/managed-greenplum/editor.md) %}

#### managed-greenplum.admin {#managed-greenplum-admin}

{% include [managed-greenplum.admin](../_roles/managed-greenplum/admin.md) %}

Подробнее см. [{#T}](../managed-greenplum/security/index.md).


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

Подробнее см. [{#T}](../managed-kubernetes/security/index.md).


## {{ mmg-full-name }} {#managed-mongodb-roles}

#### managed-mongodb.auditor {#managed-mongodb-auditor}

{% include [managed-mongodb.auditor](../_roles/managed-mongodb/auditor.md) %}

#### managed-mongodb.viewer {#managed-mongodb-viewer}

{% include [managed-mongodb.viewer](../_roles/managed-mongodb/viewer.md) %}

#### managed-mongodb.editor {#managed-mongodb-editor}

{% include [managed-mongodb.editor](../_roles/managed-mongodb/editor.md) %}

#### managed-mongodb.admin {#managed-mongodb-admin}

{% include [managed-mongodb.admin](../_roles/managed-mongodb/admin.md) %}

Подробнее см. [{#T}](../managed-mongodb/security/index.md).


## {{ mmy-full-name }} {#managed-mysql-roles}

#### managed-mysql.auditor {#managed-mysql-auditor}

{% include [managed-mysql.auditor](../_roles/managed-mysql/auditor.md) %}

#### managed-mysql.viewer {#managed-mysql-viewer}

{% include [managed-mysql.viewer](../_roles/managed-mysql/viewer.md) %}

#### managed-mysql.editor {#managed-mysql-editor}

{% include [managed-mysql.editor](../_roles/managed-mysql/editor.md) %}

#### managed-mysql.admin {#managed-mysql-admin}

{% include [managed-mysql.admin](../_roles/managed-mysql/admin.md) %}

Подробнее см. [{#T}](../managed-mysql/security/index.md).


## {{ mos-full-name }} {#opensearch-roles}

#### managed-opensearch.auditor {#managed-opensearch-auditor}

{% include [opensearch.auditor](../_roles/managed-opensearch/auditor.md) %}

#### managed-opensearch.viewer {#managed-opensearch-viewer}

{% include [opensearch.viewer](../_roles/managed-opensearch/viewer.md) %}

#### managed-opensearch.editor {#managed-opensearch-editor}

{% include [opensearch.editor](../_roles/managed-opensearch/editor.md) %}

#### managed-opensearch.admin {#managed-opensearch-admin}

{% include [opensearch.admin](../_roles/managed-opensearch/admin.md) %}

Подробнее см. [{#T}](../managed-opensearch/security/index.md).


## {{ mpg-full-name }} {#mpg-roles}

#### managed-postgresql.auditor {#managed-postgresql-auditor}

{% include [managed-postgresql.auditor](../_roles/managed-postgresql/auditor.md) %}

#### managed-postgresql.viewer {#managed-postgresql-viewer}

{% include [managed-postgresql.viewer](../_roles/managed-postgresql/viewer.md) %}

#### managed-postgresql.editor {#managed-postgresql-editor}

{% include [managed-postgresql.editor](../_roles/managed-postgresql/editor.md) %}

#### managed-postgresql.admin {#managed-postgresql-admin}

{% include [managed-postgresql.admin](../_roles/managed-postgresql/admin.md) %}

Подробнее см. [{#T}](../managed-postgresql/security/index.md).


## {{ mrd-full-name }} {#mrd-roles}

#### managed-redis.auditor {#managed-redis-auditor}

{% include [managed-redis.auditor](../_roles/managed-redis/auditor.md) %}

#### managed-redis.viewer {#managed-redis-viewer}

{% include [managed-redis.viewer](../_roles/managed-redis/viewer.md) %}

#### managed-redis.editor {#managed-redis-editor}

{% include [managed-redis.editor](../_roles/managed-redis/editor.md) %}

#### managed-redis.admin {#managed-redis-admin}

{% include [managed-redis.admin](../_roles/managed-redis/admin.md) %}

Подробнее см. [{#T}](../managed-redis/security/index.md).


## {{ mms-full-name }} {#mms-roles}

#### managed-sqlserver.auditor {#managed-sqlserver-auditor}

{% include [managed-sqlserver.auditor](../_roles/managed-sqlserver/auditor.md) %}

#### managed-sqlserver.viewer {#managed-sqlserver-viewer}

{% include [managed-sqlserver.viewer](../_roles/managed-sqlserver/viewer.md) %}

#### managed-sqlserver.editor {#managed-sqlserver-editor}

{% include [managed-sqlserver.editor](../_roles/managed-sqlserver/editor.md) %}

#### managed-sqlserver.admin {#managed-sqlserver-admin}

{% include [managed-sqlserver.admin](../_roles/managed-sqlserver/admin.md) %}


## {{ mtr-full-name }} {#mtr-roles}

#### managed-trino.auditor {#managed-trino-auditor}

{% include [managed-trino.auditor](../_roles/managed-trino/auditor.md) %}

#### managed-trino.viewer {#managed-trino-viewer}

{% include [managed-trino.viewer](../_roles/managed-trino/viewer.md) %}

#### managed-trino.user {#managed-trino-user}

{% include [managed-trino.user](../_roles/managed-trino/user.md) %}

#### managed-trino.editor {#managed-trino-editor}

{% include [managed-trino.editor](../_roles/managed-trino/editor.md) %}

#### managed-trino.admin {#managed-trino-admin}

{% include [managed-trino.admin](../_roles/managed-trino/admin.md) %}

#### managed-trino.integrationProvider {#managed-trino-integrationProvider}

{% include [managed-trino.integrationProvider](../_roles/managed-trino/integrationProvider.md) %}

Подробнее см. [{#T}](../managed-trino/security.md).


## {{ myt-full-name }} {#myt-roles}

#### managed-ytsaurus.auditor {#managed-ytsaurus-auditor}

{% include [managed-ytsaurus.auditor](../_roles/managed-ytsaurus/auditor.md) %}

#### managed-ytsaurus.viewer {#managed-ytsaurus-viewer}

{% include [managed-ytsaurus.viewer](../_roles/managed-ytsaurus/viewer.md) %}

#### managed-ytsaurus.user {#managed-ytsaurus-user}

{% include [managed-ytsaurus.user](../_roles/managed-ytsaurus/user.md) %}

#### managed-ytsaurus.editor {#managed-ytsaurus-editor}

{% include [managed-ytsaurus.editor](../_roles/managed-ytsaurus/editor.md) %}

#### managed-ytsaurus.admin {#managed-ytsaurus-admin}

{% include [managed-ytsaurus.admin](../_roles/managed-ytsaurus/admin.md) %}

Подробнее см. [{#T}](../managed-ytsaurus/security/index.md).


## {{ ydb-full-name }} {#ydb-roles}

#### ydb.auditor {#ydb-auditor}

{% include [ydb.auditor](../_roles/ydb/auditor.md) %}

#### ydb.viewer {#ydb-viewer}

{% include [ydb.viewer](../_roles/ydb/viewer.md) %}

#### ydb.editor {#ydb-editor}

{% include [ydb.editor](../_roles/ydb/editor.md) %}

#### ydb.admin {#ydb-admin}

{% include [ydb.admin](../_roles/ydb/admin.md) %}

#### ydb.kafkaApi.client {#ydb-kafkaapi-client}

{% include [ydb.kafkaApi.client](../_roles/ydb/kafkaApi/client.md) %}

Подробнее см. [{#T}](../ydb/security/index.md).


## {{ message-queue-full-name }} {#message-queue-roles}

#### ymq.reader {#ymq-reader}

{% include [ymq.reader](../_roles/ymq/reader.md) %}

#### ymq.writer {#ymq-writer}

{% include [ymq.writer](../_roles/ymq/writer.md) %}

#### ymq.admin {#ymq-admin}

{% include [ymq.admin](../_roles/ymq/admin.md) %}

Подробнее см. [{#T}](../message-queue/security/index.md).


## {{ monitoring-full-name }} {#monitoring-roles}

#### monitoring.viewer {#monitoring-viewer}

{% include [monitoring.viewer](../_roles/monitoring/viewer.md) %}

#### monitoring.editor {#monitoring-editor}

{% include [monitoring.editor](../_roles/monitoring/editor.md) %}

#### monitoring.admin {#monitoring-admin}

{% include [monitoring.admin](../_roles/monitoring/admin.md) %}

Подробнее см. [{#T}](../monitoring/security/index.md).


## {{ network-load-balancer-full-name }} {#network-load-balancer-roles}

#### load-balancer.auditor {#load-balancer-auditor}

{% include [load-balancer.auditor](../_roles/load-balancer/auditor.md) %}

#### load-balancer.viewer {#load-balancer-viewer}

{% include [loadbalancer-viewer](../_roles/load-balancer/viewer.md) %}

#### load-balancer.privateAdmin {#load-balancer-private-admin}

{% include [loadbalancer-privateadmin](../_roles/load-balancer/privateAdmin.md) %}

#### load-balancer.editor {#load-balancer-editor}

{% include [loadbalancer-editor](../_roles/load-balancer/editor.md) %}

#### load-balancer.admin {#load-balancer-admin}

{% include [loadbalancer-admin](../_roles/load-balancer/admin.md) %}

Подробнее см. [{#T}](../network-load-balancer/security/index.md).


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

Подробнее см. [{#T}](../storage/security/index.md).


## {{ yq-full-name }} {#query-roles}

#### yq.auditor {#query-auditor}

{% include [query.auditor](../_roles/yq/auditor.md) %}

#### yq.viewer {#query-viewer}

{% include [query.viewer](../_roles/yq/viewer.md) %}

#### yq.editor {#query-editor}

{% include [query.editor](../_roles/yq/editor.md) %}

#### yq.admin {#query-admin}

{% include [query.admin](../_roles/yq/admin.md) %}

#### yq.invoker {#query-invoker}

{% include [query.invoker](../_roles/yq/invoker.md) %}

Подробнее см. [{#T}](../query/security/index.md).


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

Подробнее см. [{#T}](../resource-manager/security/index.md).


## {{ search-api-full-name }} {#search-api-roles}

#### search-api.executor {#search-api-executor}

{% include [searchapi-executor](../_roles/search-api/executor.md) %}

#### search-api.webSearch.user {#search-api-webSearch-user}

{% include [search-api-webSearch-user](../_roles/search-api/webSearch/user.md) %}

#### search-api.auditor {#search-api-auditor}

{% include [searchapi-auditor](../_roles/search-api/auditor.md) %}

#### search-api.viewer {#search-api-viewer}

{% include [searchapi-viewer](../_roles/search-api/viewer.md) %}

#### search-api.editor {#search-api-editor}

{% include [searchapi-editor](../_roles/search-api/editor.md) %}

#### search-api.admin {#search-api-admin}

{% include [searchapi-admin](../_roles/search-api/admin.md) %}

Подробнее см. [{#T}](../search-api/security/index.md).


## {{ sd-full-name }} {#security-deck-roles}

### Общие роли {{ sd-name }} {#general-sd-roles}

#### security-deck.auditor {#security-deck-auditor}

{% include [security-deck.auditor](../_roles/security-deck/auditor.md) %}

#### security-deck.viewer {#security-deck-viewer}

{% include [security-deck.viewer](../_roles/security-deck/viewer.md) %}

#### security-deck.editor {#security-deck-editor}

{% include [security-deck.editor](../_roles/security-deck/editor.md) %}

#### security-deck.admin {#security-deck-admin}

{% include [security-deck.admin](../_roles/security-deck/admin.md) %}

Подробнее см. [Общие роли {{ sd-full-name }}](../security-deck/security/index.md).

### Сервисные роли для анализа данных {{ atr-name }} {#access-transparency-roles}

#### access-transparency.viewer {#access-transparency-viewer}

{% include [access-transparency.viewer](../_roles/access-transparency/viewer.md) %}

#### access-transparency.editor {#access-transparency-editor}

{% include [access-transparency.editor](../_roles/access-transparency/editor.md) %}

#### access-transparency.admin {#access-transparency-admin}

{% include [access-transparency.admin](../_roles/access-transparency/admin.md) %}

#### access-transparency.billingProvider {#access-transparency-billingProvider}

{% include [access-transparency.billingProvider](../_roles/access-transparency/billingProvider.md) %}

#### access-transparency.subscriptionManager {#access-transparency-subscriptionManager}

{% include [access-transparency.subscriptionManager](../_roles/access-transparency/subscriptionManager.md) %}

Подробнее см. [Управление доступом в {{ atr-name }}](../security-deck/security/access-transparency-roles.md).

### Сервисные роли для контроля данных ({{ dspm-name }}) {#dspm-roles}

#### dspm.worker {#dspm-worker}

{% include [dspm.worker](../_roles/dspm/worker.md) %}

#### dspm.inspector {#dspm-inspector}

{% include [dspm.inspector](../_roles/dspm/inspector.md) %}

#### dspm.auditor {#dspm-auditor}

{% include [dspm.auditor](../_roles/dspm/auditor.md) %}

#### dspm.viewer {#dspm-viewer}

{% include [dspm.viewer](../_roles/dspm/viewer.md) %}

#### dspm.editor {#dspm-editor}

{% include [dspm.editor](../_roles/dspm/editor.md) %}

#### dspm.admin {#dspm-admin}

{% include [dspm.admin](../_roles/dspm/admin.md) %}

Подробнее см. [Управление доступом в {{ dspm-name }}](../security-deck/security/dspm-roles.md).


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

#### serverless.containers.viewer {#serverless-containers-viewer-deprecated}

{% include [serverless.containers.viewer](../_roles/serverless/containers/viewer.md) %}

#### serverless.containers.editor {#serverless-containers-editor-deprecated}

{% include [serverless.containers.editor](../_roles/serverless/containers/editor.md) %}

#### serverless.containers.admin {#serverless-containers-admin-deprecated}

{% include [serverless.containers.admin](../_roles/serverless/containers/admin.md) %}

#### serverless.containers.invoker {#serverless-containers-invoker-deprecated}

{% include [serverless.containers.invoker](../_roles/serverless/containers/invoker.md) %}

Подробнее см. [{#T}](../serverless-containers/security/index.md).


## {{ si-full-name }} {#serverless-integrations-roles}

### Сервисные роли {{ er-full-name }} {#eventrouter-roles}

#### serverless.eventrouter.auditor {#serverless-eventrouter-auditor}

{% include [serverless.eventrouter.auditor](../_roles/serverless/eventrouter/auditor.md) %}

#### serverless.eventrouter.viewer {#serverless-eventrouter-viewer}

{% include [serverless.eventrouter.viewer](../_roles/serverless/eventrouter/viewer.md) %}

#### serverless.eventrouter.supplier {#serverless-eventrouter-supplier}

{% include [serverless.eventrouter.supplier](../_roles/serverless/eventrouter/supplier.md) %}

#### serverless.eventrouter.editor {#serverless-eventrouter-editor}

{% include [serverless.eventrouter.editor](../_roles/serverless/eventrouter/editor.md) %}

#### serverless.eventrouter.admin {#serverless-eventrouter-admin}

{% include [serverless.eventrouter.admin](../_roles/serverless/eventrouter/admin.md) %}

Подробнее см. [Управление доступом в {{ er-name }}](../serverless-integrations/security/eventrouter.md).


## {{ captcha-full-name }} {#captcha-roles}

#### smart-captcha.auditor {#smart-captcha-auditor}

{% include [smart-captcha.auditor](../_roles/smart-captcha/auditor.md) %}

#### smart-captcha.viewer {#smart-captcha-viewer}

{% include [smartcaptcha-viewer](../_roles/smart-captcha/viewer.md) %}

#### smart-captcha.editor {#smart-captcha-editor}

{% include [smartcaptcha-editor](../_roles/smart-captcha/editor.md) %}

#### smart-captcha.admin {#smart-captcha-admin}

{% include [smartcaptcha-admin](../_roles/smart-captcha/admin.md) %}

Подробнее см. [{#T}](../smartcaptcha/security/index.md).


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

Подробнее см. [{#T}](../smartwebsecurity/security/index.md).


## {{ speechkit-full-name }} {#speechkit-roles}

#### ai.speechkit-stt.user {#ai-speechkit-stt-user}

{% include [speechkit-stt-user](../_roles/ai/speechkit-stt/user.md) %}

#### ai.speechkit-tts.user {#ai-speechkit-tts-user}

{% include [speechkit-tts-user](../_roles/ai/speechkit-tts/user.md) %}

Подробнее см. [{#T}](../speechkit/security/index.md).


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

Подробнее см. [{#T}](../speechsense/security/index.md).


## {{ translate-full-name }} {#translate-roles}

#### ai.translate.user {#translate-user}

{% include [translate-user](../_roles/ai/translate/user.md) %}

Подробнее см. [{#T}](../translate/security/index.md).


## {{ vpc-full-name }} {#vpc-roles}

#### vpc.auditor {#vpc-auditor}

{% include [vpc.auditor](../_roles/vpc/auditor.md) %}

#### vpc.viewer {#vpc-viewer}

{% include [vpc-viewer](../_roles/vpc/viewer.md) %}

#### vpc.user {#vpc-user}

{% include [vpc-user](../_roles/vpc/user.md) %}

#### vpc.externalAddresses.user {#vpc-externalAddresses-user}

{% include [vpc.externalAddresses.user](../_roles/vpc/externalAddresses/user.md) %}

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

#### vpc.privateEndpoints.viewer {#vpc-privateEndpoints-viewer}

{% include [vpc-privateEndpoints-viewer](../_roles/vpc/privateEndpoints/viewer.md) %}

#### vpc.privateEndpoints.editor {#vpc-privateEndpoints-editor}

{% include [vpc-privateEndpoints-editor](../_roles/vpc/privateEndpoints/editor.md) %}

#### vpc.privateEndpoints.admin {#vpc-privateEndpoints-admin}

{% include [vpc-privateEndpoints-admin](../_roles/vpc/privateEndpoints/admin.md) %}

Подробнее см. [{#T}](../vpc/security/index.md).


## {{ vision-full-name }} {#vision-roles}

#### ai.vision.user {#vision-user}

{% include [vision-user](../_roles/ai/vision/user.md) %}

Подробнее см. [{#T}](../vision/security/index.md).


## {{ websql-full-name }} {#websql-roles}

#### websql.executedQueries.auditor {#websql-executedQueries-auditor}

{% include [websql.executedQueries.auditor](../_roles/websql/executedQueries/auditor.md) %}

#### websql.savedQueries.auditor {#websql-savedQueries-auditor}

{% include [websql.savedQueries.auditor](../_roles/websql/savedQueries/auditor.md) %}

#### websql.executedQueries.viewer {#websql-executedQueries-viewer}

{% include [websql.executedQueries.viewer](../_roles/websql/executedQueries/viewer.md) %}

#### websql.savedQueries.viewer {#websql-savedQueries-viewer}

{% include [websql.savedQueries.viewer](../_roles/websql/savedQueries/viewer.md) %}

#### websql.executedQueries.editor {#websql-executedQueries-editor}

{% include [websql.executedQueries.editor](../_roles/websql/executedQueries/editor.md) %}

#### websql.savedQueries.editor {#websql-savedQueries-editor}

{% include [websql.savedQueries.editor](../_roles/websql/savedQueries/editor.md) %}

#### websql.executedQueries.admin {#websql-executedQueries-admin}

{% include [websql.executedQueries.admin](../_roles/websql/executedQueries/admin.md) %}

#### websql.savedQueries.admin {#websql-savedQueries-admin}

{% include [websql.savedQueries.admin](../_roles/websql/savedQueries/admin.md) %}

#### websql.auditor {#websql-auditor}

{% include [websql.auditor](../_roles/websql/auditor.md) %}

#### websql.viewer {#websql-viewer}

{% include [websql.viewer](../_roles/websql/viewer.md) %}

#### websql.user {#websql-user}

{% include [websql.user](../_roles/websql/user.md) %}

#### websql.editor {#websql-editor}

{% include [websql.editor](../_roles/websql/editor.md) %}

#### websql.admin {#websql-admin}

{% include [websql.admin](../_roles/websql/admin.md) %}

Подробнее см. [{#T}](../websql/security/index.md).


## {{ wiki-full-name }} {#wiki-roles}

#### wiki.viewer {#wiki-viewer}

{% include [wiki-viewer](../_roles/wiki/viewer.md) %}

#### wiki.admin {#wiki-admin}

{% include [wiki-admin](../_roles/wiki/admin.md) %}

{% include [clickhouse-disclaimer](../_includes/clickhouse-disclaimer.md) %}
