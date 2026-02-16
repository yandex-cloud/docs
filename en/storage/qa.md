---
title: FAQ about {{ objstorage-full-name }}
description: This page covers FAQ about {{ objstorage-name }}.
---

# FAQ about {{ objstorage-name }}

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



#### How do I contact support? {qa-support-channels}



You can contact technical support from the management console in the [Support]({{ link-console-support }}) section.



#### How much data can I store? {#qa-storage-volume}

See [{#T}](concepts/limits.md).

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

Data is stored in several geographically distributed data centers located in Russia. For more information, see [{#T}](../overview/concepts/geo-scope.md).


#### How is my data protected in {{ objstorage-full-name }}? {#qa-data-security}

Physical media are located in {{ yandex-cloud }} data centers, which are high-security facilities.

Data is stored in an encrypted format and none of those who have access to the physical media can read the data.

By default, the storage is accessed via HTTPS.

#### How do you guarantee the performance of {{ objstorage-full-name }}? {#qa-timings}

{{ objstorage-name }} has internal SLAs and SLOs that guarantee a specific speed of sending data to the customer, which, among other things, depend on the storage class.

The {{ objstorage-name }} response time depends on multiple factors:
* Client-side performance (network speed, CPU load, or disk subsystem load).
* Speed of trunks, connections between data centers, or client-server connections.
* Performance of {{ objstorage-name }} itself.

This is why we cannot specify a particular response time value. However, we keep track of spikes in the response time and dips in the speed of sending data, and strive to improve the {{ objstorage-name }} performance.

{% include [fz-152.md](../_qa/fz-152.md) %}

{% include [logs.md](../_qa/logs.md) %}


#### How do I add my own domain to an {{ objstorage-name }} bucket? {#domain-bucket}

To add your [domain](operations/hosting/own-domain.md) to a [bucket](concepts/bucket.md):

1. [Create](operations/buckets/create.md) a bucket with the same name as your domain.

1. {% include [setup-bucket.md](../_includes/storage/setup-bucket.md) %}

1. On your DNS server, [create](operations/hosting/own-domain.md#domain-support) a CNAME record to link your domain to the bucket.

1. {% include [create-cert.md](../_includes/storage/create-cert.md) %}

1. {% include [add-cert.md](../_includes/storage/add-cert.md) %}

{% include [objects-access.md](../_includes/storage/objects-access.md) %}


#### Why did I lose access to the bucket after creating/updating a bucket policy? {#qa-lost-access}

The possible causes include:

* [Bucket policies](concepts/policy.md) treat objects within a bucket and the bucket itself as different resources. For a bucket policy rule to apply both to the bucket and the objects in it, specify them as separate resources, e.g., `samplebucket` and `samplebucket/*`.

* If a bucket policy with no rules is applied to the bucket, access is denied to all users. To disable request verification for a bucket policy, [delete](operations/buckets/policy.md#delete-policy) it.


* If a [{{ metastore-full-name }}](../metadata-hub/concepts/metastore.md) or [{{ maf-full-name}}](../managed-airflow/concepts/index.md) cluster uses a bucket with the bucket policy configured, the cluster will not be able to write or read to/from the bucket without a service account with the appropriate role. For more information, see these guides for [{{ metastore-name }}](../metadata-hub/operations/metastore/s3-policy-connect.md) and [{{ maf-name }}](../managed-airflow/operations/s3-policy-connect.md).


#### How do I get access to {{ objstorage-name }} from a {{ vpc-name }} cloud network? {#qa-from-vpc}

For resources hosted in a {{ vpc-short-name }} cloud network and having neither public IP address nor access to the internet, you can [set up a connection](../tutorials/routing/storage-vpc-access.md) to {{ objstorage-name }} via an [API endpoint](../api-design-guide/concepts/endpoints.md). The FQDN of the endpoint will be translated to a public IP address using DNS.
