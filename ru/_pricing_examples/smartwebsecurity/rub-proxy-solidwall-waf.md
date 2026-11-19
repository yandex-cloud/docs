* **Ресурсы прокси-сервера**: 6 ресурсных единиц × 720 часов × {{ sku|RUB|sws.proxy-server.v1|string }} за ресурсную единицу в час = {% calc [currency=RUB] 6 × 720 × {{ sku|RUB|sws.proxy-server.v1|number }} %}.
* **Легитимный трафик SolidWall WAF**: 300 RPS × 427 ₽ за один RPS в месяц = {% calc [currency=RUB] 300 × 427 %}.
* **Дополнительное приложение SolidWall WAF**: 4 500 ₽ за месяц.
* **Обработка запросов правилами профиля безопасности**: 0,99 × {{ sku|RUB|sws.requests.v1|pricingRate.0.01|string }} + 9 × {{ sku|RUB|sws.requests.v1|pricingRate.1|string }} = {% calc [currency=RUB] 0.99 × {{ sku|RUB|sws.requests.v1|pricingRate.0.01|number }} + 9 × {{ sku|RUB|sws.requests.v1|pricingRate.1|number }} %}.

Итого за прокси-сервер, профиль безопасности и SolidWall WAF за полный месяц: **{% calc [currency=RUB] 6 × 720 × {{ sku|RUB|sws.proxy-server.v1|number }} + 300 × 427 + 4500 + 0.99 × {{ sku|RUB|sws.requests.v1|pricingRate.0.01|number }} + 9 × {{ sku|RUB|sws.requests.v1|pricingRate.1|number }} %}**, с НДС.
