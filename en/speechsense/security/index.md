---
title: Access management in {{ speechsense-full-name }}
description: Access management in the {{ speechsense-full-name }} speech analytics service. To grant access to {{ speechsense-name }} resources, assign relevant roles from the list to the user.
---

# Access management in {{ speechsense-name }}

User access to {{ speechsense-full-name }} depends on relevant permissions granted within an organization. Organizations are managed using [{{ org-full-name }}](../../organization/).

The operations available to {{ speechsense-name }} users are determined by their roles. You can assign roles to a Yandex account, [service account](../../iam/concepts/users/service-accounts.md), [federated users](../../iam/concepts/federations.md), [user group](../../organization/operations/manage-groups.md), [system group](../../iam/concepts/access-control/system-group.md), or [public group](../../iam/concepts/access-control/public-group.md). For more information about managing access to {{ yandex-cloud }}, see [{#T}](../../iam/concepts/access-control/index.md).

Only users with the `admin`, `resource-manager.clouds.owner`, or `organization-manager.organizations.owner` role for a resource can assign roles for this resource.

## Which resources you can assign a role for {#resources}

You can assign a role for a space or a project. Roles assigned for a space also apply to all nested projects and resources.

## Which roles exist in the service {#roles-list}

### Service roles {#service-roles}

#### speech-sense.auditor {#speechsense-auditor}

{% include [speechsense-auditor](../../_roles/speech-sense/auditor.md) %}

#### speech-sense.viewer {#speechsense-viewer}

{% include [speechsense-viewer](../../_roles/speech-sense/viewer.md) %}

#### speech-sense.editor {#speechsense-editor}

{% include [speechsense-editor](../../_roles/speech-sense/editor.md) %}

#### speech-sense.admin {#speechsense-admin}

{% include [speechsense-admin](../../_roles/speech-sense/admin.md) %}

#### speech-sense.spaces.creator {#speechsense-spaces-creator}

{% include [speechsense-spaces-creator](../../_roles/speech-sense/spaces/creator.md) %}

#### speech-sense.data.viewer {#speechsense-data-viewer}

{% include [speechsense-data-viewer](../../_roles/speech-sense/data/viewer.md) %}

#### speech-sense.data.editor {#speechsense-data-editor}

{% include [speechsense-data-editor](../../_roles/speech-sense/data/editor.md) %}

Users with roles like `speech-sense.data.*` can view and rate the contents of documents but do not have access to aggregate information.

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## What roles do I need {#choosing-roles}

The table below lists the roles required to perform a particular action. You can always assign a role offering more permissions than the one specified. For example, you can assign the `speech-sense.editor` role for a space instead of `speech-sense.viewer`.

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
