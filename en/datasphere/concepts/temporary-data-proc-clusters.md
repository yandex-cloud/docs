# Specifics of working with temporary {{ dataproc-name }} clusters

If you have no existing {{ dataproc-full-name }} clusters or you need a cluster for a short time, use temporary {{ dataproc-name }} clusters. You can create them using the following:

* [Spark connector](#spark-with-temporary-cluster) (preferred)
* [{{ dataproc-name }} template](#template)

To use {{ dataproc-name }} clusters, [pre-configure a project](data-proc.md#settings).

Regardless of the deployment option, all {{ dataproc-name }} clusters are charged based on the [{{ dataproc-full-name }} pricing policy](../../data-proc/pricing.md). To view all the clusters available in your project, navigate to **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** ⟶ ![image](../../_assets/data-proc/data-proc.svg) **{{ ui-key.yc-ui-datasphere.resources.dataProc }}** on the project page.

## Spark connector {#spark-with-temporary-cluster}

When creating a Spark connector, you can create a temporary {{ dataproc-name }} cluster and configure its parameters. {{ ml-platform-name }} will create such a cluster the first time you run computations in your notebook and will monitor it all by itself. The cluster starts and stops together with the notebook VM.

The notebook VM will be stopped if there are no computations on it for the period of time specified in the **{{ ui-key.yc-ui-datasphere.edit-project-page.dedicated-vm-inactivity-timeout }}** parameter. You can also force shut down the notebook VM.

To learn more about using Spark connectors, see [this guide](../operations/data/spark-connectors.md).

## {{ dataproc-name }} templates {#template}

In a {{ dataproc-name }} template, you select one of the preset cluster configurations. Based on the {{ dataproc-name }} template activated in the project, {{ ml-platform-name }} deploys a temporary cluster using the appropriate project parameters.

{{ ml-platform-name }} monitors the project and its temporary clusters on its own. If a project's VMs are idle for two hours, the project gets terminated and the temporary cluster gets deleted. You can [set up a VM shutdown timer](../operations/projects/update.md) in the **{{ ui-key.yc-ui-datasphere.edit-project-page.dedicated-vm-inactivity-timeout }}** parameter or force shut down the notebook VM.

You can also share {{ dataproc-name }} templates with other users.

To learn more about using {{ dataproc-name }} templates, see [this guide](../operations/data-proc-template.md).

#### See also {#see-also}

* [{#T}](data-proc-template.md)
* [{#T}](../tutorials/data-proc-integration.md)
* [{#T}](spark-connector.md)
