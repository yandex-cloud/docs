
# YQL

**Interface**: [`https://yql.yandex-team.ru`](https://yql.yandex-team.ru)

**Prefix**: `/_yql` -> `https://yql.yandex.net`

**Table of contents**:
* [Tables](#sheets)
* [Operations](#operations)

## Limitations {#limits}

* No more than 1000 records and 100 KB of data per query (if you need more, create multiple queries or consider storing data in YT and retrieve them using [{{ CH }} over YT](../../tutorials/data-from-ch-over-yt.md)).
* All the queries are run on behalf of the current user who views the chart

## Tables {#sheets}

### Generating a data source {#sheets-forming-data-source}

To create a data source, the `buildTableSource` method from the `libs/yql/v1` module is used.
The `buildTableSource` method accepts one argument: an `object` with the following properties:

| Name | Type | Description | Required / By default |
|:---|:---|:---|:---
| cluster | `string` | Cluster name | Required |
| path | `string` | Path | Required |
| offset | `number` | Offset of the beginning | 0 |
| limit | `number` | Amounts of records to be loaded. If the limit isn't set, the service (YQL) sets the limit. | `null` |
| infer_scheme | `bool` | Infer the scheme from the first row of the table | `false` |
| cache | `number` | The response caching time (in seconds) | 0 |

If your table has no schema, set `infer_scheme = true`, and
then the schema will be inferred automatically from the first row of the table.

#### Example {#sheets-forming-data-source-example}

**Urls** tab
```js
// Include the data source module 
const YQL = require('libs/yql/v1');

// Build a data source 
const yqlTableSource = YQL.buildTableSource({
    cluster: 'hahn',
    path: 'home/charts/USNationalDebt',
    offset: 0,
    limit: 10,
    cache: 100000
});

// Export the data source
module.exports = {
    yqlTableSource: yqlTableSource
};
```

### The operations with data from source {#sheets-work-with-data-source}

The `prepareTableData` method from the `libs/yql/v1` module accepts as an argument the data received from the source and 
preprocesses the data.

### Examples {#sheets-work-with-data-source-examples}

[Chart based on the data from a YQL table](https://charts.yandex-team.ru/editor/Templates/simple-yql-table)

---

## Operations {#operations}

### Limitations {#operations-limits}

An executed YQL query is a read-only entity, that's why the data won't ever be updated.
If you want the data to be updated from time to time, you need to export the data somewhere (for example, to a YT table)
and specify the export as a source. 

### Generating a data source {#operations-forming-data-source}

To create a data source, the `buildOperationSource` method from the `libs/yql/v1` module is used.
The `buildOperationSource` method accepts one argument: an `object `with the following properties:

| Name | Type | Description | Required / By default |
|:---|:---|:---|:---
| operationId | `string` | Operation ID | Required |
| cache | `number` | The response caching time (in seconds) | 0 |

#### Example {#operations-forming-data-source-example}

**Urls** tab
```js
// Include the data source module
const YQL = require('libs/yql/v1');

// Build the data source
const yqlOperationSource = YQL.buildOperationSource({
    operationId: 'Wlc7fSK7Yg2vMq6rar_DrBOjQXg8RZch5sTu-9oU1ZU=',
    cache: 10000
});

// Export the data source
module.exports = {
    yqlOperationSource: yqlOperationSource
};
```

### The operations with data from source {#operations-work-with-data-source}

The `prepareOperationData` method from the `libs/yql/v1` module accepts as an argument the data received from the source and
preprocesses the  data.

## Examples {#examples}

[Chart based on the data from a YQL operation](https://charts.yandex-team.ru/editor/Templates/simple-yql-operation)
