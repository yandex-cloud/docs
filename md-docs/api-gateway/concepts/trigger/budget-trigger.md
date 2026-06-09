# Триггер для бюджетов, который отправляет сообщения в WebSocket-соединения

[Триггер](index.md) для [бюджетов](../../../billing/concepts/budget.md) отправляет сообщения в [WebSocket-соединения](../extensions/websocket.md) при превышении пороговых значений.

Триггеру для бюджетов необходим [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) для отправки сообщений в WebSocket-соединения.

О том, как создать триггер для бюджетов, читайте в инструкции [Создать триггер для бюджетов, который отправляет сообщения в WebSocket-соединения](../../operations/trigger/budget-trigger-create.md).

## Роли, необходимые для корректной работы триггера для бюджетов {#roles}

* Для создания триггера вам необходимо разрешение на сервисный аккаунт, от имени которого триггер выполняет операцию. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user), [editor](../../../iam/concepts/access-control/roles.md#editor) и выше.
* Для работы триггера сервисному аккаунту необходима роль `api-gateway.websocketBroadcaster` на каталог, в котором находится API-шлюз.

## Формат сообщения от триггера для бюджетов {#format}

После того как триггер сработает, он отправит в WebSocket-соединения следующее сообщение:

```json
{
   "messages":[
      {
         "billing_account_id":"a6q6***",
         "budget_id":"a626***",
         "budget_display_name":"name",
         "amount":90012.00,
         "currency":"RUB",
         "period":"2021",
         "budgeted_amount":100000.00,
         "threshold_amount":90000.00,
         "threshold_type":"amount"
      }
   ]
}
```

Где:

* `billing_account_id` — идентификатор платежного аккаунта.
* `budget_id` — идентификатор бюджета.
* `budget_display_name` — имя бюджета.
* `amount` — стоимость ресурсов или баланс лицевого счета в момент, когда были отправлены уведомления.
* `currency` — валюта расчетов.
* `period` — период расчета бюджета.
* `budgeted_amount` — сумма бюджета.
* `threshold_amount` — порог потребления, при котором были отправлены уведомления.
* `threshold_type` — тип порога:
  * `amount` — валюта;
  * `percent` — проценты.

## См. также {#see-also}

* [Триггер для бюджетов, который вызывает контейнер Serverless Containers](../../../serverless-containers/concepts/trigger/budget-trigger.md)
* [Триггер для бюджетов, который вызывает функцию Cloud Functions](../../../functions/concepts/trigger/budget-trigger.md)