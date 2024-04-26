---
title: "Managing service access"
description: "In this tutorial you will learn how to manage the access of services to other services' resources in {{ yandex-cloud }}."
---

# Service control



{% include notitle [preview](../../_includes/note-preview.md) %}


Some {{ yandex-cloud }} services require access to other services' resources in the user's cloud. For example, {{ connection-manager-full-name }} requires permissions to create {{ lockbox-full-name }} secrets in the user's cloud to manage database connections, as well as permissions to manage the secrets thus created.

In {{ iam-full-name }}, you can manage service access to resources in the cloud.

## What is service control? {#using-service-control}

_Service control_ is the whole of the access permissions needed to create and operate the service's resources in the user's cloud. Each {{ yandex-cloud }} service access features a set of permissions of its own.

A cloud administrator can grant, revoke, suspend, and [restore](../operations/service-control/pause-resume.md#resume) a particular service's access to resources in the cloud. For example, you can [grant](../operations/service-control/enable-disable.md#enable) access only to services used in your cloud, and [revoke](../operations/service-control/enable-disable.md#disable) access from unused services.

A service has permissions to resources only in those clouds in which this service was granted access. In clouds where a service's access is revoked or suspended, this service has no permissions for resources.

If a service access vital to the service's operation is revoked or suspended in a given cloud, an attempt to create a resource in this service will be denied. To avoid this, grant access to resources in the cloud to the service.

If a service has resources that use access to other services in the cloud, you cannot revoke access to the cloud from that service. In which case you can [suspend](../operations/service-control/pause-resume.md#pause) service access, but this may cause the resources to malfunction. To revoke a service's access to the cloud, delete from it all the resources using access to resources of other services.

## What services can I manage in terms of access? {#service-list}

Currently you can manage the following services in terms of access:

* [{{ connection-manager-full-name }}](../../metadata-hub/concepts/connection-manager.md)
* [{{ mpg-full-name }}](../../managed-postgresql/)

In the future, cloud administrators will be able to manage access of all the services that require permissions to resources of other {{ yandex-cloud }} services. With [YC CLI](../../cli/), you can [get](../operations/service-control/list-get.md#list) an up-to-date list of services you can manage in terms of access.

{% include [service-control-access](../../_includes/iam/service-control-access.md) %}