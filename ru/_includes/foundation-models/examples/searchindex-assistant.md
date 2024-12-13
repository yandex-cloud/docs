```python
#!/usr/bin/env python3

from __future__ import annotations
import pathlib
from yandex_cloud_ml_sdk import YCloudML
from yandex_cloud_ml_sdk.search_indexes import StaticIndexChunkingStrategy, TextSearchIndexType
from os import walk

mypath = "<путь_к_файлам_с_примерами>"
files_list = []

for (dirpath, dirnames, filenames) in walk(mypath):
    for i in enumerate(filenames):
        filenames[i[0]] = mypath + filenames[i[0]]
    files_list.extend(filenames)
    break

def local_path(path: str) -> pathlib.Path:
    return pathlib.Path(__file__).parent / path

def main() -> None:
    sdk = YCloudML(folder_id="<идентификатор_каталога>", auth="<API-ключ>")

    # Загрузим файлы с примерами
    # Файлы будут храниться 5 дней
    files = []
    for path in (files_list):
        file = sdk.files.upload(
            local_path(path),
            ttl_days=5,
            expiration_policy="static",
        )
        files.append(file)

    # Создадим индекс для полнотекстового поиска по загруженным файлам
    # Максимальный размер фрагмента — 700 токенов с перекрытием 300 токенов
    operation = sdk.search_indexes.create_deferred(
        files,
        index_type=TextSearchIndexType(
            chunking_strategy=StaticIndexChunkingStrategy(
                max_chunk_size_tokens=700,
                chunk_overlap_tokens=300,
            )
        )
    )

    # Дождемся создания поискового индекса
    search_index = operation.wait()

    # Создадим инструмент для работы с поисковым индексом. Или даже с несколькими индексами, если бы их было больше.
    tool = sdk.tools.search_index(search_index)
    
    # Создадим ассистента для модели {{ gpt-pro }} Latest
    # Он будет использовать инструмент поискового индекса
    assistant = sdk.assistants.create('yandexgpt', tools=[tool])
    thread = sdk.threads.create()

    input_text = ""

    while input_text != "exit":
        print("Введите ваш вопрос ассистенту:")
        input_text = input()
        if input_text != "exit":
            thread.write(input_text)

            # Отдаем модели все содержимое треда
            run = assistant.run(thread)
    
            # Чтобы получить результат, нужно дождаться окончания запуска   
            result = run.wait()
    
            # Выводим на экран ответ
            print('Answer:', result.text)

    # Можно посмотреть, что хранится в треде

    print('Вывод всей истории сообщений при выходе из чата:')

    for message in thread:
        print(f"    {message=}")
        print(f"    {message.text=}\n")

    # Удаляем все ненужное
    search_index.delete()
    thread.delete()
    assistant.delete()

    for file in files:
        file.delete()

if __name__ == '__main__':
    main()
```