### dataproc.viewer {#mdb-dataproc-viewer}

Роль `dataproc.viewer` позволяет просматривать информацию о кластерах и заданиях.

### dataproc.user {#mdb-dataproc-user}

Роль `dataproc.user` предоставляет доступ к [веб-интерфейсам компонентов](../../data-proc/concepts/interfaces.md) {{ dataproc-name }}{% if audience == "draft" %} и позволяет создавать задания{% endif %}.

Включает в себя роль `dataproc.viewer`.

### dataproc.provisioner {#mdb-dataproc-agent-deprecated}

Роль `dataproc.provisioner` предоставляет доступ к API для создания, изменения и удаления объектов кластера {{ dataproc-name }}.

{% if audience == "draft" %}

### dataproc.editor {#mdb-dataproc-editor}

Роль `dataproc.editor` позволяет создавать, изменять и удалять кластеры и задания, просматривать информацию о них и предоставляет доступ к [веб-интерфейсам компонентов](../../data-proc/concepts/interfaces.md) {{ dataproc-name }}.

Включает в себя роль `{{ roles.mgp.viewer }}`.

### dataproc.admin {#mdb-dataproc-admin}

Роль `dataproc.admin` позволяет создавать, изменять и удалять кластеры и задания, просматривать информацию о них, предоставляет доступ к [веб-интерфейсам компонентов](../../data-proc/concepts/interfaces.md) {{ dataproc-name }}, а также управляет доступом к кластерам.

Включает в себя роль `{{ roles.mgp.editor }}`.

{% endif %}
