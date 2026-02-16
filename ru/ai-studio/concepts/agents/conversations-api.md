# Управление контекстом текстового диалога

При работе с Responses API для управления контекстом вы можете [соединять ответы](../../operations/agents/manage-context.md#previous-response) друг с другом, [передавать историю сообщений](../../operations/agents/manage-context.md#manual) в каждом запросе или [использовать _Conversations API_](../../operations/agents/manage-context.md#conversations-api), чтобы хранить диалог как долгоживущий объект со стабильным идентификатором.

Conversations API воссоздает состояние диалога с помощью сохраненных элементов:

* сообщения пользователя и ассистента;
* вызовы инструментов (`tool calls`);
* другие служебные сообщения.

Редактирование элементов и обнуление диалога в настоящий момент не поддерживаются. Чтобы перезагрузить диалог, создайте новый объект `conversation`.

## Пример {#example}

В многошаговом диалоге объект `conversation` передается в следующие запросы, чтобы сохранять состояние и разделять контекст между ответами:

```py
import openai

YANDEX_CLOUD_FOLDER = "<идентификатор_каталога>"
YANDEX_CLOUD_API_KEY = "<API-ключ>"
YANDEX_CLOUD_MODEL = "yandexgpt"

client = openai.OpenAI(
    api_key=YANDEX_CLOUD_API_KEY,
    base_url="https://ai.api.cloud.yandex.net/v1",
    project=YANDEX_CLOUD_FOLDER
)

# Создаем conversation
conv = client.conversations.create()

# Первое сообщение с системной инструкцией и пользовательским вводом
r1 = client.responses.create(
    model=f"gpt://{YANDEX_CLOUD_FOLDER}/{YANDEX_CLOUD_MODEL}",
    conversation=conv.id,
    input=[
        {"role": "system", "content": "Ты мой ассистент"},
        {"role": "user", "content": "Привет! Запомни: меня зовут Настя."}
    ]
)
print("assistant:", r1.output_text)

# Продолжаем в том же conversation
r2 = client.responses.create(
    model=f"gpt://{YANDEX_CLOUD_FOLDER}/{YANDEX_CLOUD_MODEL}",
    conversation=conv.id,
    input="Как меня зовут?"
)
print("assistant:", r2.output_text)
```