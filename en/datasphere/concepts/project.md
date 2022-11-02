# Projects {{ ml-platform-name }}

A _project_ is a user's main work space that is run on a {{ yandex-cloud }} VM. Projects store the state of the interpreter, variables, installed packages, and much more. Operations with projects are performed in the [{{ jlab }}Lab](https://jupyter.org/) development environment.

A _notebook_ is an `*.ipynb` file that you're working with in the code editor. In a notebook, you write code in _cells_ and can add explanations in [Markdown](https://jupyter-notebook.readthedocs.io/en/stable/examples/Notebook/Working%20With%20Markdown%20Cells.html) between them. The code is run for each cell separately. Cells can be run in any order.

## Project storage {#storage}

{{ ml-platform-name }} provides {{ ml-project-size }} of free storage for each project. You can increase the storage size if needed. Additional space will have to be paid for separately. For more information about the main storage expansion costs, see [{#T}](../pricing.md).

When you reopen your project, the notebook loads in the state you last saved it in.

{% include [include](../../_includes/datasphere/saving-variables-warn.md) %}

You can upload small amounts of data (up to 100 MB) to your {{ ml-platform-name }} project over the interface. If you want to upload larger amounts of data, use your network storages or databases. For larger data volumes, it's also convenient to use [datasets](dataset.md).

## Configuring a project runtime environment {#environment}

Projects are created with a preset development environment and pre-installed packages. For a list of all pre-installed packages, see [{#T}](preinstalled-packages.md). If you're missing a package, you can [install it](../operations/projects/install-dependencies.md) right from the notebook cell or [build a Docker image](../operations/user-images.md).