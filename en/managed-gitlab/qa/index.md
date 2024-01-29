---
title: "Questions and answers about {{ mgl-full-name }}"
description: "This page provides answers to questions about {{ mgl-name }}."
---

# General questions about {{ mgl-name }}

#### Can I integrate {{ GL }} authentication providers? {#auth-provider}

Yes, you can. To do this, [configure OmniAuth](../operations/omniauth.md).

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

#### How to migrate data from {{ GL }} to {{ mgl-name }}? {#migration}

You can migrate data from a {{ GL }} custom installation to {{ mgl-name }}. To do it, follow [this guide](../operations/instance/migration.md). Before starting, see the [service provision procedure](../concepts/migration.md).

You cannot migrate data from {{ GL }}.com to {{ mgl-name }}: migration is only available for {{ GL }} installed on a server or local computer (self-managed {{ GL }}).
