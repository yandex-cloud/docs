# Creating a bucket

If you have a [project](../projects/create-project.md), you can create a [bucket](../../concepts/components/storage.md) in it.

{% list tabs group=instructions %}

- CLI {#cli}

  1. If the project does not exist yet, create it:

      ```bash
      kubectl create namespace <project_name>
      ```

  1. Create the `Bucket` resource file:

      ```bash
      touch bucket.yaml
      ```

  1. Open the file and paste the configuration:

      {% list tabs %}

      - Bucket without public access

          {% include notitle [YAML-file](../../_includes/yamls/operations/storage/create-bucket-without.md) %}

      - Bucket with public access

          {% include notitle [YAML-file](../../_includes/yamls/operations/storage/create-bucket.md) %}

          In this case, all objects will be available for reading without authentication via the `https://storage.sys.{{ cluster-domain }}/<bucket_name>/<object_name>` link.

      {% endlist %}

      Where:

      * `metadata.name`: Bucket name. Use only lowercase Latin letters, numbers, and hyphens.
      * `metadata.namespace`: Project you are creating the bucket in.
      * `spec.anonymousAccessFlags.read`: Allows anonymous users to read objects.
      * `spec.anonymousAccessFlags.list`: Allows anonymous users to get a list of objects.

  1. Apply the manifest:

      ```bash
      kubectl apply -f bucket.yaml -n <project_name>
      ```

  1. Check the bucket status:

      ```bash
      kubectl get bucket -n <project_name>
      ```

      Wait until the `PHASE` column shows `Ready`.


- Management console {#console}

  1. If you have not opened a project yet, select one.
  1. In the left-hand menu, select **{{ objstorage-name }}**.
  1. Click **Create bucket**.
  1. Specify the following settings:

      * **Bucket name**: Only use lowercase letters, numbers, and hyphens.
      * **Public access**: Enable or disable anonymous access to objects.

  1. Click **Create**.

{% endlist %}

## What's next {#what-next}

* [Create an access key](create-accesskey.md) to use your bucket via the S3 API.
* Learn more about the {{ objstorage-name }} resource model [here](../../concepts/components/storage.md#resource-model).
