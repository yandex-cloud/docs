# {{ wordstat-name }}

{{ wordstat-name }} is a tool that gives you statistics on Yandex search queries. Use it to see how the popularity of particular queries has evolved over time and how it varies from region to region across Russia; rank the most popular queries with the keywords of interest and learn what else people were searching for on the same topic. {{ wordstat-name }} only works via API in synchronous mode. The web version of the tool is available on the [Wordstat website](https://wordstat.yandex.ru/).

{% include [preview-stage](../../_includes/preview-pp.md) %}

## {{ wordstat-name }} API {#api}

{{ search-api-name }} offers the following gRPC calls and REST methods for statistics on queries.

| Method description | REST | gRPC |
|---|---|---|
| The most popular search queries containing specified words and phrases over the last 30 days. | [GetTop](../api-ref/Wordstat/getTop.md) | [GetTop](../api-ref/grpc/Wordstat/getTop.md) |
| Monthly, weekly, or daily aggregated frequency of queries with a keyword or phrase within the specified period. | [GetDynamics](../api-ref/Wordstat/getDynamics.md) | [GetDynamics](../api-ref/grpc/Wordstat/getDynamics.md) |
| Distribution of the number of queries with a keyword or phrase by region over the last 30 days. | [GetRegionsDistribution](../api-ref/Wordstat/getRegionsDistribution.md) | [GetRegionsDistribution](../api-ref/grpc/Wordstat/getRegionsDistribution.md) |
| List of region codes supported by Wordstat. | [GetRegionsTree](../api-ref/Wordstat/getRegionsTree.md) | [GetRegionsTree](../api-ref/grpc/Wordstat/getRegionsTree.md) |

You need the `search-api.webSearch.user` [role](../security/index.md#search-api-webSearch-user) to run queries.

## Use cases {#examples}

* [{#T}](../operations/wordstat-gettop.md)
* [{#T}](../operations/wordstat-getdynamics.md)
* [{#T}](../operations/wordstat-getregionsdistribution.md)
* [{#T}](../operations/wordstat-getregiontree.md)
