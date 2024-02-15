---
title: "How to create an OS Login profile"
description: "Follow this guide to create an OS Login profile."
---

# Creating an OS Login profile

{% include notitle [preview](../../_includes/note-preview-by-request.md) %}

By default, [enabling the setting](./os-login-access.md) creates OS Login profiles for all users within your organization. If necessary, you can create additional profiles or edit existing ones. You can use OS Login profiles as user profiles when working within VM instances.

{% list tabs group=instructions %}

- {{ org-name }} interface {#cloud-org}

  1. [Log in]({{ link-passport-login }}) as the organization administrator or owner.
  1. Go to [{{ org-full-name }}]({{ link-org-main }}).
  1. [Switch](./manage-organizations.md#switch-to-another-org) to an organization or federation of your choice as needed.
  1. In the left-hand panel, select [{{ ui-key.yacloud_org.pages.users }}]({{ link-org-users }}) ![icon-users](../../_assets/console-icons/person.svg).
  1. Select a user from the list.
  1. Go to the **{{ ui-key.yacloud_org.page.user.title_tab-os-login }}** tab.
  1. Click **{{ ui-key.yacloud_org.entity.oslogin-profile.action.create }}**.
  1. Enter a username and a unique numeric ID.
  1. (Optional) Enter the path to the user's home directory.
  1. (Optional) Enter the path to the shell executable file.
  1. Click **{{ ui-key.yacloud_org.forms.action.create }}**.

{% endlist %}
