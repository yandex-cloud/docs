
The `gitlab.admin` role enables managing {{ mgl-name }} instances and migrating them to other availability zones.

Users with this role can:
* View info on {{ mgl-name }} [instances](../../managed-gitlab/concepts/index.md#instance), as well as create, modify, and delete such instances.
* Migrate instances to other [availability zones](../../overview/concepts/geo-scope.md).
* View info on {{ mgl-name }} [quotas](../../managed-gitlab/concepts/limits.md#quotas).
* Completely manage instance backups: create, download, and delete them, as well as restore instances and create new ones from backups.

This role includes the `gitlab.editor` and `gitlab.backupAdmin` permissions.

To create {{ mgl-name }} instances, you also need the `vpc.user` role.
