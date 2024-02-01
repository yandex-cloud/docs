# Accessing Object Storage API directly, bypassing the SDK

## Issue description {#case-description}
You need to interact directly with Object Storage, bypassing the SDKs available for different programming languages.

## Solution {#case-description}
The `Authorization` header for the service request has the format: `"Authorization: AWS <key_kd>:<signature>"`, where:
- `Authorization: AWS`: Constant value.
- `<key_id>`: ID of the service account's static access key (without angle brackets).
- `<signature>`: HMAC request signature using the SHA256 hashing function (without angle brackets).

Example:
`Authorization: AWS YCAJEsU4EP6Dyo6QiHhPHz4dO:/CQuut9oew7fUoKorITnCcg2VlA=`

{% note info %}

For more information about [request signatures](../../../storage/s3/signing-requests.md), see the documentation.

{% endnote %}

## Sample Object Storage request using `curl`

Uploading an object to a bucket:
```
file='file_name' ;\
bucket='bucket_name' ;\
resource="/${bucket}/${file}" ;\
contentType="uploaded object content-type" ;\
dateValue=`date -R` ;\
stringToSign="PUT\n\n${contentType}\n${dateValue}\n${resource}" ;\
s3Key='static_access_key_ID' ;\
s3Secret='secret_key' ;\
signature=`echo -en ${stringToSign} | openssl sha1 -hmac ${s3Secret} -binary | base64` ;\
curl -vvv -X PUT -T "${file}" \
  -H "Host: ${bucket}.storage.yandexcloud.net" \
  -H "Date: ${dateValue}" \
  -H "Content-Type: ${contentType}" \
  -H "Authorization: AWS ${s3Key}:${signature}" \
  https://${bucket}.storage.yandexcloud.net/${file}
```

Before sending the request, make sure to specify the following parameters:
- `file`: Name of the file to be uploaded to the bucket as an object.
- `bucket`: Name of the bucket to upload data to.
- `s3Key` and `s3Secret`: ID and secret of the [Static access key](../../../iam/operations/sa/create-access-key.md) of the service account.
- `contentType`: MIME type of the uploaded object, for example: `text/plain`.
