---
title: How to view roles assigned to an account in {{ iam-full-name }}
description: Use this guide to view roles assigned to an account.
---

# Viewing assigned roles

To view permissions granted to an account for a resource, get a list of roles assigned for the resource and its parent resources. Roles assigned to a parent resource are [inherited](../../concepts/access-control/index.md#inheritance) by its child resources. For example, if you want to find out what permissions an account has for a folder, check the roles assigned:

1. For that folder.
1. For the cloud that the folder belongs to.
1. For the organization that the cloud belongs to.

You can view a list of inherited roles for a folder or cloud in the management console, in the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** section of the folder or cloud.

[Learn](../../concepts/access-control/resources-with-access-control.md) which resources you can assign a role for.

{% note info %}

{% include [access-control-vs-roles-notice](../../../_includes/iam/access-control-vs-roles-notice.md) %}

{% endnote %}

To view assigned roles:

{% list tabs group=instructions %}

- Management console {#console}

  To view the roles of a [Yandex account user](../../concepts/users/accounts.md#passport), [federated user](../../concepts/users/accounts.md#saml-federation), [local user](../../concepts/users/accounts.md#local), or [service account](../../concepts/users/service-accounts.md) for a cloud:

    {% include [include](../../../_includes/iam/configure-roles-console.md) %}

  To view roles of a [service account](../../concepts/users/service-accounts.md) for a folder and its child resources:

  1. In the [management console]({{ link-console-main }}), click ![image](../../../_assets/console-icons/layout-side-content-left.svg) or ![image](../../../_assets/console-icons/chevron-down.svg) in the top panel and select the folder the service account belongs to.
  1. [Navigate]({{ link-console-main }}/link/iam) to **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. In the left-hand panel, select ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
  1. The service account roles are listed in the **{{ ui-key.yacloud.iam.folder.service-accounts.column_roles }}** field.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Get the account ID:
      1. [Guide](../sa/get-id.md) for service accounts.
      1. [Guide](../../../organization/operations/users-get.md) for Yandex account users, federated users, and local users.
  1. Get the resource ID or name.
  1. {% include [include](../../../_includes/iam/list-access-bindings-via-cli.md) %}

        In the server response, find all rows where the subject contains the account ID, and the `All users` and `All authenticated users` [public groups](../../concepts/access-control/public-group.md) are specified as the subject.
    1. Repeat the previous two steps for all parent resources.

- API {#api}

    1. Get the account ID:
        1. [Guide](../sa/get-id.md) for service accounts.
        1. [Guide](../../../organization/operations/users-get.md) for Yandex account users, federated users, and local users.
    1. Get the resource ID or name.
    1. {% include [include](../../../_includes/iam/list-access-bindings-via-api.md) %}

        In the server response, find all rows where the subject contains the account ID, and the `All users` and `All authenticated users` [public groups](../../concepts/access-control/public-group.md) are specified as the subject.
    1. Repeat the previous two steps for all parent resources.

{% endlist %}

#### Useful links {#see-also}

* [{#T}](revoke.md)
* [{#T}](grant.md)