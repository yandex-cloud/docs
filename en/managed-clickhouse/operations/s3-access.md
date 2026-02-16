---
title: How to configure access to {{ objstorage-full-name }} from a {{ CH }} cluster in {{ mch-full-name }}
description: Follow this guide to configure access to {{ objstorage-full-name }} from a {{ CH }} cluster.
---

# Configuring access to {{ objstorage-name }} from a {{ CH }} cluster

{{ mch-name }} supports using {{ objstorage-full-name }} to:
* Add [ML models](ml-models.md), [data format schemas](format-schemas.md), and [custom geobases](geobase.md).
* Process data in an object storage if this data is in any [format {{ CH }} supports]({{ ch.docs }}/interfaces/formats/).

To access {{ objstorage-name }} [bucket](../../storage/concepts/bucket.md) data from a cluster, set up password-free access to the bucket using a [service account](../../iam/concepts/users/service-accounts.md):

1. [Attach the service account to the cluster](#connect-service-account).
1. [Configure access permissions for the service account](#configure-acl).

{% note info %}

The service account will send SQL queries to {{ objstorage-name }}. In this case, keys and secrets are ignored.

If no service account is specified, SQL queries will be sent:

* Anonymously, if the key and secret are not provided.
* Using the key, if the key and secret are provided.

{% endnote %}

See also [Examples of working with objects](#examples).


Before you begin, [assign](../../iam/operations/roles/grant.md) the [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) role or higher to your {{ yandex-cloud }} account. You will need this role in the following cases:


* To create or update a cluster and attach it to a service account.
* To restore a cluster attached to a service account from its backup.

## Attach the service account to the cluster {#connect-service-account}

1. When [creating](cluster-create.md) or [updating](update.md) a cluster, either select an existing service account or create a new one.

1. [Assign](../../iam/operations/sa/assign-role-for-sa.md) the relevant roles to the service account from the `storage.*` role group, e.g., `storage.viewer` and `storage.uploader`.

{% note tip %}

To connect {{ mch-name }} clusters to {{ objstorage-name }}, we recommend using dedicated service accounts. This allows you to work with any buckets, including those to which public access cannot or should not be granted.  

{% endnote %}

## Configure access permissions {#configure-acl}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your bucket. If you have no bucket, [create](../../storage/operations/buckets/create.md) one and [upload](../../storage/operations/objects/upload.md) the data you need to it.

  1. In the [management console]({{ link-console-main }}), select the folder the cluster is in.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.

  1. Set up the [bucket ACL](../../storage/operations/buckets/edit-acl.md) or [object ACL](../../storage/operations/objects/edit-acl.md):

      1. In the list of buckets or objects, select the item in question and click ![image](../../_assets/console-icons/ellipsis.svg).
      1. Click **{{ ui-key.yacloud.storage.buckets.button_permissions }}** or **{{ ui-key.yacloud.storage.bucket.button_action-permissions }}**.
      1. In the **{{ ui-key.yacloud.component.acl-dialog.label_select-placeholder }}** drop-down list, specify the service account [attached to the cluster](#connect-service-account).
      1. Set the required permissions for the service account from the drop-down list.
      1. Click **{{ ui-key.yacloud.common.add }}** and **{{ ui-key.yacloud.common.save }}**.

      {% note info %}

      Revoke access permissions from one or more users as needed by clicking **{{ ui-key.yacloud.component.acl-dialog.button_remove-new }}** in the appropriate row.

      {% endnote %}

  
  1. If [encryption](../../storage/concepts/encryption.md) is enabled for the bucket, [assign](../../kms/operations/key-access.md#add-access-binding) the service account the [kms.keys.encrypterDecrypter](../../iam/roles-reference.md#kms-keys-encrypterDecrypter) role for the encryption key linked to the bucket.


{% endlist %}

## Examples of working with objects {#examples}

You can get a bucket object [URL](../../storage/concepts/object.md#object-url) in `https://{{ s3-storage-host }}/<bucket_name>/<object_name>` format to work with geotags and schemas or to use the `s3` table function and the `S3` table engine.

The `S3` table engine is similar to [File]({{ ch.docs }}/engines/table-engines/special/file/) and [URL]({{ ch.docs }}/engines/table-engines/special/url/) engines, except that data is stored in an S3-compatible storage, such as {{ objstorage-full-name }}, rather than a file system or remote HTTP/HTTPS server. This engine allows data reads and writes to the storage using standard SQL queries, such as `SELECT` and `INSERT`.

The `s3` table function offers the same features as the `S3` table engine, without the need to create a table first.

For example, if your {{ objstorage-name }} bucket contains a file named `table.tsv` that stores table data in TSV format, you can create either a table or a function to access this file. You need to set up password-free access and get a link to `table.tsv` first.

{% list tabs %}

- S3 table

  1. Assign the `{{ roles.mch.editor }}` and `storage.uploader` roles to the service account attached to the {{ mch-name }} cluster.
  1. Create a table:
  
     ```sql
     CREATE TABLE test (n Int32) ENGINE = S3('https://{{ s3-storage-host }}/<bucket_name>/table.tsv', 'TSV');
     ```

  1. Run test queries to the table:
  
     ```sql
     INSERT INTO test VALUES (1);
     SELECT * FROM test;
  
     ┌─n─┐
     │ 1 │
     └───┘
     ```

- s3 function

  1. Assign the `{{ roles.mch.editor }}` and `storage.uploader` roles to the service account attached to the {{ mch-name }} cluster.
  1. Insert data:
     
     ```sql
     INSERT INTO FUNCTION s3('https://{{ s3-storage-host }}/<bucket_name>/table.tsv', 'TSV', 'n Int32') VALUES (1);
     ```

  1. Run this test query:
  
     ```sql
     SELECT * FROM s3('https://{{ s3-storage-host }}/<bucket_name>/table.tsv', 'TSV', 'n Int32');

     ┌─n─┐
     │ 1 │
     └───┘
     ```

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
