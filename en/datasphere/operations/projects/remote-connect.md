# Connecting to {{ jlab }}Lab from a local IDE

In {{ ml-platform-name }}, you can work with projects run in [{{ dd }}](../../concepts/project.md#dedicated) mode from any local IDE if it supports the use of remote {{ jlab }} servers. This feature is disabled by default, but the community administrator can enable it in the [community settings](../community/manage-community-config.md).

{% note info %}

Only users with the `{{ roles-datasphere-project-developer }}` [role](../../security/index.md#roles-list) or higher can get a link to connect to a project from an IDE.

{% endnote %}

Here is an example of connecting to a project using [Visual Studio Code](https://code.visualstudio.com/):

1. {% include [include](../../../_includes/datasphere/ui-find-project.md) %}

1. Run a project in {{ dd }} mode. In the project settings, select a [VM configuration](../../concepts/configurations.md) for a remote connection.

1. In the top-right corner, click **Share** ⟶ **Link for external IDE**.

1. Click **Copy link**.

1. Open a notebook in Visual Studio Code.

1. In the top-right corner, click **Select Notebook Kernel** ⟶ **Existing {{ jlab }} Server**.

1. Paste the link and press **Enter**.

Once connection is established, all computations will be run in {{ ml-platform-name }}. The started VM will be running until you stop it in the {{ ml-platform-name }} interface.
