---
title: "List of resources that you can assign roles for in {{ iam-full-name }}"
description: "In this tutorial, you will learn for which {{ yandex-cloud }} resources you can assign roles."
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
* [Registry](../../../container-registry/concepts/registry.md)
* [Repository](../../../container-registry/concepts/repository.md)

**{{ ml-platform-name }}**
* [Project](../../../datasphere/concepts/project.md)
* [Community](../../../datasphere/concepts/community.md)

**{{ dns-name }}**
* [DNS zone](../../../dns/concepts/dns-zone.md)

**{{ sf-name }}**
* [Function](../../../functions/concepts/function.md)

**{{ iam-name }}**
* [Service account](../users/service-accounts.md)

**{{ kms-name }}**

{% include notitle [kms-resources](../../../_includes/iam/resources-with-access-control/kms.md) %}

**{{ lockbox-name }}**
* [Secret](../../../lockbox/concepts/secret.md)

**{{ resmgr-name }}**
* [Cloud](../../../resource-manager/concepts/resources-hierarchy.md#cloud)
* [Folder](../../../resource-manager/concepts/resources-hierarchy.md#folder)

**{{ serverless-containers-name }}**
* [Container](../../../serverless-containers/concepts/container.md)

**{{ ydb-name }}**
* [YDB DBMS](../../../ydb/concepts/index.md#ydb)

**{{ org-name }}**

{% include notitle [organization-resources](../../../_includes/iam/resources-with-access-control/organization.md) %}
