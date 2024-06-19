| Услуга | Цена за 1 vCPU×час, <br>вкл. НДС |
| ---- | ---- |
| Время использования CPU, первые 5 vCPU×час в месяц | {{ sku|KZT|serverless.containers.compute.cpu|string }} |
| Время использования CPU, свыше 5 vCPU×час в месяц | {{ sku|KZT|serverless.containers.compute.cpu|pricingRate.5|string }} |