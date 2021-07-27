---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Bucket encryption

In {{ objstorage-short-name }}, you can encrypt objects in the bucket using [{{ kms-short-name }} keys](../../../kms/concepts/key.md):
* [Add encryption to the bucket](#add) so that all the new objects are encrypted with the specified key.
* Specify the encryption key when you [upload an object using the API](../../s3/api-ref/object/upload.md).

{% note alert %}

Data in {{ objstorage-short-name }} is encrypted using [envelope encryption](../../../kms/concepts/envelope.md). Deleting a key destroys all data encrypted with that key.

{% endnote %}

## Add encryption to the bucket {#add}

{% list tabs %}

- Management console

  To add a {{ kms-short-name }} key:

  1. In the [management console]({{ link-console-main }}), go to the bucket you want to configure encryption for.
  1. In the left panel, select **Encryption**.
  1. In the **{{ kms-short-name }} key** field, select a key.
  1. Click **Save**.

{% endlist %}

## Remove encryption from the bucket {#del}

{% list tabs %}

- Management console

  To remove encryption, delete the {{ kms-short-name }} key:

  1. In the [management console]({{ link-console-main }}), go to the bucket you want to remove encryption from.
  1. In the left panel, select **Encryption**.
  1. In the **{{ kms-short-name }} key** field, select **No encryption**.
  1. Click **Save**.

{% endlist %}