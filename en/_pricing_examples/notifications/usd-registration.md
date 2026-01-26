> {{ sku|USD|cns.notifications.sender_name_registration_event|string }} × 3 = {% calc [currency=USD] {{ sku|USD|cns.notifications.sender_name_registration_event|number }} × 3 %}
> 
> Total: {% calc [currency=USD] {{ sku|USD|cns.notifications.sender_name_registration_event|number }} × 3 %}

Where:

* {{ sku|USD|cns.notifications.sender_name_registration_event|string }}: Cost of registering a {{ cns-short-name }} sender name for 1 month.
* 3: Number of months.