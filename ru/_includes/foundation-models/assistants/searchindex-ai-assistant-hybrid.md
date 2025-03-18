```python
from yandex_cloud_ml_sdk import YCloudML
from yandex_cloud_ml_sdk.search_indexes import (
    HybridSearchIndexType,
    TextSearchIndexType,
    StaticIndexChunkingStrategy,
    ReciprocalRankFusionIndexCombinationStrategy,
)

queries = [
    "Какие сервисы входят в Райдтех?",
    "Какая рентабельность скорректированного показателя EBITDA у сервисов объявлений?",
    "На сколько млрд рублей выдал Яндекс займов за 9 месяцев до 30 сентября 2024?",
]


def main():
    sdk = YCloudML(
        folder_id="<идентификатор_каталога>",
        auth="<API-ключ>",
    )

    file = sdk.files.upload("<путь_к_файлу>")
    operation = sdk.search_indexes.create_deferred(
        [file],
        index_type=HybridSearchIndexType(
            chunking_strategy=StaticIndexChunkingStrategy(
                max_chunk_size_tokens=512,
                chunk_overlap_tokens=256,
            ),
            combination_strategy=ReciprocalRankFusionIndexCombinationStrategy(),
        ),
    )
    hybrid_index = operation.wait()
    hybrid_tool = sdk.tools.search_index(hybrid_index)
    model = sdk.models.completions("yandexgpt", model_version="rc")
    assistant = sdk.assistants.create(model, tools=[hybrid_tool])
    hybrid_index_thread = sdk.threads.create()

    for query in queries:
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