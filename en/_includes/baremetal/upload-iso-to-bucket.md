[Upload](../../baremetal/operations/image-upload.md#upload-file) the ISO image to [{{ objstorage-full-name }}](../../storage/index.yaml) and get a link to the uploaded object:

1. Create an {{ objstorage-name }} bucket:

    {% note info %}

    To create a [bucket](../../storage/concepts/bucket.md), you need the _minimum_ `storage.editor` [role](../../storage/security/index.md#storage-editor) for the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

    {% endnote %}

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder where you want to create a bucket.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
      1. At the top right, click **{{ ui-key.yacloud.storage.buckets.button_create }}**.
      1. On the bucket creation page:

          1. Enter a name for the bucket as per the [naming requirements](../../storage/concepts/bucket.md#naming).
          1. Set a bucket size limit or enable **{{ ui-key.yacloud.storage.bucket.settings.label_size-limit-disabled }}**, if required.
          1. Leave all other parameters as they are and click **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

    - {{ yandex-cloud }} CLI {#cli}

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      1. Create a bucket in the default folder:

          ```bash
          yc storage bucket create --name <bucket_name>
          ```

          Where `--name` is the name of the bucket. This is a required parameter. For more information, see [Bucket naming rules](../../storage/concepts/bucket.md#naming).

          Result:

          ```text
          name: <bucket_name>
          folder_id: b1gt6g8ht345********
          anonymous_access_flags: {}
          default_storage_class: STANDARD
          versioning: VERSIONING_DISABLED
          created_at: "2025-08-06T07:29:40.418079Z"
          resource_id: e3e9neva43dl********
          ```

          For more information about the `yc storage bucket create` command, see the [{{ yandex-cloud }} CLI reference](../../cli/cli-ref/storage/cli-ref/bucket/create.md).

    {% endlist %}

1. Upload the downloaded image file to the created bucket.

    {% list tabs group=instructions %}

    - Management console {#console}

      {% note info %}

      You can upload objects of up to 5 GB via the management console (see [{#T}](../../storage/concepts/limits.md)). To upload larger objects, use other [tools](../../storage/tools/index.md).

      {% endnote %}

      1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services and navigate to the bucket you want to upload your image to.
      1. In the left-hand panel, click ![image](../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.storage.bucket.switch_files }}** and then ![arrow-up-from-line](../../_assets/console-icons/arrow-up-from-line.svg) **{{ ui-key.yacloud.storage.bucket.button_upload }}** in the top-right corner.
      1. In the window that opens, select the image file and click **Open**.
      1. In the object upload window, click **{{ ui-key.yacloud.storage.button_upload }}** and wait for the image to upload.
      1. Refresh the page.

    - {{ yandex-cloud }} CLI {#cli}

      1. Run this command:

          ```bash
          yc storage s3api put-object \
            --body <local_file_path> \
            --bucket <bucket_name> \
            --key <object_path>
          ```

          Where:

          * `--body`: Path to the file you need to upload to the bucket, e.g., `./ubuntu.iso`.
          * `--bucket`: Name of your bucket.
          * `--key`: [Key](../../storage/concepts/object.md#key) to use for storing the object in the bucket, e.g., `Ubuntu-2404.iso`.

          Result:

          ```text
          etag: '"87740887a5159e2685500c02********"'
          request_id: 300dceee********
          ```
      For more information about the `yc storage s3api put-object` command, see the [{{ yandex-cloud }} CLI reference](../../cli/cli-ref/storage/cli-ref/s3api/put-object.md).

    {% endlist %}

1. Get a link to the image uploaded to the bucket:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select your folder.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** and then, the required bucket.
      1. Click the name of the object with the uploaded ISO image.
      1. In the top-right corner, click ![link](../../_assets/storage/link.svg) **{{ ui-key.yacloud.storage.file.button_generate }}**.
      1. Click **{{ ui-key.yacloud.storage.file.button_generate }}**.
      1. Copy the link.

    {% endlist %}