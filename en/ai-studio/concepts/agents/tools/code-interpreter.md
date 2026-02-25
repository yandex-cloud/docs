---
title: '{{ code-interpreter }}'
description: '{{ code-interpreter }} is a built-in {{ ai-studio-full-name }} tool that allow the model to write and execute Python code in an isolated testing environment.'
---

# {{ code-interpreter }}

_{{ code-interpreter }}_ is a built-in {{ ai-studio-full-name }} tool that allows the model to write and execute Python code in an isolated testing environment. It is used for tasks where text reasoning alone is not enough and actual computing is required.

The tool can be of particular use in the following scenarios:

* Data analysis.
* Programming and logic debugging.
* Mathematical calculations.
* Working with files and images.

{% include [models-for-code-interpreter](../../../../_includes/ai-studio/agents/models-for-code-interpreter.md) %}

## Main features {#capability}

### Python code execution {#run-code}

{{ code-interpreter }} offers the model a full-value Python runtime environment integrated into the reasoning process. Within the same session, the model can:

* Write Python for your task.
* Execute the code in an isolated environment.
* Get accurate and deterministic results.
* Analyze the errors.
* Edit the code and rerun it until the correct result is achieved.

The tool's key feature is that of being iterative. Code execution is not a one-off action: the model can progressively refine the logic, fix errors, and make the solution more and more sophisticated based on the results of previous runs. This makes {{ code-interpreter }} especially well-suited for tasks that depend on hypothesis testing through calculations, step-by-step analysis, high accuracy, and reproducibility of results.

### Working with files and data

{{ code-interpreter }} is integrated with the Files API and uses it as its primary file transfer and storage tool.
The agent can use this tool to:

* Load and process files in various formats (CSV, JSON, XLSX, TXT, etc.).
* Create new files – tables, datasets, reports, charts, and images – while executing code.
* Use files provided by the user in request input as source data for analysis and computation.

All files submitted with the request via the Files API are stored in a [container](#containers) and remain available to the model throughout the container's lifecycle without having to be re-uploaded.

Files created by the model are returned as annotations containing the file name and ID (`file_id`). This ID can be used to download the file through the Files API.

## Image and chart generation {#media-generation}

The {{ code-interpreter }} does not just compute, it also visualizes the results. You can use the tool to:

* Create charts of various types.
* Visualize numeric and categorical data.
* Visualize intermediate and final results.
* Saving visualizations as image files.

The model's output gets saved into full-featured visual artifacts that can be downloaded, used in subsequent processing steps, or displayed directly in the client's UI.

## Containers {#containers}

A container is a fully isolated virtual environment {{ code-interpreter }} executes Python code in. It has no access to external resources and stores temporary data and the state of ongoing calculations internally.

You can create a container in two ways:

* In automatic mode (Auto): a container is created when the {{ responses-api }} is called with the {{ code-interpreter }} tool and is available at `/v1/containers`. When creating a container, you can specify a list of files to upload.

  The lifetime is 20 minutes since the last activity. When you restart your calculations, data from the previous request gets deleted.
  
* Manually (Explicit): a container is created in advance via the `/v1/containers` endpoint, after which its ID (`container_id`) is provided in the tool's configuration.

  The lifetime since the last activity is user configured via the `expire_after` parameter, but cannot exceed 20 minutes. When you restart your calculations, data from the previous request does not get deleted.

Data from all types of containers is automatically uploaded to an external storage through the Files API. File links are available in the `container_file_citation` annotation.

#### See also {#see-also}

* [{#T}](../../../operations/agents/use-code-interpreter.md)
