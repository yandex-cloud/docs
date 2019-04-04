# Uploading an object

---

**[!TAB Management console]**

The management console allows you to work with [!KEYREF objstorage-name] buckets like a hierarchical file system. You can create folders inside buckets and upload objects there. Keep in mind that in the SDK and HTTP API, an object's key will be the entire path to the object from the bucket root. For more information, see the section [[!TITLE]](../../concepts/object.md).

> [!NOTE]
>
>You can upload objects of up to 5 GB in size via the management console (see [[!TITLE]](../../concepts/limits.md)). To upload larger objects, use other [tools](../../instruments/index.md).

To upload an object:

1. In the management console, select the appropriate folder.
1. Click **Yandex Object Storage**.
1. Click the name of the desired bucket.
1. If you want to upload the object to a particular folder, go to that folder by clicking on its name. If you want to create a new folder, click **Create folder**.
1. Once you are in the appropriate folder, click **Upload**.
1. In the window that opens, select the required files and click **Open**.
1. The management console displays all the objects selected for uploading and prompts you to select a [storage class](../../concepts/storage-class.md) for each of them. By default, the standard storage is set.
1. Click **Upload**.

---

