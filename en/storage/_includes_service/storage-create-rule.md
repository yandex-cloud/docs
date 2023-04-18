To create a rule:

1. Enable **{{ ui-key.yacloud.storage.bucket.lifecycle.field_status }}**. With this option, you can enable or disable a rule without deleting it from a configuration.
1. Fill out the fields below:
   * **{{ ui-key.yacloud.storage.bucket.lifecycle.field_description }}**: Provide the rule description as you see fit.
   * **{{ ui-key.yacloud.storage.bucket.lifecycle.field_prefix }}**: Characters taken from the beginning of the object key of the required length. The prefix is used to match objects to a rule. If a rule must apply to all objects, select **{{ ui-key.yacloud.storage.bucket.lifecycle.field_no-prefix }}**.
1. Select an object type and the action to apply to objects when the rule is triggered:
   * `Expiration`: Remove all objects from bucket.
   * `Transition`: Move any objects from `STANDARD` to `COLD` storage, from `COLD` to `ICE` storage, or from `STANDARD` to `ICE` storage.
   * `NoncurrentVersionExpiration`: Remove non-current object versions from bucket.
   * `NoncurrentVersionTransition`: Move any non-current object versions from `STANDARD` to `COLD` storage.
   * `AbortIncompleteMultipartUpload`: Remove of all parts of failed multipart uploads from bucket.
1. Select the rule trigger. Depending on type, you can select:
   * **{{ ui-key.yacloud.storage.bucket.lifecycle.value_expiration-days }}**: Rule gets triggered after a specified number of days.
   * **{{ ui-key.yacloud.storage.bucket.lifecycle.value_expiration-date }}**: On a specified date.
   * **{{ ui-key.yacloud.storage.bucket.lifecycle.value_expired-object-delete-marker }}**: After an object has only one current version. Valid only for the `Expiration` type.
1. Select a rule trigger time:
   * **{{ ui-key.yacloud.storage.bucket.lifecycle.field_days }}**: Number of days after an object is uploaded. The rule gets triggered after this number of days. The minimum value is 1.
   * **{{ ui-key.yacloud.storage.bucket.lifecycle.field_date }}**: Date when a rule gets triggered.
1. Click **{{ ui-key.yacloud.storage.bucket.lifecycle.button_save }}**.

You can add multiple rules at once. To add a new rule, click **{{ ui-key.yacloud.storage.bucket.lifecycle.label_add-lifecycle-settings }}** and repeat the above steps.