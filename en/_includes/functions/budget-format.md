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

Where:

* `billing_account_id`: Billing account ID.
* `budget_id`: Budget ID.
* `budget_display_name`: Budget name.
* `amount`: The cost of resources or account balance when notifications were triggered.
* `currency`: Payment currency.
* `period`: Budget tracking period.
* `budgeted_amount`: Budget amount.
* `threshold_amount`: Consumption threshold that triggered notifications.
* `threshold_type`: Threshold type:
   * `amount`: Currency.
   * `percent`: Percentage.