---
title: "How to migrate to {{ tracker-full-name }} from other services"
description: "Follow this guide to migrate to {{ tracker-full-name }} from other services."
---

# Migrating to {{ tracker-name }} from other services

If you manage your issues and projects with a certain service and want to change it to {{ tracker-full-name }}, you can migrate the data about your projects and issues to {{ tracker-name }}:

* If you are running Jira, our experts will help you migrate the data to {{ tracker-name }}. For this, follow the [instruction below](#jira) to prepare your data for migration and write to [support]({{ link-tracker-support }}).

* If you are running some other system (Asana, Wrike, YouTrack, or others), we'll help you select a partner company that will migrate your data to {{ tracker-name }}. To do this, submit a request using a [form]({{ link-migration-form }}).

* If you want to self-migrate the data, you can [use the API](#diy) to import your data to {{ tracker-name }} or upload a list of issues from an Excel spreadsheet using the [Python client](#excel).

## Migrating data from Jira {#jira}


1. [Connect {{ tracker-full-name }}](enable-tracker.md).

1. [Add your company's employees to {{ tracker-name }}](add-users.md).

1. Create an auxiliary account to access {{ api-name }}:

   1. Create a new account on Yandex (in the format: `{{ example-account }}`).

   1. [Add](add-users.md#invite_user) the account created to {{ tracker-name }}.

   1. Go to [{{ ya-360 }}]({{ link-ya-360 }}) and add administrative rights to the account that you created. To learn more, see [{{ yandex-360 }} Help]({{ support-business-admin }}).

   Once the migration is complete, you can delete the account or revoke the administrative rights.

1. Export your data from Jira.

   {% cut "How to export data" %}

   1. In Jira, select **Settings** > **System**.

   1. Under **IMPORT AND EXPORT**, select **Backup manager**.

   1. Under **Backup for Server**, enalbe **Include additional files**, then select **Create backup for server**.

      {% note warning %}

      Even in case you run a cloud-based version of Jira, create a server backup (**Backup for Server**).

      Create a cloud backup (**Backup for cloud**) only in case creating a server backup is unavailable.

      {% endnote %}

   1. When the backup is created, click **Download backup file**.

   For more information about data export, see the [Jira documentation](https://support.atlassian.com/jira-cloud-administration/docs/export-issues/).

   {% endcut %}

1. Create a table of correspondence between the Jira users and {{ tracker-name }} users.

1. Upload the archive with the exported data and the user correspondence table to Yandex Disk or similar service.

   {% note info %}

   If you don't use cloud services for storing files and don't know where to upload the data, tell this when you contact support. Support engineers will instruct you how to provide the data.

   {% endnote %}

1. Write a request to [support]({{ link-tracker-support }}) for migrating from Jira to {{ tracker-name }}. In the request, specify:

   * Links to the archive with exported data and the user correspondence table.

   * Credentials of the auxiliary administrative account.

1. Wait until the support employees tell you that the migration is complete.

   It's any additional information or actions are required on your part to complete the migration, our support experts will contact you.

1. When the migration is complete, grant to your employees [full access](access.md) to {{ tracker-name }}, assign [access rights for queues](manager/queue-access.md), delete the auxiliary administrative account.

## Migrating data from Excel {#excel}

If you have a list of issues in an Excel spreadsheet, you can migrate the data to {{ tracker-name }} using a Python client.

The spreadsheet must include columns with issue parameters. The same column names must be used in the script that processes the Excel file.

1. [Connect {{ tracker-full-name }}](enable-tracker.md).

1. [Add your company's employees to {{ tracker-name }}](add-users.md).

1. Get [access to the API](concepts/access.md#section_about_python_client).

1. [Create queues](manager/create-queue.md) to import your issues to.

1. Set up queue:

   - Add [issue types and resolutions](manager/add-ticket-type.md).

   - Set up [statuses](manager/workflow.md).

   - Create [versions](manager/versions.md) and [components](manager/components.md).

1. If necessary, create [issue boards](manager/create-agile-board.md) and [sprints](manager/create-agile-sprint.md).

1. Create an Excel spreadsheet with issue data.

1. Create a Python client:

   1. [Install the Python client](user/python.md).

   1. Initialize the client.

      ```
      from yandex_tracker_client import TrackerClient
      client = TrackerClient(token='<token>', org_id='<org_id>')
      ```
      Here, `<token>` is your OAuth token and `<org_id>` is your organization ID. To find out the organization ID, go to the [settings page {{ tracker-name }}]({{ link-settings }}). The ID is specified in the **Organization ID for API** field.

   1. Attach libraries.

      ```
      from datetime import datetime
      import pandas as pd
      import numpy as np
      ```

1. Run the script to upload the data from the spreadsheet.

   The Python script loads the issues from the file to the specified queue. Assign the values from the spreadsheet columns to issue fields in the script.

   Let's look at an example of how the script will import the spreadsheet with the column names **Issue**, **Description**, **End date**, **Assignee**. You can add other fields to the spreadsheet and the script.

   {% cut "How to execute the script?" %}

   1. Upload the data file.

      ```
      df = pd.read_excel(r'C:\<file path>\<file name>.xls')
      ```

   1. Check that the names of the spreadsheet columns have been added to the script.

      ```
      for i, row in df.iterrows():
         print(f"Index: {i}")
         print(f"{row['Issue']}")
         print(f"{row['Description']}")
         print(f"{row['End date']}")
         print(f"{row['Assignee']}")
      ```

   1. Create the issues. If needed, update the reporter name or edit other issue attributes.

      ```
      for i, row in df.iterrows():

            try:
                end=row['End date'].strftime("%Y-%m-%d")
            except Exception as e:
                end=""

            issue=client.issues.create(
                queue='TEST',
                summary=row['Issue'],
                type={'name': 'Issue'},
                description=row['Description']+"\n\nAdditional description :\n\nhttps://tracker.yandex.ru/",
                assignee=row['Assignee'],
                end=end
       )
            issue.update(author='<login>')
            issue.update(<Field key>='<value>')

      ```
   {% endcut %}

## Migrating data by the API {#diy}

To migrate to {{ tracker-name }}, you need to export the data from your current system and convert it to the format supported by {{ tracker-name }}. To automate data migration, you'll need to engage a developer or a systems integrator company.

To learn more about the data format used in {{ api-name }}, see the [API reference](concepts/import/import-ticket.md).

To import the data:

1. [Connect {{ tracker-full-name }}](enable-tracker.md).

1. [Add your company's employees to {{ tracker-name }}](add-users.md).

1. Get [access to the API](concepts/access.md).

1. [Create queues](manager/create-queue.md) to import your issues to.

1. Set up queue:

   - Add [issue types and resolutions](manager/add-ticket-type.md).

   - Set up [statuses](manager/workflow.md).

   - Create [versions](manager/versions.md) and [components](manager/components.md).

1. If necessary, create [issue boards](manager/create-agile-board.md) and [sprints](manager/create-agile-sprint.md).

1. Import data to {{ tracker-name }} [via the API](concepts/import/import-ticket.md).


{% note warning %}

Only an [administrator](role-model.md) can import data to {{ tracker-name }}.

{% endnote %}

