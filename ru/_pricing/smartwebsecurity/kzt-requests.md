| Количество запросов в месяц, млн | Цена за 1 млн запросов, вкл. НДС |
| --- | --- |
| Менее 0,01 (10 000 запросов) включительно | {{ sku|KZT|sws.requests.v1|string }} |
| От 0,01 до 1 включительно | {{ sku|KZT|sws.requests.v1|pricingRate.0.01|string }} |
| От 1 до 10 включительно | {{ sku|KZT|sws.requests.v1|pricingRate.1|string }} |
| От 10 до 100 включительно | {{ sku|KZT|sws.requests.v1|pricingRate.10|string }} |
| От 100 до 1000 включительно | {{ sku|KZT|sws.requests.v1|pricingRate.100|string }} |
| От 1000 до 10 000 включительно | {{ sku|KZT|sws.requests.v1|pricingRate.1000|string }} |
| Более 10 000 включительно | {{ sku|KZT|sws.requests.v1|pricingRate.10000|string }} |