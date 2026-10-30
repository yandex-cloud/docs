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

      * `metadata.name`: Bucket name unique within the storage, from 3 to 63 characters. Use only lowercase Latin letters, digits, and hyphens. Begin and end the name with letters or digits. The name must not look like an IP address.
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

      If the creation fails, get the error description:

      ```bash
      kubectl get bucket <bucket_name> -n <project_name> -o yaml
      ```

      The reason is specified in `status.message`. Fix the manifest and reapply it.


- Management console {#console}

  1. If you have not opened a project yet, select one.
  1. In the left-hand menu, select **{{ objstorage-name }}**.
  1. Click **Create bucket**.
  1. Specify the following settings:

      * **Bucket name**: Only use lowercase letters, numbers, and hyphens.
      * **Public access**: Enable or disable anonymous access to objects.

  1. Click **Create**.

{% endlist %}

## Advanced configuration via the CLI {#additional-settings}

The example below includes all available bucket configuration sections: size limit, versioning, public access, static key authentication, labels, ACLs, CORS, access policy, lifecycle rules, and object lock. Select the settings you need and update their values before applying the manifest.

This example creates a private bucket with a 100 GB limit and versioning enabled. For new object versions, a 7-day lock in `GOVERNANCE` mode is enabled. Note that object lock cannot be disabled after you turn it on.

For the ACL in the example, a service account named `archive-reader` is required in your project. If you do not have this service account yet, create one.

```bash
kubectl create serviceaccount archive-reader -n <project_name>
```

Save the manifest as `bucket.yaml`:

```yaml
apiVersion: storage.stackland.yandex.cloud/v1alpha1
kind: Bucket
metadata:
  name: app-archive
  namespace: my-project
spec:
  maxSize: 100Gi
  versioning: ENABLED
  anonymousAccessFlags:
    read: false
    list: false
    configRead: false
  disabledStaticKeyAuth: false
  tags:
    environment: production
    application: archive
  acl:
    grants:
      - permission: READ
        grantType: ACCOUNT
        grantee:
          kind: ServiceAccount
          namespace: my-project
          name: archive-reader
  cors:
    - id: archive-web-app
      allowedOrigins:
        - "https://app.example.com"
      allowedMethods:
        - GET
        - HEAD
        - PUT
        - POST
        - DELETE
      allowedHeaders:
        - "*"
      exposeHeaders:
        - ETag
        - x-amz-version-id
      maxAgeSeconds: 3600
  policy:
    Version: "2012-10-17"
    Statement:
      - Sid: AllowAuthorizedAccess
        Effect: Allow
        Principal: "*"
        Action: "s3:*"
        Resource:
          - "arn:aws:s3:::app-archive"
          - "arn:aws:s3:::app-archive/*"
  lifecycleRules:
    - id: expire-temporary-reports
      enabled: true
      filter:
        prefix: reports/
        tags:
          retention: temporary
        objectSizeGreaterThan: 1Mi
        objectSizeLessThan: 1Gi
      expiration:
        days: 90
      noncurrentExpiration:
        noncurrentDays: 30
    - id: cleanup-incomplete-uploads
      enabled: true
      filter:
        prefix: reports/
      abortIncompleteMultipartUpload:
        daysAfterExpiration: 7
    - id: cleanup-delete-markers
      enabled: true
      filter:
        prefix: reports/
      expiration:
        expiredObjectDeleteMarker: true
      noncurrentDeleteMarkers:
        noncurrentDays: 7
  objectLock:
    enabled: true
    defaultRetention:
      mode: GOVERNANCE
      days: 7
```

### Configuring example settings {#example-settings}

* `metadata.name`: Bucket name. If you modify it, make sure to also update the name in both `spec.policy.Statement[].Resource` lines: the first one is for the bucket, the second is for its objects.
* `metadata.namespace` and `spec.acl.grants[].grantee.namespace`: Your project name. All parameters listed below are located inside the `spec` section.
* `maxSize`: Maximum data size for the bucket. The `0` value or a missing field removes the bucket size limit.
* `versioning`: Set to `ENABLED` to enable object versioning. After you enable versioning, you cannot switch back to `DISABLED`. If object lock is enabled, you also cannot pause versioning via `SUSPENDED`.
* `anonymousAccessFlags`: Permissions for anonymous users: `read` to read objects, `list` to list objects, and `configRead` to read bucket configuration. All three permissions are disabled in the example.
* `disabledStaticKeyAuth`: If set to `false`, static key authentication remains available. The `true` value prohibits this authentication method.
* `tags`: Bucket labels. These are not automatically assigned to objects.
* `acl.grants`: Permissions for service accounts. In the example, `archive-reader` is granted `READ` permissions, which includes the ability to read the bucket ACL. For full access, specify `FULL_CONTROL`. In `grantee`, specify `kind: ServiceAccount`, account name, and its project. For public access, use `anonymousAccessFlags`.
* `cors`: Rules for browser-based requests:
  * `id`: Rule ID.
  * `allowedOrigins`: Non-empty list of web application addresses. Replace `https://app.example.com` with your URL.
  * `allowedMethods`: Non-empty list of allowed methods. The available methods are `GET`, `HEAD`, `PUT`, `POST`, and `DELETE`. For multipart uploads, the `POST` method is required.
  * `allowedHeaders`: Headers the browser is allowed to send. The `"*"` value allows all headers.
  * `exposeHeaders`: Response headers available to the web application code.
  * `maxAgeSeconds`: Caching time for a response to a preflight request, in seconds.

  CORS does not grant read or write permissions. The application still requires explicit access permissions for the bucket.

* `policy`: S3 access policy. In this example, the `Allow` rule allows operations on the bucket and its objects only if the user already has the relevant permissions. When updating the policy, explicitly allow the required operations: the `Deny` rule itself does not allow other actions. The final access level depends on a combination of IAM, ACLs, and public access settings.
* `lifecycleRules`: Rules for automatic cleanup. For each rule, specify an `id`, the `enabled` status, and actions:
  * `filter`: Selects objects. All its conditions must be met at the same time. In `expire-temporary-reports`, these are the `reports/` prefix, `retention: temporary` object label, and a size strictly between `1Mi` and `1Gi`. For other rules, specifying a prefix is sufficient.
  * `expiration.days: 90`: Sets a retention period in days for the current objects. If versioning is enabled, a delete marker is created, and the object version becomes non-current. Instead of `days`, you can set a `date` in RFC 3339 format, e.g., `"2030-01-01T00:00:00Z"`, or specify `expiredObjectDeleteMarker: true`. You cannot use these three properties simultaneously within the same `expiration` section.
  * `noncurrentExpiration.noncurrentDays: 30`: Deletes versions 30 days after they cease to be current.
  * `abortIncompleteMultipartUpload.daysAfterExpiration`: Deletes parts of an incomplete multipart upload seven days after it was initiated.
  * `expiration.expiredObjectDeleteMarker: true`: Removes a delete marker if it no longer has any associated object versions.
  * `noncurrentDeleteMarkers.noncurrentDays: 7`: Removes non-current delete markers after seven days.
* `objectLock`: Object lock. To use `defaultRetention`, set `enabled: true` and `versioning: ENABLED`. In `defaultRetention`, specify `mode: GOVERNANCE` or `mode: COMPLIANCE` and set the retention period in `days` or `years`. In `GOVERNANCE` mode, a user with the relevant permission can bypass the lock. In `COMPLIANCE`, deletion before the expiration date is prohibited. Lifecycle rules do not delete a protected version until the object lock ends.

### Applying the manifest {#apply-manifest}

After updating the properties, apply the manifest:

```bash
kubectl apply -f bucket.yaml
```

Check the bucket status:

```bash
kubectl get bucket <bucket_name> -n <project_name> -o yaml
```

Wait until you see `status.phase: Ready` and `status.observedGeneration` matches `metadata.generation`. To update an existing bucket, edit its manifest and reapply it. Removing optional settings from the manifest resets them to their defaults. Restrictions on disabling versioning and object lock continue to apply.

## What's next {#what-next}

* [Create an access key](create-accesskey.md) to use your bucket via the S3 API.
* Learn more about the {{ objstorage-name }} resource model [here](../../concepts/components/storage.md#resource-model).
