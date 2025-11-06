# Creating an AI assistant with RAG from PDF files with complex formatting

{% include [assistants-do-not-use](../../_includes/ai-studio/ai-assistant-disclaimer.md) %}

This tutorial provides an example of creating an [AI assistant](../../ai-studio/concepts/assistant/index.md) which will search through information in a source with complex formatting and tabular data and analyze the results using the {{ gpt-pro }} RC [text generation model](../../ai-studio/concepts/generation/models.md).

In this tutorial, a [PDF](https://en.wikipedia.org/wiki/PDF) file serves as an example of a source file with complex formatting. We will convert this source file to [Markdown](https://en.wikipedia.org/wiki/Markdown) format. Many models are trained on and work best with Markdown data, so this format is the most efficient to use as a source for a search index. The search indexes you will create from the source file will employ two [search types](../../ai-studio/concepts/assistant/search-index.md#search-types): text and hybrid.

You will use [{{ assistant-api }}](../../ai-studio/assistants/api-ref/index.md) for Python to access the [{{ ml-sdk-full-name }}](../../ai-studio/sdk/index.md) and [Text Generation API](../../ai-studio/text-generation/api-ref/index.md).


## Getting started {#before-you-begin}

{% note info %}

We recommend completing this tutorial on a machine with at least 4 GB of RAM and 12 GB of free disk space.

It may take up to one hour to set up your environment.

{% endnote %}

1. [Create](../../iam/operations/sa/create.md) a service account and [assign](../../iam/operations/sa/assign-role-for-sa.md) the `ai.assistants.editor` and `ai.languageModels.user` [roles](../../ai-studio/security/index.md#service-roles) to it.
1. {% include [sdk-before-begin-step2](../../_includes/ai-studio/sdk-before-begin-step2.md) %}
1. {% include [sdk-before-begin-step3](../../_includes/ai-studio/sdk-before-begin-step3.md) %}
1. {% include [sdk-before-begin-step4](../../_includes/ai-studio/sdk-before-begin-step4.md) %}
1. {% include [sdk-before-begin-step5](../../_includes/ai-studio/sdk-before-begin-step5.md) %}
1. Using [pip](https://pypi.org/project/pip/), install the [docling](https://github.com/DS4SD/docling) library to convert documents from PDF to Markdown format:

    ```bash
    pip install docling
    ```

1. Install the [{{ ml-sdk-full-name }}](https://github.com/yandex-cloud/yandex-cloud-ml-sdk) library to work with the {{ foundation-models-full-name }} tools:

    ```bash
    pip install yandex-cloud-ml-sdk
    ```

1. [Download](https://{{ s3-storage-host-doc-files }}/ml/assistant-example.pdf) `assistant-example.pdf` with the document to use as the information source for the AI assistant and convert it to Markdown format using the `docling` library you installed earlier:

    1. Create a file named `convert.py` containing the following code:

        ```python
        from docling.document_converter import DocumentConverter

        converter = DocumentConverter()
        result = converter.convert("assistant-example.pdf")
        content = result.document.export_to_markdown()
        with open("assistant-example.md", "wt") as f:
           f.write(content)
        ```

    1. Run `convert.py`:

        ```bash
        python3 convert.py
        ```

        As a result, `assistant-example.md` with the content from the original PDF file in Markdown format will be saved in the current directory.


### Required paid resources {#paid-resources}

The cost of using an AI assistant includes a text generation fee (see [{{ foundation-models-full-name }} pricing](../../ai-studio/pricing.md)).


## Create an AI assistant and test it {#create-assistant}

You will create a search index, sourced from a Markdown file. You will then ask the created assistant a few questions based on the information source:


### Create an AI assistant with a text search index {#test-search-assistant}

1. Create a file named `assistant-text.py` containing the following code:

    {% include [searchindex-ai-assistant-text](../../_includes/ai-studio/assistants/searchindex-ai-assistant-text.md) %}

    {% include [sdk-code-legend](../../_includes/ai-studio/assistants/sdk-code-legend.md) %}

1. Run `assistant-text.py` to create an assistant and use it to answer the questions below:

    ```bash
    python3 assistant-text.py
    ```

    Result:

    ```text
    What services does Ridetech include?
    Ridetech includes:
    * Online taxi ordering service
    * Yandex Drive carsharing service
    * Scooter rental service
    * Other promising services

    What is the adjusted EBITDA margin of ad services?
    Ad services have an adjusted EBITDA margin of 51.3%.

    How many billion rubles in loans did Yandex issue over nine months prior to September 30, 2024?
    In the provided context, there is no information about how many billion rubles Yandex issued in loans over the nine months prior to September 30, 2024.
    ```

    As you can see from the result, the text search only handled the first, easiest question. The second question yielded an incorrect result, and the third one, no answer at all.

### Create an AI assistant with a hybrid search index {#hybrid-search-assistant}

1. Create a file named `assistant-hybrid.py` containing the following code:

    {% include [searchindex-ai-assistant-hybrid](../../_includes/ai-studio/assistants/searchindex-ai-assistant-hybrid.md) %}

    {% include [sdk-code-legend](../../_includes/ai-studio/assistants/sdk-code-legend.md) %}

1. Run `assistant-hybrid.py` to create an assistant and use it to answer the questions below:

    ```bash
    python3 assistant-hybrid.py
    ```

    Result:

    ```text
    Ridetech includes:
    * Online taxi ordering service and distribution of such technologies abroad.
    * Yandex Drive carsharing service.
    * Scooter rental service.
    * Other promising services.

    What is the adjusted EBITDA margin of ad services?
    The adjusted EBITDA margin of ad services over the third quarter of 2024 was 6.5%.

    How many billion rubles of loans did Yandex issue over nine months prior to September 30, 2024?
    Over the nine months prior to September 30, 2024, Yandex issued loans worth 6.5 billion rubles.
    ```

    As you can see, the hybrid search provided a better result: the answers to all three questions are correct.


### Improve your assistant {#improve-assistant}

Improve your assistant by turning it from a simple information source into a smart helper that analyzes the retrieved data and delivers reasoned judgments.

1. Create a file named `assistant-analyst.py` containing the following code:

    {% include [searchindex-ai-assistant-analyst](../../_includes/ai-studio/assistants/searchindex-ai-assistant-analyst.md) %}

    {% include [sdk-code-legend](../../_includes/ai-studio/assistants/sdk-code-legend.md) %}

1. Run `assistant-analyst.py` to create an assistant and use it to answer the questions below:

    ```bash
    python3 assistant-analyst.py
    ```

    Result:

    ```text
    What is the adjusted EBITDA margin of ad services?
    The adjusted EBITDA margin of ad services for the third quarter of 2024
    was 6.5%. This is a significant improvement compared to the same period last year, when
    the profit margin was 3.3%. This growth indicates segment efficiency and improved
    financial performance.
    ```