# Изменение настроек инстанса

После создания [инстанса {{ GL }}](../../concepts/index.md#instance) вы можете изменить имя и описание инстанса, настроить защиту от непреднамеренного удаления пользователем, а также изменить срок хранения автоматических резервных копий. Изменить другие настройки нельзя.

## Изменить настройки инстанса {#change-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В консоли управления выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [инстанс {{ GL }}](../../concepts/index.md#instance).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Выберите инстанс и нажмите кнопку ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** в верхней части страницы.
  1. В блоке **{{ ui-key.yacloud.compute.group.overview.section_base }}**:

      * Задайте новые имя и описание инстанса.
      * Установите или снимите защиту инстанса от непреднамеренного удаления пользователем.

  1. В блоке **{{ ui-key.yacloud.gitlab.label_configuration-section }}** измените срок хранения автоматических резервных копий (в днях).

  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

{% endlist %}
