### dataproc.auditor {#mdb-dataproc-auditor}

The `dataproc.auditor` role enables you to view information about clusters and jobs (with no access to job content).

### dataproc.viewer {#mdb-dataproc-viewer}

The `dataproc.viewer` role enables you to view information about clusters and quotas.

### dataproc.user {#mdb-dataproc-user}

The `dataproc.user` role provides access to the {{ dataproc-name }} [component web interfaces](../../../data-proc/concepts/interfaces.md) and enables you to create jobs.

It includes the `dataproc.viewer` role.

### dataproc.provisioner {#mdb-dataproc-agent-deprecated}

The `dataproc.provisioner` role grants access to the API to create, update, and delete {{ dataproc-name }} cluster objects.

### dataproc.editor {#mdb-dataproc-editor}

The `dataproc.editor` role enables you to create, edit, and delete clusters and jobs, view information about them, and provides access to the {{ dataproc-name }} [component web interfaces](../../../data-proc/concepts/interfaces.md).

It includes the `{{ roles.mgp.viewer }}` role.

### dataproc.admin {#mdb-dataproc-admin}

The `dataproc.admin` role enables you to create, edit, and delete clusters and jobs, view information about them, provides access to the {{ dataproc-name }} [component web interfaces](../../../data-proc/concepts/interfaces.md), and manages access to clusters.

It includes the `{{ roles.mgp.editor }}` role.
