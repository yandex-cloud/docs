# Configuring an object lock


## Setting an object lock with a retention period or configuring its parameters {#edit-retention}

Minimum required roles:

* `storage.uploader` to set an object lock.
* `storage.admin` to change an active object lock.

You can only extend an object lock in compliance-retention mode. You can't shorten it or change its mode to governance-retention.

{% list tabs %}

- AWS CLI

   ```bash
   aws --endpoint-url=https://{{ s3-storage-host }}/ \
     s3api put-object-retention \
     --bucket <bucket_name> \
     --key <object_key> \
     --version-id <version_ID> \
     --retention Mode=<lock_type>,RetainUntilDate="<lock_retain_until_date_and_time>" \
     --bypass-governance-retention
   ```

   Where:

   * `bucket`: Your bucket's name.
   * `key`: Object [key](../../concepts/object.md#key).
   * `version-id`: Object version ID.
   * `retention`: Settings of an object lock with a retention period (both parameters are required):

      * `Mode` is the [type](../../concepts/object-lock.md#types) of object lock:

         * `GOVERNANCE`: An object lock with a predefined retention period that can be managed. You can't set this type if an object version is already locked in compliance mode.
         * `COMPLIANCE`: An object lock with a predefined retention period with strict compliance.

      * `RetainUntilDate`: Date and time until which an object is to be locked, specified in any format described in the [HTTP standard](https://www.rfc-editor.org/rfc/rfc9110#name-date-time-formats). For example, `Mon, 12 Dec 2022 09:00:00 GMT`. If a version object is already locked in compliance mode, you can only extend it by setting new retain until date and time that are later than the current ones.

   * `bypass-governance-retention`: Flag that shows that a lock is bypassed. Select it if an object version is already locked in governance mode.

{% endlist %}


## Removing an object lock in governance-retention mode {#remove-governance-retention}

The minimum required role is `storage.admin`.

{% list tabs %}

- AWS CLI

   ```bash
   aws --endpoint-url=https://{{ s3-storage-host }}/ \
     s3api put-object-retention \
     --bucket <bucket_name> \
     --key <object_key> \
     --version-id <version ID> \
     --retention Mode="",RetainUntilDate="" \
     --bypass-governance-retention
   ```

   Where:

   * `bucket`: Your bucket's name.
   * `key`: Object [key](../../concepts/object.md#key).
   * `version-id`: Object version ID.
   * `retention`: Settings of an object lock with a retention period. In both parameters, empty lines are specified to remove a lock.
   * `bypass-governance-retention`: Flag that shows that a lock is bypassed.

{% endlist %}


## Setting or removing legal holds {#edit-legal-hold}

The minimum required role is `storage.uploader`.

{% list tabs %}

- AWS CLI

   ```bash
   aws --endpoint-url=https://{{ s3-storage-host }}/ \
     s3api put-object-legal-hold \
     --bucket <bucket_name> \
     --key <object_key> \
     --version-id <version_ID> \
     --legal-hold Status=ON
   ```

   Where:

   * `bucket`: Your bucket's name.
   * `key`: Object [key](../../concepts/object.md#key).
   * `version-id`: Object version ID.
   * `legal-hold`: Legal hold settings:

      * `Status`: Legal hold status:

         * `ON`: Enabled.
         * `OFF`: Disabled.

{% endlist %}