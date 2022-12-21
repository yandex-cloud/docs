# Datasets

**Interface**: [`https://datalens.yandex-team.ru/datasets`](https://datalens.yandex-team.ru/datasets)(the old link [`https://stat.yandex-team.ru/datasets`](https://stat.yandex-team.ru/datasets))

**Prefix**: `/_bi` -> `https://back.datalens.yandex-team.ru`

## Generating a data source {#forming-data-source}

To build a data source, the `buildSource` method from the `libs/dataset/v1` module is used.
The `buildSource` method accepts one argument of the `object` type with the following properties:
|Name|Type|Description|Required / Default|
|:---|:---|:---|:---|
|id|`string`|Dataset ID|Required
|columns|`string[]`|Columns|Required
|order|`OrderObject[]`|Parameters of sorting by columns|-
|where|`FilterObject[]`|Additional conditions|-
|limit|`number`|Limit the output to the preset number of rows|-
|offset|`number`|Offset the output by the specified number of rows|-

`order` is an array consisting of `OrderObject`. `OrderObject` looks like this:
|Name|Type|Description|Required / Default|
|:---|:---|:---|:---|
|column|`string`|Column to sort by|Required
|direction|`OrderEnum`|Sort order|Required

`OrderEnum` takes upon one value out of:
- `ORDERS.DESC`: in the descending order
- `ORDERS.ASC`: in the ascending order

`ORDERS` need to be imported from the module:

`const {ORDERS} = require('libs/dataset/v1');`

`where` is an array of `FilterObject`. `FilterObject` looks like this:

| Name | Type | Description | Required / By default |
|:---|:---|:---|:---|
| column | `string` | Column to filter by | Required |
| operation | `OperationEnum` | Match operation to be used | Required |
| values | `string[]` | Values to match with  | Required |

`OperationEnum` takes upon one value out of:
- `OPERATIONS.ISNULL`: Matching an empty value (NULL).
- `OPERATIONS.ISNOTNULL`: Checking for *not* NULL
- `OPERATIONS.GT`: Greater than 
- `OPERATIONS.LT`: Less than
- `OPERATIONS.GTE`: Greater than or equal to
- `OPERATIONS.LTE`: Less than or equal to
- `OPERATIONS.EQ`: Equal
- `OPERATIONS.NE`: Not equal
- `OPERATIONS.STARTSWITH`: Starts with
- `OPERATIONS.ISTARTSWITH`: Ends with (case insensitive)
- `OPERATIONS.ENDSWITH`: Ends with
- `OPERATIONS.IENDSWITH`: Ends with (case insensitive)
- `OPERATIONS.CONTAINS`: Contains
- `OPERATIONS.ICONTAINS`: Contains (case insensitive)
- `OPERATIONS.NOTCONTAINS`: Not contains
- `OPERATIONS.NOTICONTAINS`: Not contains (case insensitive)
- `OPERATIONS.IN`: Belongs to a set
- `OPERATIONS.NIN`: Doesn't belong to a set
- `OPERATIONS.BETWEEN`: Between

`OPERATIONS` need to be imported from the module:

`const {OPERATIONS} = require('libs/dataset/v1');`

### Example {#forming-data-source-example}

**Urls** tab
```js
// Include the data source module
const {buildSource, OPERATIONS, ORDERS} = require('libs/dataset/v1');

// Build the data source
module.exports = {
    dataset: buildSource({
        // Specify the ID of the dataset
        id: 'y55xt5d3p9csw',

        // Query two columns
        columns: ['Category', 'Profit'],

        // Build the where clause
        where: [{
            // Filter by Category
            column: 'Category',

            // so that the value belongs to  
            operation: OPERATIONS.IN,

            // the set of 'Furniture', 'Office Supplies'
            values: ['Furniture', 'Office Supplies'],
        }],

        // Enable sorting
        order_by: [{
            // in descending order
            direction: ORDERS.DESC,

            // by the Profit column
            column: 'Profit',
        }],
    }),
};
```

## Examples {#examples}

[Chart based on the data from Dataset](https://charts.yandex-team.ru/editor/8nhx675cmotg6)
