---
title: Setting up access to {{ objstorage-full-name }} from a {{ CH }} cluster in {{ mch-full-name }}
description: Follow this guide to set up access to {{ objstorage-full-name }} from a {{ CH }} cluster.
---

# Configuring access to {{ objstorage-name }} from a {{ CH }} cluster

{{ mch-name }} supports using {{ objstorage-full-name }} to:
* Enable [ML models](ml-models.md), [data format schemas](format-schemas.md), and your [own geobase](geobase.md).
* Process data that is stored in object storage if this data is represented in any of the [supported {{ CH }} formats]({{ ch.docs }}/interfaces/formats/).

To access {{ objstorage-name }} [bucket](../../storage/concepts/bucket.md) data from a cluster, set up password-free access to the bucket using a [service account](../../iam/concepts/users/service-accounts.md):

1. [Connect the service account to the cluster](#connect-service-account).
1. [Set up access rights for the service account](#configure-acl).

{% note info %}

The service account will send SQL queries to {{ objstorage-name }}. These queries may or may not include the key and the secret.

If no service account is specified, SQL queries will be sent:

* Anonymously, if the key and secret are not specified in the query.
* Using the key, if the key and secret are specified in the query.

{% endnote %}

See also [Examples of working with objects](#examples).


Before you begin, [assign](../../iam/operations/roles/grant.md) the [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) role or higher to your {{ yandex-cloud }} account. You will need this role in the following cases:


* To create or modify a cluster and link it to a service account.
* To restore a cluster linked to a service account from its backup.

## Connect the service account to the cluster {#connect-service-account}

1. When [creating](cluster-create.md) or [updating](update.md) a cluster, either select an existing service account or create a new one.

1. [Assign](../../iam/operations/sa/assign-role-for-sa.md) the correct roles to the service account from the `storage.*` role group, e.g., `storage.viewer` and `storage.uploader`.

{% note tip %}

To link {{ mch-name }} clusters to {{ objstorage-name }}, we recommend using dedicated service accounts. This allows you to work with any buckets, including those to which you cannot or should not allow public access.  

{% endnote %}

## Configure access permissions {#configure-acl}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where the bucket is located. If there is no bucket, [create](../../storage/operations/buckets/create.md) one and [populate](../../storage/operations/objects/upload.md) it with the required data.

  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.

  1. Set up the [bucket ACL](../../storage/operations/buckets/edit-acl.md) or [object ACL](../../storage/operations/objects/edit-acl.md):

      1. In the list of buckets or objects, select the required element and click ![image](../../_assets/console-icons/ellipsis.svg).
      1. Click **{{ ui-key.yacloud.storage.buckets.button_permissions }}** or **{{ ui-key.yacloud.storage.bucket.button_action-permissions }}**.
      1. In the **{{ ui-key.yacloud.component.acl-dialog.label_select-placeholder }}** drop-down list, specify the service account [connected to the cluster](#connect-service-account).
      1. Set the required permissions for the service account from the drop-down list.
      1. Click **{{ ui-key.yacloud.common.add }}** and **{{ ui-key.yacloud.common.save }}**.

      {% note info %}

      If necessary, revoke access from one or more users by clicking **{{ ui-key.yacloud.component.acl-dialog.button_remove-new }}** in the appropriate line.
   
      {% endnote %}

{% endlist %}

## Examples of working with objects {#examples}

You can get a [link](../../storage/concepts/object.md#object-url) to an object in a bucket in the following format: `https://{{ s3-storage-host }}/<bucket_name>/<object_name>`. You can use it to work with geotags and schemas or to use the `s3` table function and the `S3` table engine.

The `S3` table engine is similar to [File]({{ ch.docs }}/engines/table-engines/special/file/) and [URL]({{ ch.docs }}/engines/table-engines/special/url/) engines, except that data is stored in an S3-compatible storage (such as {{ objstorage-full-name }}), rather than a file system or remote HTTP/HTTPS server. This engine allows reading data from or writing data to the storage using standard SQL queries, such as `SELECT` and `INSERT`.

The `s3` table function provides the same functionality as the `S3` table engine, but you do not need to create a table in advance to use it.

For example, if the {{ objstorage-name }} bucket contains a file named `table.tsv` that stores table data in TSV format, then you can create a table or function to work with this file. You need to set up password-free access and get a link to the `table.tsv` file first.

{% list tabs %}

- S3 table

  1. Assign the `{{ roles.mch.editor }}` and `storage.uploader` roles to the service account linked to the {{ mch-name }} cluster.
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

- S3 function

  1. Assign the `{{ roles.mch.editor }}` and `storage.uploader` roles to the service account linked to the {{ mch-name }} cluster.
  1. Insert data:
     
     ```sql
     INSERT INTO FUNCTION s3('https://{{ s3-storage-host }}/<bucket_name>/table.tsv', 'TSV', 'n Int32') VALUES (1);
     ```

  1. Run a test query:
  
     ```sql
     SELECT * FROM s3('https://{{ s3-storage-host }}/<bucket_name>/table.tsv', 'TSV', 'n Int32');

     ┌─n─┐
     │ 1 │
     └───┘
     ```

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
