```python
#!/usr/bin/env python3

from __future__ import annotations

import pathlib

from yandex_cloud_ml_sdk import YCloudML

LABEL_KEY = 'yc-ml-sdk-example'
PATH = pathlib.Path(__file__)
NAME = f'example-{PATH.parent.name}-{PATH.name}'


def local_path(path: str) -> pathlib.Path:
   return pathlib.Path(__file__).parent / path


def get_search_index(sdk):
     # Функция для получения или создания объекта search_index

     for search_index in sdk.search_indexes.list():
         if search_index.labels and search_index.labels.get(LABEL_KEY) == NAME:
             print(f'using {search_index=}')
             break
     else:
         print('no search indexes found, creating new one')
         file = sdk.files.upload(
             local_path('turkey_example.txt')
         )
         operation = sdk.search_indexes.create_deferred(file, labels={LABEL_KEY: NAME})
         search_index = operation.wait()
         print(f'new {search_index=}')

         file.delete()

     return search_index


def delete_labeled_entities(iterator):
    # Функция очистки. Удаляет все объекты итератора с атрибутом .labels

    for entity in iterator:
       if entity.labels and entity.labels.get(LABEL_KEY) == NAME:
           print(f'deleting {entity.__class__.__name__} with id={entity.id!r}')
           entity.delete()

def main() -> None:
    sdk = YCloudML(
       folder_id="<идентификатор_каталога>",
       auth="<API-ключ>",
    )
    sdk.setup_default_logging(log_level='WARNING')

    search_index = get_search_index(sdk)
    labels = {LABEL_KEY: NAME}

    # Инструмент с поисковым индексом
    tool = sdk.tools.search_index(search_index)

    # Инструмент перефразирования
    rephraser = sdk.tools.rephraser('rephraser', model_version='latest')
    tool_with_rephraser = sdk.tools.search_index(search_index, rephraser=rephraser)

    # Создаем два ассистента — с перефразированием и без него
    assistant_wo_rephraser = sdk.assistants.create('yandexgpt', labels=labels, tools=[tool])
    assistant_with_rephraser = sdk.assistants.create('yandexgpt', labels=labels, tools=[tool_with_rephraser])

    # Следующий код отправляет запросы с перефразированием и без него,
    # чтобы показать эффект перефразирования.
    # Вы можете использовать другие запросы.
    thread = sdk.threads.create(labels=labels)

    def run(query, rephrase: bool) -> None:
       assistant = assistant_with_rephraser if rephrase else assistant_wo_rephraser

       thread.write(query)
       run = assistant.run(thread)
       result = run.wait()

       print(f"Question: {query}")
       preposition = 'with' if rephrase else 'without'
       print(f"Answer {preposition} rephraser:\n    {result.text!r}")
       print()

    # Возьмем два корректных и два некорректных запроса:
    run('Куда yбежать?', rephrase=False)  # 1
    run('Гиде атттапыриццца?', rephrase=False)  # 2
    run('Где отдохнуть?', rephrase=False)  # 3
    run('Куда сбежать?', rephrase=False)  # 4

    # Первый и второй запросы нуждаются в перефразировании:
    run('Куда убежать?', rephrase=True)
    run('Гиде атттапыриццца?', rephrase=True)

    # Удалим все запросы и потоки,
    # но оставим поисковый индекс, потому что его создание — медленная операция.
    # Созданный поисковый индекс может быть использован повторно.
    delete_labeled_entities(sdk.assistants.list())
    delete_labeled_entities(sdk.threads.list())


if __name__ == '__main__':
   main()
```