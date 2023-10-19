---
title: "How to create a trigger in {{ tracker-name }}"
description: "Follow this guide to create a trigger in {{ tracker-name }}."
---

# Creating a trigger in {{ tracker-name }}

{% note warning %}

Only [queue owners](../manager/queue-access.md) can create, edit, and delete triggers by default.

{% endnote %}

1. {% include [go to settings](../../_includes/tracker/transition-page.md) %}

1. In the top-right corner, click ![](../../_assets/tracker/svg/queue-settings.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. In the left-hand panel, select **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.group-title--automatization }}** → **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_triggers.title }}** and click **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_triggers.button-create }}**.

1. Enter a name for the trigger.

1. Set [**{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_trigger-editor.label_conditions }}**](set-condition.md).

1. Add one or more [**Trigger actions**](set-action.md).

1. Click **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_trigger-editor.action_create }}**.



