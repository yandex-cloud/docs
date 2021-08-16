# Developing in NodeJS through the Document API

## Before you start

1. [Create a serverless database](../quickstart/create-db.md) in {{ yandex-cloud }}.
1. In the properties of the created database, on the Overview tab, find and copy the `Document API endpoint` value.
1. Install the developer's tools by running the command `npm install yandex-cloud`.

## Creating a table

```javascript
const { DocAPIService } = require('yandex-cloud/lib/slydb/docapi/docapi')

// change for your Document API endpoint
const endpoint = '<your Document API endpoint here>';
const docapi = new DocAPIService(endpoint)

var params =
{
  TableName: "test/pets",
  AttributeDefinitions:
  [
    {
      AttributeName: "species",
      AttributeType: "S"
    },
    {
      AttributeName: "name",
      AttributeType: "S"
    }
  ],
  KeySchema:
  [
    {
      AttributeName: "species",
      KeyType: "HASH"
    },
    {
      AttributeName: "name",
      KeyType: "RANGE"
    }
  ]
};
docapi.createTable(params).then(res => { console.log(res); }).catch(err => { console.log(err); });
```

## Saving writes

```javascript
const { DocAPIService } = require('yandex-cloud/lib/slydb/docapi/docapi')

// change for your Document API endpoint
const endpoint = '<your Document API endpoint here>';
const docapi = new DocAPIService(endpoint)

var params =
{
  TableName: "test/pets",
  Item:
  {
    "species": "cat",
    "name": "Tom",
    "color": "Black",
    "price": "10.5"
  }
};
docapi.putItem(params).then(res => { console.log(res); }).catch(err => { console.log(err); });
```

## Reading writes

```javascript
const { DocAPIService } = require('yandex-cloud/lib/slydb/docapi/docapi')

// change for your Document API endpoint
const endpoint = '<your Document API endpoint here>';
const docapi = new DocAPIService(endpoint)

var params =
{
  TableName: "test/pets",
  Key:
  {
    "species": "cat",
    "name": "Tom"
  }
};
docapi.getItem(params).then(res => { console.log(res); }).catch(err => console.log(err));
```

