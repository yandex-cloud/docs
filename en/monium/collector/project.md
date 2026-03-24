# Creating and setting up a project

A project is a logical unit used to organize telemetry data in {{ monium-name }}. In {{ monium-name }}, telemetry has this hierarchy: project → cluster → service. Data is stored in shards in _service-cluster_ pairs.

A **project** is the top level unit of the hierarchy. It is provided in the `x-monium-project` header when sending data.
  
By default, when you create a cloud and folder, two projects are created:
* `cloud__<cloud_ID>`: For cloud-level telemetry.
* `folder__<folder_ID>`: For folder-level telemetry.
  
You can create your own projects to collect telemetry from different sources to isolate responsibility and data access permissions.

## Creating a project {#project-create}

1. On the [{{ monium-name }} home page]({{ link-monium }}), in the top-left corner, click the current project name.
1. In the menu that opens, click **Create project**.
1. Enter the project name and click **Continue**.
1. Select an existing billing account or create a new one.
1. Click **Link billing account**.

You should now see the new project in the **Projects** menu.

## Project settings {#project-settings}

1. On the [{{ monium-name }}]({{ link-monium }}) home page, select **Project settings** on the left.
1. In the top-left corner, click the current project name and select the project you need.
1. On the **General information** tab, view information about the project.
1. On the **Access** tab, configure permissions:
   1. Click **Configure access**.
   1. Select the users or groups you want to grant access to the project.
   1. Click **Save**.

