---
title: Как отправить запрос к инстансу в {{ foundation-models-name }}
description: Следуя данной инструкции, вы сможете отправить запрос к инстансу в {{ foundation-models-name }}.
---

# Отправить запрос к инстансу

Следуя данной инструкции, вы сможете отправить запрос к [инстансу](../../concepts/generation/dedicated-instance.md) в {{ foundation-models-name }}.

[Получить](get-instance.md) код запроса и идентификатор модели вы также можете в [консоли управления]({{ link-console-main }}).


## Перед началом работы {#before-begin}

Чтобы воспользоваться примером:

{% list tabs group=programming_language %}

- SDK {#sdk}

  {% include [sdk-before-begin-ai-langmodel-user](../../../_includes/ai-studio/sdk-before-begin-ai-langmodel-user.md) %}

{% endlist %}


## Отправьте запрос {#send-request}

{% list tabs group=programming_language %}

- SDK {#sdk}

  1. Создайте файл `test_ml.py` и добавьте в него следующий код:

      ```python
      from yandex_ai_studio_sdk import AIStudio

      sdk = AIStudio(
          folder_id="<идентификатор_каталога>", auth="<API-ключ_или_IAM-токен>"
      )

      model = sdk.chat.completions("<идентификатор_модели>", model_version="<идентификатор_версии>")
      model = model.configure(temperature=0.3)
      result = model.run(
          [
              {
                  "role": "system",
                  "text": "Ты умный ассистент"
              },
              {
                  "role": "user",
                  "text": "Привет! Какими науками занимался Альберт Эйнштейн?",
              },
          ]
      )

      for alternative in result:
          print(result[0].text)
          # Раскомментируйте следующую строку, чтобы получить полный ответ:
          # print(alternative)
      ```

      Где:

      * `folder_id` — идентификатор [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder) {{ yandex-cloud }}.
      * `auth` — [API-ключ](../../../iam/concepts/authorization/api-key.md) или [IAM-токен](../../../iam/concepts/authorization/iam-token.md) сервисного аккаунта, полученный ранее и необходимый для [аутентификации в API](../../api-ref/authentication.md).
      * `<идентификатор модели>` — идентификатор [модели выделенного инстанса](../../concepts/generation/dedicated-instance.md#models).
      * `model_version` — идентификатор версии модели.
      * `temperature` — чем выше значение этого параметра, тем более креативными и случайными будут ответы модели. Принимает значения от `0` (включительно) до `1` (включительно).

  1. Выполните созданный файл:

      ```bash
      python3 test_ml.py
      ```

      Результат:

      ```text
      Альберт Эйнштейн был выдающимся физиком, труды которого в области теоретической физики, теоретической механики и философии науки стали фундаментальными. Он посвятил свою карьеру изучению основ Вселенной, включая теорию относительности, специальную и общую теорию относительности. Кроме того, Альберт Эйнштейн изучал:\n\n* термодинамику,\n* статистическую механику,\n* электромагнетизм,\n* квантовую теорию,\n* специальную теорию относительности и др.\n\nЕго работы по общей теории относительности получили широкое признание и оказали глубокое влияние на развитие современной физики.
      ```

{% endlist %}