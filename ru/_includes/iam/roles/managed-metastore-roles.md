#### managed-metastore.auditor {#managed-metastore-auditor}

Роль `managed-metastore.auditor` позволяет просматривать информацию о кластерах и квотах.

#### managed-metastore.viewer {#managed-metastore-viewer}

Роль `managed-metastore.viewer` позволяет просматривать информацию о кластерах, логах их работы и квотах.

#### managed-metastore.editor {#managed-metastore-editor}

Роль `managed-metastore.editor` позволяет изменять и удалять кластеры, просматривать информацию о них, логах их работы и квотах.

Для создания кластеров дополнительно необходима роль `vpc.user`.

Включает в себя роль `managed-metastore.viewer`.

#### managed-metastore.admin {#managed-metastore-admin}

Роль `managed-metastore.admin` позволяет изменять, удалять кластеры, просматривать информацию о них, логах их работы и квотах, а также управлять доступом к кластерам.

Для создания кластеров дополнительно необходима роль `vpc.user`.

Включает в себя роль `managed-metastore.editor`.
