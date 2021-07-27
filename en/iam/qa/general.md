---
title: "Yandex Identity and Access Management. FAQ"
description: "What is the Yandex Identity and Access Management service for?
How do I get started with IAM? How much does it cost to use the IAM service? Answers to these and other questions in this article."

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---


# General questions

#### What is the {{ iam-full-name }} service used for? {#usage}

{% include notitle [iam-def](../../_includes/iam-def.md) %}

{{ iam-short-name }} allows you to:

* Invite new users to the cloud and delete them from it.
* Manage access rights to resources by assigning and revoking roles.
* Create [service accounts](../concepts/users/service-accounts.md). This is a special account used for managing Yandex.Cloud resources via the API.
* Get an IAM token that is required for authorization via the API.

Other Yandex.Cloud services use the {{ iam-short-name }} API to give you more control over access to their resources. For example, {{ compute-full-name }} grants an additional `compute.images.user` role to control access to disk images.

#### How do I get started with IAM? {#start}

To start working with IAM, you need to register with Yandex.Cloud. After registration, you will be able to use the IAM features.

See [{#T}](../quickstart.md) to learn how to add a new user to your cloud and assign them a role.

#### How much does it cost to use {{ iam-short-name }}? {#price}

The {{ iam-short-name }} service can be used free of charge.

{% include [qa-logs.md](../../_includes/qa-logs.md) %}