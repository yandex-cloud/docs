# Errors

In case of an error, {{ cns-name }} returns a message with the appropriate HTTP code and its additional description in XML or JSON format depending on the specified `ResponseFormat` parameter.

Data schema:

{% list tabs %}

- XML

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <ErrorResponseXML>
   	  <RequestId>string</RequestId>
   	  <Error>
   		  <Code>string</Code>
   		  <Message>string</Message>
   	  </Error>
   </ErrorResponseXML>
   ```

- JSON

   ```json
   {
     "ErrorResponse": {
       "RequestId": "string",
       "Error": {
         "Code": "string",
         "SubCode": "string",
         "Message": "string"
       }
     }
   }
   ```

{% endlist %}

Where:
* `RequestId`: Request ID
* `Code`: Error code
* `Message`: Error description

## List of common error codes {#errors}

| HTTP | Error code | Description |
--- | --- | ---
| 400 | InvalidParameter | An invalid parameter was provided. |
| 400 | InvalidParameter | An invalid attribute was provided. |
| 400 | InvalidParameter | No required parameter was provided. |
| 403 | AuthorizationError | Authentication error. |
| 403 | AuthorizationError | Not enough permissions to perform the operation. |
| 403 | AuthorizationError | Authorization error. |