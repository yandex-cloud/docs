---
title: '{{ kms-full-name }}. FAQ'
description: How to get my activity logs in {{ kms-full-name }}? Find the answer to this and other questions in this article.
---

# General questions about {{ kms-name }}

#### Why the key status does not change to `Inactive`?

The change of the key status from `Active` to `Inactive` is an [eventually consistent](../../kms/concepts/consistency.md) operation. Changes caused by such operations take effect with a delay of up to three hours.

{% include [logs](../logs.md) %}