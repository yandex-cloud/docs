> (600 - 130) × {% calc [currency=USD] round({{ sku|USD|identity-hub.users.501-1000|number }} × 100) / 100 %} = {% calc 600 - 130 %} × {% calc [currency=USD] round({{ sku|USD|identity-hub.users.501-1000|number }} × 100) / 100 %} = {% calc [currency=USD] (600 - 130) × round({{ sku|USD|identity-hub.users.501-1000|number }} × 100) / 100 %}
> Total: {% calc [currency=USD] (600 - 130) × round({{ sku|USD|identity-hub.users.501-1000|number }} × 100) / 100 %}, a one-off payment.

> (600 - 15) × {% calc [currency=USD] round({{ sku|USD|identity-hub.users.501-1000|number }} × 100) / 100 %} = {% calc 600 - 15 %} × {% calc [currency=USD] round({{ sku|USD|identity-hub.users.501-1000|number }} × 100) / 100 %} = {% calc [currency=USD] (600 - 15) × round({{ sku|USD|identity-hub.users.501-1000|number }} × 100) / 100 %}
> Total: {% calc [currency=USD] (600 - 15) × round({{ sku|USD|identity-hub.users.501-1000|number }} × 100) / 100 %}, per month.

Where:

* 600: New limit on the number of paid users.
* 130: Old limit on the number of paid users.
* 15: Non-billable number of users.
* {% calc [currency=USD] round({{ sku|USD|identity-hub.users.501-1000|number }} × 100) / 100 %}: Cost per user per month for 501 to 1,000 users.

Immediately after the limit increase, there will be a debit of {% calc [currency=USD] (600 - 130) × round({{ sku|USD|identity-hub.users.501-1000|number }} × 100) / 100 %}.

At the beginning of each following month, there will be further debits of {% calc [currency=USD] (600 - 15) × round({{ sku|USD|identity-hub.users.501-1000|number }} × 100) / 100 %}.