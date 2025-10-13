```python
from yandex_cloud_ml_sdk import YCloudML
from yandex_cloud_ml_sdk.search_indexes import (
    HybridSearchIndexType,
    TextSearchIndexType,
    StaticIndexChunkingStrategy,
    ReciprocalRankFusionIndexCombinationStrategy,
)

query = (
    "What is the adjusted EBITDA margin of ad services?"
)
instruction = """
    You are a highly qualified investment assistant. 
    Your task is to help the user analyze companies based on financial reports for investors.
    As input, you will receive a user query and fragments of reports. Use the reports to give an answer to the user's question. Also, as an investment assistant, include an expert opinion.
     
    If your response to the user’s query includes a metric value, provide an interpretation of this value. 
    Ideally, briefly explain the meaning of the metric and give an evaluation as to whether the metric value is large/small. 
"""


def main():
    sdk = YCloudML(
        folder_id="<folder_ID>",
        auth="<API_key>",
    )

    file = sdk.files.upload("<file_path>")
    operation = sdk.search_indexes.create_deferred(
        [file],
        index_type=HybridSearchIndexType(
            chunking_strategy=StaticIndexChunkingStrategy(
                max_chunk_size_tokens=1024,
                chunk_overlap_tokens=512,
            ),
            combination_strategy=ReciprocalRankFusionIndexCombinationStrategy(),
        ),
    )
    hybrid_index = operation.wait()
    hybrid_tool = sdk.tools.search_index(hybrid_index)
    model = sdk.models.completions("yandexgpt", model_version="rc")
    assistant = sdk.assistants.create(
        model, tools=[hybrid_tool], instruction=instruction
    )
    hybrid_index_thread = sdk.threads.create()

    hybrid_index_thread.write(query)
    print(query)
    run = assistant.run(hybrid_index_thread)
    result = run.wait().message
    for part in result.parts:
        print(part)
    print("\n")


if __name__ == "__main__":
    main()
```