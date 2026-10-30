# Creating an access key

To use {{ objstorage-name }} via the S3 API you need an access key. Access keys are created in {{ iam-name }} using a service account. You can use a static key or release a [temporary key](#create-sts-key) based on the static key, with limited permissions and validity.

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
      kind: AccessKey
      metadata:
        name: <service_account_name>-s3-key
        namespace: <project_name>
      spec:
        serviceAccountRef: <service_account_name>
      ```

      Save the manifest to a file named `access-key.yaml` and apply it:

      ```bash
      kubectl apply -f access-key.yaml
      ```

  1. Check the key status:

      ```bash
      kubectl get accesskey <service_account_name>-s3-key -n <project_name>
      ```

      Wait for the `READY` column to show `True`. You will see the new secret name in the `SECRET` column and the `status.secretName` field.

  1. Get the ID and the secret key part from the secret:

      ```bash
      S3_SECRET_NAME=$(kubectl get accesskey <service_account_name>-s3-key -n <project_name> -o jsonpath='{.status.secretName}')
      export AWS_ACCESS_KEY_ID=$(kubectl get secret -n <project_name> "$S3_SECRET_NAME" -o jsonpath='{.data.access-key-id}' | base64 -d)
      export AWS_SECRET_ACCESS_KEY=$(kubectl get secret -n <project_name> "$S3_SECRET_NAME" -o jsonpath='{.data.access-key-secret}' | base64 -d)
      export AWS_DEFAULT_REGION=ru-central1
      unset AWS_SESSION_TOKEN
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

## Creating a temporary access key {#create-sts-key}

[STS](../../concepts/components/storage.md#sts) is enabled automatically together with {{ objstorage-name }}. Use the AWS CLI and the `https://sts.sys.{{ cluster-domain }}` endpoint to get the key.

1. Create a service account, assign it the required permissions for the bucket, and get a static key using the guide above. Configure the AWS CLI to use this key. Service account permissions must cover operations you want to allow for the application.

1. Save the temporary access policy to the `policy.json` file. For example, grant read access restricted to objects with the `reports/` prefix in the `app-data` bucket:

    ```json
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Principal": "*",
          "Action": "s3:GetObject",
          "Resource": "arn:aws:s3:::app-data/reports/*"
        }
      ]
    }
    ```

    Replace the bucket name and prefix with your own. Configure access to only one bucket per STS policy. For more information about the policy format, see [this STS guide](https://yandex.cloud/en/docs/iam/operations/sa/create-sts-key).

1. Request a temporary key for one hour:

    ```bash
    aws --endpoint-url=https://sts.sys.<cluster_domain> --region ru-central1 sts assume-role \
      --role-arn stackland-storage-session \
      --role-session-name reports-reader \
      --policy file://policy.json \
      --duration-seconds 3600
    ```

    In `--role-arn`, provide a random description of 20 characters or longer, and in `--role-session-name`, specify the session name. To set them, use Latin letters, digits, `_` and `-`. The `--duration-seconds` parameter sets the lifetime in seconds, up to a maximum of `43200` (12 hours).

1. From the `Credentials` section in the response, provide the `AccessKeyId`, `SecretAccessKey`, and `SessionToken` to the application. For the AWS CLI, set them in a separate terminal session:

    ```bash
    export AWS_ACCESS_KEY_ID='<AccessKeyId>'
    export AWS_SECRET_ACCESS_KEY='<SecretAccessKey>'
    export AWS_SESSION_TOKEN='<SessionToken>'
    ```

    When working with a temporary key, a session token is required. The `Expiration` field shows the key expiration time.

1. Check that you can read an existing object from the allowed prefix:

    ```bash
    aws --endpoint-url=https://storage.sys.<cluster_domain> --region ru-central1 s3 cp \
      s3://app-data/reports/<object_name> ./
    ```

    Replace this path with the path to your object. To get the next temporary key, use the original static key again.

## Available roles {#roles}

* `storage.viewer`: Allows you to read objects and get a bucket list.
* `storage.editor`: Allows you to read, create, edit, and delete objects.
* `storage.admin`: Full access to {{ objstorage-name }}, including bucket settings management.

## What's next {#what-next}

* Learn more about [access management](../../concepts/components/storage.md#access-management) in {{ objstorage-name }}.
* Check out the [{{ iam-name }}](../../concepts/components/iam.md) guides.
