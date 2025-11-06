---
title: Tools for using external information sources in {{ assistant-api }}
description: This section describes RAG tools you can use in {{ assistant-api }} to access external information sources and the capabilities these tools offer.
noIndex: true
---

# Tools for retrieval of additional information

{% include [assistants-do-not-use](../../../../_includes/ai-studio/ai-assistant-disclaimer.md) %}

AI assistants can rely on additional information sources, such as internal knowledge bases or web search, to perform tasks. To access these sources, you can use certain specialized _tools_, i.e., additional modules you can integrate with your AI assistants.

{{ foundation-models-name }} provides pre-integrated tools for {{ assistant-api }}:

* [{{ retrieval-tool-name }}](./vector-store.md)
* [WebSearch](./web-search.md)

You can connect multiple tools to an AI assistant at the same time.

#### See also {#see-also}

* [{#T}](../../../operations/assistant/create-with-searchindex.md)
* [{#T}](../../../operations/assistant/create-with-websearch.md)