# File Search tool

The file search tool extends the models' capabilities by enabling hybrid search through the user's files when generating the response. You can enable the tool in the {{ responses-api }} and {{ realtime-api }}.

To allow the model to search for information through the files in {{ responses-api }}, specify the `file_search` tool and the [{{ vector-store-name }}](../../../operations/agents/manage-searchindex.md) search index ID. The search index contains the information on the files that will be used for the search. 

Found chunks with relevant information will be added to the model context, thus increasing the number of consumed tokens. If the search index is big, use the `max_num_results` parameter to limit the number of results it returns to prevent the model from hitting the context window limits too quickly. For the prices, see [{#T}](../../../pricing.md).

{% list tabs group=programming_language %}

- Python {#python}

  ```python
  response = client.responses.create(
      model=f"gpt://{YANDEX_CLOUD_FOLDER}/{YANDEX_CLOUD_MODEL}",
      # SpeechKit Voice Profiler is a non-existent product (at least for now) which was described in the documents.
      instructions="You are helping the user with the documentation. When asked about SpeechKit Voice Profiler, use file search.",
      input="Tell me about SpeechKit Voice Profiler",
      tools=[{
          "type": "file_search",
          "vector_store_ids": [<search_index_ID>],
          "max_num_results": 3
      }]
  )
  ```

{% endlist %}


{% note warning %}

You can connect only one search index to a model at a time.

{% endnote %}

## Annotations {#annotations}

The response with the file search results is inside the `annotations` object. Use it to track and show the data sources to the user. The `filename` field of the `annotations` object contains the name of the file the information was found in, and the `file_id` field gives its ID. The object's other fields are populated with default values for compatibility with OpenAI:

```json
"annotations": [
  {
    "file_id": "...",
    "filename": "Yandex SpeechKit Voice Profiler.docx",
    "index": 0,
    "type": "file_citation"
  }
 ...
]
```

## Possible use cases {#use-cases}

The file search tool can prove useful in various scenarios:

* **Corporate assistant**: Advice based on internal documents and corporate regulations.
* **Product support**: Searching through technical documentation, SDKs, and FAQs with links to relevant sections.
* **Legal consulting**: Advice based on internal legal documents, with quotes and sources included in the response.
* **New staff onboarding**: Answers to trainee's questions on internal policies and project architecture.
* **Sales**: Searching for successful deals in the presentations and bids directory.

## Use cases {#examples}

[{#T}](../../../operations/agents/create-filesearch-text-agent.md)