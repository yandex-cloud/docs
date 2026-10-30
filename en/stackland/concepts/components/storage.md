# Object Storage

{{ objstorage-name }} is an S3-compatiable object storage based on {{ objstorage-full-name }}. You can use it for data in any format. To operate the storage, use tools supporting the S3 API.

The component settings are defined by the `StorageConfig` resource named `main`. To enable {{ objstorage-name }} and specify the storage settings during the initial cluster installation, follow the [Configuring components before installation](../../quickstart.md#component-configuration) guide.

The current package includes {{ objstorage-name }} version 26.3.9.

## Main features {#features}

* Storing raw data of any size.
* S3 API-compatibility: you can use it with any tools and SDKs that support S3.
* Managing buckets using the Kubernetes `Bucket` CRD.
* Configuring public access to objects in a flexible way.
* CORS support for web applications.
* Integration with {{ iam-name }} for access management.
* Temporary access keys with a limited validity period and an access policy.
* Versioning, limiting the bucket size, and labeling.
* Managing access with ACL and S3 policies.
* Automatic object deletion according to the lifecycle rules and object version deletion protection using object lock.

## Configuration {#configuration}

The cluster administrator configures {{ objstorage-name }} using the `StorageConfig` resource named `main`. The resource applies to the entire cluster. To modify settings, run this command:

```bash
kubectl edit storageconfig main
```

Example of a configuration with enabled storage and the standard resource settings:

```yaml
apiVersion: stackland.yandex.cloud/v1alpha1
kind: StorageConfig
metadata:
  name: main
spec:
  enabled: true
  settings:
    api:
      s3CacheMB: 256
    storage:
      diskType: SSD
      servers: 3
      size: 154Gi
    resources:
      auto:
        requests:
          cpu: "14"
          memory: 20Gi
        limits:
          cpu: "20"
          memory: 30Gi
      volumes:
        objectDatabase: 6Gi
        metadataDatabase: 3Gi
        backgroundTasksDatabase: 1Gi
        backupStorage: 11Gi
```

Where:

* `spec.enabled`: Enabling the component. The default value is `false`.
* `spec.settings.api.s3CacheMB`: S3 API cache size in megabytes. The default value is `256`.
* `spec.settings.storage.diskType`: Disk type, `SSD` or `HDD`.
* `spec.settings.storage.servers`: Number of storage servers, each deployed on a separate worker node. The minimum number is `3`. The number of servers must not be larger than the number of worker nodes.
* `spec.settings.storage.size`: Data volume size on each server. The standard configuration for SSD specifies `154Gi`. The estimated capacity of `servers × size / 3` must not exceed 60 TiB.
* `spec.settings.storage.storageClass`: [Storage class](../../operations/disk-storage/change-storage-class.md). This is an optional field. If you do not specify it, the default class is used.
* `spec.settings.resources`: Settings for CPU, RAM, and service volume sizes. If this section is not specified, the default values from the example are used.

### CPU and RAM {#compute-resources}

The `spec.settings.resources.auto` section provides CPU and RAM allocation settings for {{ objstorage-name }}. Actual total requests and pod limits may exceed these values due to the service's minimum requirements. Take this into account when planning your cluster's capacity and match the resources with your loads.

#|
|| **Parameter** | **Default and minimum** | **Maximum** ||
|| `requests.cpu` | `"14"` | `"1024"` ||
|| `requests.memory` | `20Gi` | `4Ti` ||
|| `limits.cpu` | `"20"` | `"1024"` ||
|| `limits.memory` | `30Gi` | `4Ti` ||
|#

If you are adding an `auto` section, specify all four properties. For each resource, the `requests` value must not exceed `limits`.

CPU is specified as a string with the number of CPU cores, e.g., `"20"` or `"20.5"`, or as a permillage of cores, e.g., `"20500m"`. The `Mi`, `Gi`, and `Ti` units can be used for RAM.

### Service volume size {#service-volumes}

In `spec.settings.resources.volumes`, you can set the size of each volume separately:

#|
|| **Parameter** | **Description** | **Default and minimum** ||
|| `objectDatabase` | Database with lists of objects and their metadata | `6Gi` ||
|| `metadataDatabase` | Database with bucket metadata | `3Gi` ||
|| `backgroundTasksDatabase` | Database of background tasks | `1Gi` ||
|| `backupStorage` | Storage of service database backups | `11Gi` ||
|#

The maximum size of each volume is `4Ti`. The `Mi`, `Gi`, and `Ti` units can be used. If the property is not specified, its default value is used.

You can only expand volumes. After expanding, you cannot delete the property if this brings the size to the lesser default value. Expanding these volumes does not change the capacity for custom objects specified in `spec.settings.storage.size`.

### Verifying that the settings apply {#configuration-status}

After saving the changes, check the resource:

```bash
kubectl get storageconfig main -o yaml
```

Wait for `status.phase: Ready`. In `status.conditions`, the `ResourcesValid` condition set to `True` means that the resource settings are acceptable, but does not in itself confirm that the update has been completed. The `status.observedGeneration` field must be the same as `metadata.generation`.

If the value exceeds the limits or reduces the volume that has already been allocated, the resource switches to `Error`, and the `ResourcesValid` condition gets `False`. The reason is specified in `status.message`. If the error has not been fixed, the configuration changes are not applied.

## Resource model {#resource-model}

### Bucket {#bucket}

A bucket is a container for storing objects. To create a bucket, follow [this guide](../../operations/storage/create-bucket.md).

See the full manifest example with additional settings and comments for fields in [Additional settings via the CLI](../../operations/storage/create-bucket.md#additional-settings).

Here is an example of a manifest with public reading of objects and a CORS rule:

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

* `metadata.name`: Bucket name, from 3 to 63 characters. The name must be unique within the entire storage and must not look like an IP address. Use only lowercase Latin letters, digits, and hyphens. Begin and end the name with letters or digits.
* `metadata.namespace`: Project you are creating the bucket in.
* `spec.anonymousAccessFlags`: Public access settings for the bucket:
  * `read`: Allows anonymous users to read objects in the bucket.
  * `list`: Allows anonymous users to get a list of object in the bucket.
  * `configRead`: Allows anonymous users to read the bucket configuration, e.g., CORS and lifecycle rules.
* `spec.cors`: CORS rules for cross-domain requests:
  * `id`: ID of the rule. This is an optional field.
  * `allowedOrigins`: Non-empty list of allowed request origins. This is a required field.
  * `allowedMethods`: Non-empty list of allowed HTTP methods, including `GET`, `HEAD`, `POST`, `PUT`, and `DELETE`. This is a required field. For multipart upload from a browser, allow `POST`.
  * `allowedHeaders`: List of allowed headers in preflight requests.
  * `exposeHeaders`: List of headers visible to the browser in the response.
  * `maxAgeSeconds`: Preflight response cache time in seconds.

### Additional bucket settings {#bucket-settings}

The following is also available via the `spec` of the `Bucket` resource:

* `maxSize`: Maximum bucket data size. You can specify a number of bytes or a value with a measurement unit, e.g., `100Gi`. If the field is not set or equals `0`, there is no limit for the bucket; the total storage capacity remains limited.
* `versioning`: Versioning state. The possible values are `DISABLED`, `ENABLED`, and `SUSPENDED`. The default value is `DISABLED`. After enabling, you can suspend version creation using `SUSPENDED`, but cannot go back to `DISABLED`.
* `tags`: Labels in key-value format.
* `acl.grants`: List of access permissions for the bucket. Each permission contains:
  * `permission`: `READ` or `FULL_CONTROL`.
  * `grantType`: `ACCOUNT` for granting access to a service account.
  * `grantee`: `kind: ServiceAccount`, `name`, and `namespace` of the permission grantee.
* `policy`: S3 access policy document with `Statement` rules. You can describe the policy as a YAML object directly in the manifest.
* `disabledStaticKeyAuth`: If set to `true`, static key authentication is enabled. The default value is `false`.
* `lifecycleRules`: [Object lifecycle](#lifecycle-rules) rules.
* `objectLock`: [Object lock](#object-lock) settings.

Public ACL permissions for a bucket are not supported. For anonymous access, use `anonymousAccessFlags`.

The `READ` permission for the bucket allows reading its ACL using `GetBucketAcl`.

The settings in the manifest describe the desired bucket configuration. Modify it via the `Bucket` resource: modifications of the same settings via the S3 API will be replaced with values from the manifest. Deleting the field returns it to the default value, while deleting `tags`, `acl`, `cors`, `policy`, or `lifecycleRules` clears the relevant setting. Restrictions on disabling versioning and object lock are preserved.

### Object lifecycle {#lifecycle-rules}

Each `lifecycleRules` rule contains the required `enabled` field and an optional `id`. Use `filter` to select objects:

* `prefix`: Prefix of object keys.
* `tags`: Object labels.
* `objectSizeGreaterThan` and `objectSizeLessThan`: Object size limits.

The object must meet all the specified filter conditions. Without a filter, the rule applies to the entire bucket.

Available actions:

* `expiration`: Deleting current objects. Set one of these properties: `days` for validity in days, `date` for an expiration date in RFC 3339 format, or `expiredObjectDeleteMarker: true` for deleting a deletion marker without any remaining object versions.
* `noncurrentExpiration.noncurrentDays`: Deleting previous versions after a specified number of days from the day they cease to be current.
* `noncurrentDeleteMarkers.noncurrentDays`: Deleting non-current deletion markers after a specified number of days.
* `abortIncompleteMultipartUpload.daysAfterExpiration`: Deleting parts of a multipart upload after a specified number of days from its start.

### Object lock {#object-lock}

To protect object versions against deletion, specify `objectLock.enabled: true` and `versioning: ENABLED`. After enabling an object lock, you cannot disable it or suspend versioning.

In `objectLock.defaultRetention`, you can specify the default lock period for new versions:

* `mode`: `GOVERNANCE` or `COMPLIANCE`.
* `days` or `years`: Period in days or years. Specify only one of these fields.

In `GOVERNANCE` mode, a user with the relevant permission can bypass the lock. In `COMPLIANCE`, you cannot delete a protected object version after the period expires. A lock applies to versions: writing a new object version is still possible.

### Bucket status {#bucket-status}

Once a bucket is created, you can see its status in the `status.phase` field:

* `Pending`: Bucket awaiting creation.
* `Creating`: Bucket being created.
* `Ready`: Bucket ready to use.
* `Updating`: Bucket being updated.
* `Deleting`: Bucket being deleted.
* `CreationFailed`: Failed to create a bucket.
* `UpdateFailed`: Failed to apply bucket settings.
* `DeletionFailed`: Failed to delete the bucket.

You can view the error description in `status.message` and the number of the processed manifest version in `status.observedGeneration`. After applying the manifest, make sure that the bucket returned to `Ready` and that `status.observedGeneration` matches `metadata.generation`.

## Access management {#access-management}

Access to {{ objstorage-name }} is managed via {{ iam-name }}. To use buckets, your application requires the following:

1. Service account. Create ServiceAccount in your project.
1. Role. Use the `AccessBinding` resource to assign the `storage.editor` or `storage.viewer` role to the service account.
1. Access key. Use a static access key or release a temporary STS key based on it.

To learn more about creating access keys, read the [Creating an access key](../../operations/storage/create-accesskey.md) guide.

### Bucket access policy {#bucket-policy}

If `spec.policy` is set, requests are additionally checked according to the policy rules. Specify `Allow` for the operations you need: during the policy check, a request is rejected if it does not meet any allowing rule or matches a `Deny` rule. For example, a policy containing only `s3:DeleteObject` will not allow `s3:GetObject`; therefore, reading can also throw error `403`.

When objects are accessed, their own ACLs apply too: they can allow access after the bucket policy is checked. The permission check procedure is similar to {{ objstorage-full-name }}; see the [overview of access management methods](https://yandex.cloud/en/docs/storage/security/overview) for its description. For the rule format, see the [access policy documentation](https://yandex.cloud/en/docs/storage/concepts/policy).

### Temporary access keys {#sts}

*Security Token Service* (STS) allows granting an application temporary access to a bucket with a separate policy and validity period. STS is enabled automatically together with {{ objstorage-name }}. The endpoint for key issuance is `https://sts.sys.{{ cluster-domain }}`.

A temporary key contains `AccessKeyId`, `SecretAccessKey`, and `SessionToken`. Requests to S3 require all three values. The period is returned in the `Expiration` field; after its expiry, the application will require a new key.

See the key issuance procedure and a connection example in [Creating a temporary access key](../../operations/storage/create-accesskey.md#create-sts-key).

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
* Session Token: Provide it additionally when using a temporary key.

AWS CLI configuration example:

```bash
aws configure set aws_access_key_id <access-key-id>
aws configure set aws_secret_access_key <secret-access-key>
aws configure set default.region ru-central1
aws --endpoint-url=https://storage.sys.<cluster-domain> s3 ls
```
