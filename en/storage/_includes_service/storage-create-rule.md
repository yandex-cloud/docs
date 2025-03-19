To create a rule:

1. Enable **{{ ui-key.yacloud.storage.bucket.lifecycle.field_status }}**. With this option, you can enable or disable a rule without deleting it from a configuration.
1. Fill in the fields as follows:
   * **{{ ui-key.yacloud.storage.bucket.lifecycle.field_description }}**: Rule description in any form.
   * **{{ ui-key.yacloud.storage.bucket.lifecycle.field_prefix }}**: Portion of the object's [key](../concepts/object.md#key) of the required length at the beginning of the key. Prefixes help to sort the objects covered by the rule. If the rule should cover all objects, leave this field empty.
   * **{{ ui-key.yacloud_components.labelset.button_add-label }}**: The rule triggers for all objects with the specified [labels](../concepts/tags.md).
   * **{{ ui-key.yacloud.storage.bucket.lifecycle.field_max-size }}**: The rule triggers for all objects of the specified size or smaller.
   * **{{ ui-key.yacloud.storage.bucket.lifecycle.field_min-size }}**: The rule triggers for all objects of the specified size or larger.
1. Select and configure the types of actions with objects when a rule triggers:
   * `{{ ui-key.yacloud.storage.bucket.lifecycle.label_expiration-type }}`: Removes any objects from the bucket:

     * `{{ ui-key.yacloud.storage.bucket.lifecycle.value_days }}`: Triggers as many days after an object was uploaded as specified in the **{{ ui-key.yacloud.storage.bucket.lifecycle.field_days }}** field.
     * `{{ ui-key.yacloud.storage.bucket.lifecycle.value_date }}`: Triggers on the date specified in the **{{ ui-key.yacloud.storage.bucket.lifecycle.field_date }}** field.
     * `{{ ui-key.yacloud.storage.bucket.lifecycle.value_expired-object-delete-marker }}`: Removes the delete marker for which expired object versions no longer exist.

   * `{{ ui-key.yacloud.storage.bucket.lifecycle.label_transition-type }}`: Moves any objects from `STANDARD` to `COLD` or `ICE` storage:

     * `{{ ui-key.yacloud.storage.bucket.lifecycle.value_days }}`: Triggers as many days after an object was uploaded as specified in the **{{ ui-key.yacloud.storage.bucket.lifecycle.field_days }}** field.
     * `{{ ui-key.yacloud.storage.bucket.lifecycle.value_date }}`: Triggers on the date specified in the **{{ ui-key.yacloud.storage.bucket.lifecycle.field_date }}** field.
     * **{{ ui-key.yacloud.storage.bucket.lifecycle.column_storage_class }}**: Type of storage to move the objects to.

   * `{{ ui-key.yacloud.storage.bucket.lifecycle.label_version-expiration-type }}`: Removes non-current object versions from the bucket. It triggers as many days after an object's version became non-current as specified in the **{{ ui-key.yacloud.storage.bucket.lifecycle.field_days }}** field.
   * `{{ ui-key.yacloud.storage.bucket.lifecycle.label_version-transition-type }}`: Moves non-current versions of objects from `STANDARD` to `COLD` or `ICE` storage:
     * **{{ ui-key.yacloud.storage.bucket.lifecycle.field_days }}**: Number of days to pass before the rule triggers after an object's version becomes non-current.
     * **{{ ui-key.yacloud.storage.bucket.lifecycle.column_storage_class }}**: Type of storage to move the objects to.

   * `{{ ui-key.yacloud.storage.bucket.lifecycle.label_abort-incomplete-multipart-upload-type }}`: Removes all parts of failed multipart uploads from the bucket. It triggers as many days after an object was uploaded as specified in the **{{ ui-key.yacloud.storage.bucket.lifecycle.field_days }}** field.

1. Click **{{ ui-key.yacloud.storage.bucket.lifecycle.button_save }}**.

You can add multiple rules at once. To add a new rule, click **{{ ui-key.yacloud.storage.bucket.lifecycle.label_add-lifecycle-settings }}** and repeat the above steps.