---
title: List of resources you can assign roles for in {{ iam-full-name }}
description: In this tutorial, you will learn which {{ yandex-cloud }} resources you can assign roles for.
---

# List of resources that you can assign roles for


{{ yandex-cloud }} has various resources for which you can [assign](../../operations/roles/grant.md), [view](../../operations/roles/get-assigned-roles.md), and [revoke](../../operations/roles/revoke.md) roles.

If you need to grant access to a resource that is not on the list, assign the role for the parent resource it [inherits](index.md#inheritance) permissions from. For example, [{{ mpg-full-name }} clusters](../../../managed-postgresql/concepts/index.md) inherit access permissions from their folder.

The list of resources will vary depending on the {{ yandex-cloud }} interface used to assign a role.

{% list tabs group=instructions %}

- Management console {#console}

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

- CLI {#cli}

  {% include notitle [cli-api](../../../_includes/iam/resources-with-access-control/cli-api.md) %}

- {{ TF }} {#tf}

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

  {% include notitle [compute-resources-tf](../../../_includes/iam/resources-with-access-control/compute-tf.md) %}

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

- API {#api}

  {% include notitle [cli-api](../../../_includes/iam/resources-with-access-control/cli-api.md) %}

{% endlist %}