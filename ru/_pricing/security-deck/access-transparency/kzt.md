Совокупное потребление ресурсов в организации<br>за предыдущий месяц | Стоимость подписки на месяц, вкл. НДС
----- | -----
| Менее 5 000 000 ₸ | {{ sku|KZT|security_deck.access_transparency.subscription.v1|string }} |
| От 5 000 000 до 25 000 000 ₸ | {% calc [currency=KZT] {{ sku|KZT|security_deck.access_transparency.subscription.v1|number }} × (12/7) %} |
| От 25 000 000 до 50 000 000 ₸ | {% calc [currency=KZT] ({{ sku|KZT|security_deck.access_transparency.subscription.v1|number }} × (12/7)) × 1,5 %} |
| От 50 000 000 до 100 000 000 ₸ | {% calc [currency=KZT] ({{ sku|KZT|security_deck.access_transparency.subscription.v1|number }} × (12/7)) × 3 %} |
| Более 100 000 000 ₸ | {% calc [currency=KZT] ({{ sku|KZT|security_deck.access_transparency.subscription.v1|number }} × (12/7)) × 3,75 %} |