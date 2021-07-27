---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Uploading an object

{% list tabs %}

- Management console

  In the management console, you can work with {{ objstorage-name }} buckets like a hierarchical file system. You can create folders inside buckets and upload objects there. Keep in mind that in the SDK and HTTP API, an object key is the entire path to the object from the bucket root. For more information, see [{#T}](../../concepts/object.md).

  {% note info %}

  You can upload objects of up to 5 GB via the management console (see [{#T}](../../concepts/limits.md)). To upload larger objects, use other [tools](../../tools/index.md).

  {% endnote %}

  To upload an object:
  1. In the management console, select the appropriate folder.
  1. Select **Object Storage**.
  1. Click the name of the desired bucket.
  1. If you want to upload the object to a particular folder, go to that folder by clicking on its name. If you want to create a new folder, click **Create folder**.
  1. Once you are in the appropriate folder, click **Upload**.
  1. In the window that opens, select the required files and click **Open**.
  1. The management console displays all the objects selected for uploading and prompts you to select a [storage class](../../concepts/storage-class.md) for each of them. The default storage class is defined in the [bucket settings](../../concepts/bucket.md#bucket-settings).
  1. Click **Upload**.
{% endlist %}

