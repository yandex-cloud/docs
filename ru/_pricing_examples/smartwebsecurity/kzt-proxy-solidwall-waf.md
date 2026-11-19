* **Ресурсы прокси-сервера**: 6 ресурсных единиц × 720 часов × {{ sku|KZT|sws.proxy-server.v1|string }} за ресурсную единицу в час = {% calc [currency=KZT] 6 × 720 × {{ sku|KZT|sws.proxy-server.v1|number }} %}.
* **Легитимный трафик SolidWall WAF**: 300 RPS × 2 135 ₸ за один RPS в месяц = {% calc [currency=KZT] 300 × 2135 %}.
* **Дополнительное приложение SolidWall WAF**: 22 500 ₸ за месяц.
* **Обработка запросов правилами профиля безопасности**: 0,99 × {{ sku|KZT|sws.requests.v1|pricingRate.0.01|string }} + 9 × {{ sku|KZT|sws.requests.v1|pricingRate.1|string }} = {% calc [currency=KZT] 0.99 × {{ sku|KZT|sws.requests.v1|pricingRate.0.01|number }} + 9 × {{ sku|KZT|sws.requests.v1|pricingRate.1|number }} %}.

Итого за прокси-сервер, профиль безопасности и SolidWall WAF за полный месяц: **{% calc [currency=KZT] 6 × 720 × {{ sku|KZT|sws.proxy-server.v1|number }} + 300 × 2135 + 22500 + 0.99 × {{ sku|KZT|sws.requests.v1|pricingRate.0.01|number }} + 9 × {{ sku|KZT|sws.requests.v1|pricingRate.1|number }} %}**, с НДС.
