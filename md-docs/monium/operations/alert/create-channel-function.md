[Документация Yandex Cloud](../../../index.md) > [Monium](../../index.md) > Алерты > Пошаговые инструкции > Создание канала уведомлений с вызовом функции

# Создание канала уведомлений с вызовом функции

В качестве метода уведомления вы можете указать функцию Cloud Functions. Эта функция будет вызвана при срабатывании алерта или в эскалации как обычный канал уведомления.

Чтобы настроить уведомления с использованием Cloud Functions:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. [Перейдите](https://console.yandex.cloud/link/functions) в сервис **Cloud Functions**.
  1. [Создайте функцию](../../../functions/operations/function/function-create.md) и [версию функции](../../../functions/operations/function/version-manage.md).
  1. Включите в настройках функции возможность [асинхронного вызова](../../../functions/operations/function/function-invoke-async.md).
  1. [Создайте](../../../iam/operations/sa/create.md) сервисный аккаунт с ролями `functions.functionInvoker` и `functions.viewer`. Он потребуется для вызова функции.
  1. На главной странице [Monium](https://monium.yandex.cloud) слева выберите ![shield-exclamation](../../../_assets/console-icons/shield-exclamation.svg) **Алерты и SLO** → ![bell](../../../_assets/console-icons/bell.svg) **Способы уведомления**.
  1. В правом верхнем углу нажмите **Создать** и выберите **Канал уведомления**.
  1. Введите имя канала уведомления.
  1. (Опционально) Укажите уровни критичности алертов, для которых канал будет работать по умолчанию.
  1. В поле **Метод** выберите ![bell](../../../_assets/console-icons/code.svg) **Cloud Function**.
  1. В появившемся поле выберите каталог, в котором находится функция **Cloud Functions**.
  1. В поле **Сервисный аккаунт** выберите аккаунт для запуска функции.
  1. Нажмите **Сохранить**.

{% endlist %}

## Формат сообщения при вызове функции Cloud Functions {#function-invoke-payload}

При вызове функции Cloud Functions в [точку входа](../../../functions/lang/python/handler.md) в аргумент `event` из алерта или эскалации будет передано сообщение в формате JSON с информацией о сработавшем алерте:

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
* `labels` — список [меток](../../concepts/data-model.md#label) в формате `ключ: "значение"` для [мультиалертов](../../concepts/alerting/alert.md#multi-alerts).
* `folderId` — идентификатор каталога, должно быть пустым;
* `alertStatus` — [статус алерта](../../concepts/alerting/alert.md#alert-statuses);
* `annotations` — значения [аннотаций](../../concepts/alerting/annotation.md) сработавшего алерта, словарь значений `"ключ":"значение"`.

Пример вызова функции приведен в разделе [Webhook с использованием Cloud Functions](alert-call-function.md).