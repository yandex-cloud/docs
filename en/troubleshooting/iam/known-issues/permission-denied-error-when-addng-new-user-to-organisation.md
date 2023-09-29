# Fixing errors when adding a new user to a cloud organization

## Issue description {#issue-description}

When you try to add a new user to an organization, you see this error message:

```
text message: Permission Denied; status: 403; description: Permission Denied;
```

Users are added on behalf of the current cloud owner or a billing account owner.

## Solution {#issue-resolution}

A user can be added to an organization by its administrator (the `organization-manager.admin` role) or owner (the `organization-manager.organizations.owner` role). Double-check that the account you use to add the user to your organization has one of those roles.
You can see a list of users in the organization on the [Yandex Cloud Organization](https://org.cloud.yandex.ru/users) page.

{% note info %}

The process of adding roles for accounts in an organization is described in [Granting access rights](../../../organization/security/index.md#admin).

{% endnote %}