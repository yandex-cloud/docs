---
title: How to activate a user in {{ org-full-name }}
description: Follow this guide to activate a user in {{ org-name }}.
---

# Activating a user

You can activate previously [deactivated](./deactivate-user.md) users. After activation, users regain access to the organization resources they have [access permissions](../../../iam/concepts/access-control/roles.md) for.

{% include [activate-deactivate-passport-user-notice](../../../_includes/organization/activate-deactivate-passport-user-notice.md) %}

## Activating a federated user {#activate-federated}

To activate a federated user account:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  {% include [activate-user-ui](../../../_includes/organization/activate-user-ui.md) %}

{% endlist %}


## Activating a local user {#activate-local}


{% include [note-preview](../../../_includes/note-preview.md) %}

To activate a local user account:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  {% include [activate-user-ui](../../../_includes/organization/activate-user-ui.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command to activate a [pool](../../concepts/user-pools.md) user:

     ```bash
     yc organization-manager idp user reactivate --help
     ```
  1. {% include [cli-list-userpools](../../../_includes/organization/cli-list-userpools.md) %}
  1. {% include [cli-userpool-list-users](../../../_includes/organization/cli-userpool-list-users.md) %}
  1. To activate a user, provide their ID in this command:

     ```bash
     yc organization-manager idp user reactivate <user_ID>
     ```

{% endlist %}

#### See also {#see-also}

* [{#T}](deactivate-user.md)