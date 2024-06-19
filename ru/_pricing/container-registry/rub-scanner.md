Услуга | Цена за сканирование Docker-образа, вкл. НДС
--- | ---
Первичное сканирование Docker-образа на наличие уязвимостей, первые шесть сканирований в месяц | {{ sku|RUB|cr.vulnerabilityscanner.scan.v1|string }}
Первичное сканирование Docker-образа на наличие уязвимостей, свыше шести сканирований в месяц | {{ sku|RUB|cr.vulnerabilityscanner.scan.v1|pricingRate.6|string }}
Последующее сканирование Docker-образа на наличие уязвимостей, первые шесть сканирований в месяц | {{ sku|RUB|cr.vulnerabilityscanner.rescan.v1|string }}
Последующее сканирование Docker-образа на наличие уязвимостей, свыше шести сканирований в месяц | {{ sku|RUB|cr.vulnerabilityscanner.rescan.v1|pricingRate.6|string }}