---
title: Как создать канал уведомлений с вызовом функции в {{ monitoring-full-name }}
description: Следуя данной инструкции, вы сможете создать канал уведомлений с вызовом функции {{ sf-full-name }}.
---

# Создание канала уведомлений с вызовом функции


В качестве метода уведомления вы можете указать функцию {{ sf-name }}. Эта функция будет вызвана при срабатывании алерта или в эскалации как обычный канал уведомления.

Чтобы настроить уведомления с использованием {{ sf-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. [Перейдите]({{ link-console-main }}/link/functions) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. [Создайте функцию](../../../functions/operations/function/function-create.md) и [версию функции](../../../functions/operations/function/version-manage.md).
  1. Включите в настройках функции возможность [асинхронного вызова](../../../functions/operations/function/function-invoke-async.md).
  1. [Создайте](../../../iam/operations/sa/create.md) сервисный аккаунт с ролями `{{ roles-functions-invoker }}` и `{{ roles-functions-viewer }}`. Он потребуется для вызова функции.
  1. На главной странице [{{ monium-name }}]({{ link-monium }}) слева выберите ![shield-exclamation](../../../_assets/console-icons/shield-exclamation.svg) **Алерты и SLO** → ![bell](../../../_assets/console-icons/bell.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.notification-methods.title }}**.
  1. В правом верхнем углу нажмите **{{ ui-key.yacloud_monitoring.actions.common.create }}** и выберите **{{ ui-key.yacloud_monitoring.notification-methods.create-button.channel }}**.
  1. Введите имя канала уведомления.
  1. (Опционально) Укажите уровни критичности алертов, для которых канал будет работать по умолчанию.
  1. В поле **{{ ui-key.yacloud_monitoring.channel.field_method }}** выберите ![bell](../../../_assets/console-icons/code.svg) **{{ ui-key.yacloud_monitoring.channel.type_cloud-function }}**.
  1. В появившемся поле выберите каталог, в котором находится функция **{{ sf-name }}**.
  1. В поле **{{ ui-key.yacloud_monitoring.channel.field_service-account_title }}** выберите аккаунт для запуска функции.
  1. Нажмите **{{ ui-key.yacloud_monitoring.channel.button_save }}**.

{% endlist %}

## Формат сообщения при вызове функции {{ sf-name }} {#function-invoke-payload}

При вызове функции {{ sf-name }} в [точку входа](../../../functions/lang/python/handler.md) в аргумент `event` из алерта или эскалации будет передано сообщение в формате JSON с информацией о сработавшем алерте:

```json
{
    "alertId": "",
    "alertName": "",
    "labels": {
        "ключ1": "значение1",
        "ключ2": "значение2"
    },
    "folderId": "",
    "alertStatus": "",
    "annotations": {
        "ключ1": "значение1",
        "ключ2": "значение2"
    }
}
```

Где:

* `alertId` — идентификатор сработавшего алерта;
* `alertName` — имя сработавшего алерта;
* `labels` — список [меток](../../../monium/concepts/data-model.md#label) в формате `ключ: "значение"` для [мультиалертов](../../../monium/concepts/alerting/alert.md#multi-alerts).
* `folderId` — идентификатор каталога, должно быть пустым;
* `alertStatus` — [статус алерта](../../concepts/alerting/alert.md#alert-statuses);
* `annotations` — значения [аннотаций](../../concepts/alerting/annotation.md) сработавшего алерта, словарь значений `"ключ":"значение"`.

Пример вызова функции приведен в разделе [{#T}](alert-call-function.md).
