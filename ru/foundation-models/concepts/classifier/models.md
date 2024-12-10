# Модели классификаторов на базе {{ yagpt-name }}

Обращение к модели классификатора на базе {{ yagpt-name }} по API возможно по ее [URI](https://ru.wikipedia.org/wiki/URI), содержащему [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md). Сегмент `/latest` указывает версию модели и является необязательным. Чтобы обратиться к модели классификатора на базе {{ yagpt-name }}, используйте метод [fewShotClassify](../../text-classification/api-ref/TextClassification/fewShotClassify.md) Text Classification API.

Если стандартной модели вам недостаточно, вы можете [дообучить](../tuning/classifier.md) классификатор на базе {{ gpt-pro }} , чтобы модель точнее классифицировала на ваши запросы. Чтобы обратиться к дообученной модели классификатора, используйте метод [classify](../../text-classification/api-ref/TextClassification/classify.md) Text Classification API.

| Модель | URI | Режим работы |
|---|---|---|
| Классификатор по промту на базе {{ gpt-lite }} | `cls://<идентификатор_каталога>/yandexgpt-lite/latest` | Синхронный |
| Классификатор по промту на базе {{ gpt-pro }} | `cls://<идентификатор_каталога>/yandexgpt/latest` | Синхронный |
| Дообученная модель классификатора | `cls://<идентификатор_каталога>/<идентификатор_дообученной_модели>` | Синхронный |