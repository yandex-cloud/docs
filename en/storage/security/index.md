# Identity and access management

This section lists the roles required for an account to perform operations with [!KEYREF objstorage-name] resources. The following user categories can be granted access to [!KEYREF objstorage-name]:

- Users with a registered account in Yandex.Passport.
- [Service accounts](../../iam/concepts/users/service-accounts.md) [!KEYREF iam-full-name].

> [!NOTE]
>
> Resource access rights are inherited from the cloud and folder.

## Assigning roles

To manage buckets and objects, the user must have the appropriate permissions in the cloud and folders where operations will be performed.

To assign the required roles to the user:

[!INCLUDE [grant-role-console](../../_includes/grant-role-console.md)]

## Permissions in [!KEYREF objstorage-short-name]

[!INCLUDE [cloud-roles](../../_includes/cloud-roles.md)]

#### admin

Users with the `admin` role can:

  - Perform any operations with buckets and objects in the folder: create, delete, and edit them.
  - Assign roles to other users.

#### editor

Users with the `editor` role can perform any operations with buckets and objects in the folder: create, delete, and edit them.

#### viewer

Users with the `viewer` role can view lists of buckets and objects in the folder.

