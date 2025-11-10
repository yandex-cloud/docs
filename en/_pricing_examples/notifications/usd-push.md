> (1,500 + 700 - 1,000) / 1,000 × {% calc [currency=USD] 99 / 120 %} = 1,200 / 1,000 × {% calc [currency=USD] 99 / 120 %} = {% calc [currency=USD] (1500 + 700 - 1000) / 1000 × 99 / 120 %}
> 
> Total: {% calc [currency=USD] (1500 + 700 - 1000) / 1000 × 99 / 120 %} — cost of sending 2,200 push notifications per month.

Where:

* 1,500 — mobile push notifications.
* 700 — browser push notifications.
* 1,000 — events without billing.
* {% calc [currency=USD] 99 / 120 %} — cost of processing 1,000 {{ cns-short-name }} push notification events, from 1,000 to 500,000 notifications per month.