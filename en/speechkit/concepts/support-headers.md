# Troubleshooting

{% include [ask-for-support](../../_includes/ai-common/ask-for-support.md) %}

Technical support will spend less time solving your issue if you use advanced HTTP request and response headers.

## Request headers {#request-headers}

When sending HTTP requests, use the following headers:

* {% include [x-client-request-id](../../_includes/ai-common/x-client-request-id.md) %}
* `x-data-logging-enabled`: A flag that allows data passed by the user in the request to be saved.

   By default, we do not save any audio or text that you send. If you pass the `true` value in this header, your data is saved. This data, along with the request ID, will help the technical support team solve your problem.

### Examples {#examples}

For example, you can use these headers to let us know afterwards that your audio was poorly detected and help us refine our speech recognition model.

An example of headers used in [cURL](https://curl.haxx.se):

```bash
export FOLDER_ID=<folder ID>
export IAM_TOKEN=<IAM token>

curl -X POST \
    -H "x-client-request-id: fa18fa9b-176d-4ae0-92b8-bd7897f7c00c" \
    -H "x-data-logging-enabled: true" \
    -H "authorization: Bearer ${IAM_TOKEN}" \
    --data-binary "@speech.ogg" \
    "https://stt.api.cloud.yandex.net/speech/v1/stt:recognize?folderId=${FOLDER_ID}"
```

Where:

* `folderId`: The [ID of a folder](../../resource-manager/operations/folder/get-id.md) that your account has the `editor` role for or higher.
* `IAM_TOKEN`: The [IAM token](../../iam/operations/iam-token/create.md) required for authentication.

## Response headers {#response-headers}

Each {{ speechkit-short-name }} server response contains headers that provide even more information about request execution:

* `x-request-id`: A unique response ID.
* `x-server-trace-id`: A unique request execution log ID.

To be able to retrieve the `x-request-id` and `x-server-trace-id` values, your application must log server response headers.

An implementation example for access to gRPC headers is provided in the [`grpc-go` library documentation](https://github.com/grpc/grpc-go/blob/master/Documentation/grpc-metadata.md).
