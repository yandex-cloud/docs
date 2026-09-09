---
title: Adding a mailing list for a report in {{ datalens-full-name }}
description: Follow this guide to add a mailing list for a report in {{ datalens-name }}.
---

# Mailing lists for reports

You can set up a mailing list for a report. The email will deliver a `.pdf` file containing the report pages you specify in the mailing list settings. You can set up the schedule and your mailing list recipients.

{% note info %}

* To add or update a mailing list, you need the `Editor` [role](../security/roles.md#datalens-workbooks-editor) or higher for the workbook.
* Mailing lists are only available for reports located in [workbooks](../workbooks-collections/index.md).
* Mailing lists do not support [RLS](../security/row-level-security.md).
* Mailing lists only support [shared objects](../security/workbooks-access-advanced.md) that are configured to allow delegated access permissions.

{% endnote %}

To add a mailing list for your report:

1. In the left-hand panel, click ![image](../../_assets/console-icons/display-pulse.svg) **Reports** and select the report.
1. At the top of the screen, click ![image](../../_assets/console-icons/ellipsis.svg) and select ![image](../../_assets/console-icons/envelope.svg) **Mailing lists** or click ![image](../../_assets/console-icons/envelope.svg) in the top panel.
1. Specify the mailing list settings:

   * Mailing list name:
   
     1. Next to the **New mailing list** field, click ![image](../../_assets/console-icons/pencil.svg).
     1. Enter a mailing list name to display in the email header and subject line.

        Choose the name as per these requirements:

          * It starts and ends with an upper-case or lower-case Latin or Russian letter, number, or one of these characters: `_`, `@`, `(`, `)`, or `%`.
          * The remaining characters can be upper-case or lower-case Latin or Russian letters, numbers, spaces, or the following characters: `_`, `@`, `(`, `)`, `%`, `.`, `,`, `:`, `;`, `'`, `|`, `-`, `–`, `—`, `−`, `$`, `*`, and `&`.

     1. Optionally, enter a description for the mailing list.
     1. Click **Save**.

   * In the **What** step, set the email content:

     * **File name**: Name of the file to export report pages to.
     * **Format**: Export file format. Currently, the supported format is `PDF`.
     * **Pages**: Select the report pages to include into the mailing list:
       
       * **All**: Choose to include all the pages.
       * **Specific**: Specify one or multiple pages.

     After saving the mailing list, you can edit the email content in the **Content** tab.

     {% cut "Mailing list email content" %}

     ![report-maillist-content](../../_assets/datalens/report/report-maillist-content.png =687x436)
   
     {% endcut %}

   * Under **When**, specify the delivery settings:

     * **Trigger**: Set the event to trigger email delivery. Currently, mailing lists support scheduled delivery. Delivery triggered by alerts will be available soon, as well as by updates to the dataset sourcing the report charts.

      {% list tabs %}

      - Schedule

        Set the email frequency:

        {% list tabs %}
        
        - Day

          Emails will be sent once a day. Specify the mailing time in the current time zone.

        - Week

          Select the days of the week and set the mailing time in the current time zone.

        - Month

          Specify the day of the month and time in the current time zone.

        {% endlist %}

      {% endlist %}

     After saving the mailing list, you can edit its delivery settings in the **Delivery** tab.

     {% cut "Mailing list email delivery" %}

     ![report-maillist-sending](../../_assets/datalens/report/report-maillist-sending.png =687x436)
   
     {% endcut %}

   * Under **Email to**, specify the recipients.

     
     {% note info %}

     * To receive the emails, a user must have an active seat.
     * If there are no recipients with an active seat, no emails will be sent.
     * To receive the emails, the users must be assigned a role for the parent workbook.

     {% endnote %}


     {% include [datdatalens-maillist-add-recipients](../../_includes/datalens/datalens-maillist-add-recipients.md) %}
     
     After saving the mailing list, you can edit the recipients in the **Recipients** tab.

     {% cut "Mailing list recipients" %}

     ![report-maillist-recipients](../../_assets/datalens/report/report-maillist-recipients.png =687x436)

     {% endcut %}

   * In the **History** tab, you can view the mailing list history including dates, times, and delivery status. You can access history after saving the mailing list.

     {% cut "Mailing list history" %}

     ![report-maillist-history](../../_assets/datalens/report/report-maillist-history.png =687x436)
   
     {% endcut %}

1. Click **Save**.

After you add a mailing list, it becomes `Active`, and the system starts sending emails to the specified recipients according to the delivery settings.

Each recipient will receive the mailing list email:

* The subject displays the mailing list name.
* The attachment includes a `.pdf` file named as follows: `<mailing_list_name> - <report_name> - <datetime_of_sending>`.

* The email body contains:
  
  * Name of the report used to create the mailing list and its link.
  * Link to unsubscribe from the mailing list.
  * Link to {{ datalens-short-name }}.

  {% cut "Mailing list email contents" %}

  ![maillist-attachment](../../_assets/datalens/report/report-maillist-attachment.png =419x578)

  {% endcut %}

## Managing mailing lists {#maillist-operations}

You can rename or delete a mailing list, change its settings, pause or resume deliveries, subscribe or unsubscribe from a list, or send an email immediately:

1. In the left-hand panel, click ![image](../../_assets/console-icons/display-pulse.svg) **Reports** and select the report.
1. Click ![image](../../_assets/console-icons/envelope.svg) at the top of the screen.
1. In the list on the left, select the mailing list. You can search by name or sort mailing lists by status.
1. Proceed with the relevant action:

   * Update settings. Go to the relevant tab and update the settings as follows:
     
     * Contents: Specify which pages to capture as screenshots and include in mailing list emails.
     * Sending: Specify the delivery settings.
     * Recipients: Specify the recipients.
     * History: View the mailing list history including dates, times, and delivery status.

   * Send an email immediately. At the bottom of the mailing lists window, click ![image](../../_assets/console-icons/envelope.svg) **Send** and select who will receive the email: `Only me` or `All recipients`.

   * Subscribe or unsubscribe:
     
     * Users with at least minimal access to the parent workbook can subscribe to a mailing list. To subscribe to a mailing list, click ![image](../../_assets/console-icons/bell.svg) **Subscribe** at the top below the mailing list name, or click ![image](../../_assets/console-icons/ellipsis.svg) → ![image](../../_assets/console-icons/bell.svg) **Subscribe**.
     * To unsubscribe from a mailing list, click ![image](../../_assets/console-icons/bell.svg) **Subscribed** at the top below the mailing list name, or click ![image](../../_assets/console-icons/ellipsis.svg) → ![image](../../_assets/console-icons/bell-slash.svg) **Unsubscribe**. You can also unsubscribe from a mailing list by clicking the relevant link inside the email.

   * Pause or resume deliveries:
     
     * To pause a mailing list, click ![image](../../_assets/console-icons/circle-play.svg) **Active** at the top below the mailing list name, or click ![image](../../_assets/console-icons/ellipsis.svg) → ![image](../../_assets/console-icons/pause.svg) **Pause**. The mailing list status will switch to `Paused`, and email deliveries will be suspended.
     * To activate a mailing list, click ![image](../../_assets/console-icons/circle-pause.svg) **Paused** at the top below the mailing list name, or click ![image](../../_assets/console-icons/ellipsis.svg) → ![image](../../_assets/console-icons/play.svg) **Resume**. The mailing list status will switch to `Active`, and email deliveries will resume according to the mailing list settings.

   * Rename. To rename a mailing list, click ![image](../../_assets/console-icons/ellipsis.svg) at the top to the right of the mailing list name, or click ![image](../../_assets/console-icons/ellipsis.svg) → ![image](../../_assets/console-icons/pencil.svg) **Rename** below its name. In the window that opens, enter the mailing list name and description and click **Save**.
   * Delete. To delete a mailing list, click ![image](../../_assets/console-icons/ellipsis.svg) → ![image](../../_assets/console-icons/trash-bin.svg) **Delete** at the top below the mailing list name.
