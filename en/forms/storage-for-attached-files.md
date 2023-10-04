# Save attached files from responses to the storage

If your form allows users to attach [files](blocks-ref/file.md) in their responses, you can set up these files to be saved to an external storage, e.g., {{ objstorage-full-name }} [buckets](../storage/concepts/bucket.md) or  namespaces on Yandex Disk. This way, you can:

* Manage files in your storage and set up automations for them.
* Choose conditions for file storage and deletion. If you do not use your storage, the files will be stored for a year, after which they will be deleted without the possibility of recovery.
* Bypass the [limit](blocks-ref/file.md) on the size and number of attached files.

After you connect an external storage, the attached files from new responses will be saved to it. In {{ forms-name }}, only metadata about these files will be stored, but you will be able to download them via a link in the form settings, on the **Responses** tab. Files received before you enabled this setting will continue to be stored in {{ forms-name }} for a [limited time](answers.md#files).

{% note warning %}

Maintain enough space in the external storage to download new files. If you run out of space, users will not be able to fill out the form and will be getting the error: <q>Attaching files is temporarily suspended</q>.

{% endnote %}




## Connect the form to Yandex Disk {#disk}

{% note warning %}

This option is only available for [personal forms](personal-forms.md).

{% endnote %}

To save attached files from responses to Yandex Disk, open the form, navigate to **Settings** → **Advanced**, and activate the option **Save attached files from responses to Yandex Disk**.

This will create the Yandex.Forms folder on the form owner's Yandex Disk, where files from new user responses will be saved. Files received before you enabled this setting will continue to be stored in {{ forms-name }} for a [limited time](answers.md#files).



## Connecting the form to {{ objstorage-name }} {#s3-ext}

{% note warning %}

This option is only available for [business forms](forms-for-org.md).

{% endnote %}

1. Make sure the form is linked to an organization that has a [cloud](../organization/concepts/manage-services.md#cloud). To find out the organization, click on **For organization** in the top panel: the linked organization will be highlighted in the list. You can check if there is a cloud in the {{ yandex-cloud }} [management console]({{ link-console-main }}). If there is no cloud, create one by following the [guide](../resource-manager/operations/cloud/create.md).

1. The cloud must have a [service account](../iam/concepts/users/service-accounts.md). If there is no service account, create one by following the [guide](../iam/operations/sa/create.md).

1. [Assign](../iam/operations/sa/assign-role-for-sa.md) the `storage.editor` [role](../storage/security/index.md#storage-editor) to the service account for writing and reading files in the buckets.

1. Create a static access key for the service account by following the [guide](../iam/operations/sa/create-access-key.md). Save the created key: you will need it to configure the form.

1. In the {{ forms-name }} interface, open the form you want to connect {{ objstorage-name }} to and, under **Save in custom storage** in the settings, specify the static key you created in the previous step. The added key will be effective for all forms of this organization.

1. In the {{ yandex-cloud }} [management console]({{ link-console-main }}), go to {{ objstorage-name }} and remember the path to the bucket where you want to save the attached files. If you do not have a bucket, create one by following the [guide](../storage/operations/buckets/create.md).

1. In the {{ forms-name }} interface, go to the **Advanced** section of the form settings. In the **Save attached files from responses to specified S3** field, specify the `path` to the bucket in the `s3://path` format. When saving the settings, the bucket will be checked for availability. If the bucket is unavailable, you will get an error.

If the bucket is available, files from new user responses will be saved to it. Files received before you specified the bucket, will continue to be stored in {{ forms-name }} for a [limited time](answers.md#files).

To stop saving files to the bucket, in the {{ forms-name }} interface, in the **Settings** → **Advanced** form configuration, delete the contents of the **Save attached files from responses to specified S3**.

