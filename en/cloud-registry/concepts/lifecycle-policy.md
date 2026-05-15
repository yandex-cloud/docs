---
title: Lifecycle policy in {{ cloud-registry-full-name }}
description: A lifecycle policy consists of rules that manage storage or deletion of artifacts in a registry. Policies automate the cleanup of old or unused artifact versions to save space and reduce storage costs.
---

# Lifecycle policy in {{ cloud-registry-full-name }}

A _lifecycle policy_ consists of rules that manage storage or deletion of artifacts in a [registry](registry.md). Policies automate the cleanup of old or unused [artifact](artifacts/index.md) versions to save space and reduce storage costs.

Rules are specified as a JSON [array of rule objects](#LifecycleRule) when [creating](../operations/lifecycle-policy/create.md) a lifecycle policy.

Each policy rule includes a filter by `path_prefix`. It indicates which artifacts the rule applies to.

**Examples**

Prefix | Selection
--- | ---
`/` | All artifacts in the registry
`/ubuntu` | Artifacts whose paths start with `/ubuntu`

{% note warning %}

Rules apply to packages. If you set a rule saying _Keep only the ten most recent versions_ with `path_prefix = /` for a registry containing two packages, e.g., `ubuntu` and `vault`, the rule will apply separately to each package. As a result, the ten latest versions will be retained in each package, rather than across all packages.

The number of lifecycle policies and rules within them are subject to [quotas and limits](limits.md).

{% endnote %}

## Types of rules {#rule-types}

Lifecycle policy rules:
* Apply only to artifacts matching the filter.
* Determine which of these artifacts to retain or delete.

### KEEP {#keep-rule}

Rules of the _KEEP_ type describe which artifacts the lifecycle policy should retain. These rules have higher priority than deletion rules (`HARD_DELETE` and `SOFT_DELETE`).

The retention conditions include:

* **Age**: Keeps artifacts younger than the specified age in days.
* **Number of versions**: Keeps the specified number of the latest artifact versions, e.g., the five most recently created versions.

### HARD_DELETE {#hard-delete-rule}

A rule of the _HARD_DELETE_ type permanently deletes artifacts matching the rule conditions. After the rule applies, the artifacts are permanently deleted, and you cannot restore them.

The deletion conditions include:

* **Age**: Deletes artifacts older than the specified age in days.
* **Number of versions**: Deletes the oldest artifacts if they exceed the specified number (the oldest versions are deleted).
* **Always**: Deletes all artifacts.

### SOFT_DELETE {#soft-delete-rule}

A rule of the _SOFT_DELETE_ type marks artifacts for deletion but does not delete them immediately. The artifacts remain in the registry during the `cooldown period` specified in the rule. After this period ends, the artifacts are permanently deleted.

{% note info %}

Artifacts marked for soft deletion remain billable until the end of the cooldown period.

{% endnote %}

The `SOFT_DELETE` and `HARD_DELETE` rule conditions are the same.

## Rule filters {#rule-filters}

Each rule includes filters indicating which artifacts the rule applies to:

* **Path prefix** (`path_prefix`): Determines which artifacts the rule applies to based on their path. If you specify `/`, the rule will apply to all artifacts of all packages in the registry. You can specify one or more prefixes separated by commas, e.g., `/ubuntu,/vault`. This filter does not support regular expressions (`regexp`).
* **Docker filters**: Additional filters for Docker images by tag status (with tags, no tags).
* **Maven filters**: Additional filters for Java artifacts by version type (release versions, snapshots).

Rules based on the number of versions or date apply to artifacts matching all the specified filters.

## Applying policies {#policy-execution}

Lifecycle policies apply automatically according to a schedule. Rules are processed daily at the specified time. Policy changes are not immediate and take effect with the next processing cycle.

Rules apply in the following priority order:

1. `KEEP` rules: Determine which artifacts to retain.
1. `HARD_DELETE` and `SOFT_DELETE` rules: Determine which artifacts to delete, ignoring those protected by the `KEEP` rules.

## Rule object (LifecycleRule) {#LifecycleRule}

The `keep_by_age`, `keep_by_version`, and `delete` fields are mutually exclusive; you can only specify one action per rule.

Field | Type | Description
--- | --- | ---
`path_prefix` | `string` | Path prefix indicating which artifacts the rule applies to. If it is not specified, the rule will apply to all artifacts.
`keep_by_age` | [KeepByAgeLifecycleRule](#KeepByAgeLifecycleRule) | Keeping artifacts based on their age.
`keep_by_version` | [KeepByVersionLifecycleRule](#KeepByVersionLifecycleRule) | Keeping artifacts based on the number of versions.
`delete` | [DeleteLifecycleRule](#DeleteLifecycleRule) | Deleting artifacts.
`docker_filters` | [DockerFilters](#DockerFilters) | Filters for rules applied to Docker images.
`maven_filters` | [MavenFilters](#MavenFilters) | Filters for rules applied to Java artifacts.
`version_regexp` | `string` | Regular expression to search for a package version or Docker image tag.

### KeepByAgeLifecycleRule object {#KeepByAgeLifecycleRule}

Field | Type | Description
--- | --- | ---
`younger_than_days` | `integer` | Keep artifacts younger than the specified number of days.

### KeepByVersionLifecycleRule object {#KeepByVersionLifecycleRule}

Field | Type | Description
--- | --- | ---
`keep_versions_count` | `integer` | Keep the specified number of artifact versions.

### DeleteLifecycleRule object {#DeleteLifecycleRule}

The `older_than_days`, `version_condition`, and `always` fields are mutually exclusive; you can only specify one deletion condition.

Field | Type | Description
--- | --- | ---
`type` | `string` | Deletion type:<ul><li>`HARD_DELETE`: Permanently delete artifacts.</li><li>`SOFT_DELETE`: Mark artifacts for deletion with an option to restore.</li></ul>
`cooldown_period_days` | `integer` | Waiting period before deletion, in days.
`older_than_days` | `integer` | Delete artifacts older than the specified number of days.
`version_condition` | [DeleteByVersionCondition](#dDeleteByVersionCondition) | Delete artifacts based on the number of versions.
`always` | `boolean` | Delete all matching artifacts.

### DeleteByVersionCondition object {#DeleteByVersionCondition}

Field | Type | Description
--- | --- | ---
`versions_count_greater_than` | `integer` | Delete artifacts if their versions exceed the specified number.

### DockerFilters object {#DockerFilters}

Field | Type | Description
--- | --- | --- 
`tag_status` | `string` | Filter Docker images by tag status:<ul><li>`TAG_STATUS_ANY`: Any status.</li><li>`TAGGED`: Only Docker images with a tag.</li><li>`UNTAGGED`: Only Docker images with no tags.</li><ul>

### MavenFilters object {#MavenFilters}

Field | Type | Description
--- | --- | ---
`version_type` | `string` | Filter Java artifacts by version type:<ul><li>`VERSION_TYPE_ANY`: Any type</li><li>`RELEASE`: Only release versions</li><li>`SNAPSHOT`: Only snapshots</li></ul>

#### See also {#see-also}

* [{#T}](../operations/lifecycle-policy/create.md)
* [{#T}](../tutorials/lifecycle-policy-examples.md)
* [{#T}](../operations/registry/create.md)
