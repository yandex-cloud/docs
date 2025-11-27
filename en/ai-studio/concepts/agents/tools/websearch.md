# Web search tool

The web search tools allows the model to draw information from open sources for more accurate and relevant date responses. The search can be performed across the entire internet or within a limited list of websites. You can enable the tool in {{ responses-api }} and {{ realtime-api }}. For the prices, see [{#T}](../../../pricing.md).

If the tool is enabled, the model independently decides whether it needs additional information to form a response. To allow the model to search through the internet when generating its responses, specify `web_search` in your request parameters. When connecting the tool via {{ responses-api }}, you can specify up to 5 websites in the `allowed_domains` array. If the list of websites is not specified, the search will be performed across the entire internet and will take more time. Additionally, you can limit the search region by specifying the [region code](../../../../search-api/reference/regions.md) in the `region` field of the `user_location` parameter.

{% list tabs group=programming_language %}

- Python {#python}

    ```python
    response = client.responses.create(
        model=f"gpt://{YANDEX_CLOUD_FOLDER}/{YANDEX_CLOUD_MODEL}",
        input="Create a brief overview of the latest LLM news in 2025, only facts, no specualtion.",
        tools=[
            {
                "web_search": {
                    "filters": {
                        "allowed_domains": [
                            "habr.ru"
                        ]
                    },
                    "user_location": {
                        "region": "213", # New York
                    }
                }
            }
        ],
        temperature=0.3,
        max_output_tokens=1000
    )
    ```

{% endlist %}

The response, enriched by the internet search, contains the `annotations` object. Use it to track and show the data sources to the user. The `url` field of the `annotations` object contains the address of the website where the information was found. All other fields of the object are filled with default values to maintain compatibility with OpenAI:

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

## Possible use cases {#use-cases}

The web search tool can prove useful in various scenarios:

* **Updating reference information**: Creating a summary of changes in app store rules this week.
* **Competitive analysis**: Gathering competitors' new features and use cases based on the information published on their websites.
* **Fact-checking press releases**: Verifying quotes and figures before publication.
* **Trend radar**: Compiling a quick news overview on a specific topic for a daily or weekly digest.
* **Meeting preparation**: Making a description of a client company before the meeting.