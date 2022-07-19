# Upload a file via an HTML form

This section describes how to upload files from the browser to {{ objstorage-name }} using an HTML form.

{% note info %}

Objects larger than 5 GB can't be uploaded using a form (see [{#T}](limits.md)).

{% endnote %}

## Overview {#common-dscr}

If you want to let your service users upload files to your bucket directly from the browser:

1. You develop an HTML form with everything you need to send a request to {{ objstorage-name }} and put it on a page in your service.
2. The user opens your service page from the browser and uses the form to upload their file to storage.

To set rules and restrictions for file uploads, attach your security policy to the form. You don't need a policy when your bucket is publicly available for unrestricted writing.

To create a form, follow these steps:

1. Develop a [security policy](#policy) to describe the parameters of the request to {{ objstorage-name }}. For example, your policy may set a limit on the size of an uploaded object.
2. Generate a [signature](#signing-policy) based on the security policy.
3. Create an [HTML form](#html-form) with a signed security policy that you offer users when uploading files.

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

The HTML form is defined by the `<form>`  tag and consists of a declaration and fields.

The form declaration contains the following attributes:

* `action`: The URL of the bucket where the object is to be uploaded.
* `method`: The HTTP method. Value: `POST`.
* `enctype`: The content type of the request. Value: `multipart/form-data`.

[The form fields](#form-fields) contain a detailed description of the request to {{ objstorage-name }} and the [restrictions](#policy) that apply to it.

The form and its fields must be UTF-8 encoded. Set the `charset` attribute for the `<meta>` tag of your page to `UTF-8`.

```
<html>
    <head>
        ...
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        ...
```

### Form fields {#form-fields}

{{ objstorage-name }} supports form signing based on AWS Signature V2 and V4. The signature mechanism chosen determines the set of fields in the form and their names. AWS Signature V2 is only supported for compatibility reasons. Please avoid it if possible.

Generic form layout:

{% list tabs %}

- AWS Signature V4

     ```html
     <form action="https://{{ s3-storage-host }}/{bucket-name}" method="post" enctype="multipart/form-data">
        Key in storage:
        <input type="input" name="key" value="object_key"> /><br />
        <!-- Request properties -->
        <input type="hidden" name="x-amz-credential" value="access_key_id/date/{{ region-id }}/s3/aws4_request" />
        <input type="hidden" name="acl" value="predefined-acl-name" />
        <input type="hidden" name="x-amz-algorithm" value="AWS4-HMAC-SHA256" />
        <input type="hidden" name="x-amz-date" value="date" />
        <input type="hidden" name="success_action_redirect" value="some-URL" />
        <input type="hidden" name="policy" value="base64-encoded-policy-document" />
        <input type="hidden" name="x-amz-signature" value="signature-string" />
        <!-- Other required fields -->
        File to upload:
        <input type="file" name="file" /> <br />
        <!-- Fields after file are ignored -->
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
        <!-- Fields after file are ignored -->
        <br />
        <input type="submit" value="Upload file" />
  </form>
  ```

{% endlist %}

{% note info %}

The following applies to AWS Signature V4 only.

{% endnote %}

Description of form fields:

| Field | Description | Required |
| ----- | ---------- | -------------- |
| `acl` | ACL for the object. You can set one of the [predefined ACLs](acl.md#predefined-acls). For example, if you want to make an object public, use `public-read`. | No |
| `Cache-Control` | A set of directives for caching data according to [RFC 2616](https://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.9). | No |
| `Content-Disposition` | The name {{ objstorage-name }} suggests saving an object as a file under when it's downloaded. Compliant with [RFC 2616](http://www.w3.org/Protocols/rfc2616/rfc2616-sec19.html#sec19.5.1). | No |
| `Content-Encoding` | Defines content encoding according to [RFC 2616](https://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.11). | No |
| `Content-Type` | The MIME type of the uploaded file. If you don't specify `Content-Type`, {{ objstorage-name }} saves the object as an `application/octet-stream`. This can affect end user programs since they won't understand the file format (for example, a browser won't be able to render an image). | No |
| `Expires` | Response expiration date. Complaint with [RFC 2616](https://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.21). | No |
| `key` | [The object key](object.md#key).<br/><br/>You can enter your key completely or as a template in `prefix/${filename}` format. So, if you upload `some_file.jpg`, the final object key is `prefix/some_file.jpg`. | Yes |
| `policy` | [Security policy](#policy) defining request permissions. Requests without a policy are treated as anonymous and are only processed for buckets with public write access. | Conditional |
| `x-amz-signature` | The policy signature that has to be generated using the secret key.<br/><br/>It's required if the form has a security policy. | Conditional |
| `success_action_redirect` | The URL the user is redirected to when the file is successfully uploaded. If the value isn't set, {{ objstorage-name }} returns the response specified in the `success_action_status` field. | No |
| `success_action_status` | The response status after a successful upload.<br/><br/>If `success_action_redirect` isn't specified, {{ objstorage-name }} returns `success_action_status`. The response body is empty.<br/><br/>Acceptable values: 200, 204 (default). | No |
| `x-amz-algorithm` | The security policy signature algorithm. Value: `AWS4-HMAC-SHA256`.<br/><br/>Required if the form has a security policy. | Conditional |
| `x-amz-credential` | Signature ID.<br/><br/>A string in `<access-key-id>/<date>/{{ region-id }}/s3/aws4_request` format, where `<date>` must match the `x-amz-date` field value and the date used to sign the policy.<br/><br/>Required if the form has a security policy. | Conditional |
| `x-amz-date` | Date in ISO8601 format, for example: `20180719T000000Z`. It must match the date in the `x-amz-credential` field (by the value rather than format) and the date used to sign the policy.<br/><br/>Required if the form has a security policy. | Conditional |
| `x-amz-storage-class` | [The storage class](storage-class.md) for the object. With an HTML form, you can only put an object in standard storage. | No |
| `x-amz-meta-*` | User-defined object metadata.<br/><br/>{{ objstorage-name }} considers all headers starting with `x-amz-meta-` as user-defined. It doesn't process these headers. Instead, it saves them in their original format.<br/><br/>The total size of user-defined headers must not exceed 2 KB. The size of user-defined data is determined as the length of the UTF-8 encoded string. The header names and their values are included when calculating the size. | No |
| `x-amz-website-` `redirect-location` | If the bucket is configured as a [website](hosting.md), this field sets a redirect from the specified object to any other object in the bucket or any URL on the internet. The redirect is saved in the metadata of the object. | No |
| `file` | An input field that lets the user select a file to upload. This field must be the last field in the form. All fields given after `file` are ignored. You can't upload more than one file in a single request. | Yes |

## Security policy {#policy}

The HTML form contains a security policy that puts restrictions on uploadable files.

The security policy is a JSON document and may look like the following:

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

The `expiration` field contains the policy expiration date in [ISO8601](https://en.wikipedia.org/wiki/ISO_8601) format, for example, `2019-07-22T15:39:36Z`. When the policy expires, {{ objstorage-name }} no longer accepts any files uploaded from the form.

The `conditions` field contains a set of rules for the form fields. At least one rule must be specified for each form field.

Security policy rules can be of the following types:

| Rule type | Description |
| ------------ | ----------- |
| Exact match | The form field value must be exactly the same as in the policy.<br/><br/>For example, `{"acl": "public-read"}`. An alternative format is also supported: `["eq", "$acl", "public-read" ]`. |
| Partial match | The form field value must start with the string specified in the policy.<br/><br/>For example, `["starts-with", "$key", "key_prefix"]`. If an empty string is specified as a value, the field can take any value.<br/><br/>For example, `["starts-with", "$Content-Type", ""]`. |
| `content-length-range` | The size limit of the object to upload.<br/><br/>For example, `["content-length-range", 0, 1048576]`. |

Possible restrictions:

| Element | Restriction type | Restriction scope |
| -------- | ----------------- | --------------------- |
| `acl` | Exact and partial match. | The `acl` field in the form. |
| `bucket` | Exact and partial match. | Bucket name. |
| `content-length-range` | `content-length-range` | `content-length-range` |
| `key` | Exact and partial match. | The `key` field in the form. It lets you set the object key or prefix. |
| `success_action_redirect` | Exact and partial match. | The `success_action_redirect` field in the form. |
| `success_action_status` | Exact and partial match. | The `success_action_status` field in the form. |
| `x-amz-*` | Exact match. | The `x-amz-*` fields in the form, except `x-amz-meta-*`. |
| `x-amz-meta-*` | Exact and partial match. | `x-amz-meta-*` fields in the form. |
| `Cache-Control`<br/>`Content-Disposition`<br/>`Content-Encoding`<br/>`Content-Type`<br/>`Expires` | Exact and partial match. | Form fields with the same names. |

If `key` is a template field, the policy is applied after the user-specified file name is put into the template.

### Security policy signature {#signing-policy}

Common [policy signature](../s3/signing-requests.md) algorithm:

1. Encode the policy JSON document in [base64](https://en.wikipedia.org/wiki/Base64).
2. [Generate a signing key](../s3/signing-requests.md#signing-key-gen).
3. [Generate a policy signature](../s3/signing-requests.md#signing).

## Example of generating a form using boto3 {#example-generating-form}

Input conditions:

- Files must be saved in the `user-data` bucket with the `/users/upload/` prefix.
- Uploaded objects are publicly accessible for reading.
- If the upload is successful, the user is redirected to `https://example.com`.

To generate form fields, we use [boto3](../tools/boto.md) from the Python SDK:

```python
aws_access_key_id = 'JK38EXAMPLEAKDID8'
aws_secret_access_key = 'ExamP1eSecReTKeykdokKK38800'
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

The script returns a JSON document in the following format:

```json
{
    'url': u'https://{{ s3-storage-host }}/user-data',
    'fields': {
        'x-amz-algorithm': 'AWS4-HMAC-SHA256',
        'x-amz-date': '20190722T153936Z',
        'success_action_redirect': 'https://example.com',
        'x-amz-signature': '4bdfb2209fc30744458be10bc3b99361f2f50add20f2ca2425587a2722859f96',
        'key': 'users/uploads/${filename}',
        'policy': u'eyJjb25kaXRpb25zIj...M5OjM2WiJ9',
        'x-amz-credential': u'JK38EXAMPLEAKDID8/20190722/{{ region-id }}/s3/aws4_request'}
}
```

Using the values from the returned document, you can build an HTML page with a file upload form:

```html
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    </head>
    <body>
        <form action="https://{{ s3-storage-host }}/user-data" method="post" enctype="multipart/form-data">
            Key in storage:
            <input type="input"    name="key" value="users/uploads/${filename}" /><br />
            <input type="hidden"   name="x-amz-credential" value="JK38EXAMPLEAKDID8/20190722/{{ region-id }}/s3/aws4_request" />
            <input type="hidden"   name="acl" value="public-read" />
            <input type="hidden"   name="x-amz-algorithm" value="AWS4-HMAC-SHA256" />
            <input type="hidden"   name="x-amz-date" value="20190722T153936Z" />
            <input type="hidden"   name="success_action_redirect" value="https://example.com" />
            <input type="hidden"   name="policy" value="eyJjb25kaXRpb25zIj...M5OjM2WiJ9" />
            <input type="hidden" name="x-amz-signature" value="4bdfb2209fc30744458be10bc3b99361f2f50add20f2ca2425587a2722859f96" />
            File to upload:
            <input type="file"   name="file" /> <br />
            <input type="submit" name="submit" value="Upload" />
        </form>
    </body>
</html>
```

