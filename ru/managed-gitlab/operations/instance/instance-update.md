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
      * Добавьте [метки](../../../resource-manager/concepts/labels.md) для разделения инстансов на логические группы.
      * Установите или снимите защиту инстанса от случайного удаления пользователем.

  1. В блоке **{{ ui-key.yacloud.gitlab.label_configuration-section }}**:

      * Измените срок хранения автоматических резервных копий (в днях).
      * Выберите подходящую [конфигурацию](../../concepts/approval-rules.md#packages) правил ревью кода.

          {% include [note-approval-rules-pricing](../../../_includes/managed-gitlab/note-approval-rules-pricing.md) %}

      * Укажите [токен {{ GL }}](../approval-rules.md#gitlab-token) для активации правил ревью кода..

  1. В блоке **{{ ui-key.yacloud.gitlab.label_additional-section }}** включите или отключите удаление образов без тегов. Настройка влияет на свободное место на диске инстанса.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

{% endlist %}
