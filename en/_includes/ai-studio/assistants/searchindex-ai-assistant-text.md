```python
from yandex_cloud_ml_sdk import YCloudML
from yandex_cloud_ml_sdk.search_indexes import (
    HybridSearchIndexType,
    TextSearchIndexType,
    StaticIndexChunkingStrategy,
    ReciprocalRankFusionIndexCombinationStrategy,
)

queries = [
    "What services are included in Ridetech?",
    "What is the adjusted EBITDA margin of ad services?",
    "For how many billion rubles did Yandex issue loans in 9 months to September 30, 2024?",
]


def main():
    sdk = YCloudML(
        folder_id="<folder_ID>",
        auth="<API_key>",
    )

    file = sdk.files.upload("<file_path>")
    operation = sdk.search_indexes.create_deferred(
        [file], index_type=TextSearchIndexType()
    )
    text_index = operation.wait()
    text_tool = sdk.tools.search_index(text_index)
    model = sdk.models.completions("yandexgpt", model_version="rc")
    assistant = sdk.assistants.create(model, tools=[text_tool])
    text_index_thread = sdk.threads.create()

    for query in queries:
        text_index_thread.write(query)
        print(query)
        run = assistant.run(text_index_thread)
        result = run.wait().message
        for part in result.parts:
            print(part)
        print("\n")


if __name__ == "__main__":
    main()
```