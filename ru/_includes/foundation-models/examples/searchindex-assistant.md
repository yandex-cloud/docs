```python
#!/usr/bin/env python3

from __future__ import annotations

import pathlib

from yandex_cloud_ml_sdk import YCloudML
from yandex_cloud_ml_sdk.search_indexes import (
    StaticIndexChunkingStrategy,
    TextSearchIndexType,
)

mypath = "<путь_к_файлам_с_примерами>"


def main():
    sdk = YCloudML(
        folder_id="<идентификатор_каталога>",
        auth="<API-ключ>",
    )

    paths = pathlib.Path(mypath).iterdir()

    # Загрузим файлы с примерами.
    # Файлы будут храниться 5 дней.
    files = []
    for path in paths:
        file = sdk.files.upload(
            path,
            ttl_days=5,
            expiration_policy="static",
        )
        files.append(file)

    # Создадим индекс для полнотекстового поиска по загруженным файлам.
    # В данном примере задается размер фрагмента,
    # не превышающий 700 токенов с перекрытием в 300 токенов.
    operation = sdk.search_indexes.create_deferred(
        files,
        index_type=TextSearchIndexType(
            chunking_strategy=StaticIndexChunkingStrategy(
                max_chunk_size_tokens=700,
                chunk_overlap_tokens=300,
            )
        ),
    )

    # Дождемся создания поискового индекса.
    search_index = operation.wait()

    # Создадим инструмент для работы с поисковым индексом.
    # Или даже с несколькими индексами, если бы их было больше.
    tool = sdk.tools.search_index(search_index)

    # Создадим ассистента для модели {{ gpt-pro }} Latest.
    # Он будет использовать инструмент поискового индекса.
    assistant = sdk.assistants.create(
        "yandexgpt", 
        instruction = "Ты — помощник по внутренней документации компании. Отвечай вежливо. Если информация не содержится в документах ниже, не придумывай ответ.", 
        tools=[tool])
    thread = sdk.threads.create()

    input_text = input(
        'Введите ваш вопрос ассистенту ("exit" - чтобы завершить диалог): '
    )

    while input_text.lower() != "exit":
        thread.write(input_text)

        # Отдаем модели все содержимое треда.
        run = assistant.run(thread)

        # Чтобы получить результат, нужно дождаться окончания запуска.
        result = run.wait()

        # Выводим на экран ответ.
        print("Ответ: ", result.text)

        # Выводим на экран часть атрибутов свойства citations — информацию
        # об использованных фрагментах, созданных из файлов-источников.
        # Чтобы вывести на экран все содержимое свойства citations,
        # выполните: print(result.citations)
        count = 1
        for citation in result.citations:
            for source in citation.sources:
                if source.type != "filechunk":
                    continue
                print(
                    f"* Содержимое фрагмента №{count}: {source.parts}"
                )
                print(
                    f"* Идентификатор поискового индекса в фрагменте №{count}: {source.search_index.id}"
                )
                print(
                    f"* Настройки типа поискового индекса в фрагменте №{count}: {source.search_index.index_type}"
                )
                print(
                    f"* Идентификатор файла-источника для фрагмента №{count}: {source.file.id}"
                )
                print(
                    f"* MIME-тип файла-источника для фрагмента №{count}: {source.file.mime_type}"
                )
                print()

            count += 1

        input_text = input(
            'Введите ваш вопрос ассистенту ("exit" - чтобы завершить диалог): '
        )

    # Удаляем все ненужное.
    search_index.delete()
    thread.delete()
    assistant.delete()

    for file in files:
        file.delete()


if __name__ == "__main__":
    main()
```