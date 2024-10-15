# Connecting to {{ jlab }}Lab from a local IDE

{{ ml-platform-name }} allows you to work with projects from any local IDE if it supports the use of remote {{ jlab }} servers. This feature is disabled by default, but the community administrator can enable it in the [community settings](../community/manage-community-config.md).

{% note info %}

You must have the `{{ roles-datasphere-communities-admin }}` [role](../../security/index.md#roles-list) in the community to enable the remote IDE feature. Only users with the `{{ roles-datasphere-project-developer }}` role or higher can get a link to connect to a project from an IDE.

{% endnote %}

Here is an example of connecting to a project using [Visual Studio Code](https://code.visualstudio.com/):

1. {% include [include](../../../_includes/datasphere/ui-find-community.md) %}
1. Select the community your project is in.
1. Go to the **{{ ui-key.yc-ui-datasphere.common.restrictions }}** tab.
1. Under **{{ ui-key.yc-ui-datasphere.restrictions.project-mode }}**, enable the **{{ ui-key.yc-ui-datasphere.restrictions.JUPYTER_TOKEN }}** option.
1. Go to the **{{ ui-key.yc-ui-datasphere.common.projects }}** tab and select your project.
1. In the project settings, under **{{ ui-key.yc-ui-datasphere.common.general }}**, click **{{ ui-key.yc-ui-datasphere.common.edit }}**.
1. In the **{{ ui-key.yc-ui-datasphere.external-ide.external-ide-vm-configuration }}** field, select [VM configuration](../../concepts/configurations.md) and run the project.
1. In the top-right corner, click **Share** ⟶ **Link for external IDE**.
1. Click **Copy link**.
1. Open an `ipynb` file in Visual Studio Code.
1. In the top-right corner, click the button with your Python version.
1. On the panel that opens, click **Select Notebook Kernel** ⟶ **Existing {{ jlab }} Server**.
1. Paste the link you get and press **Enter**.

Once connection is established, all computations will be run in {{ ml-platform-name }}. The started VM will be running until you stop it in the {{ ml-platform-name }} interface.
