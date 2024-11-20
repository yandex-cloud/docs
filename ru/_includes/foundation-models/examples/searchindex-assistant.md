```python
#!/usr/bin/env python3

from __future__ import annotations

import pathlib
from yandex_cloud_ml_sdk import YCloudML


def local_path(path: str) -> pathlib.Path:
    return pathlib.Path(__file__).parent / path


def main() -> None:
    sdk = YCloudML(folder_id='b1ghsjum2v37c2un8h64')

    # Загрузим файлы с примерами
    # Файлы будут храниться 5 дней
    files = []
    for path in ['bali.md', 'kazakhstan.md']:
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

    tool = sdk.tools.search_index(search_index)
    
    # Создадим ассистента с поисковым индексом для модели {{ gpt-pro }} Latest
    assistant = sdk.assistants.create('yandexgpt', tools=[tool])
    thread = sdk.threads.create()

    thread.write("Сколько стоит виза на Бали?")
    run = assistant.run(thread)
    result = run.wait()
    print('Answer:', result.text)

    # Удаляем все ненужное
    search_index.delete()
    thread.delete()
    assistant.delete()

    for file in files:
        file.delete()


if __name__ == '__main__':
    main()
```

Где:

* `<идентификатор_каталога>` — идентификатор каталога, в котором создан сервисный аккаунт.
* `<API-ключ>` — API-ключ сервисного аккаунта, полученный ранее.