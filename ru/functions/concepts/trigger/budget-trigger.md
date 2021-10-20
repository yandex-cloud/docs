# Триггер для бюджетов

Триггер для [бюджетов](../../../billing/concepts/budget.md) запускает [функцию](../function.md) {{ sf-name }} или [контейнер](../../../serverless-containers/concepts/container.md) {{ serverless-containers-name }} при превышении пороговых значений.

## Роли, необходимые для корректной работы триггера для бюджетов {#roles}

* Для создания триггера вам необходимо разрешение на сервисный аккаунт, от имени которого триггер выполняет операцию. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles#sa-user), [editor](../../../iam/concepts/access-control/roles#editor) и выше.
* Для работы триггера сервисному аккаунту необходима роль:
    * `serverless.functions.invoker` на функцию, которую вызывает триггер;
    * `serverless.containers.invoker` на контейнер, который вызывает триггер.
    * `viewer` на облако, к которому привязан платежный аккаунт.

## Формат сообщения от триггера для бюджетов {#format}

После того, как триггер сработает, он отправит в функцию или контейнер следующее сообщение:

```
{
   "messages":[
      {
         "billing_account_id":"a6q6***",
         "budget_id":"a626***",
         "budget_display_name":"name",
         "amount":100000.00,
         "currency":"RUB",
         "period":"",
         "budgeted_amount":1,
         "threshold_amount":1,
         "threshold_type":""
      }
   ]
}
```