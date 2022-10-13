# About {{ ml-platform-name }}

{% include [link-on-new-ui-datasphere-in-old-ui](../../_includes/datasphere/datasphere-old-note.md) %}

{{ ml-platform-full-name }} is a machine learning (ML) development environment where you can use a familiar Jupyter® Notebook interface, serverless computing technology, and seamlessly combine a broad range of computing resource configurations. {{ ml-platform-full-name }} helps you significantly reduce the cost of machine learning compared to computing on your own hardware or other cloud platforms.

If you never used Jupyter Notebook, try it: notebooks are convenient as they help you execute code sequentially and immediately visualize the results. Notebooks are also convenient for drafting analytical reports and papers: you can add comments between code cells using the [Markdown](https://jupyter-notebook.readthedocs.io/en/stable/examples/Notebook/Working%20With%20Markdown%20Cells.html) language.

## Advantages of the service {#advantages}

### Ready-to-use development environment {#ready-to-use}

You don't need to spend time creating and maintaining VMs: when you create a new [project](project.md), computing resources are automatically allocated for implementing it.

The VM comes ready with the JupyterLab development environment and pre-installed packages for data analysis and ML (such as TensorFlow, Keras, and NumPy), which you can start using immediately. Full list of [pre-installed packages](preinstalled-packages.md).

If you're missing a package, you can [install it](../operations/projects/install-dependencies.md) right from the notebook.

### Automatic maintenance of computing resources {#auto-service}

The service automatically manages resource allocation. If you don't perform any computations, no resources are allocated. If you use [early access](../early-access/index.md) features, the amount of vCPU and memory usage is shown directly in the notebook interface.

### Saving states at shutdown {#save-state}

If you close the notebook tab, the [state of the interpreter](save-state.md), all variables, and computation results are saved. You can continue working when you reopen your project.

### Secure storage of private data {#secure-storage-private-data}

To handle private data (such as passwords and keys), the service has a special tool, referred to as a vault, that enables you to store and process data in encrypted form. Learn more about the [vault](secrets.md).

### Managing computing resources {#control-computing-resources}

Different computing resources are required for different tasks. For some of them, a regular processor is enough, but for others, you need a GPU.

{{ ml-platform-name }} supports different computing resource [configurations](configurations.md). By default, a project launches with the minimum <q>c1.4</q> configuration (32 GB of RAM and 4 vCPUs).

You can [change the configuration](../operations/projects/control-compute-resources.md) at any time when working in the notebook. The state of the interpreter is maintained. When you select configurations with GPU, for example, <q>g1.1</q> or <q>g1.4</q>, the GPU utilization will be displayed in the upper-right corner of the project interface.

### You can share your results {#share-results}

To share your results:

* [Publish a notebook](../operations/projects/publication.md) as a report link in HTML format.
* [Export](../operations/projects/export.md) your project as a ZIP file.
* [Export](../operations/projects/checkpoints.md#export) a checkpoint.

## Current service limits {#known-restrictions}

For more information about service limits, see [{#T}](limits.md).

## Early access mode {#early-access}

Try out new {{ ml-platform-name }} features before they are released in [early access mode](../early-access/index.md) and tell us what you think about them.

## Contacting support from the service {#support}

{% include [include](../../_includes/datasphere/notebook-support.md) %}

#### See also {#see-also}

* [{#T}](../operations/index.md)
* [{#T}](limits.md)
* [{#T}](../pricing.md)
