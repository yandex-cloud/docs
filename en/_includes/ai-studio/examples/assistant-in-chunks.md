```python
#!/usr/bin/env python3

from __future__ import annotations

from yandex_cloud_ml_sdk import YCloudML


def main() -> None:
    sdk = YCloudML(
        folder_id="<folder_ID>",
        auth="<API_key>",
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

    # Basic cycle of user interaction with the assistant
    input_text = input('Ask a question to the assistant (or "exit" to exit): ')
    while input_text.lower() != "exit":

        thread.write(input_text)

        # This way you can give the whole thread contents to the model
        run = assistant.run_stream(thread)

        # This way you can see the intermediate results as the model generates a response
        for event in run:
            print(event._message.parts)

        # This way you can see all fields of the final result
        print(f"run {event=}")

        input_text = input('Ask the assistant your question (or "exit" to exit): ')

    # Displaying the entire history of messages in the chat room
    print("Outputting the whole message history when exiting the chat:")
    for message in thread:
        print(f"    {message=}")
        print(f"    {message.text=}\n")

    # Deleting everything you do not need anymore
    for assistant in sdk.assistants.list():
        assistant.delete()

    thread.delete()


if __name__ == "__main__":
    main()
```