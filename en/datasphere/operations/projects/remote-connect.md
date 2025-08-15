# Connecting to a project {{ jlab }}Lab from a local IDE

{{ ml-platform-name }} enables you to work with projects from any local IDE which supports the use of remote {{ jlab }} servers. This feature is disabled by default; however, the community admin can enable it in the [community settings](../community/manage-community-config.md).

{% note info %}

You must have the `{{ roles-datasphere-communities-admin }}` [role](../../security/index.md#roles-list) in the community to enable the remote IDE support. Only users with the `{{ roles-datasphere-project-developer }}` role or higher can get a link for connecting to a project from an IDE.

{% endnote %}

Here is an example of connecting to a project using [Visual Studio Code](https://code.visualstudio.com/):

1. {% include [include](../../../_includes/datasphere/ui-find-community.md) %}
1. Select the community your project belongs to.
1. Go to the **{{ ui-key.yc-ui-datasphere.common.restrictions }}** tab.
1. Under **{{ ui-key.yc-ui-datasphere.restrictions.project-mode }}**, enable **{{ ui-key.yc-ui-datasphere.restrictions.JUPYTER_TOKEN }}**.
1. Go to the **{{ ui-key.yc-ui-datasphere.common.projects }}** tab and select your project.
1. In the project settings, under **{{ ui-key.yc-ui-datasphere.common.general }}**, click **{{ ui-key.yc-ui-datasphere.common.edit }}**.
1. In the **{{ ui-key.yc-ui-datasphere.external-ide.external-ide-vm-configuration }}** field, select the [VM configuration](../../concepts/configurations.md) and click **{{ ui-key.yc-ui-datasphere.common.save }}**.
1. Click **{{ ui-key.yc-ui-datasphere.project-page.project-card.go-to-jupyter }}** and wait for the project to load.
1. In the top-right corner, click **Share** ⟶ **Link for external IDE**.
1. Click **Copy link**.
1. Open an `ipynb` file in Visual Studio Code.
1. In the top-right corner, click the button with your Python version.
1. On the panel that opens, click **Select Notebook Kernel** ⟶ **Existing {{ jlab }} Server**.
1. Paste the link you copied and press **Enter**.

Once connection is established, all computations will run in {{ ml-platform-name }}. The started VM will be running until you stop it in the {{ ml-platform-name }} interface.
