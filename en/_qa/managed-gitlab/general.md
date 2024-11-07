#### What are the advantages of {{ mgl-name }} over a {{ GL }} Community Edition custom installation? {#advantages}

The main advantage of {{ mgl-name }} is that it reduces the installation and administration costs of {{ GL }}. In addition, {{ mgl-name }} adds functionality not found in the [Community Edition](https://about.gitlab.com/install/ce-or-ee/) (such as approval rules). For more information, see the [Service advantages over a {{ GL }} custom installation](../../managed-gitlab/concepts/managed-gitlab-vs-custom-installation.md) section.

#### How to migrate data from {{ GL }} to {{ mgl-name }}? {#migration}

You can migrate data from a {{ GL }} custom installation to {{ mgl-name }} by following [this guide](../../managed-gitlab/operations/instance/migration.md). Before you begin, see [how to run migration](../../managed-gitlab/concepts/migration.md).

You cannot migrate data from {{ GL }}.com to {{ mgl-name }}: migration is only available for {{ GL }} installed on a server or local computer (self-managed {{ GL }}).

#### Can I integrate {{ GL }} authentication providers? {#auth-provider}

Yes, you can. To do this, [configure OmniAuth](../../managed-gitlab/operations/omniauth.md).

#### Can I use Yandex ID or Yandex 360 for authentication? {#auth-yandex-id}

Yes, you can. To do this, [add a provider](../../managed-gitlab/operations/omniauth.md#add-provider) of the `Yandex ID` type to OmniAuth and configure its [parameters](../../managed-gitlab/operations/omniauth.md#yandex-id).

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

* To protected branches (e.g., `master`): `Maintainer` or `Owner`.
* To unprotected branches: `Developer`, `Maintainer`, or `Owner`.

Users with the `Guest` and `Reporter` roles cannot push changes.

For more information about roles, see the [{{ GL }} documentation]({{ gl.docs }}/ee/user/permissions.html).

#### I get `500 Internal Server Error` when trying to open the instance. What could be the problem? {#500-error}

The instance disk space may be full. To clean up disk space and recover access to the instance, contact [support]({{ link-console-support }}).

For more information on how to prevent instance disk space overflow, see [this guide](../../managed-gitlab/operations/instance/clean-up-disk-space.md).

#### Why cannot I create backups? {#backup-failed}

If backup creation fails (`Failed` status), [configure a separate security group](../../managed-gitlab/operations/configure-security-group.md) and link it to the {{ GL }} instance.
