# Host groups in {{ mos-name }}

Each {{ mos-name }} cluster consists of one or more host groups of the `{{ OS }}` and `Dashboards` (optional) types.

## {{ OS }} {#opensearch}

An `{{ OS }}` host group may contain hosts with the [DATA](host-roles.md#data) or [MANAGER](host-roles.md#manager) roles.

If a cluster consists of a single `{{ OS }}` host group, its hosts have both the `DATA` and `MANAGER` roles.

## Dashboards {#dashboards}

A host group of the `Dashboards` type may only contain hosts with the [DASHBOARDS](host-roles.md#dashboards) role.
