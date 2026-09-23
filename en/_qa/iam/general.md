---
title: '{{ iam-full-name }}. FAQ'
description: What do I need {{ iam-full-name }} for? How do I get started with {{ iam-short-name }}? How much does it cost to use {{ iam-short-name }}? Find answers to these and other questions in this article.
---

# General questions about {{ iam-name }}

#### What do I need {{ iam-full-name }} for? {#usage}

{% include notitle [iam-def](../../_includes/iam-def.md) %}

{{ iam-short-name }} enables you to:
* Manage access permissions for resources by assigning and revoking roles.
* Create [service accounts](../../iam/concepts/users/service-accounts.md). These are special accounts used for managing {{ yandex-cloud }} resources via the API.
* Get an IAM token for API authentication.

Other {{ yandex-cloud }} services use the {{ iam-short-name }} API to give you more options for managing access to their resources. For example, {{ compute-full-name }} additionally provides the `compute.images.user` role to manage access to disk images.

#### How do I get started with {{ iam-short-name }}? {#start}

To get started with {{ iam-short-name }}, you need to register with {{ yandex-cloud }}. Once registered, you will be able to use the {{ iam-short-name }} features.

#### How much does it cost to use {{ iam-short-name }}? {#price}

Using {{ iam-short-name }} is free of charge.

{% include [logs](../logs.md) %}
