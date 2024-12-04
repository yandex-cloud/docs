---
title: Signing requests
description: Follow this guide to set up request signature.
---

# Signing requests


Many requests to {{ objstorage-name }} require authentication on the service side, so the user sending a request must sign it.

{{ objstorage-name }} supports [AWS Signature V4](https://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-authenticating-requests.html).

The signing process consists of the following stages:

1. [Generating a string to sign](#string-to-sign-gen).
1. [Generating a signing key](#signing-key-gen).
1. [Signing a string with a key](#signing).

Use [HMAC](https://ru.wikipedia.org/wiki/HMAC) with the [SHA256](https://ru.wikipedia.org/wiki/SHA-2) hash function to sign. Many programming languages support relevant methods. The examples assume that there is a `sign(KEY, STRING)` function that encodes the input string with the specified key.

## Generate a string to sign {#string-to-sign-gen}

The string to sign (`StringToSign`) depends on the {{ objstorage-name }} usage scenario:

* [Accessing an Amazon S3-compatible API](./index.md) without an SDK or special utilities.
* [Uploading objects using an HTML form](../concepts/presigned-post-forms.md).
* [Signing a URL with query parameters](../concepts/pre-signed-urls.md).

## Generating a signing key {#signing-key-gen}

To generate a signing key, you need static access keys for {{ objstorage-name }}. To learn how to get them, see [Getting started](index.md#before-you-begin).

{% include [generate-signing-key](../../_includes/storage/generate-signing-key.md) %}

## Sign a string with a key {#signing}

To get a string signature, use `HMAC` with the `SHA256` hash function and convert the result to hexadecimal format.

```text
signature = Hex(sign(SigningKey, StringToSign))
```

## Debugging using the AWS CLI {#debugging}

To debug the process of generating a [canonical request](../concepts/pre-signed-urls.md#canonical-request), [signature string](../concepts/pre-signed-urls.md#composing-string-to-sign), and [signing key](../concepts/pre-signed-urls.md#signing-key-gen), use the [AWS CLI](../tools/aws-cli.md) utility with the `--debug` parameter. 

{% note info %}

Make sure that the service account you are using to run `aws` commands has the permissions required to perform the requested actions. For example, to create a bucket, [assign](../../iam/operations/sa/assign-role-for-sa.md) the `storage.editor` [role](../security/index.md#storage-uploader) for the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to the service account. For more information, see [{#T}](../security/overview.md).

{% endnote %}

{% list tabs group=instructions %}

- AWS CLI {#aws-cli}

  In the terminal, run the bucket creation command and see how request parameters are generated:

  ```bash
  aws s3api create-bucket \
    --endpoint-url=https://{{ s3-storage-host }} \
    --bucket <bucket_name> \
    --debug
  ```

  Result:

  ```text
  2024-06-03 13:02:36,238 - MainThread - botocore.auth - DEBUG - CanonicalRequest:
  PUT
  /<bucket_name>

  host:{{ s3-storage-host }}
  x-amz-content-sha256:e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b********
  x-amz-date:20240603T100236Z

  host;x-amz-content-sha256;x-amz-date
  e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b********

  2024-06-03 13:02:36,238 - MainThread - botocore.auth - DEBUG - StringToSign:
  AWS4-HMAC-SHA256
  20240603T100236Z
  20240603/{{ region-id }}/s3/aws4_request
  7877a13bafaa45f9751e7f345b64a63acc6de279ff927736e906d7c5********

  2024-06-03 13:02:36,238 - MainThread - botocore.auth - DEBUG - Signature:
  90545034742d1e057c8eeb2cca3c23a38a3ced5ef847f61ac80cb8e1********
  ```

{% endlist %}

#### See also {#see-also}

* [Example of sending a signed request using curl](../api-ref/authentication.md#s3-api-example)
* [Example of signature generation code](../concepts/pre-signed-urls.md#code-examples)