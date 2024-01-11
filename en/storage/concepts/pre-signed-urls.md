---
title: "Pre-signed URLs in {{ objstorage-full-name }}"
description: "Using pre-signed URLs, web users can download, upload, or create an object in an {{ objstorage-name }} bucket:"
---

# Pre-signed URLs

Using pre-signed URLs, web users can perform various operations in {{ objstorage-name }}, such as:

- Download an object
- Upload an object
- Create a bucket

A pre-signed URL is a URL containing request authorization data in its parameters. Pre-signed URLs can be created by users with static access keys.

This section outlines the common principles for generating pre-signed URLs using AWS Signature V4.

{% note info %}

SDKs for various programming languages and other tools for AWS S3 have out-of-the-box methods for generating pre-signed URLs that you can also use for {{ objstorage-name }}.

{% endnote %}

## General pre-signed URL format {#presigned-url-preview}

```
https://{{ s3-storage-host }}/<bucket_name>/<object_key>?
     X-Amz-Algorithm=AWS4-HMAC-SHA256
    &X-Amz-Expires=<interval>
    &X-Amz-SignedHeaders=<list_of_headers>
    &X-Amz-Signature=<signature>
    &X-Amz-Date=<time>
    &X-Amz-Credential=<access_key_ID>%2F<date>%2F{{ region-id }}%2Fs3%2Faws4_request
```

Pre-signed URL parameters:

