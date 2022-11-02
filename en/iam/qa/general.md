---
title: "{{ iam-full-name }}. FAQ"
description: "What is the {{ iam-full-name }} service for?
How do I get started with {{ iam-short-name }}? How much does it cost to use the {{ iam-short-name }} service? Answers to these and other questions in this article."
---

# General questions about {{ iam-name }}

#### What is the {{ iam-full-name }} service used for? {#usage}

{% include notitle [iam-def](../../_includes/iam-def.md) %}

{{ iam-short-name }} allows you to:

* Invite new users to the cloud and delete them from it.
* Manage access rights to resources by assigning and revoking roles.
* Create [service accounts](../concepts/users/service-accounts.md). This is a special account used for managing {{ yandex-cloud }} resources via the API.
* Get an {{ iam-short-name }} token that is required for authorization via the API.

Other {{ yandex-cloud }} services use the {{ iam-short-name }} API to give you more control over access to their resources. For example, {{ compute-full-name }} grants an additional `compute.images.user` role to control access to disk images.

#### How do I get started with {{ iam-short-name }}? {#start}

To start working with {{ iam-short-name }}, you need to register with {{ yandex-cloud }}. After registration, you will be able to use the {{ iam-short-name }} features.

See [{#T}](../quickstart.md) to learn how to add a new user to your cloud and assign them a role.

#### How much does it cost to use {{ iam-short-name }}? {#price}

The {{ iam-short-name }} service can be used free of charge.

{% include [logs](../../_qa/logs.md) %}