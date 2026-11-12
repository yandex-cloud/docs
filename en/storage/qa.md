---
title: FAQ about {{ objstorage-full-name }}
description: This page covers questions and answers about {{ objstorage-name }}.
---

# FAQ about {{ objstorage-name }}

* [What is {{ objstorage-full-name }}?](#qa-what-is)
* [What can I do with {{ objstorage-full-name }}?](#qa-usecases)
* [How do I get started with {{ objstorage-full-name }}?](#qa-quickstart)
* [What data formats can I store?](#qa-data-types)
* [How can I leave feedback on {{ objstorage-full-name }}?](#qa-feedback)
* [How do I contact support?](#qa-support-channels)
* [How much data can I store?](#qa-storage-volume)
* [Why are objects not uploading, even though the maximum bucket size has not been reached yet?](#qa-upload-storage-quota)
* [How can I delete multiple objects at a time?](#qa-delete-multiple-objects)
* [A service account cannot access a bucket, why is that?](#sa-bucket-access)
* [What does {{ yandex-cloud }} do with the data I store in {{ objstorage-full-name }}?](#qa-data-use-by-platform)
* [Does Yandex use {{ objstorage-name }} to store its own data?](#qa-usage-by-yandex)
* [What data consistency model does {{ objstorage-full-name }} use?](#qa-consistency)
* [What AWS S3 features are supported in {{ objstorage-full-name }}?](#qa-s3-support)
* [Where is my data stored?](#qa-where)
* [How is my data protected in {{ objstorage-full-name }}?](#qa-data-security)
* [What the speed of data upload and download in {{ objstorage-full-name }} depends on?](#qa-timings)
* [How do I add my own domain to an {{ objstorage-name }} bucket?](#domain-bucket)
* [Why did I lose access to the bucket after creating/updating a bucket policy?](#qa-lost-access)
* [How do I get access to {{ objstorage-name }} from a {{ vpc-name }} cloud network?](#qa-from-vpc)
* [Do objects uploaded to a bucket get scanned for sensitive data and malicious code?](#anti-malware)
* [How do I fix an incorrect MIME type of objects when uploading them to a bucket?](#qa-mime-type)
* [How do I configure a cache-control header for objects in a bucket?](#cache-control)
* [How do I copy bucket contents to another bucket?](#copy-bucket)
* [How do I restore deleted objects?](#recover-deleted-objects)
* [How do I change the storage class of objects?](#change-storage-class)
* [How do I allow reading objects only from {{ cdn-name }} networks?](#cdn-only-access)
* [How do I fix the SignatureDoesNotMatch error?](#signature-does-not-match)
* [Why do I get the `Bucket is not empty` error when deleting a bucket?](#bucket-not-empty)
* [Why the OPTIONS request returns error 403 without the Access-Control-Allow-Origin header?](#cors-error)
* [How do I fix the certificate error when using my own domain?](#wrong-certificate)
* [Why do I get the BucketAlreadyExists error when creating a bucket?](#bucket-already-exists)

#### What is {{ objstorage-full-name }}? {#qa-what-is}

{{ objstorage-full-name }} is a universal scalable solution for data storage. It is equally effective for high-load services requiring reliable and fast access to data as well as for projects that do not need any complex storage infrastructure.

#### What can I do with {{ objstorage-full-name }}? {#qa-usecases}

With {{ objstorage-name }}, you can:
* Store your project (website or server app) files in {{ objstorage-name }} with public or private access to them. The files can be of any format.
* Store large archive data (up to 5 TB per file) and make them available based on access permissions.
* Enable shared work with data inside a distributed organization.
* Make your data accessible from anywhere in the world where there is internet.

#### How do I get started with {{ objstorage-full-name }}? {#qa-quickstart}

To get started with {{ objstorage-name }}:
1. Sign up for {{ yandex-cloud }}.
1. Create a folder.
   At this step, you can already use {{ objstorage-name }} via the {{ yandex-cloud }} management console. You can create and delete buckets, as well as upload objects to and download them from buckets.
1. Get static keys to use the {{ objstorage-name }} HTTP API or ready-made SDKs and apps.

You can find a more detailed guide in [{#T}](quickstart.md) and [{#T}](s3/index.md).

#### What data formats can I store? {#qa-data-types}

You can store data in any format. {{ objstorage-full-name }} saves data in its original form without any modification.

#### How can I leave feedback on {{ objstorage-full-name }}? {#qa-feedback}



Use the feedback form in the [support center]({{ link-console-support }}).



#### How do I contact support? {#qa-support-channels}



You can contact technical support from the management console in the [Support]({{ link-console-support }}) section.



#### How much data can I store? {#qa-storage-volume}

See [{#T}](concepts/limits.md).

#### Why are objects not uploading, even though the maximum bucket size has not been reached yet? {#qa-upload-storage-quota}

Your cloud's **{{ ui-key.yacloud_quotas.quotas.storage.volume.size-key-value }}** [quota](concepts/limits.md#storage-quotas) (`storage.volume.size`) may be exhausted. The management console may display this error message: `We encountered an internal error, please try again`.

[Maximum bucket size](operations/buckets/limit-max-volume.md) limits data size in an individual bucket, whereas the `storage.volume.size` quota limits total data size across all buckets in the cloud. Increasing the maximum bucket size does not change the cloud quota.

For example, if the maximum bucket size is 500 GB and the cloud quota is 100 GB, new object uploads may fail once 100 GB total size is reached across all the cloud's buckets.

1. [View the `storage.volume.size` quota value and consumption](../quota-manager/operations/read-quotas.md) for the cloud the bucket resides in.
1. If the quota is exhausted or the remaining amount is not enough for the upload, [request a quota increase](../quota-manager/operations/set-quotas.md).
1. After the quota is increased, reupload the objects.

#### How can I delete multiple objects at a time? {#qa-delete-multiple-objects}

You can delete multiple objects via the {{ yandex-cloud }} management console or the API using the [deleteMultipleObjects](s3/api-ref/object/deletemultipleobjects.md) method.

#### A service account cannot access a bucket, why is that? {#sa-bucket-access}


Make sure the service account has the [role](./security/#roles-list) that allows accessing the bucket.


If [encryption](./concepts/encryption.md) is enabled for the bucket, assign the service account the `kms.keys.encrypterDecrypter` [role](../kms/security/#service) for the [{{ kms-short-name }} key](../kms/concepts/key.md) used to encrypt the bucket. You can do this, for example, using the following CLI command:

```bash
yc kms symmetric-key add-access-binding \
  --id <key_ID> \
  --service-account-id <service_account_ID> \
  --role kms.keys.encrypterDecrypter
```

Where:
* `--id`: {{ kms-short-name }} key ID.
* `--service-account-id`: Service account ID.


#### What does {{ yandex-cloud }} do with the data I store in {{ objstorage-full-name }}? {#qa-data-use-by-platform}

The data is saved in the original form as transmitted by the user.


#### Does Yandex use {{ objstorage-name }} to store its own data? {#qa-usage-by-yandex}

Yes. {{ objstorage-name }} is used in the Yandex infrastructure. A number of Yandex services store their websites' static data in {{ objstorage-name }}.


#### What data consistency model does {{ objstorage-full-name }} use? {#qa-consistency}

For overwritable (PUT) and removable (DELETE) objects, the strong consistency model is used.

#### What AWS S3 features does {{ objstorage-full-name }} support? {#qa-s3-support}

{{ objstorage-name }} supports:
* Authorization using static tokens.
* Some HTTP API methods. For a full list of supported methods, see the [API reference](s3/api-ref/index.md).


#### Where is my data stored? {#qa-where}




#### How is my data protected in {{ objstorage-full-name }}? {#qa-data-security}

Physical media are located in {{ yandex-cloud }} data centers, which are high-security facilities.

Data is stored in an encrypted format and none of those who have access to the physical media can read the data.

By default, the storage is accessed via HTTPS.

#### What does the speed of data upload and download in {{ objstorage-full-name }} depend on? {#qa-timings}

The {{ objstorage-name }} response time depends on multiple factors:
* Client-side performance: network speed, CPU load, or disk subsystem load.
* Speed of trunks, data center interconnects, or client-server connections.
* Performance of {{ objstorage-name }} itself.

This is why we cannot specify a particular response time value. However, we keep track of spikes in the response time and dips in the speed of sending data, and strive to improve the {{ objstorage-name }} performance.


{% include [logs.md](../_qa/logs.md) %}


#### How do I add my own domain to an {{ objstorage-name }} bucket? {#domain-bucket}

To [add](operations/hosting/own-domain.md) your domain to a [bucket](concepts/bucket.md):

1. [Create](operations/buckets/create.md) a bucket with the same name as your domain.

1. {% include [setup-bucket.md](../_includes/storage/setup-bucket.md) %}

1. On your DNS server, [create](operations/hosting/own-domain.md#domain-support) a CNAME record to link your domain to the bucket.

1. {% include [create-cert.md](../_includes/storage/create-cert.md) %}

1. {% include [add-cert.md](../_includes/storage/add-cert.md) %}

{% include [objects-access.md](../_includes/storage/objects-access.md) %}


#### Why did I lose access to the bucket after creating/updating a bucket policy? {#qa-lost-access}

If you get the `Access Denied` error after configuring an access policy or the list of objects is not displayed, check the policy rules.

The possible causes include:

* [Bucket policies](concepts/policy.md) treat objects within a bucket and the bucket itself as different resources. For a bucket policy rule to apply both to the bucket and the objects in it, specify them as separate resources, e.g., `samplebucket` and `samplebucket/*`.

* If a bucket policy with no rules is applied to the bucket, access is denied to all users. To disable request verification for a bucket policy, [delete](operations/buckets/policy.md#delete-policy) it.


* If a [{{ metastore-full-name }}](../metadata-hub/concepts/metastore.md) or [{{ maf-full-name }}](../managed-airflow/concepts/index.md) cluster uses a bucket with the bucket policy configured, the cluster will not be able to write or read to/from the bucket without a service account with the appropriate role. For more information, see the [{{ metastore-name }}](../metadata-hub/operations/metastore/s3-policy-connect.md) and [{{ maf-name }}](../managed-airflow/operations/s3-policy-connect.md) guides.


#### How do I get access to {{ objstorage-name }} from a {{ vpc-name }} cloud network? {#qa-from-vpc}

For resources hosted in a {{ vpc-short-name }} cloud network and having no public IP address or internet access, you can [set up a connection](../tutorials/routing/storage-vpc-access.md) to {{ objstorage-name }} via an [API endpoint](../api-design-guide/concepts/endpoints.md). The FQDN of the endpoint will be translated to a public IP address using DNS.


#### Do objects uploaded to a bucket get scanned for sensitive data and malicious code? {#anti-malware}

{{ objstorage-name }} does not scan uploaded objects for sensitive data or malicious code.

Implement your own malicious code checks before uploading objects to a bucket.

To discover sensitive data in a bucket, use [Data Security Posture Management ({{ dspm-name }}) in {{ sd-full-name }}](../security-deck/concepts/dspm.md).


#### How do I fix an incorrect MIME type of objects when uploading them to a bucket? {#qa-mime-type}

If the bucket is used for [website hosting](./concepts/hosting.md), an incorrect object [MIME type](https://en.wikipedia.org/wiki/Media_type) may cause website errors, such as unrendering images or failing scripts.

In such cases, the developer console of your browser shows invalid MIME type errors for objects uploaded from the bucket.

Depending on the method of uploading objects to the bucket, the [Content-Type](./s3/api-ref/common-request-headers.md) header may be set automatically, but not always correctly, e.g., to `text/plain` instead of `text/css`, or to the default `binary/octet-stream`.

To avoid errors, explicitly set the `Content-Type` header when uploading objects to the bucket:

{% list tabs %}

- CLI

  {% include [cli-install](../_includes/cli-install.md) %}

  {% include [default-catalogue](../_includes/default-catalogue.md) %}

  1. See the description of the command for uploading an object:

     ```bash
     yc storage s3api put-object --help
     ```

  1. Upload your file with an explicitly specified MIME type:

     ```bash
     yc storage s3api put-object \
       --bucket <bucket_name> \
       --key <object_key> \
       --body <local_file_path> \
       --content-type "application/javascript"
     ```

     Where `--bucket` and `--key` are the required parameters: bucket name and object key. The `--body` parameter sets the path to the file to upload. The optional `--content-type` parameter explicitly sets the MIME type. The example uses the type for JavaScript.

- AWS CLI

  ```bash
  aws s3 cp \
    <local_file_path> \
    s3://<bucket_name>/ \
    --no-guess-mime-type \
    --content-type "application/javascript" \
    --endpoint-url=https://{{ s3-storage-host }}
  ```

- s3cmd

  ```bash
  s3cmd put \
    --no-guess-mime-type \
    --no-mime-magic \
    --mime-type="application/javascript" \
    <local_file_path> \
    s3://<bucket_name>/
  ```

{% endlist %}

You can also change the `Content-Type` header for already uploaded objects. Here is an example:

{% list tabs %}

- AWS CLI

  ```bash
  aws s3 cp \
    s3://<bucket_name>/ \
    s3://<bucket_name>/ \
    --exclude '*' \
    --include '*.js' \
    --no-guess-mime-type \
    --content-type="application/javascript" \
    --metadata-directive="REPLACE" \
    --recursive \
    --endpoint-url=https://{{ s3-storage-host }}
    ```

- s3cmd

  ```bash
  s3cmd modify \
    --recursive \
    --exclude '*' \
    --include '*.js' \
    --no-guess-mime-type \
    --no-mime-magic \
    --mime-type="application/javascript" \
    s3://<bucket_name>/
  ```

{% endlist %}

#### How do I configure a cache-control header for objects in a bucket? {#cache-control}

The `Cache-Control` header is [an object’s system metadata](concepts/object.md#metadata). You can specify it when uploading the object or update it for an already uploaded object.

You can use [**s3cmd**](tools/s3cmd.md) to add the header when uploading the file:

```bash
s3cmd --add-header 'Cache-Control:max-age=3600' \
  put <local_file_path> s3://<bucket_name>/<object_key>
```

For an already uploaded object:

```bash
s3cmd --add-header 'Cache-Control:max-age=3600' \
  modify s3://<bucket_name>/<object_key>
```

Example of uploading via the [**AWS CLI**](tools/aws-cli.md):

```bash
aws --endpoint-url=https://{{ s3-storage-host }} s3 cp \
  <local_file_path> s3://<bucket_name>/<object_key> \
  --cache-control 'max-age=3600'
```

In the examples above, the caching time is 3,600 seconds.

#### How do I copy bucket contents to another bucket? {#copy-bucket}

You can copy bucket content to another bucket in the same folder, other folder, cloud, or organization. To do this, you need read permissions for the source bucket objects and write permissions for the target bucket. When copying all objects, you also need access to the list of objects in the source.

Example for the [**AWS CLI**](tools/aws-cli.md):

```bash
aws --endpoint-url=https://{{ s3-storage-host }} s3 cp \
  s3://<source_bucket>/ s3://<target_bucket>/ \
  --recursive
```

For copying between organizations, the following approaches are available:

* Using the {{ yandex-cloud }} CLI, on behalf of a [Yandex account](../iam/concepts/users/accounts.md#passport) that has the required permissions in both organizations:

  ```bash
  yc storage s3 cp \
    s3://<source_bucket>/ s3://<target_bucket>/ \
    --recursive
  ```

  Before running the command, [install and configure the CLI](../cli/quickstart.md).

* Using the AWS CLI, on behalf of a service account with permissions for the target bucket if [public reading of objects and their list](operations/buckets/bucket-availability.md) is allowed in the source bucket. This approach is suitable only for data that can be made publicly available.

If the objects are not encrypted, they are copied on the server side, including copying between organizations. For encrypted objects, there are certain nuances described in [{#T}](operations/objects/copy.md).

Commands copy objects and save them in the source bucket. When data is migrated, source objects are deleted separately once their copy is verified.

#### How do I restore deleted objects? {#recover-deleted-objects}

If [versioning](concepts/versioning.md) was enabled during the object upload and the required version is preserved, you can [restore](operations/objects/restore-object-version.md) it.

If the object could not be restored, create a [support request]({{ link-console-support }}). Specify the bucket name, approximate date and time of the deletion, names of the objects, and links to them.

{% note warning %}

Support does not guarantee recovery of the data deleted by the user. While engineers are working on the request, do not write new data to the affected bucket.

{% endnote %}

#### How do I change the storage class of objects? {#change-storage-class}

A [storage class](concepts/storage-class.md) specified in bucket properties applies to new objects only if the upload tool does not explicitly specify another class. For example, by default, you can upload a standard class object to an ice class bucket.

For already uploaded objects, changing the bucket setting does not change the storage class. To change it, you can:

* Set up [lifecycle rules](operations/buckets/lifecycles.md) for transition to a colder storage class.
* Reupload the object with the required class or copy it using the same key, indicating the new class using an [S3 client](tools/index.md).

#### How do I allow reading objects only from {{ cdn-name }} networks? {#cdn-only-access}

{% include [cdn-only-access](../_includes/storage/cdn-only-access.md) %}

#### How do I fix the `SignatureDoesNotMatch` error? {#signature-does-not-match}

The `The request signature we calculated does not match the signature you provided` error may occur when working via an S3 client or SDK if you specified a wrong [static access key](../iam/concepts/authorization/access-key.md). Check the ID and secret part of the key as well as their format in client settings.

Repeat the operation using the [AWS CLI](tools/aws-cli.md) with the `--debug` parameter for diagnostics. The output will show intermediate results of signature calculation that you can use to identify the error cause.

If the error persists, create a [support ticket]({{ link-console-support }}) and attach the debug output. Before sending, delete all secret keys and other confidential information from it.

#### Why do I get the `Bucket is not empty` error when deleting a bucket? {#bucket-not-empty}

You can only delete an empty bucket. The `Bucket is not empty` error occurs if it still contains objects, their versions, deletion markers, or incomplete multipart uploads.

To clean up the bucket:

* [Delete all objects, their versions, and deletion markers](operations/objects/delete-all.md). This guide contains examples for the CLI, AWS CLI, and Python (boto3).
* [Delete incomplete multipart uploads](operations/objects/deleting-multipart.md).

You can also configure the cleanup using [lifecycle rules](operations/buckets/lifecycles.md). They are processed asynchronously, so it may take some time to free up the bucket.

#### Why does the OPTIONS request return error 403 without the Access-Control-Allow-Origin header? {#cors-error}

Check the [CORS configuration](operations/buckets/cors.md) in the bucket and the [OPTIONS request](s3/api-ref/object/options.md) headers:

* The `Origin` header must contain the request source, e.g., `https://example.com` allowed in `AllowedOrigin`.
* The `Access-Control-Request-Method` header must contain the further request method allowed in `AllowedMethod`.
* If the request provides `Access-Control-Request-Headers`, the listed headers must be allowed in `AllowedHeader`. To allow all headers, `*` is used.

If the source or method is not allowed, {{ objstorage-name }} returns error 403 without `Access-Control-*` headers.


#### How do I fix the certificate error when using my own domain? {#wrong-certificate}

The`err_cert_common_name_invalid` and `ssl_error_bad_cert_domain` errors may occur when the CNAME record for the website domain points to `<bucket_name>.{{ s3-storage-host }}`. For [website hosting](operations/hosting/own-domain.md), it must point to `<bucket_name>.{{ s3-web-host }}`.

Check the CNAME record and [HTTPS setting](operations/hosting/certificate.md): certificate must match the website domain.

#### Why do I get the `BucketAlreadyExists` error when creating a bucket? {#bucket-already-exists}

The `409 BucketAlreadyExists` error means that the bucket name is already taken. Bucket names are unique within the region and its endpoint, including between folders, clouds, and organizations.

Select another name and repeat the creation attempt. The naming requirements are provided in [Bucket naming rules](concepts/bucket.md#naming).
