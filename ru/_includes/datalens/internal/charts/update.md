## Редактирование {#update}

[Аутентификация](../../../../datalens/api/auth.md) • [Идентификация](../../../../datalens/api/identification.md)

`POST` `https://api.charts.yandex.net/v1/charts/<id>`

### Формат тела запроса {#example-body-request-update}
```
{
    data: <Object — данные чарта>
    mode: <String{"save", "publish"} — режим обновления>
    type¹: <String — тип чарта в ChartKit (например, "graph_wizard_node")>
    template¹: <String — тип шаблона для генерации генерируемого чарта (например, "datalens")>
}
```

¹ — необходимо указать только одно из двух, либо ничего, тогда останется старый type

### Формат ответа {#example-response-1-update}
```
{
    data: <Object — данные чарта>
    entryId: <String — id сущности в US>
    key: <String — ключ сущности в US>
    owner: <String — логин автора>
    type: <String — тип чарта в ChartKit (например, "graph_wizard_node")>
}
```

### Пример запроса {#example-request-1-update}

```bash
curl --request POST \
  --url https://api.charts.yandex.net/v1/charts/ogo5x8piotxul \
  --header "authorization: OAuth $CHARTS_OAUTH_TOKEN" \
  --header "content-type: application/json;charset=UTF-8" \
  --data '{
    "data": {
        "js": "const Dataset = require('\''libs/dataset/v1'\'');\nconst moment = require('\''vendor/moment/v2.21'\'');\nconst params = ChartEditor.getParams();\nconst loadedData = ChartEditor.getLoadedData();\nconsole.log(loadedData);\nconst preparedData = Dataset.processData(loadedData);\nconsole.log(preparedData);\nconst head = [    {        id: '\''category'\'',        name: '\''Category'\'',        type: '\''stirng'\''    },    {        id: '\''profit'\'',        name: '\''Profit'\'',        type: '\''number'\''    }];const rows = [];for (var i = 0; i < preparedData.length; i++) {    rows.push({        values: [            preparedData[i]['\''Category'\''],            preparedData[i]['\''Profit'\'']        ]    });}\nmodule.exports = {head, rows};",
        "ui": "",
        "url": "const Dataset = require('\''libs/dataset/v1'\'');\nconst moment = require('\''vendor/moment/v2.21'\'');\nconst DATE_FORMAT = '\''YYYY-MM-DD'\'';\nconst params = ChartEditor.getParams();\nconst datasetSource = Dataset.buildSource({    id: '\''y55xt5d3p9csw'\'',    columns: ['\''Category'\'', '\''Profit'\''],    where: [{        column: '\''Renamed date'\'',        operation: '\''GTE'\'',        values: ['\''2017-01-01 00:00:00'\'']    }]});\nmodule.exports = {    dataset: datasetSource};",
        "table": "module.exports = {    title: {        text: '\''Таблица со случайными данными'\'',        style: {            '\''text-align'\'': '\''center'\'',            '\''font-size'\'': '\''16px'\'',            '\''color'\'': '\''#31C733'\''        }    },    sort: '\''date'\'',    order: '\''asc'\''};",
        "params": "module.exports = {    count: 108};",
        "shared": ""
    },
    "key": "Users/apanchuk/brandNewChart",
    "type": "table_node",
    "mode": "publish"
}'
```

### Пример ответа {#example-response-2-update}

```json
{
  "entryId": "ogo5x8piotxul",
  "data": {
    "js": "const Dataset = require('libs/dataset/v1');\nconst moment = require('vendor/moment/v2.21');\nconst params = ChartEditor.getParams();\nconst loadedData = ChartEditor.getLoadedData();\nconsole.log(loadedData);\nconst preparedData = Dataset.processData(loadedData);\nconsole.log(preparedData);\nconst head = [    {        id: 'category',        name: 'Category',        type: 'stirng'    },    {        id: 'profit',        name: 'Profit',        type: 'number'    }];const rows = [];for (var i = 0; i < preparedData.length; i++) {    rows.push({        values: [            preparedData[i]['Category'],            preparedData[i]['Profit']        ]    });}\nmodule.exports = {head, rows};",
    "ui": "",
    "url": "const Dataset = require('libs/dataset/v1');\nconst moment = require('vendor/moment/v2.21');\nconst DATE_FORMAT = 'YYYY-MM-DD';\nconst params = ChartEditor.getParams();\nconst datasetSource = Dataset.buildSource({    id: 'y55xt5d3p9csw',    columns: ['Category', 'Profit'],    where: [{        column: 'Renamed date',        operation: 'GTE',        values: ['2017-01-01 00:00:00']    }]});\nmodule.exports = {    dataset: datasetSource};",
    "table": "module.exports = {    title: {        text: 'Таблица со случайными данными',        style: {            'text-align': 'center',            'font-size': '16px',            'color': '#31C733'        }    },    sort: 'date',    order: 'asc'};",
    "params": "module.exports = {    count: 108};",
    "shared": ""
  },
  "key": "Users/apanchuk/brandNewChart",
  "meta": {},
  "scope": "widget",
  "type": "table_node",
  "public": false,
  "createdAt": "2019-12-04T17:51:10.517Z",
  "createdBy": "apanchuk",
  "updatedAt": "2019-12-04T17:51:11.112Z",
  "updatedBy": "apanchuk"
}
```
