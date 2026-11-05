---
title: How to add a member to {{ video-full-name }}
description: Follow this guide to add a member to {{ video-full-name }}.
---

# Adding a member

{% list tabs group=instructions %}

- {{ video-name }} UI {#console}

  1. Open the {{ video-name }} [home page]({{ link-video-main }}).
  1. Click **{{ ui-key.yacloud_video.dashboard.action_add-user }}** to invite a user to an [organization](../../organization/quickstart.md). In the window that opens:
  
      1. Enter the email address of the user you want to invite to the organization, e.g., `login@yandex.ru`.

          You can specify multiple email addresses separated by commas to [invite](../../organization/operations/add-account.md#send-invitation) several users in one go.
      1. To send invitations, click **{{ ui-key.yacloud_components.organization.action_next }}**. This will open the window for assigning roles and adding users to the group.

      1. {% include [assign-roles-on-invite](../../_includes/organization/assign-roles-on-invite.md) %}

          For example, you can assign the `video.editor` role to create, modify, and delete {{ video-full-name }} resources and to stream video or the `video.viewer` role only to view the resources.

      1. {% include [add-to-group-on-invite](../../_includes/organization/add-to-group-on-invite.md) %}

      1. Click **{{ ui-key.yacloud.common.save }}**.
  
  {{ video-name }} will become available to the users you invite after they accept the invitation and get the required permissions to use {{ video-full-name }}.

{% endlist %}