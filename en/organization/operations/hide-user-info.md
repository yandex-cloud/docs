---
title: How to hide information about organization members in {{ org-full-name }}
description: Follow this guide to block organization users from viewing information about other organization members.
---

# Blocking users from viewing information about organization members

By default, all {{ org-name }} users can view information about all other users in the same organization. You can restrict this access by reserving it for individual users only. User visibility restriction will only apply within {{ yandex-cloud }} and will not affect external services.

Before you block access to the information about organization members, make sure to [grant](./add-role.md) this access to the appropriate users.

{% cut "Roles allowing users to view information about organization members:" %}

* `auditor`
* `viewer`
* `editor`
* `admin`
* `organization-manager.users.viewer`
* `organization-manager.groups.memberAdmin`
* `organization-manager.federations.userAdmin`
* `organization-manager.viewer`
* `organization-manager.admin`
* `organization-manager.organizations.owner`

{% endcut %}

{% note alert %}

When assigning user roles, for security reasons, apply the [least privilege principle](../../security/domains/iam-checklist.md#resources-and-roles), i.e., assign roles with minimal permissions to perform only the required tasks.

{% endnote %}


To block users from viewing information about other organization members:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.

      [Switch](./manage-organizations.md#switch-to-another-org) to an organization or federation of your choice as needed.

  1. At the top of the screen, navigate to the **{{ ui-key.yacloud_org.layout.organization }}** tab.

  1. In the left-hand panel, select ![shield](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.pages.oslogin.title }}**.

  1. Under **{{ ui-key.yacloud_org.organization.security-settings.OtherSecuritySettingsForm.title_users-list-visibility_ftTaP }}**, enable **{{ ui-key.yacloud_org.organization.security-settings.OtherSecuritySettingsForm.title_hide-users-list_9eW2W }}**.

      Disable this option to allow users to view information about other organization members.

{% endlist %}
