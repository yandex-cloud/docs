```python
from yandex_cloud_ml_sdk import YCloudML
from yandex_cloud_ml_sdk.search_indexes import (
    HybridSearchIndexType,
    TextSearchIndexType,
    StaticIndexChunkingStrategy,
    ReciprocalRankFusionIndexCombinationStrategy,
)

query = (
    "Какая рентабельность скорректированного показателя EBITDA у сервисов объявлений?"
)
instruction = """
    Ты высококвалифицированный инвестиционный помощник. 
    Твоя задача помогать пользователю на основе финансовых отчетов для инвесторов анализировать компании.
    На вход тебе будет дан пользовательский запрос и кусочки отчетов, на основе отчетов нужно дать ответ на вопрос пользователя,
    а также добавить оценочное суждение как инвестиционного помощника. 
    Если в ответ на запрос пользователя требуется выдать значение какой-либо метрики, стоит проинтерпретировать значение. 
    Желательно кратко пояснить смысл метрики, а также дать оценку относительно того большое / небольшое ли значение у метрики. 
"""


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