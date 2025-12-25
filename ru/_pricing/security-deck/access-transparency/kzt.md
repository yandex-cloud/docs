| Совокупное потребление ресурсов в организации<br>за предыдущий месяц | Стоимость подписки на месяц до 31.12.2025, вкл. НДС 12% | Стоимость подписки на месяц с 01.01.2026, вкл. НДС 16% |
| -------------------------------------------------------------------- | ------------------------------------------------------- | ------------------------------------------------------ |
| Менее 5 000 000 ₸ | {{ sku|KZT|security_deck.access_transparency.subscription.v1|string }} | 362 500,00 ₸ |
| От 5 000 000 до 25 000 000 ₸ | {% calc [currency=KZT] {{ sku|KZT|security_deck.access_transparency.subscription.v1|number }} × (12/7) %} | 621 429,00 ₸ |
| От 25 000 000 до 50 000 000 ₸ | {% calc [currency=KZT] ({{ sku|KZT|security_deck.access_transparency.subscription.v1|number }} × (12/7)) × 1,5 %} | 932 143,00 ₸ |
| От 50 000 000 до 100 000 000 ₸ | {% calc [currency=KZT] ({{ sku|KZT|security_deck.access_transparency.subscription.v1|number }} × (12/7)) × 3 %} | 1 864 286,00 ₸  |
| Более 100 000 000 ₸ | {% calc [currency=KZT] ({{ sku|KZT|security_deck.access_transparency.subscription.v1|number }} × (12/7)) × 3,75 %} | 2 330 357,00 ₸ |