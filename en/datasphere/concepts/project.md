# Projects {{ ml-platform-name }}

A _project_ is a user's main workspace run on a {{ yandex-cloud }} VM. Projects store the state of the interpreter, variables, installed packages, and much more. Operations with projects are performed in the [{{ jlab }}Lab](https://jupyter.org/) development environment.

A _notebook_ is an `*.ipynb` file that you're working with in the code editor. In a notebook, you write code in _cells_ and can add explanations in [Markdown](https://jupyter-notebook.readthedocs.io/en/stable/examples/Notebook/Working%20With%20Markdown%20Cells.html) between them. The code is run for each cell separately. Cells can be run in any order.

## Project storage {#storage}

{{ ml-platform-name }} provides {{ ml-project-size }} of free storage for each project. You can increase the storage size if needed. Additional space will have to be paid for separately. For more information about the main storage expansion costs, see [{#T}](../pricing.md).

When you reopen your project, the notebook loads in the state you last saved it in.

{% include [include](../../_includes/datasphere/saving-variables-warn.md) %}

You can upload small amounts of data (up to 100 MB) to your {{ ml-platform-name }} project over the interface. If you want to upload larger amounts of data, use your network storage or databases. For large data, it is also handy to use [datasets](dataset.md).

## Configuring a project runtime environment {#environment}

Projects are created with a preset development environment and pre-installed packages. For a list of all pre-installed packages, see [{#T}](preinstalled-packages.md). If you are missing a package, you can [install it](../operations/projects/install-dependencies.md) right from the notebook cell or [build a Docker image](../operations/user-images.md).

## Project modes {#mode}

{{ ml-platform-name }} provides two modes for running projects: {{ ds }} and {{ dd }}. You can select a mode when starting a project or [set the default mode](../operations/projects/update.md) in the project settings.

{% note warning %}

Each mode creates and uses its own technical artifacts. For instance, [saving a state](save-state.md) is only available in the {{ ds }} mode. If you change the project mode, the technical artifacts may be lost.

{% endnote %}

### {{ ds }} mode {#serverless}

{{ ml-platform-name }} {{ ds }} allows you to select [configurations](configurations.md) of computing resources from a pool of available VMs. If you change a configuration or do not run computations in a project for a long time, your VM is released and returned to the pool of available ones with a saved [state](save-state.md). This allows saving resources and running different code snippets in different configurations.

When working with {{ ml-platform-name }} {{ ds }}, you only [pay](../pricing.md) for the configuration runtime: if you are not running any computations, no fee is charged.

### {{ dd }} mode {#dedicated}

In the {{ dd }} mode, you can use {{ ml-platform-name }} as in a local {{ jlab }}Lab notebook. {{ ml-platform-name }} {{ dd }} grants a selected configuration for long-term use and assigns a VM to a project notebook until you force it to be returned to the pool of available VMs or until the timeout expires. By default, the VM is released if no computations are run in the project within three hours. You can change this value in the project settings.

The {{ dd }} mode does not support automatic [interpreter state saves](save-state.md) and [checkpoints](checkpoints.md). However, cell code changes will be saved automatically. You can disable notebook autosaves in {{ jlab }}Lab settings by selecting **Settings ⟶ Autosave Documents** in the top menu. If you want to save an interpreter state or output, you will need to do that yourself.

For the same reason, you will not be able to change a configuration for multiple cells without restarting the entire notebook.

You can have multiple configurations of VMs assigned to a single project. When running computations in your notebook for the first time, select a configuration to use for them.

VM billing in the {{ dd }} mode will start once the first computations are run in a notebook and will continue as long as the VM is assigned to the respective project. You can learn more about {{ ml-platform-name }} usage cost [here](../pricing.md).