| Parameter | Description |
---------|---------
| `X-Amz-Algorithm` | Identifies the signature version and algorithm for its calculation. Value: `AWS4-HMAC-SHA256`. |
| `X-Amz-Expires` | Link validity time in seconds. The starting point is the time specified in `X-Amz-Date`. The maximum value is 2592000 seconds (30 days). |
| `X-Amz-SignedHeaders` | Headers of the request you want to sign.<br/><br/>Make sure to sign the `Host` header and all `X-Amz-*` headers used in the request. You do not have to sign other headers; however, the more headers you sign, the safer your request is. Request headers are separated by `;`. |
| `X-Amz-Signature` | Request signature. |
| `x-amz-date` | Time in [ISO8601](https://en.wikipedia.org/wiki/ISO_8601) format, for example, `20180719T000000Z`. The date specified must match the date in the `X-Amz-Credential` parameter (by value rather than by format). |
| `X-Amz-Credential` | Signature ID.<br/><br/>This is a string in `<access_key_ID>/<date>/{{ region-id }}/s3/aws4_request` format, where `<date>` (specified in `YYYYMMDD` format: year, month, day) must match the date set in the `X-Amz-Date` header. |


## Creating pre-signed URLs {#creating-presigned-url}

{% note info %}

Generating pre-signed URLs is optional for public buckets. You can get files from a publicly available bucket via both HTTP and HTTPS even if the bucket has no [website hosting](hosting.md) configured.

{% endnote %}

To get a pre-signed URL, do the following:

1. Calculate the signature.
   1. [Compose a string to sign](#composing-string-to-sign).
   2. Calculate the signature using the [string signature algorithm](../s3/signing-requests.md).
2. [Compose a pre-signed URL](#composing-signed-url) for your request.

To compose a pre-signed URL, you must have [static access keys](../../iam/operations/sa/create-access-key.md).

### String to sign {#composing-string-to-sign}

String to sign:

```
"AWS4-HMAC-SHA256" + "\n" +
<time> + "\n" +
<date> + "\n" +
Hex(Hash-SHA256(<canonical_request>))
```

Where:

* `AWS4-HMAC-SHA256`: Hashing algorithm.
* `<time>`: Current time in ISO 8601 format, e.g., `20190801T000000Z`. The specified date must match the `<date>` parameter (by value rather than by format).
* `<date>`: `<date>/{{ region-id }}/s3/aws4_request`, where `<date>` is provided in `YYYYMMDD` format: year, month, day.
* `<canonical_request>`: [Canonical request](#canonical-request). To include your request in the string, hash it using the SHA256 algorithm and convert it to hexadecimal format.

### Canonical request {#canonical-request}

The general canonical request format is as follows:

```
<HTTPVerb>\n
<CanonicalURL>\n
<CanonicalQueryString>\n
<CanonicalHeaders>\n
<SignedHeaders>\n
UNSIGNED-PAYLOAD
```

A canonical request must always end with the `UNSIGNED-PAYLOAD` string.

#### HTTPVerb {#http-verb}

HTTPVerb stands for the HTTP method used to send a request: `GET`, `PUT`, `HEAD`, or `DELETE`.

#### CanonicalURL {#canonical-url}

Canonical URL is the URL-encoded path to the resource, e.g., `/<bucket_name>/<object_key>`.

{% note info %}

Do not normalize the path. For example, if an object has a `some//strange//key//example` key, normalizing the path to `/<bucket_name>/some/strange/key/example` will invalidate it.

{% endnote %}

#### CanonicalQueryString {#canonical-query-string}

The canonical query string must include all query parameters of the destination URL, except `X-Amz-Signature`. The parameters in the string must be URL-encoded and sorted alphabetically.

For example:

```
X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=JK38EXAMPLEAKDID8%2F20190801%2F{{ region-id }}%2Fs3%2Faws4_request&X-Amz-Date=20190801T000000Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host
```


#### CanonicalHeaders {#canonical-headers}

This section includes the list of the request headers and their values.

The requirements are as follows:

- Each header must be separated with the `\n` newline character.
- Header names must be lowercase.
- Headers must be sorted alphabetically.
- There may not be any extra spaces.
- The list must contain the `host` header and all `x-amz-*` headers used in the request.

You can also add any request header to the list. The more headers you sign, the safer your request is.

For example:

```
host:{{ s3-storage-host }}
x-amz-date:20190801T000000Z
```


#### SignedHeaders {#signed-headers}

This is a list of lowercase request header names, sorted alphabetically and separated by semicolons.

For example:

```
host;x-amz-date
```


### Pre-signed URLs {#composing-signed-url}

To create a pre-signed URL, add the [parameters](#presigned-url-preview) required to authorize the request, including the `X-Amz-Signature` parameter with the calculated signature, to the {{ objstorage-name }} resource URL.


#### Example of composing a pre-signed URL for downloading an object {#example-for-object-download}

Here is an example of creating a signed URL to download the `object-for-share.txt` object from the bucket valid for an hour.

- Static key:

   ```
   access_key_id = 'JK38EXAMP********'
   secret_access_key = 'ExamP1eSecReTKeykdo********'
   ```

- Canonical request:

   ```
   GET
   /<bucket_name>/object-for-share.txt
   X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=JK38EXAMP********%2F20190801%2F{{ region-id }}%2Fs3%2Faws4_request&X-Amz-Date=20190801T000000Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host
   host:{{ s3-storage-host }}

   host
   UNSIGNED-PAYLOAD
   ```

- String to sign:

   ```
   AWS4-HMAC-SHA256
   20190801T000000Z
   20190801/{{ region-id }}/s3/aws4_request
   2d2b4efefa9072d90a646afbc0fbaef4618c81396b216969ddfc2869********
   ```

- Signing key:

   ```
   sign(sign(sign(sign("AWS4" + "ExamP1eSecReTKeykdokKK38800","20190801"),"{{ region-id }}"),"s3"),"aws4_request")

   ```

   Here, we introduce the `sign` function to indicate the method of key calculation that uses the [HMAC](https://en.wikipedia.org/wiki/HMAC) algorithm with [SHA256](https://en.wikipedia.org/wiki/SHA-2).

- Signature:

   ```
   56bdf53a1f10c078c2b4fb5a26cefa670b3ea796567d85489135cf33********
   ```

- Pre-signed URL:

   ```
   https://{{ s3-storage-host }}/<bucket_name>/object-for-share.txt?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=JK38EXAMPLEAKDID8%2F20190801%2F{{ region-id }}%2Fs3%2Faws4_request&X-Amz-Date=20190801T000000Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=56bdf53a1f10c078c2b4fb5a26cefa670b3ea796567d85489135cf33********
   ```

## Examples of getting pre-signed links in {{ objstorage-name }} tools {#example-for-getting-in-tools}

{% list tabs %}

- Management console

   {% include [storage-get-link-for-download](../_includes_service/storage-get-link-for-download.md) %}

- AWS CLI

   You can also use AWS CLI to generate a link for downloading an object. To do this, run the following command:

   ```
   aws s3 presign s3://<bucket_name>/<object_key> --endpoint-url "https://{{ s3-storage-host }}/" [--expires-in <value>]
   ```

   To generate the link properly, make sure to provide the `--endpoint-url` parameter pointing to the {{ objstorage-name }} hostname. For detailed information, see [this section covering AWS CLI specifics](../tools/aws-cli.md#specifics).

- boto3

   The example below generates a pre-signed URL for downloading the `object-for-share` object from the `bucket-with-objects` bucket. The URL is valid for 100 seconds.

   ```python
   # coding=utf-8

   import boto3
   from botocore.client import Config


   ENDPOINT = "https://{{ s3-storage-host }}"

   ACCESS_KEY = "JK38EXAMP********"
   SECRET_KEY = "ExamP1eSecReTKeykdo********"

   session = boto3.Session(
       aws_access_key_id=ACCESS_KEY,
       aws_secret_access_key=SECRET_KEY,
       region_name="{{ region-id }}",
   )
   s3 = session.client(
       "s3", endpoint_url=ENDPOINT, config=Config(signature_version="s3v4")
   )

   presigned_url = s3.generate_presigned_url(
       "get_object",
       Params={"Bucket": "bucket-with-objects", "Key": "object-for-share"},
       ExpiresIn=100,
   )

   print(presigned_url)
   ```

{% endlist %}
