# Working with {{ dataproc-name }} templates

[{{ dataproc-name }} templates](../concepts/data-proc-template.md) let you preset a cluster's configuration for your project and make it easier to deploy temporary clusters. You can find a list of templates on the project page under **Project resources** → ![data-proc-template](../../_assets/datasphere/data-proc-template.svg) **Data Proc**, the **Available** tab.

{% include [data-proc-template-presetting](../../_includes/datasphere/settings-for-dataproc.md) %}

## Creating a {{ dataproc-name }} template {#create}

1. {% include [ui-find-project](../../_includes/datasphere/ui-find-project.md) %}
1. Under **Project resources**, click ![data-proc-template](../../_assets/datasphere/data-proc-template.svg) **{{ dataproc-name }}**.
1. Click **Create template**.
1. In the **Template name** field, enter a name.

   {% include [name-format](../../_includes/name-format.md) %}

1. Click **Create**. This will display the created template's info page.

## Activating a {{ dataproc-name }} template {#activate}

1. {% include [ui-find-project](../../_includes/datasphere/ui-find-project.md) %}
1. Under **Project resources**, click ![data-proc-template](../../_assets/datasphere/data-proc-template.svg) **{{ dataproc-name }}**.
1. Select the appropriate template from the list.
1. Click **Apply**.

A cluster based on the activated {{ dataproc-name }} template is created when you run your project in the IDE.

## Sharing a {{ dataproc-name }} template {#share}

1. {% include [ui-find-project](../../_includes/datasphere/ui-find-project.md) %}
1. Under **Project resources**, click ![data-proc-template](../../_assets/datasphere/data-proc-template.svg) **{{ dataproc-name }}**.
1. Select the appropriate template from the list.
1. Go to the **Access** tab.
1. Enable the visibility option next to the name of the community to share the template in.

## Editing a template {#edit}

You can only change the name of an existing template. To change the configuration, [recreate](#create) the template.

1. {% include [ui-find-project](../../_includes/datasphere/ui-find-project.md) %}
1. Under **Project resources**, click ![data-proc-template](../../_assets/datasphere/data-proc-template.svg) **{{ dataproc-name }}**.
1. Select the desired template in the list, click ![options](../../_assets/options.svg), and select **Edit**.
1. Edit the name and click **Save**.

## Deleting a {{ dataproc-name }} template {#delete}

1. {% include [ui-find-project](../../_includes/datasphere/ui-find-project.md) %}
1. Under **Project resources**, click ![data-proc-template](../../_assets/datasphere/data-proc-template.svg) **{{ dataproc-name }}**.
1. In the list, select the template to delete.
1. Click ![options](../../_assets/options.svg) and select **Delete**.
