---
title: Adding a mailing list for a report in {{ datalens-full-name }}
description: Follow this guide to add a mailing list for a report in {{ datalens-name }}.
---

# Mailing lists for a report

You can set up a mailing list for your report by email. Recipients will get a `.pdf` file with the report pages specified in the mailing list settings. You can configure the schedule and recipients of the mailing list.

{% note info %}

* A user with the [role](../security/roles.md#datalens-workbooks-editor) `Editor` or higher for the workbook can add or update a mailing list.
* Mailing lists for reports are only available for reports stored in [workbooks](../workbooks-collections/index.md).
* [RLS](../security/row-level-security.md) is not supported in mailing lists.
* If a mailing list uses [shared objects](../security/workbooks-access-advanced.md), only the ones with access delegation configured are supported.

{% endnote %}

To add a mailing list for a report:

1. In the left-hand panel, select ![image](../../_assets/console-icons/display-pulse.svg) **Reports** and select the report you need.
1. At the top of the screen, click ![image](../../_assets/console-icons/ellipsis.svg) and select ![image](../../_assets/console-icons/envelope.svg) **Mailing lists**, or click ![image](../../_assets/console-icons/envelope.svg) in the top panel.
1. Specify the mailing list settings:

   * Mailing list name:
   
     1. Next to the **New mailing list** field, click ![image](../../_assets/console-icons/pencil.svg).
     1. Enter a mailing list name to display in the email header and subject line.

        Choose the name as per these requirements:

          * It starts and ends with an upper-case or lower-case Latin or Russian letter, number, or one of these characters: `_`, `@`, `(`, `)`, or `%`.
          * The remaining characters can be upper-case or lower-case Latin or Russian letters, numbers, spaces, or the following characters: `_`, `@`, `(`, `)`, `%`, `.`, `,`, `:`, `;`, `'`, `|`, `-`, `–`, `—`, `−`, `$`, `*`, and `&`.

     1. Optionally, enter a description for the mailing list.
     1. Click **Save**.

   * In the **What** step, set the mailing list content:

     * **File name**: Name of the file the report pages will be exported to.
     * **Format**: Export file format. Currently, only the `PDF` format is available.
     * **Pages**: Select which report pages to include in the mailing list:
       
       * **All**: All pages will be included.
       * **Some**: Specify one or more pages.

     After saving the mailing list, you can edit its content in the **Content** tab.

     {% cut "Mailing list content" %}

     ![report-maillist-content](../../_assets/datalens/report/report-maillist-content.png =687x436)
   
     {% endcut %}

   * Under **When**, specify the delivery settings:

     * **Trigger**: Set the event to trigger mailing list delivery. Currently, mailing lists support scheduled delivery. Delivery triggered by alerts or by updates to the dataset the report charts are built on will be available soon.

      {% list tabs %}

      - Schedule

        Set the mailing list delivery frequency:

        {% list tabs %}
        
        - Day

          The mailing list will be sent once a day. Specify the delivery time in the current time zone.

        - Week

          Specify the days of the week and the delivery time in the current time zone.

        - Month

          Specify the day of the month and the delivery time in the current time zone.

        {% endlist %}

      {% endlist %}

     After saving the mailing list, you can edit its delivery settings in the **Delivery** tab.

     {% cut "Mailing list delivery" %}

     ![report-maillist-sending](../../_assets/datalens/report/report-maillist-sending.png =687x436)
   
     {% endcut %}

   * In the **Email to** step, specify the mailing list recipients.

     
     {% note info %}

     * To receive the mailing list, a user must have an active seat.
     * If there are no recipients with an active seat, the mailing list will not be sent.
     * Only users who have a role for the workbook the mailing list is configured in can receive the mailing list.

     {% endnote %}


     {% include [datdatalens-maillist-add-recipients](../../_includes/datalens/datalens-maillist-add-recipients.md) %}
     
     After saving the mailing list, you can edit the recipient list in the **Recipients** tab.

     {% cut "Mailing list recipients" %}

     ![report-maillist-recipients](../../_assets/datalens/report/report-maillist-recipients.png =687x436)

     {% endcut %}

   * In the **History** tab, you can view the mailing list history including dates, times, and delivery status. Available after saving the mailing list.

     {% cut "Mailing list history" %}

     ![report-maillist-history](../../_assets/datalens/report/report-maillist-history.png =687x436)
   
     {% endcut %}

1. Click **Save**.

After you add a mailing list, it gets the `Active` status and is sent to the specified recipients according to the settings.

Each recipient will receive the mailing list email:

* The subject line displays the mailing list name.
* Attachment: a `.pdf` file named `<mailing_list_name> - <report_name> - <send_date_and_time>`.

* The email content displays:
  
  * The name of the report the mailing list was created for, and a link to it.
  * A link to unsubscribe from the mailing list.
  * A link to the {{ datalens-short-name }} service.

  {% cut "Mailing list email content" %}

  ![maillist-attachment](../../_assets/datalens/report/report-maillist-attachment.png =419x578)

  {% endcut %}

## Managing mailing lists {#maillist-operations}

You can change the settings, pause or resume, rename or delete a mailing list, subscribe or unsubscribe from it, or send it right away:

1. In the left-hand panel, select ![image](../../_assets/console-icons/display-pulse.svg) **Reports** and select the report you need.
1. At the top of the screen, click ![image](../../_assets/console-icons/envelope.svg).
1. In the list on the left, select the mailing list you need. You can use search by name or filter by mailing list status.
1. Perform the action you need:

   * Change the settings. Go to the tab you need and change the settings:
     
     * Content: Specify which page screenshots will be sent in the mailing list.
     * Delivery: Specify the delivery settings.
     * Recipients: Specify the mailing list recipients.
     * History: You can view the mailing list history including dates, times, and delivery status.

   * Send the mailing list right away. At the bottom of the mailing list window, click ![image](../../_assets/console-icons/envelope.svg) **Send** and select who to send the mailing list to: `Only me` or `All recipients`.

   * Subscribe or unsubscribe:
     
     * A user with minimum access to the workbook the mailing list is stored in can subscribe to it. To subscribe to the mailing list, click ![image](../../_assets/console-icons/bell.svg) **Subscribe** at the top below the mailing list name, or click ![image](../../_assets/console-icons/ellipsis.svg) → ![image](../../_assets/console-icons/bell.svg) **Subscribe**.
     * To unsubscribe from the mailing list, click ![image](../../_assets/console-icons/bell.svg) **Subscribed** at the top below the mailing list name, or click ![image](../../_assets/console-icons/ellipsis.svg) → ![image](../../_assets/console-icons/bell-slash.svg) **Unsubscribe**. You can also unsubscribe from the mailing list by following the corresponding link in the mailing list email.

   * Pause or resume:
     
     * To pause the mailing list, click ![image](../../_assets/console-icons/circle-play.svg) **Active** at the top below the mailing list name, or click ![image](../../_assets/console-icons/ellipsis.svg) → ![image](../../_assets/console-icons/pause.svg) **Pause**. The mailing list will get the `Paused` status and will not be sent.
     * To resume the mailing list, click ![image](../../_assets/console-icons/circle-pause.svg) **Paused** at the top below the mailing list name, or click ![image](../../_assets/console-icons/ellipsis.svg) → ![image](../../_assets/console-icons/play.svg) **Resume**. The mailing list will get the `Active` status and will be sent according to its settings.

   * Rename. To rename the mailing list, click ![image](../../_assets/console-icons/ellipsis.svg) at the top to the right of the mailing list name, or click ![image](../../_assets/console-icons/ellipsis.svg) → ![image](../../_assets/console-icons/pencil.svg) **Rename** below the name. In the window that opens, enter the mailing list name and description, then click **Save**.
   * Delete. To delete the mailing list, click ![image](../../_assets/console-icons/ellipsis.svg) → ![image](../../_assets/console-icons/trash-bin.svg) **Delete** at the top below the mailing list name.
