# How to directly access the {{ objstorage-name }} API without using SDK


## Case description {#case-description}

You need to exchange data directly with {{ objstorage-name }}, bypassing the SDKs for supported programming languages.

## Solution {#case-resolution}

The `Authorization` header for the API request has the format: `"Authorization: AWS <key_ID>:<signature>"`, where:

* `Authorization: AWS`: Constant value.
* `<key_ID>`: ID of the service account's static access key (without angle brackets).
* `<signature>`: HMAC request signature using the SHA-256 hashing algorithm (without angle brackets).

Example:
`Authorization: AWS YCAJEsU4EP6Dyo6QiHhPHz4dO:/CQuut9oew7fUoKorITnCcg2VlA=`

{% note info %}

For more information about request signatures, see [this article](../../../storage/s3/signing-requests.md).

{% endnote %}

## Sample {{ objstorage-name }} request using `curl`

Uploading an object to a bucket:

```
file='file_name' ;\
bucket='bucket_name' ;\
resource="/${bucket}/${file}" ;\
contentType="content_type_of_the_object_to_upload" ;\
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

Before running your request, make sure to specify the following:

* `file`: Name of the file to upload to the bucket as an object.
* `bucket`: Name of the bucket to upload data to. 
* `s3Key` and `s3Secret`: ID and secret of the service account's [static access key](../../../iam/operations/authentication/manage-access-keys.md#create-access-key).
* `contentType`: MIME type of the object being uploaded, e.g., `text/plain`.
