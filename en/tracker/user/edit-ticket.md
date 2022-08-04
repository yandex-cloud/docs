# Editing an issue

To edit an issue, go to the issue page. If you don't have edit rights to an issue, [request permissions](../faq.md#section_xgr_zng_4bb) from the queue owner  or your organization's [admin](../role-model.md).

{% note info %}

Issue pages are updated in real time. If someone edits or adds a comment to an issue that you have open in your browser, you will immediately see a notification on the browser tab.

{% endnote %}

## Changing issue names {#section_name}

{% list tabs %}

- Web interface

  To the right of the issue name, click ![](../../_assets/tracker/icon-edit.png). Edit the text and click ![](../../_assets/tracker/approve-checkmark.png) or press Enter.

- Mobile app

  Tap the issue name. Edit the text and tap **Save**.

{% endlist %}

## Editing issue descriptions {#section_yrw_npn_jz}

{% list tabs %}

- Web interface

  To the right of the issue description, click ![](../../_assets/tracker/icon-edit.png) and edit the text. Use [the YFM markup](markup.md) to format text. Click **Save** to save your changes.

  If you close or refresh the page without saving your changes, the new description will still be stored in drafts. You can restore that description by clicking the edit icon ![](../../_assets/tracker/icon-edit.png), clicking ![](../../_assets/tracker/drafts.png) in the toolbar, and choosing the draft.

  You can use the issue description to specify a key for a different issue so that {{ tracker-name }} automatically links the issues.



- Mobile app

  To the right of the issue description, tap ![](../../_assets/tracker/icon-edit.png) and edit the text. Use [the YFM markup](markup.md) to format text. Click **Save** to save your changes.

  You can use the issue description to specify a key for a different issue so that {{ tracker-name }} automatically links the issues. You'll see the linked issue on the **Related** tab.



{% endlist %}

You can also [attach images or files](attach-file.md) to issue descriptions.

## Editing issue fields {#section_jqw_ppn_jz}

{% list tabs %}

- Web interface

  [The issue details](create-param.md#section_ymd_ycj_1gb) are shown in the panel on the right. To change one of the values, click the name of the field. To save your changes, click **OK**.

  If you don't see the desired fields in the right panel, add them by clicking ![](../../_assets/tracker/task-params-btn.png) **Select fields**.

- Mobile app

  [The issue details](create-param.md#section_ymd_ycj_1gb) are shown on the **Parameters** tab. To change a parameter value, tap ![](../../_assets/tracker/mobile-params-open.png). Enter a new value and tap **Save**.

  {% note info %}

  If you don't see the desired parameters, go to the web version and add them in the panel on the right by clicking ![](../../_assets/tracker/task-params-btn.png) **Select fields**.

  {% endnote %}

  The **Priority**, **Type**, **Assignee**, and **Deadline** fields are also available on the **Description** tab. To edit their values, tap the parameter name, enter a new value, and tap **Save**.

{% endlist %}

## Changing issue status {#section_status}

{% list tabs %}

- Web interface

  To change an issue's status, click the button with the status name under the issue title to the left of the **Actions** button.

- Mobile app

  To change an issue's status, open the drop-down list under the issue title and select the desired status.

{% endlist %}

## Configuring how issues are displayed {#section_display}

{% list tabs %}

- Web interface

  You can manage your issues in {{ tracker-name }} more easily by customizing the appearance of the issue page, including the interface language, user and date display, and comment order. To do this, go to [**Personal settings**](personal.md).

  The settings specified for the web interface automatically apply to the mobile app.

- Mobile app

  You can manage your issues in {{ tracker-name }} more easily by customizing the appearance of the issue page, including the interface language, user and date display, and comment order. To do this, go to the web interface and open [**Personal settings**](personal.md).

{% endlist %}

## Other issue actions

You can add comments, links, and files, and perform other actions on issues:

* [{#T}](comments.md)
* [{#T}](checklist.md)
* [{#T}](ticket-links.md)
* [{#T}](attach-file.md)
* [{#T}](move-ticket.md)

