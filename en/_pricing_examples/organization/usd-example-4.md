> (400 - 15) × {% calc [currency=USD] round({{ sku|USD|identity-hub.users.101-500|number }} × 100) / 100 %} = {% calc 400 - 15 %} × {% calc [currency=USD] round({{ sku|USD|identity-hub.users.101-500|number }} × 100) / 100 %} = {% calc [currency=USD] (400 - 15) × round({{ sku|USD|identity-hub.users.101-500|number }} × 100) / 100 %}
> Total: {% calc [currency=USD] (400 - 15) × round({{ sku|USD|identity-hub.users.101-500|number }} × 100) / 100 %}, per month.

Where:

* 400: New limit on the number of paid users.
* 15: Non-billable number of users.
* {% calc [currency=USD] round({{ sku|USD|identity-hub.users.101-500|number }} × 100) / 100 %}: Cost per user per month for 101 to 500 users.

The current month has already been paid for, so reducing the limit will not result in any charges.

At the beginning of each following month, there will be a debit of {% calc [currency=USD] (400 - 15) × round({{ sku|USD|identity-hub.users.101-500|number }} × 100) / 100 %}.