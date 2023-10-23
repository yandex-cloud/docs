---
title: "{{ yandex-cloud }} role reference"
description: "The article provides a full reference and description of roles for {{ yandex-cloud }} services."
---

# {{ yandex-cloud }} roles reference


## {{ api-gw-full-name }} {#api-gateway-roles}

#### api-gateway.viewer {#api-gateway-viewer}

{% include [api-gateway.viewer](../_roles/apigateway/apigateway-viewer.md) %}

#### api-gateway.editor {#api-gateway-editor}

{% include [api-gateway.editor](../_roles/apigateway/apigateway-editor.md) %}

#### api-gateway.websocketWriter {#api-gateway-websocketwriter}

{% include [api-gateway.websocketWriter](../_roles/apigateway/apigateway-websocketwriter.md) %}

#### api-gateway.admin {#api-gateway-admin}

{% include [api-gateway.admin](../_roles/apigateway/apigateway-admin.md) %}


## {{ alb-full-name }} {#alb-roles}

#### alb.viewer {#alb-viewer}

{% include [alb.viewer](../_roles/apploadbalancer/apploadbalancer-viewer.md) %}

#### alb.editor {#alb-editor}

{% include [alb.editor](../_roles/apploadbalancer/apploadbalancer-editor.md) %}

#### alb.admin {#alb-admin}

{% include [alb.admin](../_roles/apploadbalancer/apploadbalancer-admin.md) %}


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

For more information, see [Access management in {{ at-name }}](../audit-trails/security/index.md).


## {{ backup-full-name }} {#backup-roles}

#### backup.viewer {#backup-viewer}

{% include [backup.viewer](../_roles/backup/backup-viewer.md) %}

#### backup.editor {#backup-editor}

{% include [backup.editor](../_roles/backup/backup-editor.md) %}

#### backup.admin {#backup-admin}

{% include [backup.admin](../_roles/backup/backup-admin.md) %}

For more information, see [Access management in {{ backup-name }}](../backup/security/index.md).


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

For more information, see [Access management in {{ billing-name }}](../billing/security/index.md).


## {{ cdn-full-name }} {#cdn-roles}

#### cdn.viewer {#cdn-viewer}

{% include [cdn-viewer](../_roles/cdn/cdn-viewer.md) %}

#### cdn.editor {#cdn-editor}

{% include [cdn-editor](../_roles/cdn/cdn-editor.md) %}

#### cdn.admin {#cdn-admin}

{% include [cdn-admin](../_roles/cdn/cdn-admin.md) %}

For more information, see [Access management in {{ cdn-name }}](../cdn/security/index.md).


## {{ certificate-manager-full-name }} {#certificate-manager-roles}

#### certificate-manager.admin {#certificate-manager-admin}

{% include [certificate-manager.admin](../_roles/certificatemanager/certificatemanager-admin.md) %}

#### certificate-manager.certificates.downloader {#certificate-manager-certificates-downloader}

{% include [certificate-manager.certificates.downloader](../_roles/certificatemanager/certificatemanager-certificates-downloader.md) %}

For more information, see [Access management in {{ certificate-manager-name }}](../certificate-manager/security/index.md).


## {{ compute-full-name }} {#compute-roles}

#### compute.viewer {#compute-viewer}

{% include [compute.viewer](../_roles/compute/compute-viewer.md) %}

#### compute.admin {#compute-admin}

{% include [compute.admin](../_roles/compute/compute-admin.md) %}

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

For more information, see [Access management in {{ compute-name }}](../compute/security/index.md).


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

For more information, see [Access management in {{ container-registry-name }}](../container-registry/security/index.md).


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

For more information, see [Access management in {{ dataproc-name }}](../data-proc/security/index.md).


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

For more information, see [Access management in {{ ml-platform-name }}](../datasphere/security/index.md).


## {{ yds-full-name }} {#yds-roles}

#### yds.viewer {#yds-viewer}

{% include [yds.viewer](../_roles/yds/yds-viewer.md) %}

#### yds.writer {#yds-writer}

{% include [yds.writer](../_roles/yds/yds-writer.md) %}

#### yds.editor {#yds-editor}

{% include [yds.editor](../_roles/yds/yds-editor.md) %}

#### yds.admin {#yds-admin}

{% include [yds.admin](../_roles/yds/yds-admin.md) %}

For more information, see [Access management in {{ yds-name }}](../data-streams/security/index.md).


## {{ data-transfer-full-name }} {#data-transfer-roles}

#### data-transfer.auditor {#data-transfer-auditor}

{% include [data-transfer.auditor](../_roles/datatransfer/datatransfer-auditor.md) %}

#### data-transfer.viewer {#data-transfer-viewer}

{% include [data-transfer.viewer](../_roles/datatransfer/datatransfer-viewer.md) %}

#### data-transfer.privateAdmin {#data-transfer-privateadmin}

{% include [data-transfer.privateadmin](../_roles/datatransfer/datatransfer-privateadmin.md) %}

#### data-transfer.admin {#data-transfer-admin}

{% include [data-transfer.admin](../_roles/datatransfer/datatransfer-admin.md) %}

For more information, see [Access management in {{ data-transfer-name }}](../data-transfer/security/index.md).


## {{ dns-full-name }} {#dns-roles}

#### dns.auditor {#dns-auditor}

{% include [roles-dns-auditor](../_roles/dns/dns-auditor.md) %}

#### dns.viewer {#dns-viewer}

{% include [roles-dns-viewer](../_roles/dns/dns-viewer.md) %}

#### dns.editor {#dns-editor}

{% include [roles-dns-editor](../_roles/dns/dns-editor.md) %}

#### dns.admin {#dns-admin}

{% include [roles-dns-admin](../_roles/dns/dns-admin.md) %}

For more information, see [Access management in {{ dns-name }}](../dns/security/index.md).


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

For more information, see [Access management in {{ sf-name }}](../functions/security/index.md).


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

For more information, see [Access management in {{ cloud-logging-name }}](../logging/security/index.md).
