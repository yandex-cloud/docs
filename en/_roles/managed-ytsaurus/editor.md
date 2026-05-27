The `managed-ytsaurus.editor` role enables managing {{ ytsaurus-name }} clusters, as well as getting info on the quotas and service resource operations.

Users with this role can:
* View information on {{ ytsaurus-name }} clusters, as well as create, modify, delete, run, and stop them.
* View info on the [quotas](../../managed-ytsaurus/concepts/limits.md#quotas) for {{ myt-name }}.
* View info on resource operations for {{ myt-name }}.
* Use the {{ ytsaurus-name }} web UI.

This role includes the `managed-ytsaurus.user` permissions.

To create {{ ytsaurus-name }} clusters, you also need the `vpc.user` role.
