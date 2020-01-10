# Viewing assigned roles

To view the permissions granted to an account for a resource, retrieve the list of roles assigned for the resource and its parent resources. Assigned roles are [inherited](../../concepts/access-control/index.md#inheritance) by child resources from their parent resources. For example, if you want to find the permissions an account has for a folder, look at the roles for that folder and the cloud that the folder belongs to.

To view permissions for all resources in a cloud, repeat this operation for every resource [you can assign a role for](../../concepts/access-control/resources-with-access-control.md). No single command is currently supported for retrieving the complete list of an account's roles in a cloud.

{% list tabs %}

- Management console

  To view the roles of a [user with a Yandex account](../../concepts/index.md#passport) or [federated user](../../concepts/index.md#saml-federation):
  1. {% include [include](../../../_includes/iam/grant-role-console-first-steps.md) %}
  1. {% include [include](../../../_includes/iam/configure-roles-console.md) %}

  For a [service account](../../concepts/users/service-accounts.md), in the management console you can only view the roles for the folder where the service account was created (to view roles for other resources, use the CLI or API):
  1. Go to the folder that the service account belongs to.
  1. Go to the **Service accounts** tab.
  1. The service account's roles for the current folder are listed in the column **Roles in folder**.

- CLI

  1. Get your account ID:
      1. [Instructions](../sa/get-id.md) for service accounts.
      1. [Instructions](../users/get.md) for users with a Yandex account and federated users.

  1. Get the resource ID or name.

  1. {% include [include](../../../_includes/iam/list-access-bindings-via-cli.md) %}

      In the server response, find all the rows where the subject contains the account ID and [system groups](../../concepts/access-control/system-group.md) `allUsers` and `allAuthenticatedUsers`.

  1. Repeat the previous two steps for all the parent resources.

- API

  1. Get your account ID:
      1. [Instructions](../sa/get-id.md) for service accounts.
      1. [Instructions](../users/get.md) for users with a Yandex account and federated users.

  1. Get the resource ID or name.

  1. {% include [include](../../../_includes/iam/list-access-bindings-via-api.md) %}

      In the server response, find all the rows where the subject contains the account ID and [system groups](../../concepts/access-control/system-group.md) `allUsers` and `allAuthenticatedUsers`.

  1. Repeat the previous two steps for all the parent resources.

{% endlist %}

#### See also {#see-also}

* [{#T}](revoke.md)
* [{#T}](grant.md)

