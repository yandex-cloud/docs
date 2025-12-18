# You are still billed for your deleted {{ kms-short-name }} keys



## Issue description {#issue-description}

Based on the usage details for your billing account, the {{ kms-full-name }} resources remain billable even after you deleted them.

## Solution {#issue-resolution}

You will be billed for any {{ kms-short-name }} keys three days after [deletion](../../../kms/operations/key.md#delete). This is required to ensure [our support]({{ link-console-support }}) will be able to recover them upon your request.

We have provided for a three-day delay before the permanent deletion of {{ kms-short-name }} keys to allow time for export of any data encrypted with a deleted key from {{ yandex-cloud }}.
 