---
title: Выполнить задачу с помощью {{ code-interpreter }}
description: Следуя этой инструкции, вы сможете выполнить задачу с помощью {{ code-interpreter }} в {{ ai-studio-full-name }}.
---

# Выполнить задачу с помощью {{ code-interpreter }}

{% include [note-preview](../../../_includes/note-preview.md) %}

В {{ ai-studio-full-name }} с помощью инструмента исполнения кода [{{ code-interpreter }}](../../concepts/agents/tools/code-interpreter.md) вы сможете расширить возможности модели, чтобы она писала и выполняла Python-код в изолированной тестовой среде. Инструмент полезен для задач, в которых модель должна считать, проверять и преобразовывать данные, а не ограничиваться текстовыми рассуждениями.

{% include [models-for-code-interpreter](../../../_includes/ai-studio/agents/models-for-code-interpreter.md) %}

## Перед началом работы {#before-begin}

Чтобы воспользоваться примером:

{% list tabs group=programming_language %}

- Python {#python}

  1. [Создайте](../../../iam/operations/sa/create.md) сервисный аккаунт и [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) ему [роли](../../security/index.md#service-roles) `ai.assistants.editor` и `ai.languageModels.user`.
  1. [Получите](../get-api-key.md#run-client) и сохраните [API-ключ](../../../iam/concepts/authorization/api-key.md) сервисного аккаунта, указав для него [область действия](../../../iam/concepts/authorization/api-key.md#scoped-api-keys) `yc.ai.foundationModels.execute`.

      {% include [sdk-windows-wsl-notice](../../../_includes/ai-studio/sdk-windows-wsl-notice.md) %}

  1. {% include [sdk-before-begin-step3](../../../_includes/ai-studio/sdk-before-begin-step3.md) %}
  1. {% include [sdk-before-begin-step4](../../../_includes/ai-studio/sdk-before-begin-step4.md) %}
  1. {% include [sdk-before-begin-step5](../../../_includes/ai-studio/sdk-before-begin-step5.md) %}
  1. Установите [библиотеку](https://github.com/openai/openai-python) OpenAI для Python:

      ```bash
      pip install openai
      ```

{% endlist %}

## Создайте агента {#create-agent}

{% list tabs group=programming_language %}

- Python {#python}

  1. Создайте файл `Presentation.py` и добавьте в него код:

     ```python
     import openai
     import json
     import os     

     YC_MODEL = "qwen3-235b-a22b-fp8"

     client = openai.OpenAI(
         api_key=YC_API_KEY,
         base_url="https://ai.api.cloud.yandex.net/v1",
         project=YC_FOLDER_ID
     )

     instruction = """
     Ты программист на питоне и умеешь писать и выполнять код для решения поставленной задачи
     Проверь сначала наличие нужных тебе библиотек и если их нет – установи их
     """

     prompt = """
     Сделай мне подробную презентацию в формате pptx про производные – что это такое, как их считать, добавь инфографики.
     Слайдов должно быть не менее 5
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

     print("Начало обработки запроса...\n")

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
             print(f"\n\nИтоговый код:\n{event.code}\n")
         elif event.type == "response.code_interpreter_call.in_progress":
             print("\n[Выполняем код...]\n")
         elif event.type == "response.code_interpreter_call.done":
             print("\n[Код выполнен]\n")
         elif event.type == "response.in_progress":
             resp_id = event.response.id
             print(f"\n[Обрабатываем респонс {resp_id}]\n")

     print(f"\n\nЗадача решена: {resp_id}\n")
     print("=" * 50 + "\n")

     # Получение полного ответа
     response = client.responses.retrieve(resp_id)

     # Обработка результатов и скачивание файлов
     print("Обработка результатов выполнения:")
     os.makedirs("./downloaded_files", exist_ok=True)

     downloaded_count = 0
     for item in response.output:
         # Вывод результатов выполнения кода
         if item.type == "code_interpreter_call":
             print("\nКод:\n")
             print(item.code, '\n')
             for output_item in item.outputs:
                 output_type = output_item.type
                 logs = output_item.logs.strip()
                 if logs:
                     print(f"[{output_type.upper()}] Вывод:")
                     for log_line in logs.split('\n'):
                         print(f"        {log_line}")

         # Скачивание файлов из контейнера
         elif item.type == "message":
             for content in item.content:
                 # Проверяем наличие аннотаций с файлами
                 if hasattr(content, 'annotations') and content.annotations:
                     for annotation in content.annotations:
                         if annotation.type == "container_file_citation":
                             file_id = annotation.file_id
                             file_name = annotation.filename

                             print(f"\n📎 Найден файл: {file_name} (ID: {file_id})")

                             try:
                                 # Скачиваем файл
                                 file_content = client.files.content(file_id)
                                 
                                 # Сохраняем локально
                                 local_path = os.path.join("./downloaded_files", file_name)
                                 with open(local_path, 'wb') as f:
                                     f.write(file_content.read())
                                 
                                 print(f"✅ Файл сохранен: {local_path}")
                                 downloaded_count += 1
                             except Exception as e:
                                 print(f"❌ Ошибка при скачивании файла {file_name}: {e}")

     if downloaded_count > 0:
         print(f"\n✅ Всего скачано файлов: {downloaded_count}")
     else:
         print("\nℹ️  Файлы для скачивания не найдены.")

     print("\n" + "=" * 50 + "\n")

     # Полный ответ
     print("Полный ответ (JSON):")
     print(json.dumps(response.model_dump(), indent=2, ensure_ascii=False))
     ```

  1. Сохраните данные для аутентификации в переменные окружения:

      ```bash
      export YC_FOLDER_ID=<идентификатор_каталога>
      export YC_API_KEY=<API-ключ>
      ```

  1. Выполните созданный файл:

     ```bash
     python presentation.py
     ```

    Рядом с выполненным файлом будет создана папка `downloaded_files` с результатами работы модели: файл презентации в формате PPTX и графики. Отчет о проделанной работе будет выведен в консоль.

    {% cut "Фрагмент ответа" %}

    ```text
    Я успешно создал для вас подробную презентацию о производных в формате PowerPoint (PPTX). Презентация содержит **6 слайдов**, включая титульный, теоретические объяснения, правила дифференцирования, примеры, графическую интерпретацию с инфографикой и применение производных в реальной жизни.

    ### Содержание презентации:
    1. **Титульный слайд** — название и подзаголовок.
    2. **Что такое производная?** — определение, геометрический смысл, обозначения.
    3. **Правила дифференцирования** — основные формулы и законы.
    4. **Примеры вычисления** — пошаговые расчёты для разных функций.
    5. **Графическая интерпретация** — график функции \( y = x^2 \) и касательная в точке \( x = 1 \) (с визуализацией).
    6. **Применение производных** — физика, экономика, машинное обучение и другие области.

    ...

    📎 Найден файл: Proizvodnye_Presentation.pptx (ID: fvttk7sto2ne********)
    ✅ Файл сохранен: ./downloaded_files\Proizvodnye_Presentation.pptx
    
    📎 Найден файл: tangent_plot.png (ID: fvtt18umj1gn********)
    ✅ Файл сохранен: ./downloaded_files\tangent_plot.png
    
    ✅ Всего скачано файлов: 2
    ```

    {% endcut %}    

{% endlist %}