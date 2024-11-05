To create a rule:

1. Enable **{{ ui-key.yacloud.storage.bucket.lifecycle.field_status }}**. With this option, you can enable or disable a rule without deleting it from a configuration.
1. Fill in the fields as follows:
   * **{{ ui-key.yacloud.storage.bucket.lifecycle.field_description }}**: Provide the rule description as you see fit.
   * **{{ ui-key.yacloud.storage.bucket.lifecycle.field_prefix }}**: Portion of the object's [key](../concepts/object.md#key) of the required length starting from the beginning of the key. The prefix is used to sort the objects falling within the scope of the rule. If the rule is valid for all objects, leave this field empty.
   * **{{ ui-key.yacloud_components.labelset.button_add-label }}**: The rule triggers for all objects with the specified [labels](../concepts/tags.md).
   * **{{ ui-key.yacloud.storage.bucket.lifecycle.field_max-size }}**: The rule triggers for all objects smaller than or matching the specified size.
   * **{{ ui-key.yacloud.storage.bucket.lifecycle.field_min-size }}**: The rule triggers for all objects larger than or matching the specified size.
1. Select and configure the types of actions to be performed with the objects when a rule triggers:
   * `{{ ui-key.yacloud.storage.bucket.lifecycle.label_expiration-type }}`: Remove any objects from bucket:

     * `{{ ui-key.yacloud.storage.bucket.lifecycle.value_days }}`: Triggers as many days after an object was uploaded as specified in the **{{ ui-key.yacloud.storage.bucket.lifecycle.field_days }}** field.
     * `{{ ui-key.yacloud.storage.bucket.lifecycle.value_date }}`: Triggers on the date specified in the **{{ ui-key.yacloud.storage.bucket.lifecycle.field_date }}** field.
     * `{{ ui-key.yacloud.storage.bucket.lifecycle.value_expired-object-delete-marker }}`: Deletes the delete marker for which expired object versions no longer exist.

   * `{{ ui-key.yacloud.storage.bucket.lifecycle.label_transition-type }}`: Moves any objects from standard (`STANDARD`) to cold (`COLD`) or ice (`ICE`) storage:

     * `{{ ui-key.yacloud.storage.bucket.lifecycle.value_days }}`: Triggers as many days after an object was uploaded as specified in the **{{ ui-key.yacloud.storage.bucket.lifecycle.field_days }}** field.
     * `{{ ui-key.yacloud.storage.bucket.lifecycle.value_date }}`: Triggers on the date specified in the **{{ ui-key.yacloud.storage.bucket.lifecycle.field_date }}** field.
     * **{{ ui-key.yacloud.storage.bucket.lifecycle.column_storage_class }}**: Type of storage the objects will move to.

   * `{{ ui-key.yacloud.storage.bucket.lifecycle.label_version-expiration-type }}`: Remove non-current object versions from the bucket. Triggers as many days after an object's version became non-current as specified in the **{{ ui-key.yacloud.storage.bucket.lifecycle.field_days }}** field.
   * `{{ ui-key.yacloud.storage.bucket.lifecycle.label_version-transition-type }}`: Moves non-current versions of objects from standard (`STANDARD`) to cold (`COLD`) or ice (`ICE`) storage:
     * **{{ ui-key.yacloud.storage.bucket.lifecycle.field_days }}**: Number of days to pass before the rule triggers after an object's version becomes non-current.
     * **{{ ui-key.yacloud.storage.bucket.lifecycle.column_storage_class }}**: Type of storage the objects will move to.

   * `{{ ui-key.yacloud.storage.bucket.lifecycle.label_abort-incomplete-multipart-upload-type }}`: Remove all parts of failed multipart uploads from the bucket. Triggers as many days after an object was uploaded as specified in the **{{ ui-key.yacloud.storage.bucket.lifecycle.field_days }}** field.

1. Click **{{ ui-key.yacloud.storage.bucket.lifecycle.button_save }}**.

You can add multiple rules at once. To add a new rule, click **{{ ui-key.yacloud.storage.bucket.lifecycle.label_add-lifecycle-settings }}** and repeat the above steps.