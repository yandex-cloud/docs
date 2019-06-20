# yc resource-manager

Управление ресурсами {{ resmgr-full-name }}.

#### Использование команды

Синтаксис:

`yc resource-manager <group>`

Алиасы:

- `yc resource <group>`.

#### Группы

- `yc resource-manager cloud` — управление [облаками](../../../resource-manager/concepts/resources-hierarchy.md#cloud).
    - `get` — получить информации об указанном облаке.
    - `list` — получить список облаков.
    - `list-access-bindings` — получить список привязок доступа для указанного облака.
    - `add-access-binding` — [назначить роль для доступа к указанному облаку](../../../resource-manager/operations/cloud/set-access-bindings.md).
    - `set-access-bindings` — [назначить роли для доступа к указанному облаку](../../../resource-manager/operations/cloud/set-access-bindings.md#multiple-roles) и удаление всех существующих ролей, если они были.
    - `remove-access-binding` — удалить роль для доступа к указанному облаку.
    - `list-operations` — получить список операций для указанного облака.
- `yc resource-manager folder` — управление [каталогами](../../../resource-manager/concepts/resources-hierarchy.md#folder).
    - `get` — получить информацию об указанном каталоге.
    - `list` — получить список каталогов.
    - `create` — [создать каталог](../../../resource-manager/operations/folder/create.md).
    - `update` — [изменить указанный каталог](../../../resource-manager/operations/folder/update.md).
    - `list-access-bindings` — получить список ролей для указанного каталога.
    - `add-access-binding` — [назначить роль для доступа к указанному каталогу](../../../resource-manager/operations/folder/set-access-bindings.md).
    - `set-access-bindings` — [назначить роли для доступа к указанному каталогу](../../../resource-manager/operations/folder/set-access-bindings.md#multiple-roles) и удаление всех существующих ролей, если они были.
    - `remove-access-binding` — удалить роль для доступа к указанному каталогу.
    - `list-operations` — получить список операций для указанного каталога.
