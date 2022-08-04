# Migrating to {{ tracker-name }} from other services

If you're already using a different platform for managing your issues and projects and want to migrate everything to {{ tracker-full-name }}, you can transfer the information about your issues and projects to {{ tracker-name }}:

* If you're using Jira, our team will help you transfer data to {{ tracker-name }}. To transfer from Jira, prepare the data for migration [according to the instructions below](#jira) and contact [technical support]({{ link-tracker-support }}).

* If you're using another service (Asana, Wrike, YouTrack, and so on), we'll help you choose a partner company to transfer your data to {{ tracker-name }}. To transfer from another service, leave a request using [forms]({{ link-migration-form }}).

* If you want to perform migration on your own, you can import the data into {{ tracker-name }} using [the API](#diy) or download the issue list from an Excel spreadsheet using the [Python client](#excel).

## Transferring data from Jira {#jira}



1. [Enable {{ tracker-full-name }}.](enable-tracker.md)

1. [Add your organization's employees to {{ tracker-name }}](add-users.md).

1. Create a service account to access {{ api-name }}:

   1. Create a new Yandex account that follows the format `{{ example-account }}`.

   1. [Add](add-users.md#invite_user) the account you created to {{ tracker-name }}.

   1. Go to [{{ ya-360 }}]({{ link-ya-360 }}) and grant admin rights to the account you created. For more information, see [{{ ya-360 }} documentation]({{ support-business-admin }}).

   You can delete the account or revoke its admin rights after migration is finished.

1. Export your data from Jira.

   {% cut "How to export data" %}

   1. In Jira, select **Settings** > **System**.

   1. Go to the **IMPORT AND EXPORT** section and select **Backup manager**.

   1. Go to **Backup for Server**, enable the **Include additional files** option, and select **Create backup for server**.

      {% note warning %}

      If you're using the cloud version of Jira, you should still use the **Create backup for server** option.

      Use the **Create backup for cloud** option only if creating a server backup is impossible.

      {% endnote %}

   1. When a backup is created, click **Download backup file**.

   For more information about exporting data, see the [Jira documentation](https://support.atlassian.com/jira-cloud-administration/docs/export-issues/).

   {% endcut %}

1. Make a correspondence table between Jira users and {{ tracker-name }} users.

1. Upload the archive with the exported data and the user correspondence table to Yandex Disk or another similar service.

   {% note info %}

   If you don't use cloud services for storing files and are unsure of where to upload your data, please tell the support team. The support staff will instruct you how to transfer your data.

   {% endnote %}

1. Send a request to [technical support]({{ link-tracker-support}}) if you want to migrate data from Jira to {{ tracker-name }}. In the request, specify the following:

   * Links to the archive with exported data and the user correspondence table.

   * The credentials of the service account with administrator privileges.

1. Wait until the support staff notifies you that migration is completed.

   The support staff will also contact you if any additional information or actions are required on your part to migrate the data.

1. After data migration is completed, grant [full access](access.md) to your employees in {{ tracker-name }}, assign [queue access rights](manager/queue-access.md), and delete the admin service account.

## Transferring data from Excel {#excel}

If you have an issue list saved as an Excel spreadsheet, you can transfer the data to {{ tracker-name }} using the Python client.

The table should contain columns with issue parameters. The same column headers should be specified in the script that processes the Excel file.

1. [Enable {{ tracker-full-name }}.](enable-tracker.md)

1. [Add your organization's employees to {{ tracker-name }}](add-users.md).

1. Get [API access](concepts/access.md#section_about_python_client).

1. [Create queues](manager/create-queue.md) to import your issues to.

1. Configure the queue:

    - Add [issue types and resolutions](manager/add-ticket-type.md).

    - Set up [statuses](manager/workflow.md).

    - Create [versions](manager/versions.md) and [components](manager/components.md).

1. If necessary, create [issue boards](manager/create-agile-board.md) and [sprints](manager/create-agile-sprint.md).

1. Prepare an Excel spreadsheet with issue data.

1. Prepare the Python client:

   1. [Install the Python client](user/python.md).

   1. Initialize the client.

      ```
      from yandex_tracker_client import TrackerClient
      client = TrackerClient(token='<token>', org_id='<org_id>')
      ```

      Here `<token>` is your OAuth token, and `<org_id>` is your organization ID.

   1. Enable libraries.

      ```
      from datetime import datetime 
      import pandas as pd
      import numpy as np
      ```

1. Execute the script to load data from the table.

   The Python script loads the issues from the file into the specified queue. In the script, assign values listed in table columns to their respective issue fields.

   To understand how to use scripts, let's look at an example of importing a table with the following headers: **Issue**, **Description**, **End date**, **Assignee**. You can add other fields to the table and the script.

   {% cut "How to execute script" %}

   1. Upload the data file.

      ```
      df = pd.read_excel(r'C:\<file path>\<file name>.xls')
      ```

   1. Make sure the column headers are being inserted into the script.

      ```
      for i, row in df.iterrows():
         print(f"Index: {i}")
         print(f"{row['Issue']}")
         print(f"{row['Description']}")
         print(f"{row['End date']}")
         print(f"{row['Assignee']}")
      ```

   1. You can create issues, update the author name, or make other necessary changes in the attributes.

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
            issue.update(author='<username>')
            issue.update(<field key>='<value>')
      ```

   {% endcut %}

## Transfer data using the API {#diy}

If you want to migrate to {{ tracker-name }}, you need download the data from the platform you're currently using and convert it to the format supported by {{ tracker-name }}. To automate data migration, you will need to consult a developer or a company that provides platform integration services.

To learn more about the data format used by {{ api-name }}, see the [API Guide](concepts/import/import-ticket.md).

To import data:

1. [Enable {{ tracker-full-name }}.](enable-tracker.md)

1. [Add your organization's employees to {{ tracker-name }}](add-users.md).

1. Get [API access](concepts/access.md).

1. [Create queues](manager/create-queue.md) to import your issues to.

1. Configure the queue:

    - Add [issue types and resolutions](manager/add-ticket-type.md).

    - Set up [statuses](manager/workflow.md).

    - Create [versions](manager/versions.md) and [components](manager/components.md).

1. If necessary, create [issue boards](manager/create-agile-board.md) and [sprints](manager/create-agile-sprint.md).

1. Import data to {{ tracker-name }} [using the API](concepts/import/import-ticket.md).



{% note warning %}

Data import to {{ tracker-name }} can only be performed by the [administrator](role-model.md).

{% endnote %}


