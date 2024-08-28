---
title: "Запись логов в журнал выполнения в {{ postbox-full-name }}"
description: "Следуя данной инструкции, вы сможете настроить логирование адреса."
---

# Запись логов в журнал выполнения в {{ postbox-name }}

{% include [logging-note](../../_includes/functions/logging-note.md) %}

Настроить запись логов можно во время или после [создания](create-address.md) адреса. Чтобы настроить логирование для уже созданного адреса:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится адрес.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
    1. Выберите адрес, для которого вы хотите настроить логирование.
    1. В блоке **{{ ui-key.yacloud.logging.label_title }}** нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.  
    1. В поле **{{ ui-key.yacloud.logging.label_destination }}** выберите:
        * `{{ ui-key.yacloud.common.unspecified }}` — чтобы выключить логирование.
        * `{{ ui-key.yacloud.common.folder }}` — чтобы записывать логи в [лог-группу](../../logging/concepts/log-group.md) по умолчанию для каталога, в котором находится адрес.
        * `{{ ui-key.yacloud.logging.label_loggroup }}` — чтобы записывать логи в пользовательскую лог-группу. В поле **{{ ui-key.yacloud.logging.label_loggroup }}** выберите лог-группу, в которую будут записываться логи. Если у вас нет лог-группы, [создайте ее](../../logging/operations/create-group.md).
    1. (Опционально) Чтобы записывать логи о переходе писем в различные статусы, включите опцию **{{ ui-key.yacloud.postbox.label_mail-statuses }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

    По умолчанию {{ postbox-name }} записывает логи только при верификации адреса. При включении опции **{{ ui-key.yacloud.postbox.label_mail-statuses }}** {{ postbox-name }} будет записывать логи о принятии письма в обработку, доставке письма почтовому клиенту, а также в случаях, когда письмо не доставлено получателю.

    Для поиска записей в лог-группе можно использовать [язык фильтрующих выражений](../../logging/concepts/filter.md). Например, чтобы найти все записи об отправке сообщений почтовому клиенту получателя с ошибкой, используйте выражение:

    ```
    message = "Message bounced" and json_payload.message.to: "example@yandex.ru"
    ```

{% endlist %}

## См. также {#see-also}

* [Создать конфигурацию](create-configuration.md)
