# ListEndpointsByPlatformApplication

Gets a list of [endpoints for push notifications](../concepts/index.md#mobile-endpoints).

## HTTP request {#request}

```http
POST https://{{ cns-host }}/
```

### Query parameters {#parameters}

| Parameter | Description |
--- | ---
| `Action` | **string**<br/>Required field.<br/>Parameter to indicate the operation type.<br/>Value: `ListEndpointsByPlatformApplication`. |
| `PlatformApplicationArn` | **string**<br/>Required field.<br/>Mobile push notification channel ID.<br/>Example: `arn:aws:sns::aoegtvhtp8ob********:app/GCM/test-cns-9990`. |
| `NextToken` | **string**<br/>Token for viewing endpoint records after the first page. |
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
   <ListEndpointsByPlatformApplicationResponseXML>
   	  <ResponseMetadata>
   		  <RequestId>string</RequestId>
   	  </ResponseMetadata>
   	  <ListEndpointsByPlatformApplicationResult>
   		  <Endpoints>
   			  <member>
   				  <EndpointArn>string</EndpointArn>
   				  <Attributes>
   					  <entry>
   						  <key>string</key>
   						  <value>string</value>
   					  </entry>
   				  </Attributes>
   			  </member>
   		  </Endpoints>
   		  <NextToken>string</NextToken>
   	  </ListEndpointsByPlatformApplicationResult>
   </ListEndpointsByPlatformApplicationResponseXML>
   ```

- JSON

   ```json
   {
     "ResponseMetadata": {
       "RequestId": "string"
     },
     "ListEndpointsByPlatformApplicationResult": {
       "Endpoints": [
         {
           "EndpointARN": "string",
           "Attributes": {
             "Attribute": "string"
           }
         }
       ],
       "NextToken": "string"
     }
   }
   ```

{% endlist %}

Where:
* `RequestId`: Request ID.
* `EndpointArn`: Mobile endpoint ID (ARN).
* `Attributes`: Mobile endpoint attributes. The following attributes are supported:
   * `CustomUserData`: Other user data that is stored with the endpoint. {{ cns-name }} does not use this data in any way.
   * `Enabled`: Attribute for enabling and disabling endpoint notifications, currently not supported. It always returns `true`.

   {% note info %}

   The `Token` attribute is not output for additional data protection.

   {% endnote %}
* `NextToken`: Token for viewing endpoint records on the next page. It returns when additional records are available. If all records have been viewed, `NextToken` does not return.

### Error response {#response-4xx}

In case of an error, {{ cns-name }} returns a message with the appropriate HTTP code.

For a list of common error codes for all actions, see [{#T}](common-errors.md).

## See also {#see-also}

* [{#T}](index.md)
* [{#T}](send-request.md)
* [ListEndpointsByPlatformApplication API action](https://docs.aws.amazon.com/sns/latest/api/API_ListEndpointsByPlatformApplication.html) in the AWS documentation.
