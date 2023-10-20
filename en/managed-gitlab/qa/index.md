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

To push changes to the {{ mgl-name }} repository, [assign](https://docs.gitlab.com/ee/user/project/members/#add-users-to-a-project) the user an appropriate role in the project. To push changes:

* To protected branches (such as `master`): `Maintainer` or `Owner`.
* To unprotected branches: `Developer`, `Maintainer`, or `Owner`.

Users with the `Guest` and `Reporter` roles cannot push changes.

For more information about roles, see the [GitLab documentation](https://docs.gitlab.com/ee/user/permissions.html).
