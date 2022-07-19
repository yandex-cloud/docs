# Pre-signed URLs

Using pre-signed URLs, internet users can perform various operations in {{ objstorage-name }}, such as:

- Download an object
- Upload an object
- Creating a bucket

A pre-signed URL is a URL containing request authorization data in its parameters. Users with static access keys can create pre-signed URLs.

This section outlines the common principles for generating pre-signed URLs using AWS Signature V4.

{% note info %}

SDKs for various programming languages and other tools for AWS S3 have methods for generating pre-signed URLs that you can also use for {{ objstorage-name }}.

{% endnote %}

## General pre-signed URL format {#presigned-url-preview}

```
https://{{ s3-storage-host }}/<bucket name>/<object key>?
     X-Amz-Algorithm=AWS4-HMAC-SHA256
    &X-Amz-Expires=<time interval in seconds>
    &X-Amz-SignedHeaders=<list of headers separated by ";">
    &X-Amz-Signature=<signature>
    &X-Amz-Date=<time in ISO 8601 format>
    &X-Amz-Credential=<access-key-id>%2F<YYYYMMDD>%2F{{ region-id }}%2Fs3%2Faws4_request
```

Pre-signed URL parameters:

| Parameter | Description |
| --------- | --------- |
| `X-Amz-Algorithm` | Identifies the signature version and algorithm of its calculation. Value: `AWS4-HMAC-SHA256`. |
| `X-Amz-Expires` | Link validity time in seconds. The starting point is the time specified in `X-Amz-Date`. The maximum value is 604800 seconds (7 days). |
| `X-Amz-SignedHeaders` | Headers of the request you want to sign.<br/><br/>Make sure to sign the `host` header and all the `x-amz-*` headers used in the request. You don't have to sign other headers, but the more headers you sign, the safer your request is. |
| `X-Amz-Signature` | Request signature. |
| `X-Amz-Date` | Time in [ISO8601](https://en.wikipedia.org/wiki/ISO_8601) format, for example: `20180719T000000Z`. The date specified must match the date in the `X-Amz-Credential` parameter (by the value rather than format). |
| `X-Amz-Credential` | Signature ID.<br/><br/>A string in `<access-key-id>/<YYYYMMDD>/{{ region-id }}/s3/aws4_request` format, where `<YYYYMMDD>` must match the date set in the `X-Amz-Date` header. |

## Creating pre-signed URLs {#creating-presigned-url}

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
<timestamp> + "\n" +
<scope> + "\n" +
Hex(Hash-SHA256(<CanonicalRequest>))
```

Where:

* `AWS4-HMAC-SHA256` — The hashing algorithm.
* `timestamp` — The current time in ISO 8601 format, for example: `20190801T000000Z`. The date specified must match the date in `scope` (by the value rather than format).
* `scope` — `<YYYYMMDD>/{{ region-id }}/s3/aws4_request`.
* `CanonicalRequest` — [A canonical request](#canonical-request). To include your request in the string, hash it using the SHA256 algorithm and convert it to hexadecimal format.

### Canonical request {#canonical-request}

General canonical request format:

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

The HTTP method used to send a request: `GET`, `PUT`, `HEAD`, or `DELETE`.

#### CanonicalURL {#canonical-url}

The URL-encoded path to the resource. For example, `/<bucket-name>/<object-key>`.

{% note info %}

Do not normalize the path. For example, an object may have a `some//strange//key//example` key, so normalizing the path to `/<bucket-name>/some/strange/key/example` invalidates the key.

{% endnote %}

#### CanonicalQueryString {#canonical-query-string}

The canonical query string must include all the query parameters of the destination URL, except `X-Amz-Signature`. The parameters in the string must be URL-encoded and sorted alphabetically.

Example:

```
X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=JK38EXAMPLEAKDID8%2F20190801%2F{{ region-id }}%2Fs3%2Faws4_request&X-Amz-Date=20190801T000000Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host
```

#### CanonicalHeaders {#canonical-headers}

A list of the request headers and their values.

Requirements:

- Each header is separated by the "\n" newline character.
- Header names must be lowercase.
- Headers must be sorted alphabetically.
- There may not be any extra spaces.
- The list must contain the `host` header and all the `x-amz-*` headers used in the request.

You can also add any of the request headers to the list. The more headers you sign, the safer your request is.

Example:

```
host:{{ s3-storage-host }}
x-amz-date:20190801T000000Z
```

#### SignedHeaders {#signed-headers}

A list of lowercase request header names, sorted alphabetically and separated by commas.

Example:

```
host;x-amz-date
```

### Pre-signed URLs {#composing-signed-url}

To create a pre-signed URL, {{ objstorage-name }} add the [parameters](#presigned-url-preview) required to authorize the request to the resource URL, including the `X-Amz-Signature` parameter with the calculated signature.

#### Example of composing a pre-signed URL for object download {#example-for-object-download}

Create a signed URL to download the `object-for-share.txt` object from `example-bucket` for an hour.

- Static key:

    ```
    access_key_id = 'JK38EXAMPLEAKDID8'
    secret_access_key = 'ExamP1eSecReTKeykdokKK38800'
    ```

- Canonical request:

    ```
    GET
    /example-bucket/object-for-share.txt
    X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=JK38EXAMPLEAKDID8%2F20190801%2F{{ region-id }}%2Fs3%2Faws4_request&X-Amz-Date=20190801T000000Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host
    host:{{ s3-storage-host }}
    
    host
    UNSIGNED-PAYLOAD
    ```

- String to sign:

    ```
    AWS4-HMAC-SHA256
    20190801T000000Z
    20190801/{{ region-id }}/s3/aws4_request
    2d2b4efefa9072d90a646afbc0fbaef4618c81396b216969ddfc2869db5aa356
    ```

- Signing key:

    ```
    sign(sign(sign(sign("AWS4" + "ExamP1eSecReTKeykdokKK38800","20190801"),"{{ region-id }}"),"s3"),"aws4_request")
    ```

    The `sign` function was introduced to indicate the method of key calculation that uses the [HMAC](https://en.wikipedia.org/wiki/HMAC) algorithm with the [SHA256](https://en.wikipedia.org/wiki/SHA-2) hash function.

- Signature:

    ```
    56bdf53a1f10c078c2b4fb5a26cefa670b3ea796567d85489135cf33e77783f0
    ```

- Pre-signed URL:

    ```
    https://{{ s3-storage-host }}/example-bucket/object-for-share.txt?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=JK38EXAMPLEAKDID8%2F20190801%2F{{ region-id }}%2Fs3%2Faws4_request&X-Amz-Date=20190801T000000Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=56bdf53a1f10c078c2b4fb5a26cefa670b3ea796567d85489135cf33e77783f0
    ```

## Examples of getting pre-signed links in tools {{ objstorage-name }} {#example-for-getting-in-tools}

{% list tabs %}

- Management console

  {% include [storage-get-link-for-download](../_includes_service/storage-get-link-for-download.md) %}

- AWS CLI

    You can also use AWS CLI to generate a link for object download. To do this, run the following command:

    ```
    aws s3 presign s3://<bucket-name>/<object-key> --endpoint-url "https://{{ s3-storage-host }}/" [--expires-in <value>]
    ```
  
    For a link to be generated properly, the `--endpoint-url` parameter pointing to {{ objstorage-name }} hostname is required. For details, see the [section about AWS CLI specifics](../tools/aws-cli.md#specifics). 

- boto3

    The example generates a pre-signed URL for downloading the `object-for-share` object from the `bucket-with-objects` bucket. The URL is valid for 100 seconds.

    ```python
    # coding=utf-8
    
    import boto3
    from botocore.client import Config
    
    
    ENDPOINT = "https://{{ s3-storage-host }}"
    
    ACCESS_KEY = "JK38EXAMPLEAKDID8"
    SECRET_KEY = "ExamP1eSecReTKeykdokKK38800"
    
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

