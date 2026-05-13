# Создание канала уведомлений с вызовом функции

В качестве метода уведомления вы можете указать функцию Cloud Functions. Эта функция будет вызвана при срабатывании алерта или в эскалации как обычный канал уведомления.

Чтобы настроить уведомления с использованием Cloud Functions:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находятся ресурсы, наблюдаемые в Monium Metrics.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Cloud Functions**.
  1. [Создайте функцию](../../../functions/operations/function/function-create.md) и [версию функции](../../../functions/operations/function/version-manage.md).
  1. Включите в настройках функции [возможность асинхронного вызова](../../../functions/operations/function/function-invoke-async.md).
  1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) с ролями `functions.functionInvoker` и `functions.viewer`, он потребуется для вызова функции.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в **Monium** и слева выберите раздел **Способы уведомления**.
  1. Вверху справа нажмите **Создать** → **Канал уведомления**.
  1. Введите имя канала уведомлений.
  1. В списке **Метод** выберите **Cloud Functions**.
  1. В списке **Сервисный аккаунт** выберите аккаунт для запуска функции.
  1. Нажмите **Создать**.

{% endlist %}

## Формат сообщения при вызове функции Cloud Functions {#function-invoke-payload}

При вызове функции Cloud Functions в [точку входа функции](../../../functions/lang/python/handler.md) в аргумент `event` из алерта или эскалации будет передано сообщение в формате JSON с информацией о сработавшем алерте:

```json
{
    "alertId": "",
    "alertName": "",
    "folderId": "",
    "alertStatus": "",
    "annotations": {
        "key1": "value1",
        "key2": "value2"
    }
}
```

* `alertId` — идентификатор сработавшего алерта, текст;
* `alertName` — имя сработавшего алерта, текст;
* `folderId` — идентификатор каталога, в котором сработал алерт, текст;
* `alertStatus` — [статус алерта](../../concepts/alerting/alert.md#alert-statuses), текст;
* `annotations` — значения аннотаций сработавшего алерта, словарь значений `key:value`.

Пример вызова функции см. в разделе [Webhook с использованием Cloud Functions](alert-call-function.md).