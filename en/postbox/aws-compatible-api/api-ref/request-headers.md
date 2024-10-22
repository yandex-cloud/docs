# Request headers

Most headers available for requests in the Amazon API are of `X-Amz-*` type. They are optional and contain authentication information. Use them to create signed requests.

#|
|| **Header** | **Description** ||
|| `Accept` | Data type in the response, e.g., `application/json` (default).

For more information about data types, see [Media type](https://en.wikipedia.org/wiki/Media_type) in Wikipedia. ||
|| `Authorization` | Any request to {{ postbox-name }} must be authorized.

The header must contain a static access key and request signature. Learn more about header format [here](../signing-requests.md#authorization-header).

To avoid signing the request, use the `X-YaCloud-SubjectToken` header instead of `Authorization`. ||
|| `Content-Type` | Data type in the request, e.g., `application/json` (default).

For more information about data types, see [Media type](https://en.wikipedia.org/wiki/Media_type) in Wikipedia. ||
|| `X-Amz-Algorithm` | Request signature algorithm.

Provide `AWS4-HMAC-SHA256` in the header because {{ postbox-name }} supports [Amazon Signature Version 4](https://docs.amazonaws.cn/en_us/IAM/latest/UserGuide/reference_aws-signing.html). ||
|| `X-Amz-Content-Sha256` | Request payload hash. Used to sign requests in Amazon Signature Version 4 format. ||
|| `X-Amz-Credential` | Scope of signature validity. The header must have the following format: `<static_key_ID>/<date>/{{ region-id }}/ses/aws4_request`. In the header, specify the following:

* Static access key ID you obtained when [getting started](../index.md#before-you-begin).
* Date in `YYYYMMDD` format. ||
|| `X-Amz-Date` | Time in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format, e.g.: `20240920T091646Z`. ||
|| `X-Amz-Security-Token` | Token to provide if the authentication credentials are issued by STS. ||
|| `X-Amz-Signature` | Request signature. Learn more about signing requests [here](../signing-requests.md). ||
|| `X-Amz-SignedHeaders` | List of headers used for request signature generation. Required headers include the following:

* `host`: HTTP host to send requests to.
* `x-amz-*`: Amazon API headers.

Provide the headers in lowercase, sort them alphabetically, and separate with semicolons, e.g.: `host;x-amz-date`. ||
|| `X-YaCloud-SubjectToken` | IAM token for authenticating with the API. 

Use only one of the two headers: `Authorization` or`X-YaCloud-SubjectToken`. For `Authorization`, you need to get a static access key and sign the request, while for `X-YaCloud-SubjectToken`, get an IAM token. Learn more about authentication [here](../../api-ref/authentication.md). ||
|#
