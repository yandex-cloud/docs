# Roles

{% note info %}

{% include [access-control-vs-roles-notice](../../../_includes/iam/access-control-vs-roles-notice.md) %}

{% endnote %}

A _role_ is a set of permissions to perform operations with resources in {{ yandex-cloud }}.

There are two types of roles:
* _Primitive roles_ contain permissions that apply to all types of {{ yandex-cloud }} resources. These are roles such as `{{ roles-admin }}`, `{{ roles-editor }}`, `{{ roles-viewer }}`, and `{{ roles-auditor }}`.
* _Service roles_ contain permissions only for a specific type of resource in a particular service. The service role ID is specified in `service.resources.role` format. For example, the `{{ roles-image-user }}` role allows you to use images in {{ compute-full-name }}.

  A service role can be assigned for the resource the role is intended for or the one from which the permissions are inherited. For example, you can assign the `{{ roles-image-user }}` role for a folder or cloud, because images inherit permissions from them.

Currently, users are not allowed to create new roles with a custom set of permissions.

Using [{{ sd-full-name }}](../../../security-deck/index.yaml) [{{ access-analyzer-name }}]({{ link-sd-main }}access-analyzer/), you can view the full list of roles assigned to a subject and get recommendations for optimizing the granted permissions. For more information, see [{#T}](../../../security-deck/concepts/access-analyzer.md).

## Role reference {#roles-reference}

{% note info "" %}

Starting February 14, 2024, you can find the extended list of roles for all {{ yandex-cloud }} services on this page: [{#T}](../../roles-reference.md).

{% endnote %}

## Use cases {#examples}

* [{#T}](../../tutorials/user-group-access-control.md)
* [{#T}](../../tutorials/sa-oslogin-ansible.md)