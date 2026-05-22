
The `managed-ytsaurus.admin` role enables managing {{ ytsaurus-name }} clusters, as well as getting info on the quotas and service resource operations for {{ myt-name }}.

Users with this role can:
* View info on {{ ytsaurus-name }} clusters, as well as create, modify, run, stop, and delete them.
* View info on the [quotas](../../managed-ytsaurus/concepts/limits.md#quotas) for {{ myt-name }}.
* View info on resource operations for {{ myt-name }}.
* Use the {{ ytsaurus-name }} web UI.

This role includes the `managed-ytsaurus.editor` permissions.

To create {{ ytsaurus-name }} clusters, you also need the `vpc.user` role.
