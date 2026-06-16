
The `gitlab.editor` role enables managing the {{ mgl-name }} instances and migrating them to other availability zones.

Users with this role can:
* View info on the {{ mgl-name }} [instances](../../managed-gitlab/concepts/index.md#instance), as well as create, modify, and delete such instances.
* Migrate instances to another [availability zones](../../overview/concepts/geo-scope.md).
* View info on the [quotas](../../managed-gitlab/concepts/limits.md#quotas) for {{ mgl-name }}.

This role includes the `gitlab.viewer` permissions.

To create {{ mgl-name }} instances, you also need the `vpc.user` role.
