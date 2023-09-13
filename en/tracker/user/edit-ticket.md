# Editing an issue

To edit an issue, go to the issue page. If you don't have access to edit the issue, [request permissions](../faq.md#section_xgr_zng_4bb) from the queue owner  or your company's [admin](../role-model.md).

{% note info %}

The issue pages are updated in real time. If someone edits or comments on the issue whose page is open, you will see a notification about that in the bottom-right corner of the page.

{% endnote %}

## Changing issue names {#edit-name}

Tap the issue name. Edit the text and press **Enter**.

## Editing issue descriptions {#edit-description}

To the right of the issue description, tap ![](../../_assets/tracker/svg/icon-edit.svg) and edit the text. Use [YFM markup](markup.md) to format text. To save your changes, click **{{ ui-key.startrek.blocks-desktop_b-form-new-component.button-update }}**.


You can use the issue description to specify a key for a different issue so that {{ tracker-name }} automatically links the issues. When entering the issue key, use ALL CAPS.


You can also [attach images or files](attach-file.md) to issue descriptions.

## Editing issue fields {#edit-fields}

The [issue details](create-param.md##default-fields) are shown in the panel on the right. To edit the parameter's value, click its name and select a new value.

If you do not see the desired parameters in the right-hand panel, add them by clicking **{{ ui-key.startrek.ui_components_PageCreateIssue.add-parameter }}**.

To edit the parameters of multiple issues at once, use [bulk operations](../manager/bulk-change.md#change-parameters).

## Changing issue status {#edit-status}

To change the issue status, in the right-hand panel, select a new value in the **{{ ui-key.startrek.blocks-desktop_b-ticket-fields.status }}** field.

To edit the statuses of multiple issues at once, use [bulk operations](../manager/bulk-change.md#change-status).

## Configuring how issues are displayed {#edit-display}

You can manage your issues in {{ tracker-name }} more easily by customizing the appearance of the issue page, including the interface theme and language, user and date display. To do this, go to [**{{ ui-key.startrek.blocks-desktop_b-head.settings }}**](personal.md).

The settings specified for the web interface automatically apply to the mobile app.

## Other issue actions

You can add comments, links, and files, and perform other actions on issues:

* [{#T}](comments.md)
* [{#T}](checklist.md)
* [{#T}](ticket-links.md)
* [{#T}](attach-file.md)
* [{#T}](move-ticket.md)
