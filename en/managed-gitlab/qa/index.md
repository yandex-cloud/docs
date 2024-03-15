---
title: "Questions and answers about {{ mgl-full-name }}"
description: "This page provides answers to questions about {{ mgl-name }}."
---

# General questions about {{ mgl-name }}

#### What are the advantages of {{ mgl-name }} over a {{ GL }} Community Edition custom installation? {#advantages}

The main advantage of {{ mgl-name }} is that it reduces the installation and administration costs of {{ GL }}. In addition, {{ mgl-name }} adds functionality not found in the [Community Edition](https://about.gitlab.com/install/ce-or-ee/) (such as approval rules). For more information, see the [Service advantages over a {{ GL }} custom installation](../concepts/managed-gitlab-vs-custom-installation.md) section.

#### How to migrate data from {{ GL }} to {{ mgl-name }}? {#migration}

You can migrate data from a {{ GL }} custom installation to {{ mgl-name }}. To do it, follow [this guide](../operations/instance/migration.md). Before starting, see the [service provision procedure](../concepts/migration.md).

You cannot migrate data from {{ GL }}.com to {{ mgl-name }}: migration is only available for {{ GL }} installed on a server or local computer (self-managed {{ GL }}).

#### Can I integrate {{ GL }} authentication providers? {#auth-provider}

Yes, you can. To do this, [configure OmniAuth](../operations/omniauth.md).

#### Can I use Yandex ID or Yandex 360 for authentication? {#auth-yandex-id}

Yes, you can. To do this, [add a provider](../operations/omniauth.md#add-provider) of the `Yandex ID` type to OmniAuth and configure its [parameters](../operations/omniauth.md#yandex-id).

#### Is {{ GL }} integration with {{ tracker-full-name }} supported? {#tracker-integration}

Yes, it is. To learn how to set up integration, see [Integration with {{ tracker-full-name }}](../../tracker/user/gitlab.md).

#### Why cannot I push changes to the {{ mgl-name }} repository? {#push}

Error messages:

```text
You are not allowed to push code to this project.
```

```text
You are not allowed to push code to protected branches on this project.
```

To push changes to the {{ mgl-name }} repository, [assign]({{ gl.docs }}/ee/user/project/members/#add-users-to-a-project) the user an appropriate role in the project. To push changes:

* To protected branches (such as `master`): `Maintainer` or `Owner`.
* To unprotected branches: `Developer`, `Maintainer`, or `Owner`.

Users with the `Guest` and `Reporter` roles cannot push changes.

For more information about roles, see the [{{ GL }} documentation]({{ gl.docs }}/ee/user/permissions.html).

#### I am getting `500 Internal Server Error` when opening an instance. What could be the problem? {#500-error}

The instance disk space may be full. [Check and clean it up](../operations/instance/clean-up-disk-space.md).
