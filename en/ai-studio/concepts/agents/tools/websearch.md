# Web Search

The web search tools allows the model to draw information from open sources for more accurate and relevant date responses. It can search through the entire internet or within a limited list of websites. You can enable the tool in the {{ responses-api }} and {{ realtime-api }}. For the prices, see [{#T}](../../../pricing.md).

With the tool on, the model itself decides whether or not it needs additional information to form a response. To allow the model to search through the internet when generating its responses, specify `web_search` in your request parameters. When connecting the tool via {{ responses-api }}, the following optional parameters are available:

* `allowed_domains`: Array containing up to five domains to search in. If no domains are listed, the model will search through the entire internet. 
* `user_location`: Search region limit. Give the [region code](../../../../search-api/reference/regions.md) in the `region` field if you need to.
* `search_context_size`: Size of context yielded by the search. Controls the completeness and detail of the response and token consumption when using the tool. Possible values: `low`, `medium`, `high`. The default value is `medium`.

{% list tabs group=programming_language %}

- Python {#python}

    ```python
    response = client.responses.create(
        model=f"gpt://{YANDEX_CLOUD_FOLDER}/{YANDEX_CLOUD_MODEL}",
        input="Create a brief overview of the latest LLM news in 2025, only facts, no specualtion.",
        tools=[
            {
                "type": "web_search",
                "filters": {
                    "allowed_domains": [
                        "habr.ru"
                    ],
                    "user_location": {
                        "region": "213",
                    },
                },
                "search_context_size": "medium", # Possible options: low | medium | high
            }
        ],
        temperature=0.3,
        max_output_tokens=1000
    )
    ```

{% endlist %}

The response, enriched by the internet search, contains the `annotations` object. Use it to track and show the data sources to the user. The `url` field of the `annotations` object contains the address of the website the information was found on. All other fields of the object are populated with default values for compatibility with OpenAI:

```json
"annotations": [
  {
    "end_index": 0,
    "start_index": 0,
    "title": "",
    "type": "url_citation",
    "url": "www.rbc.ru"
  },
  {
    "end_index": 0,
    "start_index": 0,
    "title": "",
    "type": "url_citation",
    "url": "ria.ru"
  }
]
```

## Possible use cases for the tool {#use-cases}

The web search tool can prove useful in various scenarios:

* **Updating reference information**: Creating a summary of app store rule updates for this week.
* **Competitive analysis**: Gathering the competitors' innovations and roadmaps based on the information published on their websites.
* **Fact-checking press releases**: Verifying quotes and figures prior to publication.
* **Trend radar**: Compiling a quick news overview on a topic for a daily or weekly digest.
* **Meeting preparation**: Putting together a description of the client company ahead of the conference call.

## Use cases {#examples}

[{#T}](../../../operations/agents/create-websearch-text-agent.md)
