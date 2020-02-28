# Access management

This section lists the roles required for an account to perform operations with {{ objstorage-name }} resources. The following user categories can be granted access to {{ objstorage-name }}:

- Users with a registered account in Yandex.Passport.
- [Service accounts](../../iam/concepts/users/service-accounts.md) for {{ iam-full-name }}.

{% note info %}

Resource access rights are inherited from the cloud and folder.

{% endnote %}

## Assigning roles {#grant-roles}

To manage buckets and objects, the user must have the appropriate permissions in the cloud and folders where operations will be performed.

To assign the required roles to the user:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Permissions in {{ objstorage-short-name }} {#permissions}

{% include [cloud-roles](../../_includes/cloud-roles.md) %}

### admin {#admin}

Users with the `admin` role can:

  - Perform any operations with buckets and objects in the folder: create, delete, and edit them.
  - Assign roles to other users.

### editor {#editor}

Users with the `editor` role can perform any operations with buckets and objects in the folder: create, delete, and edit them.

### viewer {#viewer}

Users with the `viewer` role can view lists of buckets and objects in the folder.

