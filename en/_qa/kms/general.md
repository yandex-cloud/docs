---
title: '{{ kms-full-name }}. FAQ'
description: How do I get my activity logs in {{ kms-full-name }}? Find answers to this and other questions in this article.
---

# General questions about {{ kms-name }}

#### Why does the key status not change to `Inactive`?

The change of the key status from `Active` to `Inactive` is an [eventually consistent](../../kms/concepts/consistency.md) operation. Changes resulting from such operations take effect with a delay of up to three hours.

{% include [logs](../logs.md) %}