# Web Search

The Web Search tools allows the model to draw information from open sources for more accurate and up-to-date responses. It can search through the entire internet or within a limited list of websites. You can enable the tool in the {{ responses-api }} and {{ realtime-api }}.

With the tool on, the model itself decides whether or not it needs additional information to form a response. To allow the model to search for information on the internet when generating its responses, specify `web_search` in your request parameters and up to 5 websites in the `allowed_domains` array. If no websites are listed, the model will search through the entire internet, which will take more time. You can additionally limit the search region by putting the [region code](../../../../search-api/reference/regions.md) in the `region` field of the `user_location` parameter.

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

The Web Search tool can be of use in multiple scenarios:

- **Updating reference information**: Creating a summary of app store rule updates for this week.
- **Competitive analysis**: Gathering the competitors' innovations and roadmaps based on the information published on their websites.
- **Fact-checking press releases**: Verifying quotes and figures prior to publication.
- **Trend radar**: Compiling a quick news overview on a topic for a daily or weekly digest.
- **Meeting preparation**: Putting together a description of the client company ahead of the conference call.