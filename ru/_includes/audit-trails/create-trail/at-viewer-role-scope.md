* `audit-trails.viewer` на один из ресурсов, который определяет [нужную область сбора](../../../audit-trails/concepts/trail.md#collecting-area) логов:

    * [Организация](../../../organization/operations/add-role.md) — чтобы собирать логи в выбранных облаках организации.
    * [Облако](../../../resource-manager/operations/cloud/set-access-bindings.md#access-to-sa) — чтобы собирать логи в выбранных каталогах облака.
    * [Каталог](../../../resource-manager/operations/folder/set-access-bindings.md#access-to-sa) — чтобы собирать логи в этом каталоге.

    Права доступа наследуются от родительского ресурса к дочерним. Например, если сервисному аккаунту [назначить роль на облако](../../../resource-manager/operations/cloud/set-access-bindings.md), то трейл, использующий этот аккаунт, сможет собирать логи ресурсов во всех каталогах этого облака. Однако трейл не сможет собирать логи в других облаках, принадлежащих организации, — для этого потребуется [назначить роль на организацию](../../../organization/operations/add-role.md).
