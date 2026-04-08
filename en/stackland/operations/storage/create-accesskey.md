# Creating an access key

To use {{ objstorage-name }} via the S3 API you need an access key. Access keys are created in {{ iam-name }} using a service account.

## Getting started {#before-you-begin}

1. Make sure you have a [project](../projects/create-project.md).
1. Make sure there is a [bucket](create-bucket.md) in your project.

{% list tabs group=instructions %}

- CLI {#cli}

  1. Create a service account in your project:

      ```bash
      kubectl create serviceaccount <service_account_name> -n <project_name>
      ```

  1. Assign to the service account the `storage.editor` role for access to buckets:

      ```yaml
      apiVersion: iam.stackland.yandex.cloud/v1alpha1
      kind: AccessBinding
      metadata:
        name: <service_account_name>-storage-access
        namespace: <project_name>
      spec:
        roleID: storage.editor
        subject:
          kind: ServiceAccount
          name: <service_account_name>
          namespace: <project_name>
      ```

      Save the manifest to a file named `access-binding.yaml` and apply it:

      ```bash
      kubectl apply -f access-binding.yaml
      ```

  1. Create a static access key for the service account:

      ```yaml
      apiVersion: iam.stackland.yandex.cloud/v1alpha1
      kind: APIKey
      metadata:
        name: <service_account_name>-s3-key
        namespace: <project_name>
      spec:
        serviceAccountRef:
          name: <service_account_name>
        secretName: <service_account_name>-s3-credentials
      ```

      Save the manifest to a file named `api-key.yaml` and apply it:

      ```bash
      kubectl apply -f api-key.yaml
      ```

  1. Get the access key and secret key from the secret you created:

      ```bash
      export AWS_ACCESS_KEY_ID=$(kubectl get secret -n <project_name> <service_account_name>-s3-credentials -o jsonpath='{.data.accessKeyId}' | base64 -d)
      export AWS_SECRET_ACCESS_KEY=$(kubectl get secret -n <project_name> <service_account_name>-s3-credentials -o jsonpath='{.data.secretAccessKey}' | base64 -d)
      ```

  1. Check your connection to {{ objstorage-name }}:

      ```bash
      export CLUSTER_DOMAIN=$(kubectl get platformenvironments main -o jsonpath='{.status.clusterDomain}')
      aws --endpoint-url=https://storage.sys.$CLUSTER_DOMAIN s3 ls
      ```


- Management console {#console}

  1. If you have not opened a project yet, select one.
  1. In the left-hand menu, select **Service accounts**.
  1. Click **Create service account**.
  1. Enter a name for the service account and click **Create**.
  1. Select the new service account.
  1. Go to the **Access keys** tab.
  1. Click **Create key**.
  1. Save the **Access Key ID** and **Secret Access Key**.

      {% note warning %}

      The secret key is only displayed once. Save it to a secure location.

      {% endnote %}

  1. Assign the `storage.editor` role to the service account:
      1. Go to the **Access permissions** section of your project.
      1. Click **Assign role**.
      1. Select the `storage.editor` role.
      1. Select the new service account as the subject.
      1. Click **Assign**.

{% endlist %}

## Available roles {#roles}

* `storage.viewer`: Allows you to read objects and get a bucket list.
* `storage.editor`: Allows you to read, create, edit, and delete objects.
* `storage.admin`: Full access to {{ objstorage-name }}, including bucket settings management.

## What's next {#what-next}

* Learn more about [access management](../../concepts/components/storage.md#access-management) in {{ objstorage-name }}.
* Check out the [{{ iam-name }}](../../concepts/components/iam.md) guides.
