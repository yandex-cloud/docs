To create a rule:

1. Enable **{{ ui-key.yacloud.storage.bucket.lifecycle.field_status }}**. With this option, you can enable or disable a rule without deleting it from a configuration.
1. Fill out the fields below:
   * **{{ ui-key.yacloud.storage.bucket.lifecycle.field_description }}**: Provide the rule description as you see fit.
   * **{{ ui-key.yacloud.storage.bucket.lifecycle.field_prefix }}**: Characters taken from the beginning of the object [key](../concepts/object.md#key) of the required length. The prefix is used to match objects to a rule. If a rule must apply to all objects, select **{{ ui-key.yacloud.storage.bucket.lifecycle.field_no-prefix }}**.
   * **{{ ui-key.yacloud.storage.bucket.lifecycle.field_max-size }}**: Triggers for all objects smaller than or matching the specified size.
   * **{{ ui-key.yacloud.storage.bucket.lifecycle.field_min-size }}**: Triggers for all objects larger than or matching the specified size.
1. Select and configure the types of actions to be performed with the objects when a rule triggers:
   * `{{ ui-key.yacloud.storage.bucket.lifecycle.value_type-expiration }}`: Remove any objects from bucket:

      * `{{ ui-key.yacloud.storage.bucket.lifecycle.value_expiration-days }}`: Triggers as many days after an object was uploaded as specified in the **{{ ui-key.yacloud.storage.bucket.lifecycle.field_days }}** field.
      * `{{ ui-key.yacloud.storage.bucket.lifecycle.value_expiration-date }}`: Triggers on the date specified in the **{{ ui-key.yacloud.storage.bucket.lifecycle.field_date }}** field.
      * `{{ ui-key.yacloud.storage.bucket.lifecycle.value_expired-object-delete-marker }}`: Triggers if an object has only the current version left.

   * `{{ ui-key.yacloud.storage.bucket.lifecycle.value_type-transition }}`: Move any objects from the `STANDARD` to `COLD` storage:

      * `{{ ui-key.yacloud.storage.bucket.lifecycle.value_expiration-days }}`: Triggers as many days after an object was uploaded as specified in the **{{ ui-key.yacloud.storage.bucket.lifecycle.field_days }}** field.
      * `{{ ui-key.yacloud.storage.bucket.lifecycle.value_expiration-date }}`: Triggers on the date specified in the **{{ ui-key.yacloud.storage.bucket.lifecycle.field_date }}** field.

      You can set up the change of the storage class from `STANDARD` to `ICE` or from `COLD` or `STANDARD_IA` to `ICE` using YC CLI, AWS CLI, {{ TF }}, and the API.

   * `{{ ui-key.yacloud.storage.bucket.lifecycle.value_type-version-expiration }}`: Remove non-current object versions from the bucket. Triggers as many days after an object's version became non-current as specified in the **{{ ui-key.yacloud.storage.bucket.lifecycle.field_days }}** field.
   * `{{ ui-key.yacloud.storage.bucket.lifecycle.value_type-version-transition }}`: Move non-current object versions from `STANDARD` to `COLD` storage. Triggers as many days after an object's version became non-current as specified in the **{{ ui-key.yacloud.storage.bucket.lifecycle.field_days }}** field.

      You can set up the change of the storage class from `STANDARD` to `ICE` or from `COLD` or `STANDARD_IA` to `ICE` using YC CLI, AWS CLI, {{ TF }}, and the API.

   * `{{ ui-key.yacloud.storage.bucket.lifecycle.value_type-abort-incomplete-multipart-upload }}`: Remove all parts of failed multipart uploads from the bucket. Triggers as many days after an object was uploaded as specified in the **{{ ui-key.yacloud.storage.bucket.lifecycle.field_days }}** field.

1. Click **{{ ui-key.yacloud.storage.bucket.lifecycle.button_save }}**.

You can add multiple rules at once. To add a new rule, click **{{ ui-key.yacloud.storage.bucket.lifecycle.label_add-lifecycle-settings }}** and repeat the above steps.