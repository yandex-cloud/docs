---
title: How to remove a user from a project
description: In this guide, you will learn how to remove a user from a project in {{ ml-platform-name }}.
---

# Removing a user from a project

{% note info %}

You can only remove a user if you have the `{{ roles-datasphere-project-admin }}` role in the project or the `{{ roles-datasphere-communities-admin }}` role in the project community.

{% endnote %}

1. {% include [include](../../../_includes/datasphere/ui-find-project.md) %}
1. Go to the **{{ ui-key.yc-ui-datasphere.project-page.tab.members }}** tab.
1. Click ![image](../../../_assets/console-icons/ellipsis.svg) next to the user and select **{{ ui-key.yc-ui-datasphere.common.member.remove }}**.
1. Click **{{ ui-key.yc-ui-datasphere.common.submit }}**.
1. If you used a link to add this user, recreate it:
    * Click **{{ ui-key.yc-ui-datasphere.common.add-member }}**.
    * At the bottom of the window that opens, click **{{ ui-key.yc-ui-datasphere.invite-link.reset-invitation-link }}** ⟶ **{{ ui-key.yc-ui-datasphere.invite-link.reset-link }}**.
