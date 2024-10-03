# System groups


A _system group_ is a group of users (subjects) to which you can assign [roles](./roles.md). {{ yandex-cloud }} has two types of system groups: `All users in organization X` and `All users in federation N`. These groups allow you to grant access to your resources for a specific user group, but only for the operations that are allowed by the assigned role. System groups do not include [service accounts](../users/service-accounts.md).

System groups are dynamic: any new user added to an organization or federation automatically inherits all the permissions assigned to that organization or federation. When a user is removed from an organization or federation, those permissions are automatically revoked.

Granting roles with extensive permissions, such as `editor` or `admin`, to system groups poses a significant security risk.

### All users in organization X {#allOrganizationUsers}

`All users in organization X` includes all users in the `X` [organization](../../../organization/quickstart.md).

When assigning a role to `All users in organization X` via the [CLI](../../../cli/quickstart.md), [{{ TF }}]({{ tf-provider-link }}), and [API](../../../api-design-guide/concepts/general.md), use `group:organization:<organization_ID>:users` as the [subject](./index.md#subject) ID, where `<organization_ID>` is the unique ID assigned to the `X` [organization](../../../organization/quickstart.md).

### All users in federation N {#allFederationUsers}

`All users in federation N` includes all users in the `N` [identity federation](../../../organization/concepts/add-federation.md).

When assigning a role to `All users in federation N` via the [CLI](../../../cli/quickstart.md), [{{ TF }}]({{ tf-provider-link }}), and [API](../../../api-design-guide/concepts/general.md), use [group:federation:<federation_ID>:users](./index.md#subject) as the `subject` ID, where `<federation_ID>` is the unique ID assigned to the [N](../../../organization/concepts/add-federation.md) `identity federation`.