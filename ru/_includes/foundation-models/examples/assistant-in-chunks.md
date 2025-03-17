```python
#!/usr/bin/env python3

from __future__ import annotations

from yandex_cloud_ml_sdk import YCloudML


def main() -> None:
    sdk = YCloudML(
        folder_id="<идентификатор_каталога>",
        auth="<API-ключ>",
    )
    sdk.setup_default_logging()

    assistant = sdk.assistants.create(
        "yandexgpt",
        temperature=0.5,
        max_prompt_tokens=50,
        ttl_days=6,
        expiration_policy="static",
    )

    thread = sdk.threads.create(
        name="foo",
        ttl_days=6,
        expiration_policy="static",
    )

    # Основной цикл взаимодействия пользователя с ассистентом
    input_text = input('Задайте вопрос ассистенту ("exit" — для выхода): ')
    while input_text.lower() != "exit":

        thread.write(input_text)

        # Так можно отдать модели все содержимое треда
        run = assistant.run_stream(thread)

        # Так можно посмотреть промежуточные результаты по мере генерации моделью ответа
        for event in run:
            print(event._message.parts)

        # Так можно посмотреть все поля окончательного результата
        print(f"run {event=}")

        input_text = input('Задайте ваш вопрос ассистенту ("exit" — для выхода): ')

    # Вывод на экран всей истории сообщений в чате
    print("Вывод всей истории сообщений при выходе из чата:")
    for message in thread:
        print(f"    {message=}")
        print(f"    {message.text=}\n")

    # Удаление всего ненужного
    for assistant in sdk.assistants.list():
        assistant.delete()

    thread.delete()


if __name__ == "__main__":
    main()
```