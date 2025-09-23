```python
#!/usr/bin/env python3

from __future__ import annotations
from yandex_cloud_ml_sdk import YCloudML


def main():
    sdk = YCloudML(
        folder_id="<идентификатор_каталога>",
        auth="<API-ключ>",
    )

    # Создаем тред, в котором будем хранить переписку
    # Тред будет храниться в течение 5 дней
    thread = sdk.threads.create(
        name="SimpleAssistant", ttl_days=5, expiration_policy="static"
    )
    print(f"new {thread=}")

    # Определяем модель {{ gpt-pro }} RC и ее максимальный контекст
    model = sdk.models.completions("yandexgpt", model_version="rc")

    # Создаем ассистента для модели
    # Ассистент будет удален через 4 дня, если к нему не будут обращаться
    assistant = sdk.assistants.create(
        model, ttl_days=4, expiration_policy="since_last_active", max_tokens=500
    )

    # Здесь нужно предусмотреть чтение сообщений пользователей
    # Пока же мы просто запишем что-нибудь в тред

    input_text = ""

    while input_text != "exit":
        input_text = input("Введите ваш вопрос ассистенту: ")
        if input_text != "exit":
            thread.write(input_text)

            # Так можно отдать модели все содержимое треда
            run = assistant.run(thread)
            print(f"{run=}")

            # Чтобы получить результат, нужно дождаться окончания запуска
            result = run.wait()

            # Можно посмотреть все поля результата
            print(f"run {result=}")

            # В поле text сохраняется удобная для дальнейшей работы строка
            print("Answer:", result.text)

    # Можно посмотреть, что хранится в треде

    print("Вывод всей истории сообщений при выходе из чата:")

    for message in thread:
        print(f"    {message=}")
        print(f"    {message.text=}\n")

    # Удаляем все ненужное
    thread.delete()
    assistant.delete()


if __name__ == "__main__":
    main()
```