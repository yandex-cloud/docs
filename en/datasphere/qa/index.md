---
title: '{{ ml-platform-full-name }}. FAQ'
description: How do I get the log files with my activity in {{ ml-platform-full-name }}? Find the answer to this and other questions in this article.
---

# General questions about {{ ml-platform-name }}

{% include [logs](../../_qa/logs.md) %}

{% include [personal-data](../../_qa/personal-data.md) %}

#### What do I do if I cannot install a package in my project or do not have internet access? {#error-connection}

You might have connection issues if you added a subnet to your project that does not have internet access.

If you need a subnet for your project, [set up an NAT gateway](../../vpc/operations/create-nat-gateway.md) to get internet access.

You can [change or disable](../operations/projects/update.md) the subnet in the project settings.

#### Can I close a tab with a notebook? {#close-notebook-tab}

Yes, you can. If you close the notebook tab, current executions will continue, all variables and computation results will be saved, but the output will not be saved for the executions that finished while the notebook was closed.
After completion of all the running computations, the VM will be assigned to the notebook for three hours. You can [change](../operations/projects/update.md) this value in the project settings.

#### How do I specify the configuration type for my project? {#instance-type}

You can select a [computing resource configuration](../concepts/configurations.md) when you first run computations in the {{ ml-platform-name }} notebook. The minimum available configuration is **c1.4** (4 vCPUs).

#### If I delete a running cell, will computations stop? {#delete-cell}

No, they will not. Computations will continue even if you delete a cell from the notebook. Before deleting a cell, make sure to stop it. If you have deleted a running cell, stop running calculations. To do this, select **File ⟶ Stop IDE executions** in {{ jlab }}Lab or click **{{ ui-key.yc-ui-datasphere.project-page.stop-ide-executions }}** in the **{{ ui-key.yc-ui-datasphere.project-page.executions }}** widget on the project page.

#### How do I clear a cell's outputs? {#clear-outputs}

Select **Edit** ⟶ **Clear All Outputs** in {{ jlab }}Lab or right-click on any cell and select **Clear All Outputs**. If you choose the second option, the outputs will only be [reset](../operations/projects/clear-outputs.md) for the current session.

#### Does {{ ml-platform-name }} support scheduled cell runs? {#regular-launch}

You can run scheduled calculations by [rerunning](../concepts/jobs/fork.md) the {{ ds-jobs }} jobs and [integrating them with {{ maf-full-name }}](../concepts/jobs/airflow.md).

You can also use [{{ sf-full-name }}](../../functions/concepts/trigger/timer.md) to automatically initiate notebook execution using the [{{ ml-platform-name }} API](../api-ref/overview.md). For a detailed description of regular runs, see this [guide](../tutorials/regular-launch.md).

#### My browser cannot open a {{ ml-platform-name }} project in the IDE. How can I fix this? {#browser}

When opening a project in the IDE, {{ ml-platform-name }} redirects your request to its own host with {{ jlab }}Lab. Modern browsers may block such website behavior if you use more advanced privacy tools, including incognito mode. To open a project in the IDE, turn off the blocking settings:

* **Chrome**: Allow using third-party cookies.
* **Safari**: Disable **Website tracking: Prevent cross-site tracking** under **Preferences** → **Privacy**.
* **Yandex Browser**: Allow using third-party cookies for {{ ml-platform-name }} in the browser settings under **Sites** → **Advanced site settings**.
* **Firefox**: Click the shield icon in the address bar and disable **Enhanced Tracking Protection**.

#### My browser asks me to grant access to a {{ jlab }}Lab host. How do I do that? {#access}

The message is triggered by an experimental option in Google Chrome, which implements the storage access API. To disable it, type `chrome://flags` in the browser address bar, find **Storage Access API** in the search bar below, and change the option status to **Disabled**.

#### How do I deploy a Hugging Face model in {{ ml-platform-name }}? {#huggingface}

Some libraries download models to predefined folders by default. Models may not be available for import if the folder they were downloaded to is not located in the project repository. To avoid this, choose a correct download directory and specify it when importing a model:

```python
cache_dir="/home/jupyter/datasphere/project/huggingface_cache_dir/"

config = AutoConfig.from_pretrained("<model_name>", cache_dir=cache_dir)
model = AutoModel.from_pretrained("<model_name>", config=config, cache_dir=cache_dir)
```

To avoid specifying the directory's path every time, you can provide it in an environment variable. Make sure you do this at the very start of the notebook, prior to importing libraries:

```python
import os
os.environ['TRANSFORMERS_CACHE'] = '/home/jupyter/datasphere/project/huggingface_cache_dir/'
```

In addition, you can configure a model to operate in offline mode by referring to the [official Hugging Face documentation](https://huggingface.co/docs/transformers/installation#fetch-models-and-tokenizers-to-use-offline).
