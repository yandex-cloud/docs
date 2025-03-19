---
title: Uploading a file via an HTML form
description: In this article, you will learn how to upload a file via an HTML form.
__system:
  dislikeVariants:
    - There is no answer to my question
    - The recommendations did not help
    - The page content does not match the title
    - Other
---

# Uploading a file via an HTML form


This section describes how to upload files from the browser to {{ objstorage-name }} using an HTML form.

{% note info %}

You cannot upload objects larger than 5 GB using the form (see [{#T}](limits.md)).
All form fields after the `file` field are ignored.

{% endnote %}


## Overview {#common-dscr}

If you want to allow your service users to upload files to your bucket directly from the browser:

1. Develop an HTML form with everything you need to send a request to {{ objstorage-name }} and place it on a page in your service.
1. The user opens your service page in the browser and uses the form to upload their file to the storage.

To set rules and restrictions for file uploads, attach your security policy to the form. You do not need a policy when your bucket has public write access with no restrictions.

To create a form, follow these steps:

1. Develop a [security policy](#policy) to describe the parameters of a request to {{ objstorage-name }}. For example, your policy may set a limit on the uploaded object size.
1. Generate a [signature](#signing-policy) based on the security policy.
1. Create an [HTML form](#html-form) with the signed security policy for your users to upload files.

## HTML form {#html-form}

Generic layout of an HTML page with an upload form:

```html
<html>
    <head>
        ...
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        ...
    </head>
    <body>
        ...
        <form action="https://{{ s3-storage-host }}/{bucket-name}" method="post" enctype="multipart/form-data">
            ...
            <input .../>
            ...
        </form>
        ...
    </body>
</html>
```

An HTML form is described in the `<form>` tag and consists of a declaration and some fields.

The form's declaration contains the following attributes:

* `action`: URL of the bucket to upload the object to.
* `method`: HTTP method that takes the `POST` value.
* `enctype`: Request contents type. that takes the `multipart/form-data` value.

The [form fields](#form-fields) contain a detailed description of the request to {{ objstorage-name }} and the [restrictions](#policy) that apply to it.

The form and its fields must be UTF-8 encoded. Set the `charset` attribute of your page's `<meta>` tag to `UTF-8`:

```html
<html>
    <head>
        ...
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        ...
```

### Form fields {#form-fields}

{{ objstorage-name }} supports form signing based on the AWS Signature V2 and V4. The chosen signature method determines the set of fields in the form and their names. The AWS Signature V2 is only supported for compatibility reasons. Avoid using it if possible.

Generic form layout:

{% list tabs %}

- AWS Signature V4

     ```html
     <form action="https://{{ s3-storage-host }}/{bucket-name}" method="post" enctype="multipart/form-data">
        Key in storage:
        <input type="input" name="key" value="object_key" /><br />
        <!-- Request properties -->
        <input type="hidden" name="X-Amz-Credential" value="access_key_id/date/{{ region-id }}/s3/aws4_request" />
        <input type="hidden" name="acl" value="predefined-acl-name" />
        <input type="hidden" name="X-Amz-Algorithm" value="AWS4-HMAC-SHA256" />
        <input type="hidden" name="X-Amz-Date" value="date" />
        <input type="hidden" name="success_action_redirect" value="some-URL" />
        <input type="hidden" name="policy" value="base64-encoded-policy-document" />
        <input type="hidden" name="X-Amz-Signature" value="signature-string" />
        <!-- Other required fields -->
        File to upload:
        <input type="file" name="file" /> <br />
        <!-- Fields after `file` are ignored -->
        <input type="submit" name="submit" value="Upload" />
    </form>
    ```

- AWS Signature V2

  ```html
   <form action="https://{{ s3-storage-host }}/{bucket-name}" method="post" enctype="multipart/form-data">
        Key in storage:
        <input type="input" name="key" value="object_key" />
        <!-- Request properties -->
        <input type="hidden" name="AWSAccessKeyId" value="access_key_id" />
        <input type="hidden" name="acl" value="access_type" />
        <input type="hidden" name="success_action_redirect" value="url" />
        <input type="hidden" name="policy" value="base64-encoded-policy-document" />
        <input type="hidden" name="signature" value="signature_string" />
        <input type="hidden" name="Content-Type" value="content/type" />
        <!-- Other required fields -->
        File to upload:
        <input type="file" name="file" /> <br />
        <!-- Fields after `file` are ignored -->
        <br />
        <input type="submit" value="Upload file" />
  </form>
  ```

{% endlist %}

{% note info %}

The following applies to the AWS Signature V4 only.

{% endnote %}

Description of form fields:

Field | Description | Required
-----|----------|--------------
`acl` | ACL for the object. You can set one of the [predefined ACLs](acl.md#predefined-acls). For example, if you want to make an object public, use `public-read`. | No
`Cache-Control` | Directives for caching data according to [RFC 2616](https://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.9). | No
`Content-​Disposition` | Name under which {{ objstorage-name }} will suggest to save the object as a file when downloaded, which is compliant with [RFC 2616](http://www.w3.org/Protocols/rfc2616/rfc2616-sec19.html#sec19.5.1). | No
`Content-Encoding` | Defines the content encoding according to [RFC 2616](https://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.11). | No
`Content-Type` | MIME type of the uploaded file. If you do not specify `Content-Type`, {{ objstorage-name }} will save the object as `application/octet-stream`. This can affect end user applications because they will not identify the file format, e.g., a browser will be unable to render an image. | No
`Expires` | Response expiration date, which is compliant with [RFC 2616](https://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.21). | No
`key` | [Object key](object.md#key).<br/><br/>You can enter the whole key or a template in `prefix/${filename}` format, i.e., if you upload a file named `some_file.jpg`, the final object key will be `prefix/some_file.jpg`. | Yes
`policy` | [Security policy](#policy) defining request permissions. Requests without a policy are treated as anonymous and are only processed for buckets with public write access. | Conditional
`X-Amz-Signature` | Signature of the policy to generate using a secret key.<br/><br/>It is required if the form has a security policy. | Conditional
`success_action_redirect` | URL the user is redirected to when the file is successfully uploaded. If the value is not set, {{ objstorage-name }} returns the response specified in the `success_action_status` field. | No
`success_action_status` | The response status after a successful upload.<br/><br/>If `success_action_redirect` is not specified, {{ objstorage-name }} returns `success_action_status`. The response body is empty.<br/><br/>Acceptable values include 200, 204 (default). | No
`X-Amz-Algorithm` | Security policy signature algorithm that takes the `AWS4-HMAC-SHA256` value.<br/><br/>It is required if the form has a security policy. | Conditional
`X-Amz-Credential` | Signature ID.<br/><br/>A string in `<access-key-id>/<date>/{{ region-id }}/s3/aws4_request` format, where `<date>` must match the `X-Amz-Date` field value and the date used to sign the policy.<br/><br/>It is required if the form has a security policy. | Conditional
`X-Amz-Date` | Date in ISO8601 format, e.g., `20180719T000000Z`. It must match the date in the `X-Amz-Credential` field (by value, not format) and the date used to sign the policy.<br/><br/>It is required if the form has a security policy. | Conditional
`X-Amz-Storage-Class` | [Storage class](storage-class.md) for the object. With an HTML form, you can only put an object in a standard storage. | No
`X-Amz-Meta-*` | User-defined object metadata.<br/><br/>{{ objstorage-name }} considers all headers starting with `X-Amz-Meta-` as user-defined and does not process them. Instead, it saves them in their original format.<br/><br/>The total size of user-defined headers must not exceed 2 KB. The size of user-defined data is determined as the length of the UTF-8 encoded string. The size includes header names and their values. | No
`X-Amz-Website-` `redirect-location` | If the bucket is configured as a [website](hosting.md), this field sets a redirect from the specified object to any other object in the bucket or any URL on the web. The redirect is stored in the object metadata. | No
`file` | Input field that allows the user to select a file to upload. This field must be the last field in the form. All fields after `file` are ignored. You cannot upload more than one file in a single request. | Yes


## Security policy {#policy}

The HTML form contains a security policy that restricts file uploads.

The security policy is a JSON document that may look as follows:

```json
{
    "expiration": "timestamp",
    "conditions": [
        {"bucket": "bucket-name"},
        ["starts-with", "$key", "users-uploads/"],
        {"acl": "public-read"},
        {"success_action_redirect": "http://localhost/"},
        ["starts-with", "$Content-Type", ""],
        ["content-length-range", 0, 1048576]
    ]
}
```

The `expiration` field contains the policy expiration date in [ISO8601](https://en.wikipedia.org/wiki/ISO_8601) format, e.g., `2019-07-22T15:39:36Z`. When the policy expires, {{ objstorage-name }} no longer accepts any files uploaded using the form.

The `conditions` field contains rules for the form fields. At least one rule must be specified for each form field.

Security policy rules may be of the following types:

Rule type | Description
------------|-----------
Exact match | The form field value must be exactly the same as in the policy.<br/><br/>Example: `{"acl": "public-read"}`. You can also use the alternative format: `[ "eq", "$acl", "public-read" ]`.
Partial match | The form field value must start with the string specified in the policy.<br/><br/>Example: `["starts-with", "$key", "key_prefix"]`. If an empty string is specified as a value, the field can take any value.<br/><br/>Example: `["starts-with", "$Content-Type", ""]`.
`content-length-range` | Size limit for the object to upload.<br/><br/>Example: `["content-length-range", 0, 1048576]`.

The possible restrictions include:

Element | Restriction type | Restriction scope
--------|-----------------|---------------------
`acl` | Exact and partial match. | `acl` form field.
`bucket` | Exact and partial match. | Bucket name.
`content-length-range` | `content-length-range` | `content-length-range`
`key` |  Exact and partial match. | `key` form field. It allows you to set the object key or prefix.
`success_action_redirect` |  Exact and partial match. | `success_action_redirect` form field.
`success_action_status` | Exact and partial match. | `success_action_status` form field.
`X-Amz-*` | Exact match. | `X-Amz-*` form fields, except `X-Amz-Meta-*`.
`X-Amz-Meta-*` |  Exact and partial match. | `X-Amz-Meta-*` form fields.
`Cache-Control`<br/>`Content-Disposition`<br/>`Content-Encoding`<br/>`Content-Type`<br/>`Expires` | Exact and partial match. | Form fields with the same names.

If the `key` field has a template format, the policy is applied after the user-defined file name is substituted into the template.

### Security policy signature {#signing-policy}

The common policy [signature algorithm](../s3/signing-requests.md) is as follows:

1. Encode the policy JSON document in [base64](https://en.wikipedia.org/wiki/Base64).
1. [Generate a signing key](../s3/signing-requests.md#signing-key-gen).
1. [Generate a policy signature](../s3/signing-requests.md#signing).


## Example of generating a form using boto3 {#example-generating-form}

The input conditions are as follows:

- Files must be saved into the `user-data` bucket with the `/users/upload/` prefix.
- Uploaded objects have public read access.
- If the upload is successful, the user is redirected to `https://example.com`.

To generate form fields, we will use [boto3](../tools/boto.md) SDK for Python:

```python
aws_access_key_id = 'JK38EXAMP********'
aws_secret_access_key = 'ExamP1eSecReTKeykdo********'
endpoint = 'https://{{ s3-storage-host }}'

s3 = boto3.client('s3',
                  aws_access_key_id=aws_access_key_id,
                  aws_secret_access_key=aws_secret_access_key,
                  region_name='{{ region-id }}',
                  endpoint_url=endpoint,
                  config=botocore.client.Config(signature_version='s3v4'),
                  )

key = 'users/uploads/${filename}'
bucket = 'user-data'
conditions = [{"acl":"public-read"}, ["starts-with", "$key", "users/uploads"], {'success_action_redirect': 'https://example.com'}]
fields = {'success_action_redirect': 'https://example.com'}

prepared_form_fields = s3.generate_presigned_post(Bucket=bucket,
                                                  Key=key,
                                                  Conditions=conditions,
                                                  Fields=fields,
                                                  ExpiresIn=60 * 60)


print(prepared_form_fields)
```


The script will return a JSON document in the following format:

```json
{
    'url': u'https://{{ s3-storage-host }}/user-data',
    'fields': {
        'X-Amz-Algorithm': 'AWS4-HMAC-SHA256',
        'X-Amz-Date': '20190722T153936Z',
        'success_action_redirect': 'https://example.com',
        'X-Amz-Signature': '4bdfb2209fc30744458be10bc3b99361f2f50add20f2ca2425587a27********',
        'key': 'users/uploads/${filename}',
        'policy': u'eyJjb25kaXRpb25zIj...M5OjM2WiJ9',
        'X-Amz-Credential': u'JK38EXAMP********/20190722/{{ region-id }}/s3/aws4_request'}
}
```

You can build an HTML page with a file upload form using the values from the returned document:

```html
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    </head>
    <body>
        <form action="https://{{ s3-storage-host }}/user-data" method="post" enctype="multipart/form-data">
            Key in storage:
            <input type="input"    name="key" value="users/uploads/${filename}" /><br />
            <input type="hidden"   name="X-Amz-Credential" value="JK38EXAMP********/20190722/{{ region-id }}/s3/aws4_request" />
            <input type="hidden"   name="acl" value="public-read" />
            <input type="hidden"   name="X-Amz-Algorithm" value="AWS4-HMAC-SHA256" />
            <input type="hidden"   name="X-Amz-Date" value="20190722T153936Z" />
            <input type="hidden"   name="success_action_redirect" value="https://example.com" />
            <input type="hidden"   name="policy" value="eyJjb25kaXRpb25zIj...M5OjM2WiJ9" />
            <input type="hidden" name="X-Amz-Signature" value="4bdfb2209fc30744458be10bc3b99361f2f50add20f2ca2425587a2722859f96" />
            File to upload:
            <input type="file"   name="file" /> <br />
            <input type="submit" name="submit" value="Upload" />
        </form>
    </body>
</html>
```
