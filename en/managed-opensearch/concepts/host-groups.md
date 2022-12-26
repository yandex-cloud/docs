# Host groups in {{ mos-name }}

Each {{ mos-name }} cluster consists of one or more host groups of the `OPENSEARCH` and `DASHBOARDS` type (optional).

## OPENSEARCH {#opensearch}

An `OPENSEARCH` host group may contain hosts with the [DATA](hosts-roles.md#data) or [MANAGER](hosts-roles.md#manager) role.

If a cluster consists of one `OPENSEARCH` host group, its hosts have both the `DATA` and `MANAGER` roles.

## DASHBOARDS {#dashboards}

A host group of the `DASHBOARDS` type may only contain hosts with the [DASHBOARDS](hosts-roles.md#dashboards) role.
