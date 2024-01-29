---
title: "How to view roles assigned to an account in {{ iam-full-name }}"
description: "Use this guide to view roles assigned to an account."
---

# Viewing assigned roles

To view the permissions granted to an account for a resource, retrieve the list of roles assigned for the resource and its parent resources. Assigned roles will be [inherited](../../concepts/access-control/index.md#inheritance) by child resources from their parent resources. For example, if you want to find out what permissions an account has for the folder, look at the roles:

1. For that folder.
1. For the cloud that the folder belongs to.
1. For the organization that the cloud belongs to.

You can view a list of inherited roles for the folder or the cloud in the management console, in the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** section of the corresponding folder or cloud.

{% list tabs group=instructions %}

- Management console {#console}

   In the management console, you can view roles only for the folder, cloud, or organization. To view roles for other resources, use the CLI or API.

   To view the roles of a [user with a Yandex account](../../concepts/index.md#passport), [federated user](../../concepts/index.md#saml-federation), or [service account](../../concepts/users/service-accounts.md):

   {% include [include](../../../_includes/iam/configure-roles-console.md) %}

   For the [service account](../../concepts/users/service-accounts.md), in the management console you can only view the roles for the folder where the service account was created (to view roles for other resources, use the CLI or API):

   1. In the [management console]({{ link-console-main }}), select the folder the service account belongs to.
   1. At the top of the screen, go to the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab.
   1. The service account's roles for the current folder are listed in the **{{ ui-key.yacloud.iam.folder.service-accounts.column_roles }}** column.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   1. Get your account ID:
      1. [Guide](../sa/get-id.md) for service accounts.
      1. [Guide](../users/get.md) for users with a Yandex account and federated users.
   1. Get the resource ID or name.
   1. {% include [include](../../../_includes/iam/list-access-bindings-via-cli.md) %}

      In the server response, find all the rows where the subject contains the account ID and the `allUsers` and `allAuthenticatedUsers` [system groups](../../concepts/access-control/system-group.md) as subjects.
   1. Repeat the previous two steps for all the parent resources.

- API {#api}

   1. Get your account ID:
      1. [Guide](../sa/get-id.md) for service accounts.
      1. [Guide](../users/get.md) for users with a Yandex account and federated users.
   1. Get the resource ID or name.
   1. {% include [include](../../../_includes/iam/list-access-bindings-via-api.md) %}

      In the server response, find all the rows where the subject contains the account ID and the `allUsers` and `allAuthenticatedUsers` [system groups](../../concepts/access-control/system-group.md) as subjects.
   1. Repeat the previous two steps for all the parent resources.

{% endlist %}

#### See also {#see-also}

* [{#T}](revoke.md)
* [{#T}](grant.md)