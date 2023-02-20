# {{ message-queue-full-name }} API

{{ message-queue-full-name }} provides an HTTP {% if lang == "ru" and audience != "internal" %}[API](../../glossary/rest-api.md){% else %}API{% endif %} that is partially compatible with the Amazon SQS API.

## Making API requests {#api-request}

To make a request to the {{ message-queue-full-name }} API, send an HTTP POST request to the path `/` at `https://message-queue.{{ api-host }}`.

```
POST / HTTP/1.1
Host: message-queue.{{ api-host }}
Content-Length: length
Content-Type: application/x-www-form-urlencoded
Authorization: authorization string (AWS Signature Version 4)

Request parameters
```

### Request headers {#request-headers}

All requests must have standard headers:

* `Content-Type`: `application/x-www-form-urlencoded`.
* `Authorization`: Request signature as per [Authenticating Requests](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-api-request-authentication.html) in the Amazon SQS documentation. If you use the [SDK or a console client](../instruments/index.md), a request and its signature are generated automatically and you only need to pass the request parameters.

### Request parameters {#request-parameters}

All requests must contain standard parameters:

* `Action`: the name of the API method being called.
* `Version`: always equal to `2012-11-05`.

Parameters are passed in the request body in the [form-urlencoded](https://en.wikipedia.org/wiki/Percent-encoding) format.

### Passing arrays of parameters {#array-parameters}

Some message parameters, such as message or queue attributes, are passed as arrays. Each element of an array is passed as two or more request parameters. For example, for attributes, this is the name and value of an array element.

Example of using an attribute with multiple parameters:

```
Attribute.1.Name=VisibilityTimeout
Attribute.1.Value=40
Attribute.2.Name=MessageRetentionPeriod
Attribute.2.Value=1000
```

In this example, attribute 1 is the `VisibilityTimeout` set to 40; attribute 2 is the `MessageRetentionPeriod` set to 1000.

## API response {#api-response}

In response to an API request, {{ message-queue-name }} returns an XML structure containing the request result.

### Successful response {#success}

If the request execution is successful, the main element of the response gets the name of the method being called plus the `Response` suffix (`<Action> + "Response"`).

This element contains the following child elements:

| Tag | Description |
----- | -----
| `ActionNameResult` | Contains elements specific to the method being called. For possible elements, see the documentation for each method. For example, `CreateQueueResult` contains the `QueueUrl` element with the URL of the queue created. |
| `ResponseMetadata` | Contains the `RequestId` with the UUID of the request. |

Example of a successful response:

```
<?xml version="1.0" encoding="UTF-8"?>
<CreateQueueResponse>
   <CreateQueueResult>
      <QueueUrl>https://message-queue.{{ api-host }}/b1g8ad42m6he1ooql78r/dj600000000000me07ol/sample-queue</QueueUrl>
   </CreateQueueResult>
   <ResponseMetadata>
      <RequestId>3c9b76fb-f35fb266-48e9c5bf-faca-ddc10b592cfce6ffdf83329a2062f99b</RequestId>
   </ResponseMetadata>
</CreateQueueResponse>
```

### Error response {#error}

If a request fails, the main element of the response is named `ErrorResponse`. This element contains such child elements as `Error` and `RequestId`.

The Error element contains the following child elements:

| Tag | Description |
----- | -----
| `Type` | Error type indicating whether the error occurred on the producer or consumer's side. |
| `Code` | Error ID.<br/><br/>For a list of common errors, see [{#T}](common-errors.md). |
| `Message` | Error description in English. |
| `Detail` | Additional information about the error (optional). |

The `RequestId` element contains the UUID of the request.

Sample error response:

```xml
<ErrorResponse>
   <Error>
      <Type>Sender</Type>
      <Code>InvalidParameterValue</Code>
      <Message>
         Value (queuename_nonalpha) for parameter QueueName is invalid.
         Must be an alphanumeric String of 1 to 80 in length.
      </Message>
   </Error>
   <RequestId>42d59b56-7407-4c4a-be0f-4c88daeea257</RequestId>
</ErrorResponse>
```
