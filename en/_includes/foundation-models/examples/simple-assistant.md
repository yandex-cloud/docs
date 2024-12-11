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

    # Specifying YandexGPT Pro RC for model; setting up its maximum context length
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
    thread.write("Imagine some user messages here")
    
    # This is how you print all the messages stored in the thread
    for message in thread:
        print(f"    {message=}")
        print(f"    {message.text=}\n")

    # This is how you run the model over the whole thread contents
    run = assistant.run(thread)
    print(f"{run=}")
    
    # To get the result, wait until the run is complete
    result = run.wait()
    
    # This is how you print all the result fields
    print(f"run {result=}")
    
    # The `text` field stores a string, convenient for later use
    print(result.text)
    
    thread.write("A new message from the user")
    # Creating a new run based on the earlier messages from the user and previous response from the model
    run = assistant.run(thread)
    result = run.wait()
    print(result.text)
    
    # Deleting what is no longer needed
    thread.delete()
    assistant.delete()


if __name__ == "__main__":
    main()
```

Where:

* `<folder_ID>`: ID of the folder in which the service account was created.
* `<API_key>`: Service account API key you got earlier.
