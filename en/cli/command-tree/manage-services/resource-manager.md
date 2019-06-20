# yc resource-manager

Manage {{ resmgr-full-name }} resources.

#### Usage

Syntax:

`yc resource-manager <group>`

Aliases:

- `yc resource <group>`.

#### Groups

- `yc resource-manager cloud` — manage [clouds](../../../resource-manager/concepts/resources-hierarchy.md#cloud).
    - `get` — show information about the specified cloud.
    - `list` — list clouds.
    - `list-access-bindings` — list access bindings for the specified cloud.
    - `set-access-bindings` — [set access bindings for the specified cloud](../../../resource-manager/operations/cloud/set-access-bindings.md#multiple-roles) and delete all existing access bindings if there were any.
    - `add-access-binding` — [add access binding for the specified cloud](../../../resource-manager/operations/cloud/set-access-bindings.md).
    - `remove-access-binding` — remove access binding for the specified cloud.
    - `list-operations` — list operations for the specified cloud.
- `yc resource-manager folder` — manage [folders](../../../resource-manager/concepts/resources-hierarchy.md#folder).
    - `get` — show information about the specified folder.
    - `list` — list folders.
    - `create` — [create a folder](../../../resource-manager/operations/folder/create.md).
    - `update` — [update the specified folder](../../../resource-manager/operations/folder/update.md).
    - `list-access-bindings` — list access bindings for the specified folder.
    - `set-access-bindings` — [set access bindings for the specified folder](../../../resource-manager/operations/folder/set-access-bindings.md#multiple-roles) and delete all existing access bindings if there were any.
    - `add-access-binding` — [add access binding for the specified folder](../../../resource-manager/operations/folder/set-access-bindings.md).
    - `remove-access-binding` — remove access binding for the specified folder.
    - `list-operations` — list operations for the specified folder.
