# Setting up access to {{ objstorage-name }}

{{ mch-name }} lets you use {{ objstorage-full-name }} to:
* Enable [ML models](ml-models.md), [data format schemas](format-schemas.md), and your [own geobase](internal-dictionaries.md).
* Process data that is stored in object storage if this data is represented in any of the [supported {{ CH }} formats](https://{{ ch-domain }}/docs/en/interfaces/formats/).


To access {{ objstorage-name }} [bucket](../../storage/concepts/bucket.md) data from a cluster, use one of the following methods:
* Set up password-free access to the bucket using a [service account](../../iam/concepts/users/service-accounts.md). This method lets you access bucket objects without entering the credentials. To use this method:
   1. [Connect a service account to a cluster](#connect-service-account).
   1. [Set up access rights for the service account](#configure-acl).
* Set up a public bucket by [allowing public access to it](../../storage/operations/buckets/bucket-availability.md) for reads or writes.


After setting up any of these methods, [get a link to the bucket object](#get-link-to-object), which you can use to perform operations with the cluster data. See [examples of working with objects](#examples).

## Connecting a service account to a cluster {#connect-service-account}


1. When [creating](cluster-create.md) or [updating](update.md) a cluster, either select an existing service account or create a new one.


1. Make sure that this account is assigned the correct roles from the `storage.*` role group. If necessary, assign it the necessary roles, such as `storage.viewer` and `storage.uploader`.

{% note tip %}

To link {{ mch-name }} clusters to {{ objstorage-name }}, it's recommended to use service accounts specially created for this purpose. This lets you organize work with any buckets, including those for which public access is undesirable or impossible.

{% endnote %}

## Setting up access rights {#configure-acl}

{% list tabs %}

- Management console

   
   1. In the [management console]({{ link-console-main }}), select the folder where the desired bucket is located. If there is no bucket, [create](../../storage/operations/buckets/create.md) one and [populate](../../storage/operations/objects/upload.md) it with the necessary data.


   1. Select **{{ objstorage-name }}**.

   
   1. Set up the [bucket ACL](../../storage/operations/buckets/edit-acl.md) or [object ACL](../../storage/operations/objects/edit-acl.md):


       1. In the list of buckets or objects, select the appropriate item and click ![image](../../_assets/options.svg).
       1. Click **Bucket ACL** or **Object ACL**.
       1. In the **Select user** drop-down list, specify the service account [connected to the cluster](#connect-service-account).
       1. Click **Add**.
       1. Set the necessary permissions for the service account from the drop-down list.
       1. Click **Save**.

       {% note info %}

       If necessary, revoke access from one or more users by clicking **Revoke** in the appropriate line.

       {% endnote %}

{% endlist %}

## Getting a link to an object {#get-link-to-object}


To use {{ mch-name }} to work with data of an object in {{ objstorage-name }}, you need to [get a link](../../storage/operations/objects/link-for-download.md) to this object in the bucket:


* For a bucket with restricted access, a link like `https://{{ s3-storage-host }}/<bucket name>/<object name>?X-Amz-Algorithm=...` should be changed to `https://{{ s3-storage-host }}/<bucket name>/<object name>`. To do this, delete all parameters in the query string.
* For a bucket with public access, the link is generated in the correct format.

## Examples of working with objects {#examples}

[You can use object links](#get-link-to-object) like `https://{{ s3-storage-host }}/<bucket name>/<object name>` to work with geotags and schemas or to use the `s3` table function and the `S3` table engine.

The `S3` table engine is similar to [File](https://{{ ch-domain }}/docs/en/engines/table-engines/special/file/) and [URL](https://{{ ch-domain }}/docs/en/engines/table-engines/special/url/) engines, except that data is stored in S3-compatible storage (such as {{ objstorage-full-name }}) rather than using a file system or a remote HTTP/HTTPS server. This engine allows reading or writing data from/to storage using standard SQL queries such as `SELECT` and `INSERT`.

The `s3` table function provides the same functionality as the `S3` table engine, but you don't need to create a table before using it.

For example, if the {{ objstorage-name }} `my-bucket` bucket with restricted access has a `table.tsv` file that stores table data in TSV format, then you can create a table or function that will work with this file. You must set up password-free access and obtain a link to the `table.tsv` file first.

{% list tabs %}

- S3 table

   1. Create a table:

      ```sql
      CREATE TABLE test (n Int32) ENGINE = S3('https://{{ s3-storage-host }}/my-bucket/table.tsv', 'TSV');
      ```

   1. Run test queries to the table:

      ```sql
      INSERT INTO test VALUES (1);
      SELECT * FROM test;

      ┌─n─┐
      │ 1 │
      └───┘
      ```

- S3 function

   1. Insert data:

      ```sql
      INSERT INTO FUNCTION s3('https://{{ s3-storage-host }}/my-bucket/table.tsv', 'TSV', 'n Int32') VALUES (1);
      ```

   1. Run a test query:

      ```sql
      SELECT * FROM s3('https://{{ s3-storage-host }}/my-bucket/table.tsv', 'TSV', 'n Int32');

      ┌─n─┐
      │ 1 │
      └───┘
      ```

{% endlist %}
