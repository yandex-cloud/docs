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

#### How do I import a project from gitlab.com to {{ mgl-name }}?

Follow the project import and export guide in the [{{ GL }} documentation]({{ gl.docs }}/ee/user/project/settings/import_export.html).

If the described method does not suit you for some reason, set up server integration using [this guide]({{ gl.docs }}/ee/integration/gitlab.html), contact the {{ yandex-cloud }} [tech support]({{ link-console-support }}) to provide them with the obtained `Application ID` and `Secret` values and specify other parameters you need.
