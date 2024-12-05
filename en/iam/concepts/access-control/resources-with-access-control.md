---
title: List of resources you can assign roles for in {{ iam-full-name }}
description: In this tutorial, you will learn which {{ yandex-cloud }} resources you can assign roles for.
---

# List of resources you can assign roles for


{{ yandex-cloud }} has various resources for which you can [assign](../../operations/roles/grant.md), [view](../../operations/roles/get-assigned-roles.md), and [revoke](../../operations/roles/revoke.md) roles.

If you need to grant access to a resource that is not on the list, assign the role for the parent resource it [inherits](index.md#inheritance) permissions from. For example, [{{ mpg-full-name }} clusters](../../../managed-postgresql/concepts/index.md) inherit access permissions from their folder.

The list of resources will vary depending on the {{ yandex-cloud }} interface used to assign a role.

{% list tabs group=instructions %}

- Management console and service interfaces {#console}

  **{{ billing-name }}**
  * [Billing account](../../../billing/concepts/billing-account.md)

  **{{ cloud-desktop-full-name }}**
  * [Desktop groups](../../../cloud-desktop/concepts/desktops-and-groups.md)

  **{{ org-full-name }}**

  {% include notitle [organization-resources](../../../_includes/iam/resources-with-access-control/organization.md) %}

  **{{ compute-full-name }}**

  {% include notitle [compute-resources](../../../_includes/iam/resources-with-access-control/compute.md) %}

  **{{ container-registry-full-name }}**
  * [Registry](../../../container-registry/concepts/registry.md)

  **{{ datalens-full-name }}**
  * [Workbook](../../../datalens/workbooks-collections/index.md)
  * [Collection](../../../datalens/workbooks-collections/index.md)

  **{{ ml-platform-full-name }}**
  * [Project](../../../datasphere/security/index.md)
  * [Community](../../../datasphere/security/index.md)

  **{{ iam-full-name }}**
  * [Service account](../../operations/sa/assign-role-for-sa.md)

  **{{ kms-full-name }}**

  {% include notitle [kms-resources](../../../_includes/iam/resources-with-access-control/kms.md) %}

  **{{ lockbox-full-name }}**
  * [Secret](../../../lockbox/operations/secret-access.md)

  **{{ ydb-full-name }}**
  * [YDB DBMS](../../../ydb/concepts/index.md#ydb)

  **{{ metadata-hub-full-name }}**
  * [Connection to managed databases](../../../metadata-hub/operations/connection-access.md) in {{ connection-manager-full-name }}

  **{{ objstorage-full-name }}**
  * [Bucket](../../../storage/operations/buckets/iam-access.md)

  **{{ resmgr-full-name }}**
  * [Cloud](../../../resource-manager/operations/cloud/set-access-bindings.md)
  * [Folder](../../../resource-manager/operations/folder/set-access-bindings.md)

  **{{ speechsense-full-name }}**
  * [Space](../../../speechsense/concepts/resources-hierarchy.md#space)
  * [Project](../../../speechsense/concepts/resources-hierarchy.md#project)

  **{{ websql-full-name }}**
  * [Saved query](../../../websql/concepts/index.md#saved-queries)
  * [Historical query](../../../websql/concepts/index.md#query-log)

- CLI {#cli}

  **{{ api-gw-full-name }}**
  * [API gateway](../../../api-gateway/concepts/index.md)

  **{{ at-full-name }}**
  * [Trail](../../../audit-trails/concepts/trail.md)

  **{{ certificate-manager-full-name }}**
  * [Custom certificate](../../../certificate-manager/concepts/imported-certificate.md)

  **{{ cloud-desktop-full-name }}**
  * [Desktop groups](../../../cloud-desktop/concepts/desktops-and-groups.md)

  **{{ dns-full-name }}**
  * [DNS zone](../../../dns/operations/zone-access.md)

  **{{ sf-full-name }}**
  * [Function](../../../functions/operations/function/role-add.md)

  **{{ cloud-logging-full-name }}**
  * [Log group](../../../logging/concepts/log-group.md)
  * [Log target](../../../logging/operations/create-sink.md)

  **{{ org-full-name }}**

  {% include notitle [organization-resources](../../../_includes/iam/resources-with-access-control/organization.md) %}

  **{{ compute-full-name }}**

  {% include notitle [compute-resources](../../../_includes/iam/resources-with-access-control/compute.md) %}

  **{{ container-registry-full-name }}**
  * [Registry](../../../container-registry/concepts/registry.md)
  * [Repository](../../../container-registry/concepts/repository.md)

  **{{ iam-full-name }}**
  * [Service account](../../../iam/operations/sa/assign-role-for-sa.md)

  **{{ kms-full-name }}**

  {% include notitle [kms-resources](../../../_includes/iam/resources-with-access-control/kms.md) %}

  **{{ lockbox-full-name }}**
  * [Secret](../../../lockbox/operations/secret-access.md)

  **{{ ydb-full-name }}**
  * [YDB DBMS](../../../ydb/concepts/index.md#ydb)
  * YDB DBMS backup

  **{{ resmgr-full-name }}**
  * [Cloud](../../../resource-manager/operations/cloud/set-access-bindings.md)
  * [Folder](../../../resource-manager/operations/folder/set-access-bindings.md)

  **{{ serverless-containers-full-name }}**
  * [Container](../../../serverless-containers/operations/role-add.md)

- {{ TF }} {#tf}

  **{{ dns-full-name }}**
  * [DNS zone](../../../dns/operations/zone-access.md)

  **{{ sf-full-name }}**
  * [Function](../../../functions/operations/function/role-add.md)

  **{{ org-full-name }}**

  {% include notitle [organization-resources](../../../_includes/iam/resources-with-access-control/organization.md) %}

  **{{ compute-full-name }}**

  {% include notitle [compute-resources-tf](../../../_includes/iam/resources-with-access-control/compute-tf.md) %}

  **{{ container-registry-full-name }}**
  * [Registry](../../../container-registry/concepts/registry.md)
  * [Repository](../../../container-registry/concepts/repository.md)

  **{{ ml-platform-full-name }}**
  * [Project](../../../datasphere/security/index.md)
  * [Community](../../../datasphere/security/index.md)

  **{{ iam-full-name }}**
  * [Service account](../../operations/sa/assign-role-for-sa.md)

  **{{ kms-full-name }}**

  {% include notitle [kms-resources](../../../_includes/iam/resources-with-access-control/kms.md) %}

  **{{ lockbox-full-name }}**
  * [Secret](../../../lockbox/operations/secret-access.md)

  **{{ ydb-full-name }}**
  * [YDB DBMS](../../../ydb/concepts/index.md#ydb)

  **{{ resmgr-full-name }}**
  * [Cloud](../../../resource-manager/operations/cloud/set-access-bindings.md)
  * [Folder](../../../resource-manager/operations/folder/set-access-bindings.md)

  **{{ serverless-containers-full-name }}**
  * [Container](../../../serverless-containers/operations/role-add.md)

- API {#api}

  **{{ api-gw-full-name }}**
  * [API gateway](../../../api-gateway/concepts/index.md)

  **{{ at-full-name }}**
  * [Trail](../../../audit-trails/concepts/trail.md)

  **{{ certificate-manager-full-name }}**
  * [Custom certificate](../../../certificate-manager/concepts/imported-certificate.md)

  **{{ billing-name }}**
  * [Billing account](../../../billing/concepts/billing-account.md)

  **{{ cloud-desktop-full-name }}**
  * [Desktop groups](../../../cloud-desktop/concepts/desktops-and-groups.md)

  **{{ dns-full-name }}**
  * [DNS zone](../../../dns/operations/zone-access.md)

  **{{ sf-full-name }}**
  * [Function](../../../functions/operations/function/role-add.md)

  **{{ cloud-logging-full-name }}**

  {% include notitle [logging-resources](../../../_includes/iam/resources-with-access-control/logging.md) %}

  **{{ org-full-name }}**

  {% include notitle [organization-resources](../../../_includes/iam/resources-with-access-control/organization.md) %}

  **{{ compute-full-name }}**

  {% include notitle [compute-resources](../../../_includes/iam/resources-with-access-control/compute.md) %}

  **{{ container-registry-full-name }}**
  * [Registry](../../../container-registry/concepts/registry.md)
  * [Repository](../../../container-registry/concepts/repository.md)

  **{{ ml-platform-full-name }}**
  * [Project](../../../datasphere/security/index.md)
  * [Community](../../../datasphere/security/index.md)

  **{{ iam-full-name }}**
  * [Service account](../../../iam/operations/sa/assign-role-for-sa.md)

  **{{ kms-full-name }}**

  {% include notitle [kms-resources](../../../_includes/iam/resources-with-access-control/kms.md) %}

  **{{ lockbox-full-name }}**
  * [Secret](../../../lockbox/operations/secret-access.md)

  **{{ ydb-full-name }}**
  * [YDB DBMS](../../../ydb/concepts/index.md#ydb)
  * YDB DBMS backup

  **{{ resmgr-full-name }}**
  * [Cloud](../../../resource-manager/operations/cloud/set-access-bindings.md)
  * [Folder](../../../resource-manager/operations/folder/set-access-bindings.md)

  **{{ serverless-containers-full-name }}**
  * [Container](../../../serverless-containers/operations/role-add.md)

{% endlist %}