# Data source

## General information {#common}

The **Urls** tab describes the data sources.
The result of the tab execution is an object that describes the HTTP requests for uploading
 data.
To execute the requests, you can use the `GET` and `POST` methods:

**GET query**

```js
module.exports = {
    totals: '/api/some/get/request?scale=d&region=RU'
};
```

**POST query**

```js
module.exports = {
    totals: {
        url: '/api/some/post/request',
        method: 'post',
        data: {
            scale: 'd',
            region: 'RU'
        }
    }
};
```

To generate the URL, use our **URI** library
so that you don't have to escape special characters manually in the request parameters.

```js
const URI = require('libs/uri/v1');

const url = new URI(`/api/some/get/request`);

url.setParams({
    scale: 'd',
    field: ['users', 'hits', 'hosts']
});

url.setParam('region', 'RU');

module.exports = {
    totals: url.toString()
};
```

**Caching**

Our service also supports caching of the response from the sources.

To use caching in the **GET** request, specify the parameter `_sp_cache_duration=<TTL>` (TTL is the cache time-to-live, in seconds).
The cache key for **GET** requests is built from the URL.

For **POST** requests, specify, in the parameters, the property `cache: <TTL>` (TTL is the cache time-to-live, in seconds).
For **POST** requests, the cache key is built from the URL and the CRC32 hash of the request body.

Note that some sources don't support caching of responses.  See the list of sources below for the support details.

## List data sources {#list-data-sources}

Here's a list of popular sources available in our service.

| Name | Caching support | Comment |
|:---|:---|:---|
| [Datasets](dataset.md) | No | The cache runs on the Dataset API side |
| [Statistics](stat.md) | No ||
| [Metric](metrika.md) | Yes | The cache is running by default to avoid excessive load on the Yandex Metria API |
| [Mobile metric](appmetrika.md) | Yes | The cache is running by default to avoid excessive load on the Yandex Metria API |
| [ClickHouse](clickhouse.md) | Yes | The cache is available for all the CH clusters |
| [Graphite (Graphana)](graphite.md) | Yes | The cache is available for all the Graphite installations |
| [Metrics](metrics.md) | Yes ||
| [Solomon](solomon.md) | Yes ||
| [Razladki](razladki.md) | Yes ||
| [YQL](yql.md) | No ||
| [YT](yt.md) | Yes | The cache is available for all the YT clusters |
| QC API | Yes ||
| Browser | Yes ||
| Browser Infra | Yes ||
| Addappter Sales | Yes ||
| Stat Infra | Yes ||
| Infra API | Yes ||
| YDB | Yes ||
| YDB Meta | Yes ||
| YDB API | Yes ||
| [Golovan (YASM)](https://charts.yandex-team.ru/editor/templates/simple-yasm) | Yes |
| API Timeline Crypta | No ||
| TestPalm | No ||
| Serp Docs | No ||
| Error Booster | No ||
| StarTrek API | No ||
| MDS | No ||
| Market Analytics | No ||
| Telephony (mphomon) | No ||

Some sources aren't included in the list. For example, we haven't included ad-hoc sources and individual ClickHouse instances.

### Adding new sources {#add-sources}

If you want to use the source data that is missing from this list, create a [ticket in DLFR](https://st.yandex-team.ru/createTicket?queue=dlfr) by clicking a link with your API description.

There's no specific requirements for the API, usually it's enough that it returns JSON in response to GET/POST.

The data format is not our concern at this step: after connecting, you can either write a custom ChartEditor module to cast the data to the rendering format or revise the API to return the data immediately in the proper format.

## Limitations {#limits}

There are limits on the size and time of data loading:

* 100 MB on the total size from all sources per request.
* 50 MB on the size of data from one source.
* 300s on the total time of data upload from all sources per request.
* 95s on the time of loading data from a single data source.
* 10s to run a JavaScript tab.

These limits are set to ensure stable operation for the service and its sources.
