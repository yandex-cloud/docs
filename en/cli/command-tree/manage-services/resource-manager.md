# yc resource-manager

Managing {{ resmgr-full-name }} resources.

#### Command usage

Syntax:

`yc resource-manager <group>`

Aliases:

- `yc resource <group>`.

#### Groups

- `yc resource-manager cloud`: Manage [clouds](../../../resource-manager/concepts/resources-hierarchy.md#cloud).
   - `get`: Get information about the specified cloud.
   - `list`: Get a list of clouds.
   - `list-access-bindings`: Get a list of access bindings for the specified cloud.
   - `add-access-binding`: [Assign a role to enable access to the specified cloud](../resource-manager/operations/cloud/set-access-bindings.md).
   - `set-access-bindings`: [Assign roles to enable access to the specified cloud](../../../resource-manager/operations/cloud/set-access-bindings.md#multiple-roles) and remove all the current roles (if any).
   - `remove-access-binding`: Remove a role that enables access to the specified cloud.
   - `list-operations`: Get a list of operations for the specified cloud.
- `yc resource-manager folder`: Manage [folders](../../../resource-manager/concepts/resources-hierarchy.md#folder).
   - `get`: Get information about the specified folder.
   - `list`: Get a list of folders.
   - `create`: [Create a folder](../../../resource-manager/operations/folder/create.md).
   - `update`: [Update the specified folder](../../../resource-manager/operations/folder/update.md).
   - `list-access-bindings`: Get a list of roles for the specified folder.
   - `add-access-binding`: [Assign a role to enable access to the specified folder](../../../resource-manager/operations/folder/set-access-bindings.md).
   - `set-access-bindings`: [Assign roles to enable access to the specified folder](../../../resource-manager/operations/folder/set-access-bindings.md#multiple-roles) and remove all the current roles (if any).
   - `remove-access-binding`: Remove a role that enables access to the specified folder.
   - `list-operations`: Get a list of operations for the specified folder.
