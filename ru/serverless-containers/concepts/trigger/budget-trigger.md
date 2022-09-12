# Триггер для бюджетов

Триггер для [бюджетов](../../../billing/concepts/budget.md) запускает [контейнер](../container.md) {{ serverless-containers-name }} при превышении пороговых значений.

## Роли, необходимые для корректной работы триггера для бюджетов {#roles}

* Для создания триггера вам необходимо разрешение на сервисный аккаунт, от имени которого триггер выполняет операцию. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles#sa-user), [editor](../../../iam/concepts/access-control/roles#editor) и выше.
* Для работы триггера сервисному аккаунту необходима роль:
    * `serverless.containers.invoker` на контейнер, который вызывает триггер.
    * `viewer` на облако, к которому привязан платежный аккаунт.

## Формат сообщения от триггера для бюджетов {#format}

После того, как триггер сработает, он отправит в контейнер следующее сообщение:

```
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

## См. также {#see-also_}

* [Триггер для бюджетов, который запускат функцию {{ sf-name }}](../../../functions/concepts/trigger/budget-trigger.md).