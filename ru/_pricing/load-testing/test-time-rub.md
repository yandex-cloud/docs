| Услуга                                | Цена за час, вкл. НДС |
| ------------------------------------- | --------------------- |
| Выполнение тестов, до 50 часов        | {{ sku|RUB|load_testing.test_execution.v1|string }} |
| Выполнение тестов, начиная с 50 часов | {% calc [currency=RUB] {{ sku|RUB|load_testing.test_execution.v1|pricingRate.180000|number }} × 3600 %} |