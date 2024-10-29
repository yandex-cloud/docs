# Resizing project storage

{% note info %}

You can only resize a project storage if you have the `{{ roles-datasphere-project-admin }}` [role](../../security/index.md) in the project or the `{{ roles-datasphere-communities-admin }}` role in the project community.

You can [restrict](../community/manage-community-config.md) resizing the project storage in the community settings.

{% endnote %}

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Information about the project storage size is available on the project page in the **{{ ui-key.yc-ui-datasphere.project-page.tab.overview }}** tab, the **{{ ui-key.yc-ui-datasphere.project-page.project-disk }}** section. Click ![pencil](../../../_assets/console-icons/pencil-to-line.svg) **{{ ui-key.yc-ui-datasphere.common.resize }}**.
1. Specify the required size as an integer.
1. Click **{{ ui-key.yc-ui-datasphere.common.resize }}**.
1. You can open the project as soon as storage resizing is completed.

{% note warning %}

A project storage is more than a file storage facility: it also addresses the file system needs and other support functions.

{% endnote %}
