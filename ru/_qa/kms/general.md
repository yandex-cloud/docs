
# Общие вопросы про {{ kms-name }}

#### Почему статус ключа не меняется на `Inactive`?

Изменение статуса ключа с `Active` на `Inactive` относится к [eventually consistent](../../kms/concepts/consistency.md) операциям. Изменения, вызванные такими операциями, вступают в силу с задержкой до трех часов.

{% include [logs](../logs.md) %}