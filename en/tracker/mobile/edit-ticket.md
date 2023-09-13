# Editing an issue

To edit an issue, go to the issue page. If you don't have access to edit the issue, [request permissions](../faq.md#section_xgr_zng_4bb) from the queue owner  or your company's [admin](../role-model.md).

{% note info %}

The issue pages are updated in real time. If someone edits or comments on the issue whose page is open, you will see a notification about that in the bottom-right corner of the page.

{% endnote %}

## Changing issue names {#edit-name}

Tap the issue name. Edit the text and tap **{{ ui-key.startrek.ui_components_settings_IssueUpdatesSettings.save }}**.

## Editing issue descriptions {#edit-description}

To the right of the issue description, tap ![](../../_assets/tracker/icon-edit.png) and edit the text. Use [YFM markup](../user/markup.md) to format text. To save your changes, tap **{{ ui-key.startrek.ui_components_settings_IssueUpdatesSettings.save }}**.

You can use the issue description to specify a key for a different issue so that {{ tracker-name }} automatically links the issues. You will see the linked issue in the **{{ ui-key.startrek.ui_components_IssueTabs.links-tab }}** tab.


You can also [attach images or files](attach-file.md) to issue descriptions.

## Editing issue fields {#edit-fields}

The [issue details](../user/create-param.md#default-fields) are shown in the **{{ ui-key.startrek.ui_components_IssueTabs.fields-tab }}** tab. To change a parameter value, tap ![](../../_assets/tracker/mobile-params-open.png). Enter a new value and click **{{ ui-key.startrek.ui_components_settings_IssueUpdatesSettings.save }}**.

{% note info %}

If you do not see the required parameters, go to the web version and add them in the panel on the right by tapping ![](../../_assets/tracker/task-params-btn.png) **{{ ui-key.startrek.blocks-desktop_fields-switcher.switcher-title }}**.

{% endnote %}

The **{{ ui-key.startrek-backend.fields.issue.priority-key-value }}**, **{{ ui-key.startrek-backend.fields.issue.type-key-value }}**, **{{ ui-key.startrek-backend.fields.issue.assignee-key-value }}**, and **{{ ui-key.startrek-backend.fields.issue.dueDate-key-value }}** fields are also available in the **{{ ui-key.startrek.ui_components_IssueTabs.description-tab }}** tab. To edit their values, tap the parameter name, enter a new value, and tap **{{ ui-key.startrek.ui_components_settings_IssueUpdatesSettings.save }}**.

## Changing issue status {#edit-status}

To change an issue's status, open the drop-down list under the issue title and select the desired status.

## Configuring how issues are displayed {#edit-display}

You can manage your issues in {{ tracker-name }} more easily by customizing the appearance of the issue page, including the interface language, user and date display, and comment order. To do this, go to the web interface and open [**{{ ui-key.startrek.blocks-desktop_m-head.my-settings }}**](../user/personal.md).

## Other issue actions

You can add comments, links, and files, and perform other actions on issues:

* [{#T}](comments.md)
* [{#T}](checklist.md)
* [{#T}](ticket-links.md)
* [{#T}](attach-file.md)
