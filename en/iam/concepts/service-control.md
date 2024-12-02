---
title: Managing service access to user cloud resources
description: In this tutorial, you will learn how to manage the access of services to user resources in {{ yandex-cloud }}.
---

# Service access to user resources



{% include notitle [preview](../../_includes/note-preview.md) %}


{{ yandex-cloud }} comprises multiple [services](../../overview/concepts/services.md). Some of these services may need access to various resources in a user [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) to perform certain tasks. For example, to manage DB connections, {{ connection-manager-full-name }} requires permissions to create and manage {{ lockbox-full-name }} secrets in a user cloud.

{{ iam-full-name }} allows you to manage service access to resources in a user cloud by [enabling](../operations/service-control/enable-disable.md#enable) or [disabling](../operations/service-control/enable-disable.md#disable) the relevant services.

_Service control_ is the whole of the access permissions needed to create and operate the service's resources in the user's cloud. Such access permissions are assigned to special service accounts, [service agents](#service-agent), which the service uses to access user resources in a cloud.

## Service status {#access-status}

{{ yandex-cloud }} services may have one of the following statuses:

* `DEFAULT`: Default status.

    The service has no [service agents](#service-agent). However, if you try to run an operation that requires access to other resources in a user cloud (e.g., create a [connection](../../metadata-hub/concepts/connection-manager.md) in {{ connection-manager-full-name }}), the service agents will be automatically created and the service status will change to `ENABLED`.

* `ENABLED`: Service enabled. Its service agents have been created, and the service has access to resources in a user cloud.

    When the status of a service in a cloud changes to `ENABLED`, its service agents are created automatically. Such service agents have the required permissions to manage user resources in that cloud.

* `DISABLED`: Service disabled. It has no service agents and no access to resources in a user cloud.

    When a service in a cloud changes its status to `DISABLED`, its service agents are automatically deleted.

## Service agents {#service-agent}

_Service agents_ are dedicated system service accounts which belong to specific services in a user cloud and provide such services with access to resources in that cloud. The number of service agents and the exact access permissions granted to them depend on the service they belong to.

{% note info %}

Currently, you cannot view or change the roles granted to service agents by default. You will be able to do this going forward.

{% endnote %}

Service agents are created in a dedicated system folder in a user cloud. That folder is managed by the system, and no user can access it even if they have the administrator or cloud owner role.

A service agent has permissions to manage resources only in the cloud where it was created.

The user cannot directly create, delete, or assign roles to service agents. All the required service agents with the appropriate access permissions are automatically created when you [enable a service](../operations/service-control/enable-disable.md#enable) and get deleted when you [disable](../operations/service-control/enable-disable.md#disable) it. When a service is re-enabled, it gets new service agents with new IDs.


If a service has resources with access to the other resources in the user cloud, you cannot disable this service. To disable such a service, first delete all the service resources that have access to the other resources in this user cloud.

If you disable a service in a user cloud, this service will still be running, but its resources will not be able to access the other resources in that cloud.

## What services can I manage in terms of access? {#service-list}

Currently you can manage the following services in terms of access:

Service | ID
--- | ---
{{ compute-full-name }}: [Disk encryption](../../compute/concepts/encryption.md) | `disk-encryption`
[{{ ml-platform-full-name }}](../../datasphere/index.yaml) | `datasphere`
{{ metadata-hub-full-name }}: [{{ connection-manager-name }}](../../metadata-hub/concepts/connection-manager.md) | `connection-manager`
{{ sd-full-name }}: [Data Security Posture Management (DSPM)](../../security-deck/concepts/dspm.md) | `dspm`
[{{ websql-full-name }}](../../websql/index.yaml) | `websql`

Moving forward, cloud administrators will be able to manage access of all the services that require permissions for actions with resources in {{ yandex-cloud }}. With [CLI](../../cli/cli-ref/iam/cli-ref/service-control/list.md), you can [get](../operations/service-control/list-get.md#list) an up-to-date list of services whose access you can manage.

{% include [service-control-access](../../_includes/iam/service-control-access.md) %}

#### See also {#see-also}

* [{#T}](../operations/service-control/list-get.md)
* [{#T}](../operations/service-control/enable-disable.md)
