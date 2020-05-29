# About {{ ml-platform-name }}

{{ ml-platform-full-name }} simplifies the use of the [JupyterLab](https://jupyter.org/) development environment on Yandex.Cloud computing capabilities. This lets you perform complex calculations, such as training neural networks or analyze big data, using the familiar Jupyter Notebook interface.

If you never used Jupyter Notebook, try it: notebooks are convenient as they help you execute code sequentially and immediately visualize the results. Notebooks are also convenient for making analytical reports and articles: between the code cells, you can add explanations in [Markdown](https://jupyter-notebook.readthedocs.io/en/stable/examples/Notebook/Working%20With%20Markdown%20Cells.html).

## Advantages of the service {#advantages}

### A ready-to-use development environment {#ready-to-use}

You don't need to spend time creating and maintaining VMs: when creating a new [project](project.md), a new VM is automatically allocated.

{% include [include](../../_includes/datasphere/project-opening-delay.md) %}

The VM already has the JupyterLab development environment and pre-installed packages for data analysis and machine learning (TensorFlow, Keras, NumPy, and [more](preinstalled-packages.md)) on it, and you can start using them immediately. Full list of pre-installed packages.

If you're missing a package, you can [install it](../operations/projects/install-dependencies.md) right from the notebook.

### Automatic maintenance {#auto-service}

The service automatically stops the VM if you don't use the project. The state of the interpreter is saved, meaning no variables or calculation results are lost and you can continue working when you reopen the project.

{% include [include](../../_includes/datasphere/saving-variables-warn.md) %}

### Managing computing resources {#control-computing-resources}

Different computing resources are required for different tasks. For some of them, a regular processor is enough, but for others, you need a GPU.

{{ ml-platform-name }} supports different VM [configurations](vm-configurations.md). By default, a project runs on a VM with the minimal <q>S</q> configuration (32 GB RAM and 2 vCPUs).

You can [migrate to a VM with a different configuration](../operations/projects/control-compute-resources.md) at any time when working in the notebook. The state of the interpreter is maintained.

Changing the configuration helps you get more computing resources when you need them and save them when you don't.

{% include [include](../../_includes/datasphere/default-vm-configuration.md) %}

### Data files are available from any project {#common-resources}

In {{ ml-platform-name }}, files are stored separately from notebooks. You can upload a data file for analysis and use it in any project. The uploaded files appear under the **Resources** tab and are available from inside and outside the projects.

If you change the contents of the file, it changes for all projects. If you create a new file using a notebook from inside a project, this file will be available in the rest of the projects.

### Errors don't change the state of the interpreter {#handling-errors}

If an error occurs while running a cell, it won't update the state of the interpreter. This allows you to keep the results obtained in the previous cells.

{% note important %}

If a variable value was assigned in the cell where the error occurred, the assignment is also canceled.

{% endnote %}

### You can share your results {#share-results}

You can [export your notebook to HTML format](../operations/projects/share.md) with all calculation results and cell explanations and share a link to the report in this format. Exporting in other formats is currently not supported.

In addition to exporting notebooks, you can write the calculation results to a file. It appears under the **Resources** tab, and you can [download](../operations/resources/download.md) the file or [share a link](../operations/resources/get-link.md) to it.

{% include [include](../../_includes/datasphere/known-restrictions.md) %}

#### See also {#see-also}

* [{#T}](../operations/index.md)
* [{#T}](limits.md)
* [{#T}](../pricing.md)

