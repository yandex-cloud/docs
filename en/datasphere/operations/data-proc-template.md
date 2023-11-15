# Working with {{ dataproc-name }} templates

[{{ dataproc-name }} templates](../concepts/data-proc-template.md) let you preset a cluster's configuration for your project and make it easier to deploy temporary clusters. You can find a list of templates on the project page under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** → ![data-proc-template](../../_assets/datasphere/data-proc-template.svg) **{{ ui-key.yc-ui-datasphere.resources.dataProc }}**, the **{{ ui-key.yc-ui-datasphere.common.shared-with-project-resources }}** tab.

{% include [data-proc-template-presetting](../../_includes/datasphere/settings-for-dataproc.md) %}

## Creating a {{ dataproc-name }} template {#create}

1. {% include [ui-find-project](../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![data-proc-template](../../_assets/datasphere/data-proc-template.svg) **{{ ui-key.yc-ui-datasphere.resources.dataProc }}**.
1. Click **{{ ui-key.yc-ui-datasphere.data-proc.create-template }}**.
1. In the **{{ ui-key.yc-ui-datasphere.data-proc.template-name }}** field, enter a name for the template. The naming requirements are as follows:

   {% include [name-format](../../_includes/name-format.md) %}

1. Click **{{ ui-key.yc-ui-datasphere.common.create }}**. This will display the created template's info page.

## Activating a {{ dataproc-name }} template {#activate}

1. {% include [ui-find-project](../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![data-proc-template](../../_assets/datasphere/data-proc-template.svg) **{{ ui-key.yc-ui-datasphere.resources.dataProc }}**.
1. Click ![options](../../_assets/options.svg) next to the appropriate template and select **{{ ui-key.yc-ui-datasphere.common.activate }}**.

A cluster based on the activated {{ dataproc-name }} template is created when you run your project in the IDE.

## Sharing a {{ dataproc-name }} template {#share}

1. {% include [ui-find-project](../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![data-proc-template](../../_assets/datasphere/data-proc-template.svg) **{{ ui-key.yc-ui-datasphere.resources.dataProc }}**.
1. Select the appropriate template from the list.
1. Go to the **{{ ui-key.yc-ui-datasphere.common.access }}** tab.
1. Enable the visibility option next to the name of the community to share the template in.

## Editing a template {#edit}

You can only change the name of an existing template. To change the configuration, [recreate](#create) the template.

1. {% include [ui-find-project](../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![data-proc-template](../../_assets/datasphere/data-proc-template.svg) **{{ ui-key.yc-ui-datasphere.resources.dataProc }}**.
1. Select the relevant template in the list, click ![options](../../_assets/options.svg), and select **{{ ui-key.yc-ui-datasphere.common.edit }}**.
1. Edit the name and click **{{ ui-key.yc-ui-datasphere.common.save }}**.

## Deleting a {{ dataproc-name }} template {#delete}

1. {% include [ui-find-project](../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![data-proc-template](../../_assets/datasphere/data-proc-template.svg) **{{ ui-key.yc-ui-datasphere.resources.dataProc }}**.
1. In the list, select the template to delete.
1. Click ![options](../../_assets/options.svg) and select **{{ ui-key.yc-ui-datasphere.common.delete }}**.
1. Click **{{ ui-key.yc-ui-datasphere.common.submit }}**.