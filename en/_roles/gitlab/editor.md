The `gitlab.editor` role enables managing the Managed Service for GitLab instances and migrating them to other availability zones.

Users with this role can:
* View info on the Managed Service for GitLab [instances](../../managed-gitlab/concepts/index.md#instance), as well as create, modify, and delete such instances.
* Migrate instances to another [availability zones](../../overview/concepts/geo-scope.md).
* View info on the [quotas](../../managed-gitlab/concepts/limits.md#quotas) for Managed Service for GitLab.

This role includes the `gitlab.viewer` permissions.

To create Managed Service for GitLab instances, you also need the `vpc.user` role.
