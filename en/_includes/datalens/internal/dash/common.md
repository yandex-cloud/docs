## General information {#about}

### Tab{#tab-common-dash}

```json
{
  "tabs": [
    {
      "id": "WR",
      "title": "Sales",
      "items": [...],
      "layout": [...],
      "connections": [...],
      "aliases": {...}
    },
    ...
  ]
}
```

Includes:

* `items` - set of items
* `layout`: Description of the grid (item layout)
* `connections`: List of links between items
* `aliases`

**Note**: Make sure that all `IDs` (of tabs, items, chart tabs (`widget` item)) within the layout are unique.

### Element{#element-common-dash}

```json
{
  "items": [
    {
      "id": "7r5",
      "namespace": "default",
      "type": "...",
      "data": {...}
    },
    ...
  ]
}
```

**Note**: Each item must have a respective record in the layout.

**Note**: Each item has the `namespace` property that currently must always be set to `default`.

Depending on the `type`, an item has its own set of `data` required for the item to run properly.

An element can be one of the following types:

* **title**: Title

   ```json
   {
     ...,
     "type": "title",
     "data": {
       "text": "Sales",

       // size: xs, s, m, l
       "size": "l",

       // display in contents
       "showInTOC": true
     }
   }
   ```

* **text**: Text

   ```json
   {
     ...,
     "type": "text",
     "data": {
       "text": "Sample dashboard based on the Sample SuperStore data."
     }
   }
   ```

* **widget**: Chart

   ```json
   {
     ...,
     "type": "widget",
     "data": {
       // hide the title (only if there is a single item in tabs)
       "hideTitle": false,

       // tabs
       "tabs": [
         {
           "id": "xq",
           "title": "Sales dynamics by Region",

           // default parameters
           "params": {},

           // chart ID
           "chartId": "rj9ym88l5zd8q",

           // indicates if the tab is default
           "isDefault": true,

           "description": ""
         }
       ]
     }
   }
   ```

* **control**: Selector

   ```json
   {
     ...,
     "type": "control",
     "data": {
       "title": "Segment",
       "sourceType": "...",
       "source": {...}
     },
     "defaults": {
       "b9024e08-70ca-402e-9236-ec1e63a3e91b": ["Consumer"],
       "Date": "__interval_2014-01-01_2014-01-31"
     }
   }
   ```

An item of the `control` type has the `defaults` property
that lists parameters associated with the item and their default values.

Depending on the `sourceType`, a `control` item has different sets of `source` data required for the item to run properly.

The source type can take the values:

* **dataset**: Based on dataset

   ```json
   {
     ...,
     "type": "control",
     "data": {
       ...
       "sourceType": "dataset",
       "source": {
         // show the title
         "showTitle": true,

         // dataset ID
         "datasetId": "aoetfany4sy88",

         // dataset field ID
         "datasetFieldId": "b9024e08-70ca-402e-9236-ec1e63a3e91b",

         // element type
         "elementType": "select",

         // multiple choice (only for "elementType": "select")
         "multiselectable": true,

         // default value
         // (for "elementType": "select")
         "defaultValue": ["Consumer"]

         // (for "elementType": "date")
         // "defaultValue": "__interval_2014-01-01_2014-01-31"
       }
     }
   }
   ```

* **manual**: Manual input

   ```json
   {
     ...,
     "type": "control",
     "data": {
       ...,
       "sourceType": "manual",
       "source": {
         // show the title
         "showTitle": true,

         // parameter name
         "fieldName": "Date",

         // possible values
         // (only for "elementType": "date")
         "acceptableValues": {
           "to": "2017-12-31",
           "from": "2014-01-01"
         },

         // possible values
         // (only for "elementType": "select")
         // "acceptableValues": [{
         //   "title": "daily",
         //   "value": "daily"
         // }, ...],

         // element type
         "elementType": "date",

         // interval calendar (only for "elementType": "date")
         "isRange": true,

         // default value
         // (for "elementType": "date")
         "defaultValue": "__interval_2014-01-01_2014-01-31"

         // (for "elementType": "select")
         // "defaultValue": ["Consumer"]
       }
     }
   }
   ```

* **external**: External selector

   ```json
   {
     ...,
     "type": "control",
     "data": {
       ...,
       "sourceType": "external",
       "source": {
         // selector chart ID
         "chartId": "az26sxbs6uga7"
       }
     }
   }
   ```

### Grid {#grid-common-dash}

```json
{
  "layout": [
    {
      // item ID
      "i": "Xb",

      // height
      "h": 14,

      // width
      "w": 12,

      "x": 21,
      "y": 4
    },
    ...
  ]
}
```

36 columns, each unit is 18px in height.

**Note**: Each item must have a respective record in the layout.

### Links {#connections-common-dash}

```json
{
  "connections": [
    {
      // ID of a control item or ID of a widget item tab
      "from": "lRM",

      // ID of a control item or ID of a widget item tab
      "to": "wz",

      // link type
      "kind": "ignore"
    },
    ...
  ]
}
```

Currently, links are only supported between selectors -> chart tabs (unidirectional) and selectors <-> selectors (bidirectional).
By default, a link is established between items by the same parameter name.

Possible types of links: 

* `ignore`

### Aliases {#aliases-common-dash}

```json
{
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
  }
}
```

Lists parameter names.
Parameters listed in an alias are synced by value, meaning that the value will always be the same for all parameters and it will be updated simultaneously.

For example:
* selector A sets the `car` parameter
* selector B sets the `machine` parameter
* a chart accepts the `machine` parameter

Only the chart and selector B are linked by default.
If you set an alias like `["car", "machine"]`, the `car` and `machine` parameters will be synced.
In this case, if selector A updates the `car` parameter, the chart and selector B will get the `machine` parameter equal to the `car` parameter.
Likewise, if selector B updates the `machine` parameter, the chart will get the `machine` parameter and selector A will get the `car` parameter whose value is equal to the `machine` parameter.

**Note**: Currently, `aliases` must only have a single `default` property where aliases will be listed.
