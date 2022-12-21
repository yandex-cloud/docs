## Reads {#read}

[Authentication](../../../../datalens/api/auth.md)


- `GET` `https://api.charts.yandex.net/v1/charts/<id>`
- `GET` `https://api.charts.yandex.net/v1/charts/entryByKey`

### Sample request by `id` {#example-request-id-read}

```bash
curl -X GET "https://api.charts.yandex.net/v1/charts/ogo5x8piotxul" \
  -H "Authorization: OAuth $CHARTS_OAUTH_TOKEN"
```

### Sample request by `key` {#example-request-key-read}

```bash
curl -X GET "https://api.charts.yandex.net/v1/charts/entryByKey?key=Users/apanchuk/brandNewChart" \
  -H "Authorization: OAuth $CHARTS_OAUTH_TOKEN"
```

### Response example {#example-response-read}

```json
{
  "entryId": "ogo5x8piotxul",
  "data": {
    "js": "const Dataset = require('libs/dataset/v1');\nconst moment = require('vendor/moment/v2.21');\nconst params = ChartEditor.getParams();\nconst loadedData = ChartEditor.getLoadedData();\nconsole.log(loadedData);\nconst preparedData = Dataset.processData(loadedData);\nconsole.log(preparedData);\nconst head = [    {        id: 'category',        name: 'Category',        type: 'stirng'    },    {        id: 'profit',        name: 'Profit',        type: 'number'    }];const rows = [];for (var i = 0; i < preparedData.length; i++) {    rows.push({        values: [            preparedData[i]['Category'],            preparedData[i]['Profit']        ]    });}\nmodule.exports = {head, rows};",
    "ui": "",
    "url": "const Dataset = require('libs/dataset/v1');\nconst moment = require('vendor/moment/v2.21');\nconst DATE_FORMAT = 'YYYY-MM-DD';\nconst params = ChartEditor.getParams();\nconst datasetSource = Dataset.buildSource({    id: 'y55xt5d3p9csw',    columns: ['Category', 'Profit'],    where: [{        column: 'Renamed date',        operation: 'GTE',        values: ['2017-01-01 00:00:00']    }]});\nmodule.exports = {    dataset: datasetSource};",
    "table": "module.exports = {    title: {        text: 'Table with random data',        style: {            'text-align': 'center',            'font-size': '16px',            'color': '#31C733'        }    },    sort: 'date',    order: 'asc'};",
    "params": "module.exports = {    count: 8};",
    "shared": ""
  },
  "key": "Users/apanchuk/brandNewChart",
  "meta": {},
  "scope": "widget",
  "type": "table_node",
  "public": false,
  "isFavorite": false,
  "createdAt": "2019-12-04T17:51:10.517Z",
  "createdBy": "apanchuk",
  "updatedAt": "2019-12-04T17:54:53.363Z",
  "updatedBy": "apanchuk"
}
```
