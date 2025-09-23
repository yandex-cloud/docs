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
    At the input, you will be given a user query and pieces of reports, based on which you need to give an answer to the user's question and add an evaluation as an investment assistant.
     
    If you need to output the value of a metric in response to a user query, you should interpret the value. 
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