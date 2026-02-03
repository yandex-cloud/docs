> (130 - 15) × {% calc [currency=USD] round({{ sku|USD|identity-hub.users.101-500|number }} × 100) / 100 %} = {% calc 130 - 15 %} × {% calc [currency=USD] round({{ sku|USD|identity-hub.users.101-500|number }} × 100) / 100 %} = {% calc [currency=USD] (130 - 15) × round({{ sku|USD|identity-hub.users.101-500|number }} × 100) / 100 %}
> Total: {% calc [currency=USD] (130 - 15) × round({{ sku|USD|identity-hub.users.101-500|number }} × 100) / 100 %}.

Where:

* 130: Limit on the number of paid users.
* 15: Non-billable number of users.
* {% calc [currency=USD] round({{ sku|USD|identity-hub.users.101-500|number }} × 100) / 100 %}: Cost per user per month for 101 to 500 users.


Immediately after the limit increase, there will be a debit of {% calc [currency=USD] (130 - 15) × round({{ sku|USD|identity-hub.users.101-500|number }} × 100) / 100 %}.

At the beginning of each following month, there will be further debits of {% calc [currency=USD] (130 - 15) × round({{ sku|USD|identity-hub.users.101-500|number }} × 100) / 100 %}.