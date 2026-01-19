# {{ wordstat-name }}

{{ wordstat-name }} — это инструмент для получения статистики поисковых запросов к Яндексу. С его помощью вы можете посмотреть, как менялась популярность интересующих вас запросов и как она отличается в разных регионах России, а также получить рейтинг наиболее популярных запросов с нужными словами и узнать, что еще люди искали на ту же тему. {{ wordstat-name }} работает только через API в синхронном режиме. Веб-версия инструмента доступна на сайте [Вордстат](https://wordstat.yandex.ru/).

{% include [preview-stage](../../_includes/preview-pp.md) %}

## {{ wordstat-name }} API {#api}

В {{ search-api-name }} доступны следующие вызовы gRPC и методы REST для получения статистики запросов.

| Описание метода | REST | gRPC |
|---|---|---|
| Наиболее популярные за последние 30 дней поисковые запросы, содержащие указанные слова и фразы. | [GetTop](../api-ref/Wordstat/getTop.md) | [GetTop](../api-ref/grpc/Wordstat/getTop.md) |
| Частота запросов с ключевым словом или фразой за указанный период, агрегированная по месяцам, неделям или дням. | [GetDynamics](../api-ref/Wordstat/getDynamics.md) | [GetDynamics](../api-ref/grpc/Wordstat/getDynamics.md) |
| Распределение количества запросов с ключевым словом или фразой по регионам за последние 30 дней. | [GetRegionsDistribution](../api-ref/Wordstat/getRegionsDistribution.md) | [GetRegionsDistribution](../api-ref/grpc/Wordstat/getRegionsDistribution.md) |
| Список кодов регионов, поддержанных в Wordstat. | [GetRegionsTree](../api-ref/Wordstat/getRegionsTree.md) | [GetRegionsTree](../api-ref/grpc/Wordstat/getRegionsTree.md) |

Для выполнения запросов необходима [роль](../security/index.md#search-api-webSearch-user) `search-api.webSearch.user`.

## Примеры использования {#examples}

* [{#T}](../operations/wordstat-gettop.md)
* [{#T}](../operations/wordstat-getdynamics.md)
* [{#T}](../operations/wordstat-getregionsdistribution.md)
* [{#T}](../operations/wordstat-getregiontree.md)
