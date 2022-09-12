### dataproc.agent {#mdb-dataproc-agent}

Роль `dataproc.agent` позволяет сервисному аккаунту, привязанному к кластеру {{ dataproc-name }}, сообщать сервису о состоянии каждого хоста в кластере.

Эту роль необходимо назначить тому сервисному аккаунту, который вы указали при [создании кластера](../data-proc/operations/cluster-create.md).

{% include [roles-restriction-only-parents](iam/roles-restriction-only-parents.md) %}

### mdb.dataproc.agent {#mdb-dataproc-agent-deprecated}

{% note warning %}

Роль `mdb.dataproc.agent` скоро будет удалена. Пользователям с этой ролью автоматически назначится роль [dataproc.agent](#mdb-dataproc-agent) с аналогичными правами. Не рекомендуется использовать эту роль.

{% endnote %}

{% include [roles-restriction-only-parents](iam/roles-restriction-only-parents.md) %}
