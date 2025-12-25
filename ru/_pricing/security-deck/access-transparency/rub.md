| Совокупное потребление ресурсов в организации<br>за предыдущий месяц | Стоимость подписки на месяц до 31.12.2025, вкл. НДС 20% | Стоимость подписки на месяц с 01.01.2026, вкл. НДС 22% |
| -------------------------------------------------------------------- | --------------------------------------------------------| ------------------------------------------------------ |
| Менее 1 000 000 ₽ | {{ sku|RUB|security_deck.access_transparency.subscription.v1|string }} | 71 167,00 ₽ |
| От 1 000 000 до 5 000 000 ₽ | {% calc [currency=RUB] {{ sku|RUB|security_deck.access_transparency.subscription.v1|number }} × (12/7) %} | 122 000,00 ₽ |
| От 5 000 000 до 10 000 000 ₽ | {% calc [currency=RUB] ({{ sku|RUB|security_deck.access_transparency.subscription.v1|number }} × (12/7)) × 1,5 %} | 183 000,00 ₽ |
| От 10 000 000 до 20 000 000 ₽ | {% calc [currency=RUB] ({{ sku|RUB|security_deck.access_transparency.subscription.v1|number }} × (12/7)) × 3 %} | 366 000,00 ₽ |
| Более 20 000 000 ₽ | {% calc [currency=RUB] ({{ sku|RUB|security_deck.access_transparency.subscription.v1|number }} × (12/7)) × 3,75 %} | 457 500,00 ₽ |