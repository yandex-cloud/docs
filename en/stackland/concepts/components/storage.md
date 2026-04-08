# Object Storage

{{ objstorage-name }} is an S3-compatiable object storage based on {{ objstorage-full-name }}. It can hold data of any format. To operate the storage, use tools supporting the S3 API.

## Main features {#features}

* Stores raw data of any size.
* S3 API compatibility: use any tools and SDKs that support S3.
* Bucket management via Kubernetes' `Bucket` CRD.
* Flexible options for public access to objects.
* Supports CORS for web applications.
* Integration with {{ iam-name }} for access management.

## Resource model {#resource-model}

### Bucket {#bucket}

A bucket is a container used to store objects. To create a bucket, follow [this guide](../../operations/storage/create-bucket.md).

Manifest example:

```yaml
apiVersion: storage.stackland.yandex.cloud/v1alpha1
kind: Bucket
metadata:
  name: my-bucket
  namespace: my-project
spec:
  anonymousAccessFlags:
    read: true
    list: false
  cors:
    - allowedOrigins:
        - "https://example.com"
      allowedMethods:
        - "GET"
        - "PUT"
      allowedHeaders:
        - "*"
      maxAgeSeconds: 3600
```

Where:

* `metadata.name`: Bucket name. The name must be unique within the entire storage. Use only lowercase Latin letters, numbers, and hyphens.
* `metadata.namespace`: Project you are creating the bucket in.
* `spec.anonymousAccessFlags`: Public access settings for the bucket:
  * `read`: Allows anonymous users to read objects in the bucket.
  * `list`: Allows anonymous users to get a list of object in the bucket.
  * `configRead`: Allows anonymous users to read the bucket configuration (CORS, lifecycle, website).
* `spec.cors`: CORS rules for cross-domain requests:
  * `allowedOrigins`: List of allowed request origins.
  * `allowedMethods`: List of allowed HTTP methods.
  * `allowedHeaders`: List of allowed headers in preflight requests.
  * `exposeHeaders`: List of headers visible to the browser in the response.
  * `maxAgeSeconds`: Preflight response cache time in seconds.

### Bucket status {#bucket-status}

Once a bucket is created, you can see its status in the `status.phase` field:

* `Pending`: The bucket is awaiting creation.
* `Creating`: The bucket is being created.
* `Ready`: The bucket is ready to use.
* `Updating`: The bucket is being updated.
* `Deleting`: The bucket is being deleted.
* `Failed`: An error occurred.

## Access management {#access-management}

Access to {{ objstorage-name }} is managed via {{ iam-name }}. To use buckets, your applications need the following:

1. A service account. Create a `ServiceAccount` resource in your project.
1. A role. Use the `AccessBinding` resource to assign the `storage.editor` or `storage.viewer` role to the service account.
1. A static key. Get an access key to work with the S3 API.

Learn more about creating access keys in [this guide](../../operations/storage/create-accesskey.md).

### Example of assigning a role {#access-example}

```yaml
apiVersion: iam.stackland.yandex.cloud/v1alpha1
kind: AccessBinding
metadata:
  name: app-storage-access
  namespace: my-project
spec:
  roleID: storage.editor
  subject:
    kind: ServiceAccount
    name: my-app-sa
    namespace: my-project
```

## Connecting to a storage {#connection}

Use the following settings to connect to {{ objstorage-name }}:

* Endpoint: `storage.sys.{{ cluster-domain }}`.
* Access Key ID: Get it from your service account secret.
* Secret Access Key: Get it from your service account secret.

AWS CLI configuration example:

```bash
aws configure set aws_access_key_id <access-key-id>
aws configure set aws_secret_access_key <secret-access-key>
aws configure set default.region ru-central1
aws --endpoint-url=https://storage.sys.<cluster-domain> s3 ls
```
