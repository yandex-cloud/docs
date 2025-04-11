# Creating an AI assistant with search through PDF files with complex formatting

{% include [assistants-preview-stage](../../_includes/foundation-models/assistants-preview-stage.md) %}

This tutorial provides an example of creating an [AI assistant](../../foundation-models/concepts/assistant/index.md) that searches through information in a source containing complex formatting and tabular data and analyzes the retrieved data using the {{ gpt-pro }} RC [text generation model](../../foundation-models/concepts/yandexgpt/models.md).

A [PDF](https://en.wikipedia.org/wiki/PDF) file serves as an example of a source file with complex formatting. The source file will be converted to [Markdown](https://en.wikipedia.org/wiki/Markdown) format. Many models are trained on and work best with Markdown data, so this format is the most efficient to use as a source for a search index. The search indexes you will create from the source file will use two [search options](../../foundation-models/concepts/assistant/search-index.md#search-types): text and hybrid.

You will access the [{{ assistant-api }}](../../foundation-models/assistants/api-ref/index.md) and [Text Generation API](../../foundation-models/text-generation/api-ref/index.md) through [{{ ml-sdk-full-name }}](../../foundation-models/sdk/index.md) for Python.

## Getting started {#before-you-begin}

1. [Create](../../iam/operations/sa/create.md) a service account and [assign](../../iam/operations/sa/assign-role-for-sa.md) the `ai.assistants.editor` and `ai.languageModels.user` [roles](../../foundation-models/security/index.md#service-roles) to it.
1. [Get](../../iam/operations/authentication/manage-api-keys.md#create-api-key) the service account API key and save it.

    {% include [sdk-auth-details-paragraph](../../_includes/foundation-models/sdk-auth-details-paragraph.md) %}
1. Install Python [3.10](https://www.python.org/downloads/release/python-3100/) or [3.11](https://www.python.org/downloads/release/python-3110/).
1. Install the Python [venv](https://docs.python.org/3/library/venv.html) utility to create isolated virtual environments in Python.
1. Create and log in to a new Python virtual environment:

    ```bash
    python3 -m venv new-env
    source new-env/bin/activate
    ```
1. Using the [pip](https://pypi.org/project/pip/) package manager, install the [docling](https://github.com/DS4SD/docling) library to convert documents from PDF to Markdown format:

    ```bash
    pip install docling
    ```
1. Install the [{{ ml-sdk-full-name }}](https://github.com/yandex-cloud/yandex-cloud-ml-sdk) library to work with the {{ foundation-models-full-name }} tools:

    ```bash
    pip install yandex-cloud-ml-sdk
    ```
1. [Download](https://{{ s3-storage-host-doc-files }}/ml/assistant-example.pdf) the `assistant-example.pdf` file with the document to use as the information source for the AI assistant and convert it to Markdown format using the `docling` library you installed earlier:

    1. Create a file named `convert.py` containing the following code:

        ```python
        from docling.document_converter import DocumentConverter

        converter = DocumentConverter()
        result = converter.convert("assistant-example.pdf")
        content = result.document.export_to_markdown()
        with open("assistant-example.md", "wt") as f:
           f.write(content)
        ```
    1. Execute the `convert.py` file:

        ```bash
        python3 convert.py
        ```

        As a result, the `assistant-example.md` file with the content from the original PDF file in Markdown format will be saved in the current directory.

### Required paid resources {#paid-resources}

The cost of using an AI assistant includes a text generation fee (see [{{ foundation-models-full-name }} pricing](../../foundation-models/pricing.md)).

## Create an AI assistant and test it {#create-assistant}

You will create a search index, sourced from a Markdown file. You will then ask the created assistant a few questions based on the information source:

### Create an AI assistant with a text search index {#test-search-assistant}

1. Create a file named `assistant-text.py` containing the following code:

    {% include [searchindex-ai-assistant-text](../../_includes/foundation-models/assistants/searchindex-ai-assistant-text.md) %}

    {% include [sdk-code-legend](../../_includes/foundation-models/assistants/sdk-code-legend.md) %}

1. Run the `assistant-text.py` file to create an assistant and get answers to questions from it:

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

    How many billion rubles of loans did Yandex issue over nine months prior to September 30, 2024?
    In the provided context, there is no information about how many billion rubles Yandex issued in loans over the nine months prior to September 30, 2024.
    ```

    As you can see from the result, the text search only handled the first, easiest question. The second question yielded an incorrect result, and the third one, no answer at all.

### Create an AI assistant with a hybrid search index {#hybrid-search-assistant}

1. Create a file named `assistant-hybrid.py` containing the following code:

    {% include [searchindex-ai-assistant-hybrid](../../_includes/foundation-models/assistants/searchindex-ai-assistant-hybrid.md) %}

    {% include [sdk-code-legend](../../_includes/foundation-models/assistants/sdk-code-legend.md) %}

1. Run the `assistant-hybrid.py` file to create an assistant and get answers to questions from it:

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

### Refine your assistant {#improve-search}

Expand the capabilities of the created assistant, turning it from a simple informant into a smart assistant that analyzes found data and provides evaluations based on it.

1. Create a file named `assistant-analyst.py` containing the following code:

    {% include [searchindex-ai-assistant-analyst](../../_includes/foundation-models/assistants/searchindex-ai-assistant-analyst.md) %}

    {% include [sdk-code-legend](../../_includes/foundation-models/assistants/sdk-code-legend.md) %}

1. Run the `assistant-analyst.py` file to create an assistant and get answers to questions from it:

    ```bash
    python3 assistant-analyst.py
    ```

    Result:

    ```text
    What is the adjusted EBITDA margin of ad services?
    The adjusted EBITDA margin of ad services over the third quarter of 2024 was 6.5%.
     This is a significant improvement compared to the same period last year, when the profit margin was 3.3%.
     This growth indicates the efficiency of the segment and the improvement of its financial performance.
    
    ```