---
title: How to draft a specification for creating or editing a trail
description: Follow this guide to draft a specification for creating or editing a {{ at-full-name }} trail.
---

# Drafting a trail specification

You can [create](#spec-for-create) and [edit](#spec-for-update) trails via the [CLI](../../cli/) using YAML specifications. To create a new trail, create a specification from the `get` command output of a similar trail. To edit an existing trail, proceed based on the `get` command output of the same trail.

{% note tip %}

To create and manage multiple trails, use [{{ TF }}](../tf-ref.md).

{% endnote %}

## Drafting a specification for a trail {#spec-for-create}

{% list tabs group=instructions %}

- CLI {#cli}

  1. [Get](get-info.md) information about the trail you want to edit or use as the basis for a new one:

      ```bash
      yc audit-trails trail get <trail_name_or_ID>
      ```

      Result:

      ```text
      id: cnpmhbf7gsq3********
      folder_id: b1g681qpemb4********
      created_at: "2026-02-13T20:32:52.357Z"
      updated_at: "2026-02-13T20:32:52.357Z"
      name: create-me
      destination:
        object_storage:
          bucket_id: recreate-trails
      service_account_id: ajelprpohp7r********
      status: ACTIVE
      cloud_id: b1gia87mbaom********
      filtering_policy:
        management_events_filter:
          resource_scopes:
            - id: b1g681qpemb4********
              type: resource-manager.folder
        data_events_filters:
          - service: compute
            resource_scopes:
              - id: b1g681qpemb4********
                type: resource-manager.folder
      ```

  1. Save the information you got into a file, e.g., `my-trail-spec.yaml`.
  1. When editing a trail, rename the `id` field to `trail_id`.
  1. Delete these fields:
      * `folder_id` (only when editing a trail)
      * `created_at`
      * `updated_at`
      * `status`
      * `cloud_id`

  1. Optionally, delete obsolete sections, if any:
      * `filter`
      * `path_filter`
      * `event_filter`

  1. Edit relevant trail parameters.

      {% cut "Description of trail parameters" %}

      {% include [trail-create-cli-yaml-config](../../_includes/audit-trails/trail-create-cli-yaml-config.md) %}

      Where:

      * `name`: Trail name. It must be unique within the folder.
      * `folder_id`: [ID](../../resource-manager/operations/folder/get-id.md) of the folder the trail will reside in.

      {% include [spec-params-common](../../_includes/audit-trails/spec-params-common.md) %}

      {% include [trail-create-cli-yaml-desc-filtering](../../_includes/audit-trails/trail-create-cli-yaml-desc-filtering.md) %}

      {% endcut %}

  1. Save the changes to the file.

{% endlist %}