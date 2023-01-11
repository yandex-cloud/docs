# Группы хостов в {{ mos-name }}

Каждый кластер {{ mos-name }} состоит из одной или нескольких групп хостов типа `OPENSEARCH` и `DASHBOARDS` (опционально).

## OPENSEARCH {#opensearch}

Группа хостов типа `OPENSEARCH` может содержать хосты с ролями [DATA](host-roles.md#data) или [MANAGER](host-roles.md#manager).

Если кластер состоит из одной группы хостов `OPENSEARCH`, её хосты совмещают роли `DATA` и `MANAGER`.

## DASHBOARDS {#dashboards}

Группа хостов типа `DASHBOARDS` может содержать только хосты с ролью [DASHBOARDS](host-roles.md#dashboards).
