# Группы хостов в {{ mos-name }}

Каждый кластер {{ mos-name }} состоит из одной или нескольких групп хостов типа `{{ OS }}` и `Dashboards` (опционально).

## {{ OS }} {#opensearch}

Группа хостов типа `{{ OS }}` может содержать хосты с ролями [DATA](host-roles.md#data) или [MANAGER](host-roles.md#manager).

Если кластер состоит из одной группы хостов `{{ OS }}`, её хосты совмещают роли `DATA` и `MANAGER`.

## Dashboards {#dashboards}

Группа хостов типа `Dashboards` может содержать только хосты с ролью [DASHBOARDS](host-roles.md#dashboards).
