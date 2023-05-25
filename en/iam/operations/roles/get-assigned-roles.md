# Viewing assigned roles

To view the permissions granted to an account for a resource, retrieve the list of roles assigned for the resource and its parent resources. Assigned roles will be [inherited](../../concepts/access-control/index.md#inheritance) by child resources from their parent resources. For example, if you want to find out what permissions an account has for the folder, look at the roles:

1. For that folder.
1. For the cloud that the folder belongs to.
1. For the organization that the cloud belongs to.

You can view a list of inherited roles for the folder or the cloud in the management console, in the **Access bindings** section of the corresponding folder or cloud.

{% list tabs %}

- Management console

   In the management console, you can view roles only for the folder, cloud, or organization. To view roles for other resources, use the CLI or API.

   You can view a list of users if:

   * The **Available:** setting is set to **All users**.
   * The **Available:** setting is set to **Administrators** and you have the administrator role.

   To view the roles of a [user with a Yandex account](../../concepts/index.md#passport), [federated user](../../concepts/index.md#saml-federation), or [service account](../../concepts/users/service-accounts.md):

   {% include [include](../../../_includes/iam/configure-roles-console.md) %}

   For the [service account](../../concepts/users/service-accounts.md), in the management console you can only view the roles for the folder where the service account was created (to view roles for other resources, use the CLI or API):

   1. In the [management console]({{ link-console-main }}), select the folder the service account belongs to.
   1. At the top of the screen, go to the **Service accounts** tab.
   1. The service account's roles for the current folder are listed in the column **Roles in folder**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   1. Get your account ID:
      1. [Instructions](../sa/get-id.md) for service accounts.
      1. [Instructions](../users/get.md) for users with a Yandex account and federated users.
   1. Get the resource ID or name.
   1. {% include [include](../../../_includes/iam/list-access-bindings-via-cli.md) %}

      In the server response, find all the rows where the subject contains the account ID and the `allUsers` and `allAuthenticatedUsers` [system groups](../../concepts/access-control/system-group.md) as subjects.
   1. Repeat the previous two steps for all the parent resources.

- API

   1. Get your account ID:
      1. [Instructions](../sa/get-id.md) for service accounts.
      1. [Instructions](../users/get.md) for users with a Yandex account and federated users.
   1. Get the resource ID or name.
   1. {% include [include](../../../_includes/iam/list-access-bindings-via-api.md) %}

      In the server response, find all the rows where the subject contains the account ID and the `allUsers` and `allAuthenticatedUsers` [system groups](../../concepts/access-control/system-group.md) as subjects.
   1. Repeat the previous two steps for all the parent resources.

{% endlist %}

#### See also {#see-also}

* [{#T}](revoke.md)
* [{#T}](grant.md)