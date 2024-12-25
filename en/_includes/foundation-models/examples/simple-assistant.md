```python
#!/usr/bin/env python3

from __future__ import annotations
from yandex_cloud_ml_sdk import YCloudML

def main() -> None:
    sdk = YCloudML(folder_id="<folder_ID>", auth="<API_key>")

    # Creating a thread to store the conversation
    # The thread will be stored for five days
    thread = sdk.threads.create(name="SimpleAssistant", ttl_days=5, expiration_policy="static")
    print(f"new {thread=}")

    # Specifying {{ gpt-pro }} RC for model and setting its maximum context length
    model = sdk.models.completions(
        "yandexgpt", 
        model_version="rc"
    )

    # Creating an assistant for the model
    # The assistant will be deleted four days after its last activity
    assistant = sdk.assistants.create(
        model,
        ttl_days=4,
        expiration_policy="since_last_active",
        max_tokens=500
    )

    # In this block, provide your code for reading user messages
    # For now, let's just write some data to the thread

    input_text = ""

    while input_text != "exit":
        print("Enter your question to the assistant:")
        input_text = input()
        if input_text != "exit":
            thread.write(input_text)

            # This is how you run the model over the whole thread contents
            run = assistant.run(thread)
            print(f"{run=}")
    
            # To get the result, wait until the run is complete   
            result = run.wait()
    
            # This is how you print all the result fields
            print(f"run {result=}")
    
            # The `text` field stores a string which is convenient for later use
            print('Answer:', result.text)

    # This is how you print all the messages stored in the thread

    print('Outputting the whole message history when exiting the chat:')

    for message in thread:
        print(f"    {message=}")
        print(f"    {message.text=}\n")

    # Deleting everything you no longer need
    thread.delete()
    assistant.delete()

if __name__ == "__main__":
    main()
```