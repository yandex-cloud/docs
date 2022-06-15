# Project

A _project_ is a [JupyterLab](https://jupyter.org/) development environment that runs on a {{ yandex-cloud }} VM. It includes the Jupyter Notebook editor and auxiliary tools.

A _notebook_ is an `*.ipynb` file that you are working with in the Jupyter Notebook editor. In this editor, you write code in cells and between them you can write explanations in [Markdown](https://jupyter-notebook.readthedocs.io/en/stable/examples/Notebook/Working%20With%20Markdown%20Cells.html). The code is run for each cell separately. Cells can be run in any order.

Projects store the state of the interpreter, variables, installed packages, and much more. When you reopen your project, the notebook loads in the state you last saved it in.

You can upload small amounts of data (up to 100 MB) to your {{ ml-platform-name }} project over the interface. If you want to [upload](../operations/index.md#data-source) larger amounts of data, use your network storages or databases. For larger data volumes, it's also convenient to use [datasets](dataset.md) that are available in [early access mode](../early-access/index.md).

{{ ml-platform-name }} provides {{ ml-project-size }} of free storage for each project. If, when a cell is running, the amount of data exceeds the allocated storage, the cell is stopped. You can [expand](../operations/projects/storage-resize.md) your primary storage. Additional space will have to be paid for separately. For more information about the main storage expansion costs, see [{#T}](../pricing.md).

{% include [include](../../_includes/datasphere/saving-variables-warn.md) %}

The service automatically redirects you to the management console if you don't use the project for 20 minutes or close it. For more information about service limits, see [{#T}](limits.md).

#### See also {#see-also}

* [Step-by-step instructions](../operations/index.md#projects)
* [{#T}](limits.md)