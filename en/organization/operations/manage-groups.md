# Managing user groups

You can [group](../concepts/groups.md) users by any criteria, e.g., by their duties or department.

## Creating a group {#create-group}

{% include [create-group-org](../../_includes/organization/create-group-org.md) %}

## Adding members {#add-member}

{% include [group-add-member.md](../../_includes/organization/group-add-member.md) %}

## Editing a group {#edit-group}

{% include [group-edit](../../_includes/organization/group-edit.md) %}

## Setting up permissions to manage a group {#access-manage-group}

Change a [subject's](../../iam/concepts/access-control/index.md#subject) access bindings to a group as a resource.

### Assigning a role {#set-access-binding}

{% include [accessbinding-group-as-object](../../_includes/organization/accessbinding-group-as-object.md) %}

### Revoking a role {#remove-access-binding}

{% include [accessbinding-remove](../../_includes/organization/accessbinding-remove.md) %}

## Setting up a group's access to use {{ yandex-cloud }}{#access}

To enable group members to work with {{ yandex-cloud }} services, assign the appropriate [roles](../../iam/concepts/access-control/roles.md) to the group.

### Assigning a role for a separate resource {#access-services}

In the management console, you can assign a role for a cloud, folder, or service account.

To grant a group access to a resource:

{% include [accessbinding-group-as-subject](../../_includes/organization/accessbinding-group-as-subject.md) %}

### Assigning a role for an entire organization {#access-organization}

A role granted for the entire organization allows group members to manage any {{ yandex-cloud }} resources activated for the organization as per the role's permissions.

{% include [accessbinding-group-as-subject-org](../../_includes/organization/accessbinding-group-as-subject-org.md) %}

## Mapping user groups {#group-mapping}

{% include notitle [preview](../../_includes/note-preview-by-request.md) %}

To configure user access to {{ yandex-cloud }} resources using [group mapping](../concepts/add-federation.md#group-mapping):

1. [Create user groups](#create-group) in {{ org-name }}.
1. [Configure access rights](#access) to {{ yandex-cloud }} resources.
1. Create user groups in your [identity provider](../concepts/add-federation.md#federation-usage) and add users to them.

   {% note info %}

   You can use existing user groups.

   {% endnote %}

1. Set up user group mapping in the identity provider's SAML attribute settings. Follow the guide that corresponds to your identity vendor:

   * [Microsoft AD FS](https://learn.microsoft.com/en-us/power-pages/security/authentication/saml2-settings#create-an-ad-fs-relying-party-trust)
   * [Google](https://support.google.com/a/answer/11143403?sjid=815248229840499495-EU)
   * [KeyCloak](https://www.keycloak.org/docs/22.0.3/server_admin/#_protocol-mappers). After completing the steps described in the guide, set **Group attribute name** to `member`.

1. Set up user group mapping in the federation settings:

   1. [Log in to an account]({{ link-passport-login }}) that belongs to an organization administrator or owner.
   1. Go to [{{ org-full-name }}]({{ link-org-main }}).
   1. In the left-hand panel, select ![icon-federation](../../_assets/organization/icon-federation.svg) [{{ ui-key.yacloud_org.pages.federations }}]({{ link-org-federations }}).
   1. Select a federation and open the **{{ ui-key.yacloud_org.form.group-mapping.note.tab-idp }}** tab.
   1. Enable **{{ ui-key.yacloud_org.form.group-mapping.field.idp }}**.
   1. Click **{{ ui-key.yacloud_org.form.group-mapping.create.add }}** and configure mapping:
      * **{{ ui-key.yacloud_org.form.group-mapping.note.group-name }}**: Enter the name of an identity provider group.
      * **{{ ui-key.yacloud_org.form.group-mapping.note.iam-group }}**: Select a {{ org-name }} group from the list.
   1. Repeat the previous step for each group you want to map.
