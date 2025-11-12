---
title: How to view user groups
description: Follow this guide to view user groups.
---

# Viewing user groups

To view which [groups](../../organization/concepts/groups.md) a specific [user](../../overview/roles-and-resources.md#users) belongs to, do the following:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Go to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![icon-users](../../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}** and select the user from the list that opens.

      Optionally, use the search bar or filter at the top of the page.
  1. Navigate to the **{{ ui-key.yacloud_org.user.title_groups }}** tab.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command to view user's groups:

     ```bash
     yc organization-manager group list-effective --help
     ```

  1. [Get the user ID](users-get.md).
  
  1. Run this command:

     ```bash
     yc organization-manager group list-effective --subject_id <user_ID>
     ```

     Where `--subject_id` is the user ID you got in the previous step.

{% endlist %}