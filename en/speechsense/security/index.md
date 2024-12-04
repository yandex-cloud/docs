---
title: Access management in {{ speechsense-full-name }}
description: Access management in {{ speechsense-full-name }}, a speech analytics service. For access to {{ speechsense-name }} resources, assign to the user the required roles from the list below.
---

# Access management in {{ speechsense-name }}

User access to {{ speechsense-full-name }} depends on relevant permissions granted within an organization. Organizations are managed using [{{ org-full-name }}](../../organization/).

The operations available to {{ speechsense-name }} users are determined by their roles. You can assign roles to a Yandex account, [service account](../../iam/concepts/users/service-accounts.md), [federated users](../../iam/concepts/federations.md), [user group](../../organization/operations/manage-groups.md), [system group](../../iam/concepts/access-control/system-group.md), or [public group](../../iam/concepts/access-control/public-group.md). For more information about access management in {{ yandex-cloud }}, see [{#T}](../../iam/concepts/access-control/index.md).

Only users with the `admin`, `resource-manager.clouds.owner`, or `organization-manager.organizations.owner` role for a resource can assign roles for this resource.

## Which resources you can assign a role for {#resources}

In the [{{ speechsense-name }} interface]({{ link-speechsense-main }}), you can assign a role for a [space](../concepts/resources-hierarchy.md#space) or [project](../concepts/resources-hierarchy.md#project). Roles assigned for a space also apply to all nested projects and resources.

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

Users with `speech-sense.data.*` roles can view and rate the contents of documents but have no access to aggregated information.

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## What roles do I need {#choosing-roles}

The table below lists the roles required to perform a particular action. You can always assign a role offering more permissions than the one specified. For example, you can assign the `speech-sense.editor` role for a space instead of `speech-sense.viewer`.

#|
|| **Action** | **Required roles** ||
|| **Viewing data** ||
|| Viewing a space and all its projects | `speech-sense.auditor` ||
|| Viewing space and project specifications | `speech-sense.viewer` ||
|| Viewing a project, its channels and dialogs | `speech-sense.data.viewer` ||
|| **Project management** ||
|| Creating a project | `speech-sense.editor` ||
|| Editing project settings | `speech-sense.editor` ||
|| Uploading and rating dialogs | `speech-sense.data.editor` ||
|| Writing comments | `speech-sense.data.editor` ||
|| Creating connections | `speech-sense.editor` ||
|| Creating classifiers | `speech-sense.editor` ||
|| Running analysis | `speech-sense.editor` ||
|| Deleting a project | `speech-sense.admin` ||
|| Granting a role in a project | `speech-sense.admin` ||
|| **Space management** ||
|| Editing space settings | `speech-sense.editor` ||
|| Deleting a space | `speech-sense.admin` ||
|| Granting a role in a space | `speech-sense.admin` ||
|#
