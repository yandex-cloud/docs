> {{ sku|KZT|cns.notifications.sender_name_registration_event|string }} × 3 = {% calc [currency=KZT] {{ sku|KZT|cns.notifications.sender_name_registration_event|number }} × 3 %}
> 
> Итого: {% calc [currency=KZT] {{ sku|KZT|cns.notifications.sender_name_registration_event|number }} × 3 %}

Где:

* {{ sku|KZT|cns.notifications.sender_name_registration_event|string }} — стоимость регистрации имени отправителя {{ cns-short-name }} на 1 месяц.
* 3 — количество месяцев.