# {{ ml-platform-name }} projects

A _project_ is a user's main workspace that serves as a single entry point for all {{ ml-platform-name }} features. A project allows you to perform computations on {{ yandex-cloud }} VMs with standard [configurations](configurations.md) and stores [{{ ml-platform-name }} user resources](resources.md).

A _notebook_ is an `*.ipynb` file that you work with in the [{{ jlab }}Lab](https://jupyter.org/) development environment. In a notebook, you write code in _cells_ and can add [Markdown](https://jupyter-notebook.readthedocs.io/en/stable/examples/Notebook/Working%20With%20Markdown%20Cells.html) comments between them. The code is run for each cell separately. Cells can be run in any order.

## Project storage {#storage}

{{ ml-platform-name }} provides {{ ml-project-size }} of free storage for each project. You can increase the storage size, but this will result in additional charges. See the cost of expanding the main storage in [{#T}](../pricing.md).

You can upload small amounts of data (up to 100 MB) to your {{ ml-platform-name }} project through the UI. If you want to upload larger amounts of data, use your network storage or databases. For large data volumes, you can also use [datasets](dataset.md).

## Configuring a project runtime environment {#environment}

Projects you create will have a pre-configured development environment and [pre-installed packages](preinstalled-packages.md). {{ ml-platform-name }} provides several [Docker images](docker.md) of the environment with a choice of Python versions and libraries. The **DS Default (Python 3.10)** image is used by default, but you can [select](../operations/projects/python-version.md) another standard image. For a list of all pre-installed packages, see [{#T}](preinstalled-packages.md). If you are missing a package, you can [install it](../operations/projects/install-dependencies.md) directly from the notebook cell or [build a Docker image](../operations/user-images.md).

## {{ ds-nb }} {#mode}

{{ ds-nb }} allows you to run computations on a VM as if you were running them on a local {{ jlab }}Lab notebook. {{ ds-nb }} provides the selected configuration for long-term use and assigns the VM to the project notebook until you forcibly return it to the pool of available VMs or until the timeout expires. By default, the VM is released if no computations are run in the project within three hours. You can change this value in the project settings.

Cell code changes will be saved automatically. You can disable notebook autosaves in the {{ jlab }}Lab settings by selecting **Settings ⟶ Autosave Documents** in the top menu. If you want to save an interpreter state or output, you will need to do that yourself.

You can link multiple VM configurations to a single project. When running computations in your notebook for the first time, select a configuration to use for them.

The {{ ds-nb }} billing will start once the first computations are run in a notebook and will continue as long as the VM is assigned to the project. You can learn more about {{ ml-platform-name }} usage cost [here](../pricing.md).

### {{ jlab }}Lab console {#console}

In {{ ds-nb }}, you can use the {{ jlab }}Lab console with an interactive Python interpreter. The console is run on a separate VM instance with the c1.4 configuration. To open the console, on the {{ jlab }}Lab home page, select **{{ ml-platform-name }} Kernel** under **Console**. You enter commands in the console input line and run them using the **Shift** + **Enter** keyboard shortcut.

If you just close the console, the VM instance will keep running. To shut down the console VM and stop paying for it, use the widget in the top-right corner of the screen or on the project home page and shut down the console VM.

#### {{ jlab }}Lab extensions {#extensions}

The following {{ jlab }}Lab extensions are available:

* {{ jlab }}Lab-latex
* {{ jlab }}Lab-widgets ipywidgets
* {{ jlab }}Lab-code-formatter black isort
* {{ jlab }}Lab-execute-time
* {{ jlab }}Lab-limit-output
* {{ jlab }}Lab-spellchecker
* [{{ jlab }}Lab-templates](../operations/projects/templates.md)
