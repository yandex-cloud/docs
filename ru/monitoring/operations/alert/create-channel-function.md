---
title: Как создать канал уведомлений с вызовом функции в {{ monitoring-full-name }}
description: Следуя данной инструкции, вы сможете создать канал уведомлений с вызовом функции {{ sf-full-name }}.
---

# Создание канала уведомлений с вызовом функции

В качестве метода уведомления вы можете указать функцию {{ sf-name }}. Эта функция будет вызвана при срабатывании алерта или в эскалации как обычный канал уведомления.

Чтобы настроить уведомления с использованием {{ sf-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находятся ресурсы, наблюдаемые в {{ monitoring-name }}.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. [Создайте функцию](../../../functions/operations/function/function-create.md) и [версию функции](../../../functions/operations/function/version-manage.md).
  1. Включите в настройках функции [возможность асинхронного вызова](../../../functions/operations/function/function-invoke-async.md).
  1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) с ролями `{{ roles-functions-invoker }}` и `{{ roles-functions-viewer }}`, он потребуется для вызова функции.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.channel.button_new-channel }}**.
  1. Введите имя канала уведомлений.
  1. В списке **{{ ui-key.yacloud_monitoring.channel.field_method }}** выберите **{{ sf-name }}**.
  1. В списке **{{ ui-key.yacloud_monitoring.channel.field_service-account_title }}** выберите аккаунт для запуска функции.
  1. Нажмите **{{ ui-key.yacloud_monitoring.actions.common.create }}**.

{% endlist %}

## Формат сообщения при вызове функции {{ sf-name }} {#function-invoke-payload}

При вызове функции {{ sf-name }} в [точку входа функции](../../../functions/lang/python/handler.md) в аргумент `event` из алерта или эскалации будет передано сообщение в формате JSON с информацией о сработавшем алерте:

```json
{
    "alertId": "",
    "alertName": "",
    "folderId": "",
    "status": "",
    "annotations": {
        "key1": "value1",
        "key2": "value2"
    }
}
```

* `alertId` — идентификатор сработавшего алерта, текст;
* `alertName` — имя сработавшего алерта, текст;
* `folderId` — идентификатор каталога, в котором сработал алерт, текст;
* `status` — [статус алерта](../../concepts/alerting/alert.md#статусы-алертов-alert-statuses), текст;
* `annotations` — значения аннотаций сработавшего алерта, словарь значений `key:value`.

Пример вызова функции см. в разделе [{#T}](alert-call-function.md).