### mdb.dataproc.agent {#mdb-dataproc-agent}

Роль `mdb.dataproc.agent` позволяет сервисному аккаунту, привязанному к кластеру {{ dataproc-name }}, сообщать сервису о состоянии каждого хоста в кластере.

Эту роль необходимо назначить тому сервисному аккаунту, который вы указали при [создании кластера](../data-proc/operations/cluster-create.md).

{% include [roles-restriction-only-parents](iam/roles-restriction-only-parents.md) %}