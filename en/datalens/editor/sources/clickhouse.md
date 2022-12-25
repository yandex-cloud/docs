# ClickHouse

{% note warning %}

New direct connections from Editor aren't created in {{ CH }}. Use standard [connections](connections.md) to access sources from Editor.

{% endnote %}

**Documentation**: [`{{ ch.docs }}`]({{ ch.docs }})

**Prefixes**:
* `/_clickhouse_mtmega` -> `http://mtmega.yandex.ru:8123`
* `/_clickhouse_mtstat` -> `http://mtstat.yandex.ru:8123`
* `/_clickhouse_mtsmart` -> `http://mtsmart.yandex.ru:8123`
* `/_clickhouse_april` -> `http://april-storage01i.yandex.ru:8123`
* `/_clickhouse_zen` -> `http://zclick-f1.kaizen.yandex.net:8123`

---

## Limitations {#limits}

* You have quotas for Charts on all the ClickHouse clusters.
   The quotas are quite high, but please keep in mind that *with great power comes great responsibility*.
* ClickHouse is a fast database, but make sure to control the time of your chart execution.
   Heavy queries may take minutes or even hours to execute, which is unacceptable for widgets.

---

## Generating a data source {#forming-data-source}

To build a data source, the `buildSource` method from the `libs/clickhouse/v1` module is used.
The `buildSource` method accepts one argument: an `object` with the following properties:

| Name | Type | Description | Required / By default |
|:---|:---|:---|:---|
| cluster | `string` | Cluster name | Required |
| query | `string` | Request | Required |
| cache | `number` | The response caching time (in seconds) | 0 |
| method | `string` | HTTP request method | `get` |

Better use a `post` request because the `query` may be too long and result in errors.

### Example {#forming-data-source-example}

**Urls** tab
```js
// Include the data source module
const ClickHouse = require('libs/clickhouse/v1');

// Build the query
const query = `
    SELECT *
    FROM charts.raif_rates
    WHERE currency IN ('USD')
    ORDER BY timestamp LIMIT 1000
`;

// Build the data source
const clickHouseSource = ClickHouse.buildSource({
    cluster: 'mtstat',
    query: query,
    cache: 360
});

// Export the data source
module.exports = {
    clickHouseSource: clickHouseSource
};
```

## Examples {#examples}

[Chart based on the data from ClickHouse](https://charts.yandex-team.ru/editor/Templates/simple-clickhouse)
