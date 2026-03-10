---
title: Completing a task with {{ code-interpreter }}
description: Follow this guide to complete a task using {{ code-interpreter }} in {{ ai-studio-full-name }}.
---

# Completing a task with {{ code-interpreter }}

{% include [note-preview](../../../_includes/note-preview.md) %}

In {{ ai-studio-full-name }}, you can use [{{ code-interpreter }}](../../concepts/agents/tools/code-interpreter.md) to enhance the model's abilities so it can write and execute Python code in a sandboxed environment. This tool will prove useful in tasks where the model calculates, validates, and transforms data instead of being limited to textual reasoning.

{% include [models-for-code-interpreter](../../../_includes/ai-studio/agents/models-for-code-interpreter.md) %}

## Getting started {#before-begin}

To use an example:

{% list tabs group=programming_language %}

- Python {#python}

  1. [Create](../../../iam/operations/sa/create.md) a service account and [assign](../../../iam/operations/sa/assign-role-for-sa.md) the `ai.assistants.editor` and `ai.languageModels.user` [roles](../../security/index.md#service-roles) to it.
  1. [Get](../get-api-key.md#run-client) and save the service account's [API key](../../../iam/concepts/authorization/api-key.md) with `yc.ai.foundationModels.execute` for its [scope](../../../iam/concepts/authorization/api-key.md#scoped-api-keys).

      {% include [sdk-windows-wsl-notice](../../../_includes/ai-studio/sdk-windows-wsl-notice.md) %}

  1. {% include [sdk-before-begin-step3](../../../_includes/ai-studio/sdk-before-begin-step3.md) %}
  1. {% include [sdk-before-begin-step4](../../../_includes/ai-studio/sdk-before-begin-step4.md) %}
  1. {% include [sdk-before-begin-step5](../../../_includes/ai-studio/sdk-before-begin-step5.md) %}
  1. Install the OpenAI [library](https://github.com/openai/openai-python) for Python:

      ```bash
      pip install openai
      ```

{% endlist %}

## Create an agent {#create-agent}

{% list tabs group=programming_language %}

- Python {#python}

  1. Create a file named `Presentation.py` and add the following code to it:

     ```python
     import openai
     import json
     import os     

     YC_MODEL = "qwen3-235b-a22b-fp8"
     YC_API_KEY = os.getenv('YC_API_KEY')
     YC_FOLDER_ID = os.getenv('YC_FOLDER_ID')

     client = openai.OpenAI(
         api_key=YC_API_KEY,
         base_url="https://ai.api.cloud.yandex.net/v1",
         project=YC_FOLDER_ID
     )

     instruction = """
     You are a Python programmer and can write and run code to solve the task you are given.
     First, check if you have the necessary libraries, and if not, install them.
     """

     prompt = """
     Give me a detailed pptx presentation on derivatives: what they are, how to calculate them. Add some infographics.
     There must be at least 5 slides in the presentation.
     """

     stream = client.responses.create(
         model=f"gpt://{YC_FOLDER_ID}/{YC_MODEL}",
         input=prompt,
         # instructions=instruction,
         tool_choice="auto",
         temperature=0.3,
         tools=[
             {
                 "type": "code_interpreter",
                 "container": {
                     "type": "auto",
                 }
             }
         ],
         stream=True
     )

     resp_id = None

     print("Request processing started...\n")

     for event in stream:
         if event.type == "response.output_text.delta":
             print(event.delta, end='')
         elif event.type == "response.code_interpreter_call_code.delta":
             print(event.delta, end='')
         elif event.type == "response.reasoning_text.delta":
             print(event.delta, end='')
         elif event.type == "response.reasoning_summary_text.delta":
             print(event.delta, end='')
         elif event.type == "response.code_interpreter_call_code.done":
             print(f"\n\nFinal code:\n{event.code}\n")
         elif event.type == "response.code_interpreter_call.in_progress":
             print("\n[Executing the code...]\n")
         elif event.type == "response.code_interpreter_call.done":
             print("\n[Code executed]\n")
         elif event.type == "response.in_progress":
             resp_id = event.response.id
             print(f"\n[Processing the {resp_id}] response\n")

     print(f"\n\nTask solved: {resp_id}\n")
     print("=" * 50 + "\n")

     # Getting a full response
     response = client.responses.retrieve(resp_id)

     # Processing results and downloading files
     print("Processing the execution results:")
     os.makedirs("./downloaded_files", exist_ok=True)

     downloaded_count = 0
     for item in response.output:
         # Outputting code execution results
         if item.type == "code_interpreter_call":
             print("\nCode:\n")
             print(item.code, '\n')
             for output_item in item.outputs:
                 output_type = output_item.type
                 logs = output_item.logs.strip()
                 if logs:
                     print(f"[{output_type.upper()}] Output:")
                     for log_line in logs.split('\n'):
                         print(f"        {log_line}")

         # Downloading files from a container
         elif item.type == "message":
             for content in item.content:
                 # Checking for annotations with files
                 if hasattr(content, 'annotations') and content.annotations:
                     for annotation in content.annotations:
                         if annotation.type == "container_file_citation":
                             file_id = annotation.file_id
                             file_name = annotation.filename

                             print(f"\n📎 File found: {file_name} (ID: {file_id})")

                             try:
                                 # Downloading file
                                 file_content = client.files.content(file_id)
                                 
                                 # Saving locally
                                 local_path = os.path.join("./downloaded_files", file_name)
                                 with open(local_path, 'wb') as f:
                                     f.write(file_content.read())
                                 
                                 print(f"✅ File saved: {local_path}")
                                 downloaded_count += 1
                             except Exception as e:
                                 print(f"❌ Error downloading {file_name}: {e}")

     if downloaded_count > 0:
         print(f"\n✅ Total files downloaded: {downloaded_count}")
     else:
         print("\nℹ️  No files found for download.")

     print("\n" + "=" * 50 + "\n")

     # Full response
     print("Full response (JSON):")
     print(json.dumps(response.model_dump(), indent=2, ensure_ascii=False))
     ```

  1. Save authentication data into environment variables:

      ```bash
      export YC_FOLDER_ID=<folder_ID>
      export YC_API_KEY=<API_key>
      ```

  1. Run the file you created:

     ```bash
     python presentation.py
     ```

    Next to the file, a folder named `downloaded_files` will be created containing the model's output: an PPTX presentation and graphs. A progress report will be sent to the console.

    {% cut "Response fragment" %}

    ```text
    I have successfully created a detailed PowerPoint (PPTX) presentation on derivatives for you. The presentation contains **6 slides**, including the title slide, theoretical explanations, differentiation rules, examples, a graphical interpretation with infographics, and info on real-life use of derivatives.

    ### Presentation contents:
    1. **Title slide**: Title and subtitle.
    2. **What is a derivative?**: Definition, geometrical meaning, notation.
    3. **Differentiation rules**: Basic formulas and laws.
    4. **Calculation examples**: Step-by-step calculations for various functions.
    5. **Graphical interpretation**: Graph of the \(y = x^2 \) function and tangent at the \(x = 1 \) point (with visualization).
    6. **Use of derivatives**: Physics, economics, machine learning, other fields.

    ...

    📎 File found: Proizvodnye_Presentation.pptx (ID: fvttk7sto2ne********)
    ✅ File saved: ./downloaded_files\Proizvodnye_Presentation.pptx
    
    📎 File found: tangent_plot.png (ID: fvtt18umj1gn********)
    ✅ File saved: ./downloaded_files\tangent_plot.png
    
    ✅ Total files downloaded: 2
    ```

    {% endcut %}    

{% endlist %}