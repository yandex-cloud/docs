---
title: "How to send a chat-mode request in {{ yagpt-full-name }}"
description: "This guide will teach you how to use {{ yagpt-full-name }} in chat mode."
---

# Sending requests in chat mode

To generate text in [chat mode](../concepts/index.md#working-mode), deliver a list of messages that provide the context for the model, in the [completion](../api-ref/v1/TextGeneration/completion.md) method.

## Getting started {#before-begin}

{% include notitle [ai-before-beginning](../../_includes/yandexgpt/ai-before-beginning.md) %}

## Send a request to the model {#request}

1. Create a file with the request body (for example, `body.json`).

   ```json
   {
     "modelUri": "gpt://<folder_ID>/yandexgpt-lite",
     "completionOptions": {
       "stream": false,
       "temperature": 0.6,
       "maxTokens": "5000"
     },
     "messages": [
       {
         "role": "system",
         "text": "You are a smart assistant"
       },
       {
         "role": "user", 
         "text": "Hello! How do I prepare for exams?"
       },
       {
         "role": "assistant", 
         "text": "Hello! Which subjects are you studying?"
       },
       {
         "role": "user", 
         "text": "Mathematics and physics"
       }
     ]
   }
   ```

   Where:

   {% include [api-parameters](../../_includes/yandexgpt/api-parameters.md) %}

1. To send the request to the model, run this command:

   ```bash
   export FOLDER_ID=<folder_ID>
   export IAM_TOKEN=<IAM_token>
   curl --request POST \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer ${IAM_TOKEN}" \
     -H "x-folder-id: ${FOLDER_ID}" \
     -d "@<path_to_json_file>" \
     "https://llm.{{ api-host }}/foundationModels/v1/completion"
   ```

   Where:

   * `FOLDER_ID`: ID of the folder for which your account has the `{{ roles-yagpt-user }}` role or higher.
   * `IAM_TOKEN`: IAM token received [before starting](#before-begin).

   The service will respond with the generated text:

   ```json
   {
     "result": {
       "alternatives": [
         {
           "message": {
             "role": "assistant",
             "text": "1. Make a study plan. Determine how much time you can dedicate to studying every day, and allocate it between mathematics and physics.\n\n
             2. Study the subjects one by one. Begin with mathematics, then move on to physics, and review them in the same order. This way, you will not forget what you have already learned.\n\n
             3. Use textbooks and study guides. They will assist you in understanding complex topics and grasping the fundamental principles.\n\n
             4. Solve problems and do exercises. This will help solidify your knowledge and teach you how to apply it in practice.\n\n
             5. Do not forget to take breaks. Constant studying can be exhausting, so take breaks every 30 or 40 minutes and engage in physical exercise or yoga.\n\n
             6. Do not be afraid to make mistakes. Mistakes are okay. They show you where you have gaps in your knowledge and help fill them.\n\n
             7. Check your knowledge regularly. This will help assess your progress and identify which topics require additional attention.\n\n
             8. Do not overwhelm yourself. If you are tired or not in the studying mood, do not push yourself too much. Better take a break and return to your studies rejuvenated.\n\n
             9. Do not forget about a healthy lifestyle. Proper nutrition, sleep, and physical activity will help you absorb information better and be more attentive during exams.\n\n
             10. Finally, and most importantly, stay calm. Worrying may interfere with your ability to concentrate and understand the subject. Remember, exams are just a test of your knowledge and skills, not the end of the world. Good luck with your exams!"
           },
           "status": "ALTERNATIVE_STATUS_FINAL"
         }
       ],
       "usage": {
         "inputTextTokens": "44",
         "completionTokens": "323",
         "totalTokens": "367"
       },
       "modelVersion": "06.12.2023"
     }
   }
   ```
