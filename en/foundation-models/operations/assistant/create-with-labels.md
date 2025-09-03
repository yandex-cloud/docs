---
title: Creating a RAG search assistant with file and index metadata
description: Follow this guide to use {{ assistant-api }} to create a personalized assistant that draws information from external sources with file and index level metadata specified.
---

# Creating an AI assistant for RAG with source file and index metadata preserved

{% include [assistants-preview-stage](../../../_includes/foundation-models/assistants-preview-stage.md) %}

{{ assistant-api }} is a {{ foundation-models-name }} tool for creating [AI assistants](../../concepts/assistant/index.md). It can be used to create personalized assistants and implement a generative response scenario based on information from external sources (Retrieval Augmented Generation or [RAG](https://en.wikipedia.org/wiki/Retrieval-augmented_generation)) by assigning [metadata](../../concepts/assistant/index.md#labels) sets to source files and search indexes for more efficient navigation through external sources.

The VectorStore [tool](../../concepts/assistant/tools/vector-store.md) allows AI assistants to draw information from the knowledge base.

## Getting started {#before-begin}

To use an example:

{% list tabs group=programming_language %}

- SDK {#sdk}

  {% include [sdk-before-begin-assistants](../../../_includes/foundation-models/sdk-before-begin-assistants.md) %}

{% endlist %}

## Create an assistant {#create-assistant}

{% list tabs group=programming_language %}

- SDK {#sdk}

  This example shows how to create an [assistant](../../concepts/assistant/index.md) that relies on information from files for responses. In the example, we will create a vector search index and a simplest form of chat. The search index and source files will get a set of metadata containing summarized information about them.

  1. {% include [download-context-file-step](../../../_includes/foundation-models/assistants/download-context-file-step.md) %}
  1. Create a file named `search-assistant.py` and paste the following code into it:

      {% include [searchindex-assistant-labels](../../../_includes/foundation-models/examples/searchindex-assistant-labels.md) %}

      Where:

      * `mypath`: Variable containing the path to the directory containing the files you downloaded earlier, e.g., `/Users/myuser/tours-example/`.

      {% include [sdk-code-legend](../../../_includes/foundation-models/examples/sdk-code-legend.md) %}

  1. Run the file you created:

      ```bash
      python3 search-assistant.py
      ```

      The example implements the simplest chat possible: enter your requests to the assistant from your keyboard and get answers. To end the dialog, enter `exit`.

      {% cut "Approximate result" %}

      {% include [assistant-labels-output](../../../_untranslatable/foundation-models/assistant-labels-output.md) %}

      {% endcut %}

      In the `run.text` property, the AI assistant returned the model-generated response based on the uploaded knowledge base. The `run.citations` property contains [source citations](../../concepts/assistant/index.md#citations), i.e., information about the knowledge base files and search indexes used to generate the response, including source file (`citation.sources.file.labels` property) and index (`citation.sources.search_index.labels` property) [metadata](../../concepts/assistant/index.md#labels).

{% endlist %}

#### See also {#see-also}

* [{#T}](./create.md)
* [{#T}](./create-with-searchindex.md)
* [{#T}](./create-with-websearch.md)
* [{#T}](../../tutorials/pdf-searchindex-ai-assistant.md)
* [{#T}](../../concepts/assistant/tools/index.md)
* Examples of working with {{ ml-sdk-name }} on [GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/master/examples/sync/assistants)