```python
#!/usr/bin/env python3
from __future__ import annotations

from yandex_cloud_ml_sdk import YCloudML


def main() -> None:
    sdk = YCloudML(folder_id="<folder_ID>", auth="<API_key>")

    # Create a thread to store the conversation
    # The thread will be stored for five days
    thread = sdk.threads.create(name="SimpleAssistant", ttl_days=5, expiration_policy="static")
    print(f"new {thread=}")

    # Specify YandexGPT Pro RC and set its maximum context length
    model = sdk.models.completions(
        "yandexgpt", 
        version="rc",
        max_tokens=500
    )

    # Create an assistant for the model
    # The assistant will be deleted four days after its last activity
    assistant = sdk.assistants.create(
        model,
        ttl_days=4,
        expiration_policy="since_last_active",
    )

    # Here, provide your code for reading user messages
    # For now, let's simply write some data to the thread
    thread.write("Imagine some user messages here")
    
    # You can print all the messages stored in the thread
    for message in thread:
        print(f"    {message=}")
        print(f"    {message.text=}\n")

    # You can feed the the entire thread contents to the model
    run = assistant.run(thread)
    print(f"{run=}")
    
    # To get the result, wait until the run is complete   
    result = run.wait()
    
    # You can print all the result fields
    print(f"run {result=}")
    
    # The `text` field stores a string convenient for later use
    print(result.text)
    
    thread.write(“New user message")
    # Create a new run based on the previous user messages model response
    run = assistant.run(thread)
    result = run.wait()
    print(result.text)
    
    # Delete everything you no longer need
    thread.delete()
    assistant.delete()


if __name__ == "__main__":
    main()
```

Where:

* `<folder_ID>`: ID of the folder in which the service account was created.
* `<API_key>`: Service account API key you got earlier.