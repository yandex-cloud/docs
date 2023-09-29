# Managing community limits

{% note info %}

You can limit {{ ml-platform-name }} resources and features available across your community projects only if you have the `{{ roles-datasphere-communities-admin }}` role in the community.

{% endnote %}

1. Open the {{ ml-platform-name }} [home page]({{ link-datasphere-main }}).
1. In the left-hand panel, select ![community-panel](../../../_assets/datasphere/communities.svg) **{{ ui-key.yc-ui-datasphere.common.spaces }}**.
1. Select the community to set up the {{ ml-platform-name }} functionality in.
1. Go to the **{{ ui-key.yc-ui-datasphere.common.restrictions }}** tab.
1. Under **{{ ui-key.yc-ui-datasphere.restrictions.project-mode }}**:

   * **{{ ui-key.yc-ui-datasphere.dedicated-mode.serverless-mode }}**: Community projects will be able to run in [{{ ds }} mode](../../concepts/project.md#dedicated). You can select the runtime mode in the project settings and whenever you open your project in {{ jlab }}Lab.
   * **{{ ui-key.yc-ui-datasphere.restrictions.SERVERLESS_BACKGROUND_CELLS }}**: Your project will support [background operations](../../concepts/async).

1. Under **{{ ui-key.yc-ui-datasphere.common.resources }}**:

   * **{{ ui-key.yc-ui-datasphere.restrictions.CHANGING_DISK_SIZE }}**: Enable this option to allow changing the project storage size.
   * **{{ ui-key.yc-ui-datasphere.restrictions.NODES_AND_ALIASES }}**: Community projects will support service deployment using [nodes](../../concepts/deploy/index.md#node) and [aliases](../../concepts/deploy/index.md#alias).
   * **{{ ui-key.yc-ui-datasphere.restrictions.DATAPROC_TEMPLATES }}**: Community projects will support [{{ dataproc-name }} templates](../../concepts/data-proc-template).
   * **{{ ui-key.yc-ui-datasphere.common.datasets }}**: Users will be able to create [datasets](../../concepts/dataset) in community projects.

1. Under **{{ ui-key.yc-ui-datasphere.spaces-page.configurations }}**, you can select [computing resource configurations](../../concepts/configurations.md) to be available across community projects.
