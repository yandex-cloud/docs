# Working with {{ dataproc-name }} templates

[{{ dataproc-name }} templates](../concepts/data-processing-template.md) enable you to preset a cluster configuration for your project, making it easier to deploy temporary clusters. You can find a list of templates on your project page under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** → ![data-proc-template](../../_assets/data-processing/data-processing.svg) **{{ ui-key.yc-ui-datasphere.resources.dataProc }}**, the **{{ ui-key.yc-ui-datasphere.common.shared-with-project-resources }}** tab.

{% include [data-proc-template-presetting](../../_includes/datasphere/settings-for-data-processing.md) %}

## Creating a {{ dataproc-name }} template {#create}

1. {% include [ui-find-project](../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![data-proc-template](../../_assets/data-processing/data-processing.svg) **{{ ui-key.yc-ui-datasphere.resources.dataProc }}**.
1. Click **{{ ui-key.yc-ui-datasphere.data-proc.create-template }}**.
1. In the **{{ ui-key.yc-ui-datasphere.data-proc.template-name }}** field, enter a name for the template. Follow these naming requirements:

    {% include [name-format](../../_includes/name-format.md) %}

1. Click **{{ ui-key.yc-ui-datasphere.common.create }}**. You will see a page with detailed info on the template you created.

## Activating a {{ dataproc-name }} template {#activate}

1. {% include [ui-find-project](../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![data-proc-template](../../_assets/data-processing/data-processing.svg) **{{ ui-key.yc-ui-datasphere.resources.dataProc }}**.
1. Click ![options](../../_assets/console-icons/ellipsis.svg) next to the template you need and select **{{ ui-key.yc-ui-datasphere.common.activate }}**.

The system will create a cluster based on the activated {{ dataproc-name }} template when you run your project in the IDE.

## Sharing a {{ dataproc-name }} template {#share}

1. {% include [ui-find-project](../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![data-proc-template](../../_assets/data-processing/data-processing.svg) **{{ ui-key.yc-ui-datasphere.resources.dataProc }}**.
1. Select the template from the list.
1. Go to the **{{ ui-key.yc-ui-datasphere.common.access }}** tab.
1. Enable the visibility option next to the name of the community you want to share the template in.

To make a template available for use in a different project, the project admin needs to [add](./projects/use-shared-resource.md) that template on the **{{ ui-key.yc-ui-datasphere.common.shared-with-project-resources }}** tab.

## Editing a template {#edit}

You can only change the name of an existing template. To update the configuration, [recreate](#create) the template.

1. {% include [ui-find-project](../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![data-proc-template](../../_assets/data-processing/data-processing.svg) **{{ ui-key.yc-ui-datasphere.resources.dataProc }}**.
1. Select the template from the list, click ![options](../../_assets/console-icons/ellipsis.svg), and select **{{ ui-key.yc-ui-datasphere.common.edit }}**.
1. Edit the name and click **{{ ui-key.yc-ui-datasphere.common.save }}**.

## Deleting a {{ dataproc-name }} template {#delete}

1. {% include [ui-find-project](../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![data-proc-template](../../_assets/datasphere/data-processing-template.svg) **{{ ui-key.yc-ui-datasphere.resources.dataProc }}**.
1. In the list, select the template you want to delete.
1. Click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yc-ui-datasphere.common.delete }}**.
1. Click **{{ ui-key.yc-ui-datasphere.common.submit }}**.

{% include [deletion-time](../../_includes/datasphere/deletion-time.md) %}
