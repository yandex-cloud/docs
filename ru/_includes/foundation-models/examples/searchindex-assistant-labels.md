```python
import pathlib
from yandex_cloud_ml_sdk import YCloudML
from yandex_cloud_ml_sdk.search_indexes import (
    VectorSearchIndexType,
)

# Локальный путь, по которому расположены файлы-источники.
mypath = "<путь_к_файлам_с_примерами>"

# Переменная file_labels содержит метаданные,
# которые будут присвоены файлам-источникам.
file_labels = [
    {"bali": "Файл с описанием туров на Бали"},
    {"kazakhstan": "Файл с описанием предложения по Казахстану"},
]

# Переменная index_label содержит метаданные,
# которые будут присвоены поисковому индексу.
index_label = {
    "promo": "Индекс содержит общую информацию о Бали и Казахстане",
    "visas": "Индекс содержит информацию о визовой политике при въезде на Бали и в Казахстан",
}

def main():
    sdk = YCloudML(
        folder_id="<идентификатор_каталога>",
        auth="<API-ключ>",
    )

    # Загрузим файлы-источники и присвоим им метаданные из переменной file_labels.
    # Файлы будут храниться 5 дней.
    paths = pathlib.Path(mypath).iterdir()
    files = []
    file_count = 0
    for path in paths:
        file = sdk.files.upload(
            path,
            ttl_days=5,
            expiration_policy="static",
            name=str(path),
            labels=file_labels[file_count]
        )
        files.append(file)
        file_count += 1

    # Создадим индекс для векторного поиска, присвоим индексу метаданные.
    operation = sdk.search_indexes.create_deferred(
        files,
        index_type=VectorSearchIndexType(),
        name="the-bali-and-kazakhstan-index",
        labels=index_label,
    )

    # Дождемся создания поискового индекса.
    search_index = operation.wait()

    # Создадим инструмент для работы с поисковым индексом.
    # Или даже с несколькими индексами, если бы их было больше.
    tool = sdk.tools.search_index(search_index)

    # Создадим ассистента для модели {{ gpt-pro }} Latest.
    # Он будет использовать инструмент поискового индекса.
    assistant = sdk.assistants.create("yandexgpt", tools=[tool])
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

        # Выводим ответ на экран.
        print(f"Answer: {result.text}")

        input_text = input(
            'Введите ваш вопрос ассистенту ("exit" - чтобы завершить диалог): '
        )

    # Выводим на экран часть атрибутов свойства citations — информацию
    # об использованных файлах-источниках, их содержимое и присвоенные
    # метаданные, а также информацию об индексе и его метаданные.
    # С помощью присвоенных метаданных (labels) вы можете применять
    # к полученным значениям дополнительные фильтры.
    print("Citations:")
    for citation in result.citations:
        for source in citation.sources:
            print(f"    {source.text=}")
            print(f"    {source.file.name=}")
            print(f"        {source.file.labels=}")
            print(f"    {source.search_index.name=}")
            print(f"        {source.search_index.labels=}")

    # Удаляем все ненужное.
    search_index.delete()
    thread.delete()
    assistant.delete()

    for file in files:
        file.delete()


if __name__ == "__main__":
    main()
```