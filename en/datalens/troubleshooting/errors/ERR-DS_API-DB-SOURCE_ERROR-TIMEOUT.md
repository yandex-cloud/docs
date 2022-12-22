# Data source timed out

`ERR.DS_API.DB.SOURCE_ERROR.TIMEOUT`

Query execution time exceeded for the data source.

{% if audience == "internal" %}

To connect [CH over YT](../../tutorials/data-from-ch-over-yt.md#before-you-begin) with `*ch_datalens` public clique, query execution does not exceed 30 seconds. We recommend using a [private clique](https://yt.yandex-team.ru/docs/description/chyt/cliques/start) in the connection.

{% endif %}

