
# General questions about {{ kms-name }}

#### Why the key status does not change to `Inactive`?

The change of the key status from `Active` to `Inactive` is an [eventually consistent](../../kms/concepts/consistency.md) operation. Changes caused by such operations take effect with a delay of up to three hours.

{% include [logs](../logs.md) %}