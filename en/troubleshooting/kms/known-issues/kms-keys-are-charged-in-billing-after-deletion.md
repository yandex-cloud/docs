# You are still billed for your deleted KMS keys

## Issue description {#case-description}
Based on the usage details of the billing account, resources of the Key Management Service continue to be billed after they are deleted by the user.

## Solution {#case-resolution}
You continue being charged for KMS keys three days after [deletion](../../../kms/operations/key.md#delete). This is necessary to ensure the possibility of their recovery upon request to technical support.

We have provided for a three-day delay before the permanent deletion of keys to allow time for export of any data encrypted with a deleted key from Yandex Cloud.

