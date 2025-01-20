# Signing requests

Many requests to {{ postbox-name }} are authenticated on the service side; therefore, they must be signed when sending. {{ postbox-name }} supports [Amazon Signature Version 4](https://docs.amazonaws.cn/en_us/IAM/latest/UserGuide/reference_aws-signing.html) for signing. It is used in the `Authorization` header.

{% note tip %}

To avoid signing requests, use [authentication with an IAM token](../api-ref/authentication.md#iam-ses-example).

{% endnote %}

To get a signature:

1. [Create a canonical request](#canonical-request)
1. [Generate a string to sign](#string-to-sign-gen)
1. [Generate a signing key](#signing-key-gen)
1. [Sign the string with the key](#signing)
1. Optionally, [debug the obtained data using the AWS CLI](#debugging)
1. [Create the `Authorization` header](#authorization-header)

Use [HMAC](https://en.wikipedia.org/wiki/HMAC) with the [SHA256](https://en.wikipedia.org/wiki/SHA-2) hash function for signing. This technique supports many programming languages. The examples below assume the code uses functions for encoding and hashing strings with the appropriate technique.

## Create a canonical request {#canonical-request}

Use the following format:

```text
<HTTPVerb>\n
<CanonicalURI>\n
<CanonicalQueryString>\n
<CanonicalHeaders>\n
<SignedHeaders>\n
UNSIGNED-PAYLOAD
```

Where:

* `HTTPVerb`: HTTP method
* `CanonicalURI`: Endpoint

   For a list of endpoints and relevant HTTP methods, see the [API reference](api-ref/index.md). For example, the endpoint in the `GET /v2/email/configuration-sets HTTP/2` request is `/v2/email/configuration-sets`.

* `CanonicalQueryString`: Query parameters of the final URL. Provide all possible and supported parameters in the request. They must be URL-encoded and sorted alphabetically.

   Example: `NextToken=my%2Ftoken&PageSize=10`.

* `CanonicalHeaders`: List of request headers and their values. 

   The list must follow these requirements:

   * Each header must be separated with the line break symbol `\n`.
   * Header names must be lowercase.
   * Headers must be sorted alphabetically.
   * There may not be any extra spaces.
   * The list must contain the `host` header and all `x-amz-*` headers used in the request.

   You can also add any request header to the list. The more headers you sign, the safer your request is going to be.

   Here is an example: 

   ```
   host:{{ postbox-host }}
   x-amz-date:20240920T091646Z
   ```

* `SignedHeaders`: List of header names used for request signature generation. Provide the headers in lowercase, sort them alphabetically, and separate with semicolons.

   Example: `content-type;host;x-amz-date`.

Add the `UNSIGNED-PAYLOAD` string at the end of your canonical request.

## Generate a string to sign {#string-to-sign-gen}

A string to sign is a concatenation of the following strings:

```text
"AWS4-HMAC-SHA256" + "\n" +
"<time_in_ISO_8601_format>" + "\n" +
"<date_in_YYYYMMDD_format>/{{ region-id }}/ses/aws4_request" + "\n" +
Hex(SHA256Hash(<canonical_request>))
```

Here is an example of time in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format: `20240920T091646Z`.

## Generate a signing key {#signing-key-gen}

Before you start, [generate a static access key](index.md#before-you-begin).

{% include [generate-signing-key](../../_includes/storage/generate-signing-key.md) %}

## Sign the string with the key {#signing}

Sign the string and convert it to hexadecimal format:

```text
signature = Hex(sign(SigningKey, StringToSign))
```

## Optionally, debug the obtained data using the AWS CLI {#debugging}

To debug the process of signing requests, use the [AWS CLI](../tools/aws-cli.md) utility with the `--debug` parameter. It adds `CanonicalRequest`, `StringToSign`, and `Signature` to the command output. You can compare these against your values.

{% list tabs group=instructions %}

- AWS CLI {#aws-cli}

   In the terminal, run the [configuration create](../operations/create-configuration.md) command and see how request parameters are generated:

   ```bash
   aws sesv2 create-configuration-set \
      --endpoint-url={{ postbox-endpoint }} \
      --profile default \
      --configuration-set-name <configuration_name> \
      --debug
   ```

   {% note info %}

   For this example, the service account you are using to run the `aws` commands needs the `postbox.editor` [role](../security/index.md#postbox-editor) or higher.

   {% endnote %}

   Result:

   ```text
   ...
   2024-09-02 13:16:46,063 - MainThread - botocore.auth - DEBUG - CanonicalRequest:
   POST
   /v2/email/configuration-sets

   content-type:application/json
   host:{{ postbox-host }}
   x-amz-date:20240920T091646Z

   content-type;host;x-amz-date
   e9cc542601e782471dc41e9c1aa0a6c9e55cf6b926c0e2b200e461d0********
   2024-09-02 13:16:46,063 - MainThread - botocore.auth - DEBUG - StringToSign:
   AWS4-HMAC-SHA256
   20240920T091646Z
   20240902/{{ region-id }}/ses/aws4_request
   bcbaab5d2a5f44555276ec63a07e4141a04d72b886b419fe280ca07d********
   2024-09-02 13:16:46,063 - MainThread - botocore.auth - DEBUG - Signature:
   d88f587982912662d886c77de0c110aad8fa2899bc2e733ff4f03f7e********
   ...
   ```

{% endlist %}

## Create the Authorization header {#authorization-header}

Create the `Authorization` header in the following format:

```text
Authorization: AWS4-HMAC-SHA256 Credential=<static_key_ID>/<date>/{{ region-id }}/ses/aws4_request SignedHeaders=<signed_headers> Signature=<signature>
```

Use this header when accessing the API directly, without the [AWS CLI](../tools/aws-cli.md) or apps.

In the header, specify the following:

* Static access key ID you obtained when [getting started](index.md#before-you-begin).
* Date in `YYYYMMDD` format.
* Signed headers, e.g., `content-type;host;x-amz-date`. Learn more about signed headers [here](api-ref/request-headers.md).
* Request signature.
