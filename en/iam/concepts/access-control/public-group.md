---
title: Public groups
description: In this tutorial, you will learn about public groups and their types.
---

# Public groups


A _public group_ is a group of users (subjects) to which you can assign [roles](./roles.md). In {{ yandex-cloud }}, there are two types of public groups: `All authenticated users` and `All users`. These groups allow you to grant public access to your resources, but only for operations that are allowed by the assigned role.

It is unsafe to assign roles with extensive permissions, such as `editor` or `admin`, to public groups.

### All authenticated users {#allAuthenticatedUsers}

The `All authenticated users` public group includes all the [authenticated](../authorization/index.md) users, i.e., all users or service accounts registered in {{ yandex-cloud }} from both your clouds and other users' clouds. Using this group is unsafe. Instead, use [system groups](./system-group.md), such as `All users in organization X` and `All users in federation N`, or your own custom groups.

> For example, let's say you have an OS disk image that you want to share with all {{ yandex-cloud }} users. To do this, assign the `compute.images.user` role to the `All authenticated users` subject for the folder containing the image.

When assigning a role to `All authenticated users` via the [CLI](../../../cli/quickstart.md), [{{ TF }}]({{ tf-provider-link }}), and [API](../../../api-design-guide/concepts/general.md), use the `allAuthenticatedUsers` [subject](./index.md#subject) ID.

{% note alert %}

Assigning this role to the `All authenticated users` system group gives public access to your resources. The role grants permissions for your resources to **every** user authenticated in {{ yandex-cloud }}, **not only the users from your cloud**.

{% endnote %}

### All users {#allUsers}

The `All users` public group includes any user, with no authentication required.

> For example, when making an API request to your resource, users do not need to specify their IAM tokens. Using this group is unsafe. Instead, use system groups, such as `All users in organization X` and `All users in federation N`, or your custom organization user [groups](../../../organization/concepts/groups.md).

When assigning a role to `All users` via the [CLI](../../../cli/quickstart.md), [{{ TF }}]({{ tf-provider-link }}), and [API](../../../api-design-guide/concepts/general.md), use the `allUsers` [subject](./index.md#subject) ID.

{% note info %}

Currently, `All users` is only supported for the following services: {{ objstorage-name }} (when using [ACL-based access management](../../../storage/concepts/acl.md)), {{ container-registry-name }}, and {{ sf-name }}.

For other services, assigning a role to the `All users` group is equivalent to assigning a role to `All authenticated users`.

{% endnote %}
