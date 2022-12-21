# CHYT (ClickHouse over YT)

## How to work with CHYT from ChartEditor {#working-from-charteditor}

{% note alert %}

We recommend using a [created connection](../../operations/connection/chyt/create-chyt.md) {{ datalens-short-name }} instead of accessing CHYT in ChartEditor. For more information about connections, see [{#T}](connections.md).

{% endnote %}

You can use ChartEditor to work with data from public clusters.

The following clusters are available so far:
* Hahn
* Arnold
* Vanga

To build a data source, the `buildSource` method from the `libs/chyt/v1` module is used.
The `buildSource` method accepts one argument: an `object` with the following properties:
|Name|Type|Description|Required / Default
|:---|:---|:---|:---
|cluster|`string`|Cluster name|Required
|cliqueId|`string`|Clique ID or alias|Required
|token|`string`|OAuth token for authentication|Required
|query|`string`|Query|Required
|cache|`boolean`|Caching|`false`

#### Example {#working-from-charteditor-example}

**Urls** tab

```js
const {buildSource} = require('libs/chyt/v1');

// Query
const query = `
    SELECT 2+2
`;

module.exports = {
    example: buildSource({
        cluster: 'hahn', // Cluster
        cliqueId: '8d255cea-660d35d6-3fe03e8-5f426888', // ID or alias of any public clique
        // cliqueId: '*ch_datalens',
        token: ChartEditor.getSecrets()['token'], // yt token
        query
    })
};
```

