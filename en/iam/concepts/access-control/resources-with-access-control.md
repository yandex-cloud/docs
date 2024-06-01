---
title: "List of resources that you can assign roles for in {{ iam-full-name }}"
description: "In this tutorial, you will learn for which {{ yandex-cloud }} resources you can assign roles."
---

# List of resources that you can assign roles for


{{ yandex-cloud }} has various resources for which you can [assign](../../operations/roles/grant.md), [view](../../operations/roles/get-assigned-roles.md), and [revoke](../../operations/roles/revoke.md) roles. The list of such resources depends on the {{ yandex-cloud }} interface you use to assign a role.

If you need to grant access to a resource that is not on the list, assign the role for the parent resource it [inherits](index.md#inheritance) permissions from. For example, [{{ mpg-full-name }} clusters](../../../managed-postgresql/concepts/index.md) inherit access permissions from their folder.

## Resources for which you can assign roles in the management console {#console}

**{{ container-registry-name }}**
* [Registry](../../../container-registry/concepts/registry.md)

**{{ compute-name }}**

{% include notitle [compute-resources](../../../_includes/iam/resources-with-access-control/compute.md) %}

**{{ iam-name }}**
* [Service account](../users/service-accounts.md)

**{{ kms-name }}**

{% include notitle [kms-resources](../../../_includes/iam/resources-with-access-control/kms.md) %}

**{{ ydb-name }}**
* [YDB DBMS](../../../ydb/concepts/index.md#ydb)

**{{ metadata-hub-name }}**
* [Connection to managed databases](../../../metadata-hub/concepts/connection-manager.md) in {{ connection-manager-full-name }}

**{{ objstorage-name }}**
* [Bucket](../../../storage/concepts/bucket.md)

**{{ resmgr-name }}**
* [Cloud](../../../resource-manager/concepts/resources-hierarchy.md#cloud)
* [Folder](../../../resource-manager/concepts/resources-hierarchy.md#folder)

**{{ lockbox-name }}**
* [Secret](../../../lockbox/concepts/secret.md)

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
* [DNS zone](../../../dns/concepts/dns-zone.md)

**{{ sf-name }}**
* [Function](../../../functions/concepts/function.md)

**{{ cloud-logging-name }}**

{% include notitle [logging-resources](../../../_includes/iam/resources-with-access-control/logging.md) %}

**{{ org-name }}**

{% include notitle [organization-resources](../../../_includes/iam/resources-with-access-control/organization.md) %}

**{{ container-registry-name }}**
* [Registry](../../../container-registry/concepts/registry.md)
* [Repository](../../../container-registry/concepts/repository.md)

**{{ compute-name }}**

{% include notitle [compute-resources](../../../_includes/iam/resources-with-access-control/compute.md) %}

**{{ iam-name }}**
* [Service account](../users/service-accounts.md)

**{{ kms-name }}**

{% include notitle [kms-resources](../../../_includes/iam/resources-with-access-control/kms.md) %}

**{{ ydb-name }}**
* [YDB DBMS](../../../ydb/concepts/index.md#ydb)
* YDB DBMS backup

**{{ resmgr-name }}**
* [Cloud](../../../resource-manager/concepts/resources-hierarchy.md#cloud)
* [Folder](../../../resource-manager/concepts/resources-hierarchy.md#folder)

**{{ serverless-containers-name }}**
* [Container](../../../serverless-containers/concepts/container.md)

**{{ lockbox-name }}**
* [Secret](../../../lockbox/concepts/secret.md)
