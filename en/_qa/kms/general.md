---
title: '{{ kms-full-name }}. FAQ'
description: How do I get my activity logs in {{ kms-full-name }}? Find answers to this and other questions in this article.
---

# General questions about {{ kms-name }}

#### Why does the key status not change to `Inactive`?

The change of the key status from `Active` to `Inactive` is an [eventually consistent](../../kms/concepts/consistency.md) operation. Changes resulting from such operations take effect with a delay of up to three hours.

#### Why am I still billed for my deleted keys? {#keys-charged-after-deletion}

After you request the [deletion of a key](../../kms/operations/key.md#delete), its versions get the `Scheduled For Destruction` status for three days and remain [billable](../../kms/pricing.md). During this period, you can restore the key and its versions by contacting [support]({{ link-console-support }}).

After three days' time, the key and all its versions get permanently deleted. After that, the data encrypted with that key can no longer be decrypted.

{% include [logs](../logs.md) %}