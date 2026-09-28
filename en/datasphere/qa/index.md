---
title: '{{ ml-platform-full-name }}. FAQ'
description: How do I get my activity logs in {{ ml-platform-full-name }}? Find answers to this and other questions in this article.
---

# General questions about {{ ml-platform-name }}

{% include [logs](../../_qa/logs.md) %}

{% include [personal-data](../../_qa/personal-data.md) %}

If a project fails to open, check your [current quota usage]({{ link-console-quotas }}) in the cloud. If the quotas allocated to {{ ml-platform-name }} are used up, the project may fail to start.

#### What do I do if I cannot install a package in my project or do not have internet access? {#error-connection}

Internet connectivity issues may occur if you enabled a subnet that is not configured for Internet access in your project. For example, you may get a `ConnectTimeoutError` error while installing a package with `pip`:

```text
Defaulting to user installation because normal site-packages is not writeable
WARNING: Retrying (Retry(total=4, connect=None, read=None, redirect=None, status=None)) after connection broken by 'ConnectTimeoutError(<HTTPSConnection(host='pypi.org', port=443) at 0x7f42c810ca00>, 'Connection to pypi.org timed out. (connect timeout=15)')': /simple/langchain/
ERROR: Could not find a version that satisfies the requirement langchain (from versions: none)
ERROR: No matching distribution found for langchain
```

If you need a subnet for your project, [set up an NAT gateway](../../vpc/operations/create-nat-gateway.md) to enable internet access for this subnet.

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

**The project is still loading.** If the loading icon persists, wait up to ten minutes. Loading a large project with many files can take this long. You can track your browser network activity on the **Network** tab in your browser's developer tools. To open the developer tools, press `F12`.

**The browser blocks access to the IDE.** In this case, you may see a blank page or a `Web page temporarily unavailable`, `Error 503`, or `Deadline Exceeded` message. When opening a project in an IDE, {{ ml-platform-name }} redirects your request to its own host with {{ jlab }}Lab. Modern browsers may block this redirect if you use enhanced privacy settings, including incognito mode. To open a project in an IDE, disable the blocking settings:

* **Chrome**: Allow using third-party cookies.
* **Safari**: Disable **Website tracking: Prevent cross-site tracking** under **Preferences** → **Privacy**.
* **Yandex Browser**: Allow using third-party cookies for {{ ml-platform-name }} in the browser settings under **Sites** → **Advanced site settings**.
* **Firefox**: Click the shield icon in the address bar and disable **Enhanced Tracking Protection**.

If your project fails to open, make sure none of the quotas has reached its limit. Navigate to the **Communities** tab, select a community, and open the **Quotas** tab. 

#### My browser asks me to grant access to a {{ jlab }}Lab host. How do I grant it? {#access}

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

#### Why do I get an Access Denied: Spec gX.X is not available for your cloud error? {#gpu-access}

This error means the selected GPU configuration is not available in your cloud. [Configurations](../concepts/configurations.md) marked with footnote `1` become available after switching to paid usage and topping up the billing account. The required top-up amount is specified in [this article](../concepts/configurations.md).

After topping up your balance:

1. Stop computations through **File** ⟶ **Stop IDE executions** and exit the project.
1. Reopen the project in the [management console]({{ link-console-main }}).

To learn how resources are charged within projects, see [{#T}](../pricing.md).

#### Why does code in project cells take a long time to run? {#slow-cell-execution}

When running code, a `Preparing <configuration_name> instance` message may be displayed for a long time. The possible causes may include the following:

1. The notebook has many cells, or its cells contain a large amount of code. Fully loading a project that contains hundreds of cells may take more than ten minutes. If feasible, try to reduce the number of cells in your project or opt for a higher-performance [computing configuration](../concepts/configurations.md).
1. When running code for the first time, {{ ml-platform-name }} provisions and starts a virtual machine with the selected resource configuration. This may take a while. To reduce startup time, use a higher-performance resource configuration.

#### Why do I get a Servant not allocated error when running code? {#servant-not-allocated}

When running code, you may see the following messages:

```text
Preparing <configuration_name> instance
Execute error: Servant <configuration_name> not allocated: Internal Error
```

This error may occur when available computing resources are temporarily insufficient. Try using a different [configuration](../concepts/configurations.md) or rerun the code later.

If your project uses a custom Docker image, check whether the issue persists on a public image.

#### What should I do if I get a Device or resource busy error when installing a library? {#device-resource-busy}

When installing a library, you may get this error:

```text
ERROR: Could not install packages due to an OSError: [Errno 16] Device or resource busy: '.nfs0000000000009d3a00000018'
```

This is a system message related to resources. To fix this error:

1. Restart the kernel by selecting **Kernel** ⟶ **Restart Kernel**.
1. Stop computations by selecting **File** ⟶ **Stop IDE executions** in {{ jlab }}Lab or clicking **{{ ui-key.yc-ui-datasphere.project-page.stop-ide-executions }}** in the **{{ ui-key.yc-ui-datasphere.project-page.executions }}** widget on the project page.
