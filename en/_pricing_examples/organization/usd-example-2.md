> (130 - 15) × {% calc [currency=USD] {{ sku|USD|identity-hub.users.101-500|number }} %} = {% calc 130 - 15 %} × {% calc [currency=USD] {{ sku|USD|identity-hub.users.101-500|number }} %} = {% calc [currency=USD] (130 - 15) × {{ sku|USD|identity-hub.users.101-500|number }} %}
> Total: {% calc [currency=USD] (130 - 15) × {{ sku|USD|identity-hub.users.101-500|number }} %}.

Where:

* 130: Limit on the number of paid users.
* 15: Non-billable number of users.
* {% calc [currency=USD] {{ sku|USD|identity-hub.users.101-500|number }} %}: Cost per user per month for 101 to 500 users.


Immediately after the limit increase, there will be a debit of {% calc [currency=USD] (130 - 15) × {{ sku|USD|identity-hub.users.101-500|number }} %}.

At the beginning of each following month, there will be further debits of {% calc [currency=USD] (130 - 15) × {{ sku|USD|identity-hub.users.101-500|number }} %}.