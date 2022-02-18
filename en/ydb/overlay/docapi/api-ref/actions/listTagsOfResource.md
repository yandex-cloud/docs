# ListTagsOfResource method

Returns a list of all tags on the {{ ydb-name }} resource. The method can be called up to 10 times per second.

The result is returned page-by-page.

## Request

The request contains data in JSON format.

```json
{
   "NextToken": "string",
   "ResourceArn": "string"
}
```

### Parameters

| Parameter | Description |
| ----- | ----- |
| `ResourceArn` | A {{ ydb-name }} resource with displayed tags.<br/>**Type**: String<br/>**Length**: 1 - 1283 characters<br/>**Required**: Yes |
| `NextToken` | Used to get the next result  page.<br/>If the method didn't return all the results for the previous query, copy the `NextToken` value from the response and substitute it in this parameter.<br/><br/>**Type**: String<br/>**Required**: No |

## Response

If successful, HTTP code 200 is returned.
The response is returned in JSON format.

```json
{
   "NextToken": "string",
   "Tags": [ 
      { 
         "Key": "string",
         "Value": "string"
      }
   ]
}
```

### Parameters

| Parameter | Description |
| ----- | ----- |
| `NextToken` | If the value is not empty, some results still can be returned. To get them, call the method again and pass the value to the `NextToken` parameter.<br/><br/>**Type**: String |
| `Tags` | Tags associated with the {{ ydb-name }} resource<br/><br/>**Type**: array of objects of the `Tag` type. |

## Errors

| Parameter | Description |
| ----- | ----- |
| `InternalServerError` | An internal error occurred on the server side.<br/><br/>**HTTP status code**: 500 |
| `ResourceNotFoundException` | The specified table doesn't exist.<br/><br/>**HTTP status code**: 400 |

There may be [common errors](../common-errors) as well. These are errors that are common to all methods.