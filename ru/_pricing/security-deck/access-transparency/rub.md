Совокупное потребление ресурсов в организации<br>за предыдущий месяц | Стоимость подписки на месяц, вкл. НДС
----- | -----
| Менее 1 000 000 ₽ | {{ sku|RUB|access_transparency.subscription.v1|string }} |
| От 1 000 000 до 5 000 000 ₽ | {% calc [currency=RUB] {{ sku|RUB|access_transparency.subscription.v1|number }} × (12/7) %} |
| От 5 000 000 до 10 000 000 ₽ | {% calc [currency=RUB] ({{ sku|RUB|access_transparency.subscription.v1|number }} × (12/7)) × 1,5 %} |
| От 10 000 000 до 20 000 000 ₽ | {% calc [currency=RUB] ({{ sku|RUB|access_transparency.subscription.v1|number }} × (12/7)) × 3 %} |
| Более 20 000 000 ₽ | {% calc [currency=RUB] ({{ sku|RUB|access_transparency.subscription.v1|number }} × (12/7)) × 3,75 %} |