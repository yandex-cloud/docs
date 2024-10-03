---
title: List of resources that you can assign roles for in {{ iam-full-name }}
description: In this tutorial, you will learn for which {{ yandex-cloud }} resources you can assign roles.
---

# List of resources that you can assign roles for


{{ yandex-cloud }} has various resources for which you can [assign](../../operations/roles/grant.md), [view](../../operations/roles/get-assigned-roles.md), and [revoke](../../operations/roles/revoke.md) roles. The list of such resources depends on the {{ yandex-cloud }} interface you use to assign a role.

If you need to grant access to a resource that is not on the list, assign the role for the parent resource it [inherits](index.md#inheritance) permissions from. For example, [{{ mpg-full-name }} clusters](../../../managed-postgresql/concepts/index.md) inherit access permissions from their folder.

## Resources for which you can assign roles in the management console {#console}

**{{ container-registry-name }}**
* [Registry](../../../container-registry/operations/roles/grant.md)

**{{ compute-name }}**

{% include notitle [compute-resources](../../../_includes/iam/resources-with-access-control/compute.md) %}

**{{ iam-name }}**
* [Service account](../../operations/sa/assign-role-for-sa.md)

**{{ kms-name }}**

{% include notitle [kms-resources](../../../_includes/iam/resources-with-access-control/kms.md) %}

**{{ ydb-name }}**
* [YDB DBMS](../../../ydb/operations/manage-databases.md#add-access-binding)

**{{ metadata-hub-full-name }}**
* [Connection to managed databases](../../../metadata-hub/operations/connection-access.md) in {{ connection-manager-full-name }}

**{{ objstorage-name }}**
* [Bucket](../../../storage/operations/buckets/iam-access.md)

**{{ resmgr-name }}**
* [Cloud](../../../resource-manager/operations/cloud/set-access-bindings.md)
* [Folder](../../../resource-manager/operations/folder/set-access-bindings.md)

**{{ lockbox-name }}**
* [Secret](../../../lockbox/operations/secret-access.md)

## Resources for which you can assign roles via the YC CLI and {{ yandex-cloud }} API {#cli-api}

**{{ api-gw-name }}**
* [API gateway](../../../api-gateway/concepts/index.md)

**{{ at-name }}**
* [Trail](../../../audit-trails/concepts/trail.md)

**{{ certificate-manager-name }}**
* [Custom certificate](../../../certificate-manager/concepts/imported-certificate.md)

**{{ cloud-desktop-name }}**
* [Desktop groups](../../../cloud-desktop/concepts/desktops-and-groups.md)

**{{ dns-name }}**
* [DNS zone](../../../dns/operations/zone-access.md)

**{{ sf-name }}**
* [Function](../../../functions/operations/function/role-add.md)

**{{ cloud-logging-name }}**

{% include notitle [logging-resources](../../../_includes/iam/resources-with-access-control/logging.md) %}

**{{ org-name }}**

{% include notitle [organization-resources](../../../_includes/iam/resources-with-access-control/organization.md) %}

**{{ container-registry-name }}**
* [Registry](../../../container-registry/operations/roles/grant.md)
* [Repository](../../../container-registry/operations/roles/grant.md)

**{{ compute-name }}**

{% include notitle [compute-resources](../../../_includes/iam/resources-with-access-control/compute.md) %}

**{{ iam-name }}**
* [Service account](../../operations/sa/assign-role-for-sa.md)

**{{ kms-name }}**

{% include notitle [kms-resources](../../../_includes/iam/resources-with-access-control/kms.md) %}

**{{ ydb-name }}**
* [YDB DBMS](../../../ydb/operations/manage-databases.md#add-access-binding)
* YDB DBMS backup

**{{ resmgr-name }}**
* [Cloud](../../../resource-manager/operations/cloud/set-access-bindings.md)
* [Folder](../../../resource-manager/operations/folder/set-access-bindings.md)

**{{ serverless-containers-name }}**
* [Container](../../../serverless-containers/operations/role-add.md)

**{{ lockbox-name }}**
* [Secret](../../../lockbox/operations/secret-access.md)

## Resources for which you can assign roles using {{ TF }} {#terraform}

**{{ container-registry-name }}**
* [Registry](../../../container-registry/operations/roles/grant.md)
* [Repository](../../../container-registry/operations/roles/grant.md)

**{{ ml-platform-name }}**
* [Project](../../../datasphere/security/index.md)
* [Community](../../../datasphere/security/index.md)

**{{ dns-name }}**
* [DNS zone](../../../dns/operations/zone-access.md)

**{{ sf-name }}**
* [Function](../../../functions/operations/function/role-add.md)

**{{ compute-name }}**
* [VM instance](../../../compute/operations/vm-control/vm-access.md)
* [VM placement group](../../../compute/operations/placement-groups/access.md)
* [Non-replicated disk placement group](../../../compute/operations/disk-placement-groups/access.md)
* [VM disk](../../../compute/operations/disk-control/disk-access.md)
* [GPU cluster](../../../compute/operations/gpu-cluster/access.md)
* [Image](../../../compute/operations/image-control/access.md)
* [Snapshot schedule](../../../compute/operations/snapshot-control/snapshot-schedule-access.md)
* [Disk snapshot](../../../compute/operations/snapshot-control/snapshot-access.md)
* [File storage](../../../compute/operations/filesystem/filesystem-access.md)

**{{ iam-name }}**
* [Service account](../../operations/sa/assign-role-for-sa.md)

**{{ kms-name }}**

{% include notitle [kms-resources](../../../_includes/iam/resources-with-access-control/kms.md) %}

**{{ lockbox-name }}**
* [Secret](../../../lockbox/operations/secret-access.md)

**{{ resmgr-name }}**
* [Cloud](../../../resource-manager/operations/cloud/set-access-bindings.md)
* [Folder](../../../resource-manager/operations/folder/set-access-bindings.md)

**{{ serverless-containers-name }}**
* [Container](../../../serverless-containers/operations/role-add.md)

**{{ ydb-name }}**
* [YDB DBMS](../../../ydb/security/index.md)

**{{ org-name }}**

{% include notitle [organization-resources](../../../_includes/iam/resources-with-access-control/organization.md) %}
