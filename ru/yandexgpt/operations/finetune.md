---
title: "Как отправлять запросы к дообученным моделям в {{ yagpt-full-name }}"
description: "Следуя данной инструкции, вы научитесь отправлять запросы к дообученным моделям."
---

# Отправить запрос к дообученной модели

В {{ yagpt-name }} можно отправлять запросы к дообученным моделям. Поддерживаются запросы к следующим моделям:

* модель {{ yagpt-name }}, дообученная для краткого пересказа содержимого текста — суммаризации;
* [дообученные фундаментальные модели](../../datasphere/concepts/models/tuned-models.md) в сервисе {{ ml-platform-full-name }}.

## Перед началом работы {#before-begin}

{% include notitle [ai-before-beginning](../../_includes/foundation-models/yandexgpt/ai-before-beginning.md) %}

## Отправить запрос для краткого пересказа текста {#text-summarization}

1. Создайте файл с телом запроса (например, `body.json`):

   ```json
   {
     "modelUri": "gpt://<идентификатор_каталога>/summarization",
     "completionOptions": {
       "stream": false,
       "temperature": 0.1,
       "maxTokens": "2000"
     },
     "messages": [
       {
         "role": "user",
         "text": "<текст_статьи>"
       }
     ]
   }
   ```

   {% include [api-parameters](../../_includes/foundation-models/yandexgpt/api-parameters.md) %}

1. Отправьте запрос к модели, выполнив команду:

   ```bash
   export FOLDER_ID=<идентификатор_каталога>
   export IAM_TOKEN=<IAM-токен>
   curl --request POST \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer ${IAM_TOKEN}" \
     -H "x-folder-id: ${FOLDER_ID}" \
     -d "@<путь_до_файла_json>" \
     "https://llm.{{ api-host }}/foundationModels/v1/completion"
   ```

   Где:

   * `FOLDER_ID`— идентификатор каталога, на который у вашего аккаунта есть роль `{{ roles-yagpt-user }}` или выше.
   * `IAM_TOKEN` — IAM-токен, полученный [перед началом работы](#before-begin).

   Пример результата для статьи [Протокол SSH](../../glossary/ssh-keygen.md):

   ```json
   {
     "result": {
       "alternatives": [
         {
           "message": {
             "role": "assistant",
             "text": "- SSH - сетевой протокол для безопасного взаимодействия между компьютерами.\n
             - SSH используется для подключения к удаленным серверам, выполнения команд, копирования и редактирования файлов.\n
             - SSH широко применяется в корпоративной инфраструктуре для установки обновлений и управления бизнес-критичными системами.\n
             - Поддержка SSH встроена в операционные системы Unix и Linux, а также в Windows с бесплатными SSH-клиентами.\n
             - В работе по SSH участвуют SSH-сервер и SSH-клиент, которые создают безопасное соединение для передачи зашифрованных данных.\n
             - Надежность SSH обеспечивается аутентификацией пользователей и обработкой передаваемых данных.\n
             - SSH-сервер поддерживает три способа аутентификации: по IP-адресу, по логину/паролю и по ключу.\n
             - Ключи SSH обеспечивают высокую степень защиты и удобство использования в скриптах для автоматизации рутиных операций."
           },
           "status": "ALTERNATIVE_STATUS_FINAL"
         }
       ],
       "usage": {
         "inputTextTokens": "1609",
         "completionTokens": "168",
         "totalTokens": "1777"
       },
       "modelVersion": "06.12.2023"
     }
   }
   ```

