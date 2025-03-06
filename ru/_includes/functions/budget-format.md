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