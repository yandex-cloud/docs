---
title: How to create a user pool in {{ org-full-name }}
description: Follow this guide to create a user pool in {{ org-name }}.
---

# Creating a user pool


{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}**.  
  1. In the top-right corner of the page, click ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.organization.userpools.action_create-userpool }}**.
  1. Enter a name and description for the [user pool](../../../organization/concepts/user-pools.md).

      The name must be unique within the organization and aligned with the naming requirements:

      {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}

  1. In the **{{ ui-key.yacloud_org.form.userpool.caption.domain }}** field, add the [domain](../../concepts/domains.md) that will be used for all the default pool users.
  1. Optionally, add labels:
     1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
     1. Enter a label in `key: value` format.
     1. Press **Enter**.
  1. Click **{{ ui-key.yacloud_org.form.userpool.create.action.create }}**.

{% endlist %}

#### See also {#see-also}

* [{#T}](add-user.md)
* [{#T}](add-domain.md)