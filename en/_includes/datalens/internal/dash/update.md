## Edits {#update}

[Authentication](../../../../datalens/api/auth.md)

`POST` `https://api.dash.yandex.net/v1/dashboards/<id>`

* `data`: Dashboard layout.
* `mode`: Update mode, possible options:
   * `publish`: An updated dashboard version will be the latest one.
   * `save`: An updated version will be a draft. If the field is not passed, the `publish` value is applied by default.
      For more information, see [Versioning](../../../../datalens/concepts/dashboard.md).

### Example query{#example-request-update-dash}

```bash
curl -X POST "https://api.dash.yandex.net/v1/dashboards/ujnm9ovaaewur" \
  -H "Content-Type: application/json; charset=utf-8" \
  -H "Authorization: OAuth $CHARTS_OAUTH_TOKEN" \
  -d '{
    "data": {
      "tabs": [
        {
          "id": "WR",
          "items": [
            {
              "id": "Xb",
              "data": {
                "tabs": [
                  {
                    "id": "xq",
                    "title": "Sales dynamics by Region",
                    "params": {},
                    "chartId": "rj9ym88l5zd8q",
                    "isDefault": true
                  }
                ]
              },
              "type": "widget",
              "namespace": "default"
            },
            {
              "id": "A1",
              "data": {
                "tabs": [
                  {
                    "id": "v6",
                    "title": "Profit per Category and Segment",
                    "params": {},
                    "chartId": "mn6cabdn8y6kk",
                    "isDefault": true
                  }
                ]
              },
              "type": "widget",
              "namespace": "default"
            },
            {
              "id": "wz",
              "data": {
                "title": "Segment",
                "source": {
                  "datasetId": "aoetfany4sy88",
                  "showTitle": true,
                  "elementType": "select",
                  "datasetFieldId": "b9024e08-70ca-402e-9236-ec1e63a3e91b",
                  "multiselectable": true
                },
                "sourceType": "dataset"
              },
              "type": "control",
              "defaults": {
                "b9024e08-70ca-402e-9236-ec1e63a3e91b": null
              },
              "namespace": "default"
            },
            {
              "id": "Gv",
              "data": {
                "text": "Sample dashboard based on the Sample SuperStore data."
              },
              "type": "text",
              "namespace": "default"
            },
            {
              "id": "9Ag",
              "data": {
                "title": "Date",
                "source": {
                  "isRange": true,
                  "fieldName": "Date",
                  "showTitle": true,
                  "elementType": "date",
                  "defaultValue": "__interval_2014-01-01_2014-01-31",
                  "acceptableValues": {
                    "to": "2017-12-31",
                    "from": "2014-01-01"
                  }
                },
                "sourceType": "manual"
              },
              "type": "control",
              "defaults": {
                "Date": "__interval_2014-01-01_2014-01-31"
              },
              "namespace": "default"
            },
            {
              "id": "7r5",
              "data": {
                "size": "l",
                "text": "Sales",
                "showInTOC": true
              },
              "type": "title",
              "namespace": "default"
            },
            {
              "id": "wmz",
              "data": {
                "title": "Sample External Selector",
                "source": {
                  "chartId": "az26sxbs6uga7"
                },
                "sourceType": "external"
              },
              "type": "control",
              "defaults": {
                "Date": "",
                "Category": ""
              },
              "namespace": "default"
            }
          ],
          "title": "Sales",
          "layout": [
            {
              "h": 14,
              "i": "Xb",
              "w": 12,
              "x": 21,
              "y": 4
            },
            {
              "h": 14,
              "i": "A1",
              "w": 12,
              "x": 8,
              "y": 6
            },
            {
              "h": 2,
              "i": "wz",
              "w": 12,
              "x": 8,
              "y": 2
            },
            {
              "h": 3,
              "i": "Gv",
              "w": 7,
              "x": 0,
              "y": 2
            },
            {
              "h": 2,
              "i": "9Ag",
              "w": 12,
              "x": 21,
              "y": 2
            },
            {
              "h": 2,
              "i": "7r5",
              "w": 36,
              "x": 0,
              "y": 0
            },
            {
              "h": 2,
              "i": "wmz",
              "w": 12,
              "x": 8,
              "y": 4
            }
          ],
          "aliases": {
            "default": [
              [
                "Category",
                "b029ce50-4551-4267-9241-74c079c130d5"
              ],
              [
                "Date",
                "5fe5a345-37d4-45ff-bf19-e36ff8e3050a"
              ]
            ]
          },
          "connections": [
            {
              "to": "wz",
              "from": "xq",
              "kind": "ignore"
            },
            {
              "to": "xq",
              "from": "wz",
              "kind": "ignore"
            },
            {
              "to": "wmz",
              "from": "xq",
              "kind": "ignore"
            },
            {
              "to": "xq",
              "from": "wmz",
              "kind": "ignore"
            },
            {
              "to": "9Ag",
              "from": "v6",
              "kind": "ignore"
            },
            {
              "to": "v6",
              "from": "9Ag",
              "kind": "ignore"
            }
          ]
        }
      ]
    },
    "mode": "publish"
  }'
```

### Response example {#example-response-update-dash}

```json
{
  "entryId": "ujnm9ovaaewur",
  "key": "Dash API Test/My Test API Dash",
  "data": {
    "tabs": [
      ...
    ],
  },
  ...
}
```
