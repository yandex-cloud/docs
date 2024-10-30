---
title: Getting started with the management console
description: Follow this guide to create a bucket and upload an object to it using the management console.
---

# Getting started with {{ objstorage-full-name }}

In this section, you will learn how to use {{ objstorage-full-name }} via the {{ yandex-cloud }} management console. For instructions on how to use the AWS CLI, see [{#T}](./quickstart/quickstart-aws-cli.md).

To get started with {{ objstorage-name }}:

1. [Create a bucket](#the-first-bucket) for storing data.
1. [Upload a file to the bucket](#upload-files).
1. [Get a download link for the file](#get-link).


## Getting started {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or sign up if not signed up yet.
1. On the [**{{ ui-key.yacloud_billing.billing.label_service }}**]({{ link-console-billing }}) page, make sure you have a [billing account](../billing/concepts/billing-account.md) linked and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you do not have a billing account yet, [create one](../billing/quickstart/index.md#create_billing_account).
1. On the [{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}]({{ link-console-access-management }}) page, make sure you have the `editor` [role](../iam/roles-reference.md#editor) or higher. The role must be assigned for the [folder](../resource-manager/concepts/resources-hierarchy.md#folder) you will be working with or the [cloud](../resource-manager/concepts/resources-hierarchy.md#cloud) the folder belongs to.


## Creating the first bucket {#the-first-bucket}

To create your first bucket in {{ objstorage-name }}:

1. In the [management console]({{ link-console-main }}), select the folder you want to create a bucket in.
1. Click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select ![bucket](../_assets/storage/bucket.svg) **{{ ui-key.yacloud.iam.folder.dashboard.value_storage }}**.
1. Enter the name of the bucket.

    The bucket name must be unique across {{ objstorage-name }}. It is used as part of the data access URL and is visible to your data users.
1. Limit the maximum bucket size, if required.

    {% include [storage-no-max-limit](_includes_service/storage-no-max-limit.md) %}

1. If you want the files you upload to be always accessible from outside of {{ yandex-cloud }}, configure public [access](concepts/bucket.md#bucket-access).

    {% include [public-access-warning](../_includes/storage/security/public-access-warning.md) %}

    In a bucket with restricted access, you can also make the uploaded files accessible with the help of [temporary links](./concepts/pre-signed-urls.md).

1. Choose the default [storage class](concepts/storage-class.md) to be used when uploading objects:
    * _Standard storage_ is designed for storing frequently used objects.
    * _Cold storage_ is designed for long-term storage of objects that are rarely read.
    * _Ice storage_ is designed for objects you need to store for at least one year and which rarely get read requests.
1. Click **{{ ui-key.yacloud.storage.buckets.button_create }}**.

## Uploading files to a bucket {#upload-files}

To upload an object to a bucket:

1. In the [management console]({{ link-console-main }}), select the folder.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
1. Click the name of the bucket you need.
1. To upload files to the bucket, drag them to the bucket screen or click ![bucket](../_assets/storage/upload.svg) **{{ ui-key.yacloud.storage.bucket.button_upload }}** and confirm the upload of the files.

## Getting a file download link {#get-link}

To get a link to an uploaded object:

{% include [storage-get-link-for-download](_includes_service/storage-get-link-for-download.md) %}

You can share the received link or use it in your service to access the file.

To perform operations with buckets and objects, you can use [other tools](tools/index.md) in addition to the {{ yandex-cloud }} management console.


## See also {#see-also}

* [{#T}](quickstart/quickstart-aws-cli.md).
