---
title: "Access management in {{ speechsense-full-name }}"
description: "Access management in the {{ speechsense-full-name }} speech analytics service. To grant access to {{ speechsense-name }} resources, assign relevant roles from the list to the user."
---

# Access management in {{ speechsense-name }}

Access to {{ speechsense-full-name }} is regulated by assigning permissions in an organization. Organizations are managed using [{{ org-full-name }}](../../organization/).

The list of operations available to {{ speechsense-name }} users is determined by the roles they have. Roles can be assigned to a Yandex account, a [service account](../../iam/concepts/users/service-accounts.md), [federated users](../../iam/concepts/federations.md), a [user group](../../organization/operations/manage-groups.md), or a [system group](../../iam/concepts/access-control/system-group.md). For more information about managing access to {{ yandex-cloud }}, see [{#T}](../../iam/concepts/access-control/index.md).

## Which resources can be assigned a role {#resources}

You can assign a role for a space or a project. Roles assigned for a space also apply to all nested projects and resources.

## Which roles exist in the service {#roles-list}

### Service roles {#service-roles}

{% include [auditor](../../_includes/roles-speech-sense-auditor.md) %}

{% include [viewer](../../_includes/roles-speech-sense-viewer.md) %}

{% include [editor](../../_includes/roles-speech-sense-editor.md) %}

{% include [admin](../../_includes/roles-speech-sense-admin.md) %}

{% include [spaces-creator](../../_includes/roles-speech-sense-spaces-creator.md) %}

{% include [data-viewer](../../_includes/roles-speech-sense-data-viewer.md) %}

{% include [data-editor](../../_includes/roles-speech-sense-data-editor.md) %}

Users with roles like `speech-sense.data.*` can view and rate the contents of documents but do not have access to aggregate information.

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

## What roles do I need {#choosing-roles}

The table below lists the roles needed to perform a particular action. You can always assign a role granting more permissions than the role specified. For example, you can assign the `speech-sense.editor` role for a space instead of `speech-sense.viewer`.

#|
|| **Action** | **Required role** ||
|| **Viewing information** ||
|| Viewing a space and all its nested projects | `speech-sense.auditor` ||
|| Viewing the characteristics of a space or a project | `speech-sense.viewer` ||
|| Viewing a project, its channels, and dialogs | `speech-sense.data.viewer` ||
|| **Managing a project** ||
|| Creating a project | `speech-sense.editor` ||
|| Modifying project settings | `speech-sense.editor` ||
|| Uploading and rating dialogs | `speech-sense.data.editor` ||
|| Commenting | `speech-sense.data.editor` ||
|| Creating connections | `speech-sense.editor` ||
|| Creating classifiers | `speech-sense.editor` ||
|| Running analysis | `speech-sense.editor` ||
|| Deleting a project | `speech-sense.admin` ||
|| Assigning roles for a project | `speech-sense.admin` ||
|| **Managing a space** ||
|| Modifying space settings | `speech-sense.editor` ||
|| Deleting a space | `speech-sense.admin` ||
|| Assigning roles for a space | `speech-sense.admin` ||
|#
