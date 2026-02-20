---
subcategory: Cloud Registry
---

# yandex_cloudregistry_lifecycle_policy (Resource)

A LifecyclePolicy resource.


## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). Output only. Creation timestamp.
- `created_by` (*Read-Only*) (String). Output only. ID of the user who created the lifecycle policy.
- `description` (String). Description of the lifecycle policy. 0-1024 characters long.
- `id` (String). ID of the lifecycle policy to return.
- `modified_at` (*Read-Only*) (String). Output only. Modification timestamp.
- `modified_by` (*Read-Only*) (String). Output only. ID of the user who last modified the lifecycle policy.
- `name` (String). Name of the lifecycle policy.
- `policy_id` (String). ID of the lifecycle policy to return.
- `registry_id` (**Required**)(String). ID of the registry that the lifecycle policy belongs to.
- `rules` [Block]. List of lifecycle rules.
  - `delete` [Block]. Rule that deletes artifacts.
    - `always` (Bool). Always delete (use with caution).
    - `cooldown_period_days` (Number). Cooldown period in days before deletion.
    - `older_than_days` (Number). Delete artifacts older than specified days.
    - `type` (String). Type of deletion.
    - `version_condition` [Block]. Delete artifacts by version count condition.
      - `versions_count_greater_than` (Number). Delete when version count exceeds this number.
  - `docker_filters` [Block]. Docker-specific filters.
    - `tag_status` (String). Filter by tag status.
  - `keep_by_age` [Block]. Rule that keeps artifacts by age.
    - `younger_than_days` (Number). Keep artifacts younger than this number of days.
  - `keep_by_version` [Block]. Rule that keeps artifacts by version count.
    - `keep_versions_count` (Number). Number of versions to keep.
  - `maven_filters` [Block]. Maven-specific filters.
    - `version_type` (String). Filter by version type.
  - `path_prefix` (String). Path prefix to which the rule applies.
  - `version_regexp` (String). Regular expression pattern to match package version or docker tag.
- `state` (String). Current state of the lifecycle policy.


