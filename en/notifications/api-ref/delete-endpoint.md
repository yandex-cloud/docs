# DeleteEndpoint

Deletes an [endpoint for push notifications](../concepts/index.md#mobile-endpoints).

## HTTP request {#request}

```http
POST https://{{ cns-host }}/
```

### Query parameters {#parameters}

| Parameter | Description |
--- | ---
| `Action` | **string**<br/>Required field.<br/>Parameter to indicate the operation type.<br/>Value: `DeleteEndpoint`. |
| `EndpointArn` | **string**<br/>Required field.<br/>Mobile endpoint ID (ARN).<br/>Example: `arn:aws:sns::aoegtvhtp8ob********:endpoint/GCM/test-cns-9990/4cbe148515360244248c993abe0a12884d162bb15e87d6c16bd0c810********`. |
| `ResponseFormat` | **string**<br/>Response format.<br/>The possible values include:<ul><li>`XML` (by default)</li><li>`JSON`.</li></ul> |

## Response {#response}

### Successful response {#response-200}

If there are no errors, {{ cns-name }} returns the `200` HTTP code.

A successful response contains additional data in XML or JSON format depending on the specified `ResponseFormat` parameter.

Data schema:

{% list tabs %}

- XML

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <DeleteEndpointResponse>
   	  <ResponseMetadata>
   		  <RequestId>string</RequestId>
   	  </ResponseMetadata>
   </DeleteEndpointResponse>
   ```

- JSON

   ```json
   {
     "ResponseMetadata": {
       "RequestId": "string"
     }
   }
   ```

{% endlist %}

Where `RequestId` is the request ID.

### Error response {#response-4xx}

In case of an error, {{ cns-name }} returns a message with the appropriate HTTP code.

For a list of common error codes for all actions, see [{#T}](common-errors.md).

## See also {#see-also}

* [{#T}](index.md)
* [{#T}](send-request.md)
* [DeleteEndpoint API action](https://docs.aws.amazon.com/sns/latest/api/API_DeleteEndpoint.html) in the AWS documentation.
