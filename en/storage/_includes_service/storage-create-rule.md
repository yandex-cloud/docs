To create a rule:

1. Enable the **Status** option. With this option, you can enable or disable a rule without deleting it from a configuration.
1. Complete the fields below:
   * **Description**: Freeform description of the rule.
   * **Prefix**: Characters taken from the beginning of the object key of the required length. The prefix is used to match objects to a rule. If a rule must apply to all objects, select **All objects**.
1. Select an object type and the action to apply to objects when the rule is triggered.
   * `Expiration`: Remove all objects from bucket.
   * `Transition`: Move any objects from `STANDARD` to `COLD` storage.
   * `NoncurrentVersionExpiration`: Remove non-current object versions from bucket.
   * `NoncurrentVersionTransition`: Move any non-current object versions from `STANDARD` to `COLD` storage.
   * `AbortIncompleteMultipartUpload`: Remove of all parts of failed multipart uploads from bucket.
1. Select the rule trigger. Depending on type, you can select:
   * **Number of days**: Rule triggers after a specified number of days.
   * **Exact date**: On specified date.
   * **Deletion marker without noncurrent versions**: After an object has only one current version. Valid only for the `Expiration` type.
1. Select a rule trigger time:
   * **Trigger time**: Number of days after an object is uploaded that a rule must trigger. Minimum value: 1.
   * **Trigger date**: Date when a rule must trigger.
1. Click **Save**.

You can add multiple rules at once. To add a new rule, click **Add rule** and repeat the above steps.