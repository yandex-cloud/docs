```python
#!/usr/bin/env python3

from __future__ import annotations
from yandex_cloud_ml_sdk import YCloudML


def main():
    sdk = YCloudML(
        folder_id="<folder_ID>",
        auth="<API_key>",
    )

    # Creating a thread to store the conversation
    # The thread will be stored for five days
    thread = sdk.threads.create(
        name="SimpleAssistant", ttl_days=5, expiration_policy="static"
    )
    print(f"new {thread=}")

    # Specifying {{ gpt-pro }} RC for model and setting its maximum context length
    model = sdk.models.completions("yandexgpt", model_version="rc")

    # Creating an assistant for the model
    # The assistant will be deleted four days after its last activity
    assistant = sdk.assistants.create(
        model, ttl_days=4, expiration_policy="since_last_active", max_tokens=500
    )

    # Here you should make provision for reading user messages
    # For now, let's just write something to the thread

    input_text = ""

    while input_text != "exit":
        input_text = input("Enter your question to the assistant: ")
        if input_text != "exit":
            thread.write(input_text)

            # This way you can give the whole thread contents to the model
            run = assistant.run(thread)
            print(f"{run=}")

            # To get the result, wait until the run is complete
            result = run.wait()

            # You can view all the result fields
            print(f"run {result=}")

            # The `text` field stores a string which is convenient for later use
            print("Answer:", result.text)

    # You can view all the messages stored in the thread

    print("Outputting the whole message history when exiting the chat:")

    for message in thread:
        print(f"    {message=}")
        print(f"    {message.text=}\n")

    # Deleting everything you no longer need
    thread.delete()
    assistant.delete()


if __name__ == "__main__":
    main()
```