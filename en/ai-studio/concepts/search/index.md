# {{ ai-search-name }} technology overview

{{ ai-search-name }} comprises {{ ai-studio-name }} tools and technologies that enable models to generate responses grounded in verified data, such as corporate documents, internal knowledge bases, or internet content.

{{ ai-search-name }} provides search tools for the following two types of sources:

* [File Search](../agents/tools/filesearch.md) to search within proprietary user data (documents, guides, FAQ).
* [Web Search](../agents/tools/websearch.md) to search across selected internet domains.

You can use either of the tools when creating [voice agents](../agents/realtime.md) with {{ realtime-api }} or in {{ responses-api }} when creating text agents and calling text generation models to generate accurate, relevant, and verifiable responses. Both tools can be enabled simultaneously, but the model will select the most appropriate one based on the user's query, tool description, and prompt.

## How {{ ai-search-name }} works {#how-aisearch-works}

To generate text, models can only refer to their training data or information provided in the request context. Thus, if you want your selected {{ model-gallery-name }} model to integrate your information in its response, you need to prepare the data and add it to the request context. Context enrichment is a multi-stage process:

1. Data indexing. By default, {{ ai-studio-name }} automatically prepares data for search. All you need to do is upload files in the management console or via the Files API and create a {{ vector-store-name }} search index. After that, {{ ai-studio-name }} will break the data into chunks of the required size, i.e., fragments of text from a few lines to several paragraphs, and then [tokenize](../generation/tokens.md) them and store them in the search index.

   To avoid possible loss of meaning when preparing files, you can [split](../../operations/agents/create-prechunked-search-agent.md) the data into chunks yourself and upload them to {{ ai-studio-name }} in [JSONL](https://jsonlines.org/) format. One chunk may contain a maximum of 8,000 characters.

1. Generating a search query. Depending on the task at hand and conditions for using search tools described in the prompt, the model generates a query to either file search or internet search tools.

1. Getting fragments. The tool returns the most relevant information from the search index as chunks and adds it to the model context.

1. Generating a response. The model relies on the retrieved information for facts, maintaining the tone, style, and instructions from the prompt.

## Use cases {#examples}

* [{#T}](../../operations/agents/create-websearch-text-agent.md)
* [{#T}](../../operations/agents/create-filesearch-text-agent.md)
* [{#T}](../../operations/agents/create-prechunked-search-agent.md)