---
title: '{{ code-interpreter }}'
description: '{{ code-interpreter }} is an in-built {{ ai-studio-full-name }} tool allowing the model to write and execute Python code in an isolated test environment.'
---

# {{ code-interpreter }}

{% include [note-preview](../../../../_includes/note-preview.md) %}

_{{ code-interpreter }}_ is an in-built {{ ai-studio-full-name }} tool allowing the model to write and execute Python code in an isolated test environment. It is used for tasks where text reasoning alone is not enough and actual computing is required.

This code execution tool can be of particular use in the following scenarios:

* Data analysis.
* Programming and debugging logic.
* Mathematical calculations.
* Working with files and images.

{% include [models-for-code-interpreter](../../../../_includes/ai-studio/agents/models-for-code-interpreter.md) %}

## Main features {#capability}

### Python code execution {#run-code}

{{ code-interpreter }} provides the model with a full-fledged Python runtime environment integrated into the reasoning process. Within a single session, the model can:

* Write Python code to solve a task.
* Execute the code in an isolated testing environment.
* Get accurate and deterministic results.
* Analyze occurring errors.
* Edit the code and rerun it until it achieves the correct result.

Key feature of the tool is that it is iterative. Code execution is not a one-time action: the model can sequentially check the logic, fix errors, and keep building up the solution based on the results of previous runs. This makes {{ code-interpreter }} especially well-suited for tasks that require hypothesis testing through calculations, step-by-step analysis, high accuracy, and result reproducibility.

### Working with files and data

{{ code-interpreter }} is integrated with Files API and uses it as the primary tool for transferring and storing files.
Using this tool, the agent can:

* Load and process files in various formats, such as CSV, JSON, XLSX, TXT, etc.
* Create new files, such as tables, datasets, reports, charts, and images during code execution.
* Use the files provided by the user in the request input as source data for analysis and computing.

All files submitted in the request via the Files API are saved to a [container](#containers) and remain available to the model throughout the container's lifecycle without having to be re-uploaded.

Files created by the model are returned as annotations with the file name and ID (`file_id`). This file ID can be used to download this file through the Files API.

## Image and chart generation {#media-generation}

The {{ code-interpreter }} allows not only to perform computations but also visualizes the results. You can use this tool for:

* Creating various types of charts.
* Visualizing numerical and categorical data.
* Presenting intermediate and final results in a visual form.
* Saving visualizations as image files.

The results produced by the model are turned into fully-fledged visual artifacts that can be downloaded, used in subsequent processing steps, or displayed directly in the client interface.

## Containers {#containers}

A container is a fully isolated virtual environment where the {{ code-interpreter }} executes Python code. It has no access to external resources and independently stores temporary data and the state of ongoing calculations.

You can create a container in two ways:

* Automatic mode (Auto): a container is created when the {{ responses-api }} is called with the {{ code-interpreter }} tool and is accessible at `/v1/containers`. When creating a container, you can specify a list of files to upload.

  The lifetime is 20 minutes since it was last active. When you restart calculations, data from the previous request is deleted.
  
* Manual container creation (Explicit): a container is created in advance via the `/v1/containers` endpoint, after which its ID (`container_id`) is passed in the tool configuration.

  The lifetime after the last activity is configured by the user via the `expire_after` parameter, but cannot exceed 20 minutes. When you restart calculations, data from the previous request is not deleted.

Data from all types of containers is automatically uploaded to external storage through the Files API. File links are available in the `container_file_citation` annotation.

#### See also {#see-also}

* [{#T}](../../../operations/agents/use-code-interpreter.md)
