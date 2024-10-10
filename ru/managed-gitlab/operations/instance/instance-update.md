# Изменение настроек инстанса

После создания [инстанса {{ GL }}](../../concepts/index.md#instance) вы самостоятельно можете изменить общие и дополнительные настройки инстанса. Тип инстанса и размер диска можно изменить только через обращение в [техническую поддержку]({{ link-console-support }}). Изменить другие настройки нельзя.

## Изменить общие и дополнительные настройки инстанса {#change-settings}

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

      * Укажите [токен {{ GL }}](../approval-rules.md#gitlab-token) для активации правил ревью кода.

  1. В блоке **{{ ui-key.yacloud.gitlab.label_additional-section }}** включите или отключите удаление образов без тегов. Настройка влияет на свободное место на диске инстанса.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Изменить тип инстанса или размер диска {#change-type-instance}

Чтобы увеличить размер диска или изменить тип инстанса (например, увеличить с `s2.micro` до `s2.small`), обратитесь в [техническую поддержку]({{ link-console-support }}).

Уменьшить размер диска нельзя.
