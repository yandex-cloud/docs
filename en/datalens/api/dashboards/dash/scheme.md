# Dashboard layout

* Make sure that all `ID` (of tabs, items, chart tabs (`widget` item)) within the layout are unique.
* Note: Each item (`items`) must have a respective record in the layout (`layout`).
* At present, the `namespace` of all `items` must be set to `default` and `alises` can include the only value: `default`.
* `Connections` can only use two selectors (items of the `control` type) or a selector and chart tab (item of the `widget` type)

```json
{
  // Dashboard description
  "description": "Dashboard description",

  // Text displayed if object access permissions are missing
  "accessDescription": "Message when access restricted",

  // Text displayed when contacting support
  "supportDescription": "Message on contact support",

  // Tabs
  // Required
  "tabs": [
    {
      // Required
      "id": "WR",

      // Header
      // Required
      "title": "Sales",

      // Items
      // Required
      "items": [
        {
          // Required
          "id": "7r5",

          // Item type
          // Required
          "type": "title",

          // Required
          "namespace": "default",

          // Data of a title item
          // Required
          "data": {
            // Size: xs, s, m, l
            // Required
            "size": "l",

            // Text
            // Required
            "text": "Sales",

            // Show in TOC
            "showInTOC": true
          }
        },
        {
          // Required
          "id": "Gv",

          // Item type
          // Required
          "type": "text",

          // Required
          "namespace": "default",

          // Data of a text item
          // Required
          "data": {
            // Text
            // Required
            "text": "Dashboard sample based on Sample SuperStore data."
          }
        },
        {
          //  required
          "id": "Xb",

          // element type
          //  required
          "type": "widget",

          //  required
          "namespace": "default",

          // widget element data
          //  required
          "data": {
            // hide the title (only if there is a single item in tabs)
            "hideTitle": false,

            // tabs
            //  required
            "tabs": [
              {
                //  required
                "id": "xq",

                // title
                // required
                "title": "Sales dynamics by Region",

                // default parameters
                "params": {},

                // chart id
                //  required
                "chartId": "rj9ym88l5zd8q",

                // indicates if the tab is default
                "isDefault": true,

                "description": ""
              }
            ]
          }
        },
        {
          // required
          "id": "wz",

          // element type
          //  required
          "type": "control",

          //  required
          "namespace": "default",

          // control element data
          //  required
          "data": {
            // title
            //  required
            "title": "Segment",

            // source type
            //  required
            "sourceType": "dataset",

            // dataset source data
            //  required
            "source": {
              // show the title
              "showTitle": true,

              // dataset id  (only for "sourceType": "dataset")
              //  required
              "datasetId": "aoetfany4sy88",

              // dataset fields id (only for "sourceType": "dataset")
              //  required
              "datasetFieldId": "b9024e08-70ca-402e-9236-ec1e63a3e91b",

              // element type
              // required
              "elementType": "select",

              // multiple choice (only for "elementType": "select")
              "multiselectable": true,

              // default value
              // (for "elementType": "select")
              "defaultValue": ["Consumer"]

              // (for "elementType": "date")
              // "defaultValue": "__interval_2014-01-01_2014-01-31"
            }
          },

          // default parameters
          //  required (for "type": "control")
          "defaults": {
            "b9024e08-70ca-402e-9236-ec1e63a3e91b": ["Consumer"]
          }
        },
        {
          // required
          "id": "9Ag",

          // element type
          //  required
          "type": "control",

          //  required
          "namespace": "default",

          // control element data
           // required
          "data": {
            // title
            //  required
            "title": "Date",

            // source type
            //  required
            "sourceType": "manual",

            // manual source data
            //  required
            "source": {
              // show the title
              "showTitle": true,

              // parameter name (only for "sourceType": "manual")
              // required
              "fieldName": "Date",

              // possible values (only for "sourceType": "manual")
              // (only for "elementType": "date")
              // required
              "acceptableValues": {
                "to": "2017-12-31",
                "from": "2014-01-01"
              },

              // possible values (only for "sourceType": "manual")
              // (only for "elementType": "select")
              //  required
              // "acceptableValues": [{
              //   "title": "daily",
              //   "value": "daily"
              // }, ...],

              // element type
              //  required
              "elementType": "date",

              //  interval calendar (only for "elementType": "date")
              "isRange": true,

              // default value
              // (for "elementType": "date")
              "defaultValue": "__interval_2014-01-01_2014-01-31"

              // (for "elementType": "select")
              // "defaultValue": ["Consumer"]
            }
          },

          // default parameters
          // required (for "type": "control")
          "defaults": {
            "Date": "__interval_2014-01-01_2014-01-31"
          }
        },
        {
          // required
          "id": "wmz",

          // element type
          //  required
          "type": "control",

          //  required
          "namespace": "default",

          // control element data
          //  required
          "data": {
            // title
            //  required
            "title": "Sample External Selector",

            // source type
            //  required
            "sourceType": "external",

            // external source data
            //  required
            "source": {
              //chart id type selector
              //  required
              "chartId": "az26sxbs6uga7"
            }
          },

          // default parameters
          //  required (for "type": "control")
          "defaults": {
            "Date": "",
            "Category": ""
          }
        },
        ...
      ],

      // arrangement of elements
      // required
      "layout": [
        {
          // element id
          // required
          "i": "Xb",

          // height
          // required
          "h": 14,

          // width
          // required
          "w": 12,

          // required
          "x": 21,

          // required
          "y": 4
        },
        ...
      ],

      // required
      "aliases": {
        // namespace
        "default": [
          // parameter names
          [
            "Category",
            "b029ce50-4551-4267-9241-74c079c130d5"
          ],
          ...
        ]
      },

      // links
      // required
      "connections": [
        {
          // ID of a control item or ID of a widget item tab
          // required
          "to": "wz",

          // ID of a control item or ID of a widget item tab
          // required
          "from": "lRM",

          // link type
          // required
          "kind": "ignore"
        },
        ...
      ]
    }
  ]
}
```
