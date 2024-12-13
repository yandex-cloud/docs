---
title: Как узнать размер запроса в токенах
description: Следуя данной инструкции, вы научитесь определять размер запросов к моделям {{ yagpt-full-name }} в токенах.
---

# Оценить размер в токенах

Нейросети работают с текстами, представляя слова и предложения в виде [токенов](../../concepts/yandexgpt/tokens.md).

{{ foundation-models-name }} использует свой токенизатор для обработки текстов. Чтобы рассчитать размер текста или запроса к модели {{ yagpt-name }} в токенах, используйте методы [Tokenize](../../text-generation/api-ref/Tokenizer/index.md) API генерации текста или [{{ ml-sdk-full-name }}](../../sdk/index.md).

Число токенов в одном и том же тексте может отличаться для каждой [модели](../../concepts/yandexgpt/models.md).

## Перед началом работы {#before-begin}

Чтобы воспользоваться примерами:

{% list tabs group=programming_language %}

- SDK {#sdk}

  {% include [sdk-before-begin-ai-langmodel-user](../../../_includes/foundation-models/sdk-before-begin-ai-langmodel-user.md) %}

{% endlist %}

## Рассчитать размер запроса {#evaluate}

В приведенном примере оценивается размер запроса к модели {{ yagpt-name }}. Контекст запроса задается в переменной `messages`.

{% list tabs group=programming_language %}

- SDK {#sdk}

  1. Создайте файл `tokenize.py` и добавьте в него следующий код:

      {% include [yandexgpt-tokenize-sdk](../../../_includes/foundation-models/examples/yandexgpt-tokenize-sdk.md) %}

      Где:

      {% include [the-messages-parameter](../../../_includes/foundation-models/yandexgpt/the-messages-parameter.md) %}

      {% include [sdk-code-legend](../../../_includes/foundation-models/examples/sdk-code-legend.md) %}

  1. Выполните созданный файл:

      ```bash
      python3 tokenize.py
      ```

      {% cut "Результат выполнения запроса — список полученных токенизатором токенов:" %}

      ```text
      Token(id=1, special=True, text='<s>')
      Token(id=16861, special=False, text='▁Пользователь')
      Token(id=125851, special=False, text=':')
      Token(id=502, special=False, text='▁[')
      Token(id=2361, special=False, text='▁▁▁▁▁▁▁▁▁▁▁▁▁▁')
      Token(id=125913, special=False, text='{')
      Token(id=689, special=False, text='▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁')
      Token(id=125864, special=False, text='"')
      Token(id=14726, special=False, text='role')
      Token(id=956, special=False, text='":')
      Token(id=450, special=False, text='▁"')
      Token(id=10183, special=False, text='system')
      Token(id=789, special=False, text='",')
      Token(id=689, special=False, text='▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁')
      Token(id=125864, special=False, text='"')
      Token(id=1277, special=False, text='text')
      Token(id=956, special=False, text='":')
      Token(id=450, special=False, text='▁"')
      Token(id=64592, special=False, text='Найди')
      Token(id=14660, special=False, text='▁ошибки')
      Token(id=273, special=False, text='▁в')
      Token(id=28802, special=False, text='▁тексте')
      Token(id=286, special=False, text='▁и')
      Token(id=16283, special=False, text='▁исправ')
      Token(id=125839, special=False, text='ь')
      Token(id=1349, special=False, text='▁их')
      Token(id=125864, special=False, text='"')
      Token(id=2361, special=False, text='▁▁▁▁▁▁▁▁▁▁▁▁▁▁')
      Token(id=1735, special=False, text='},')
      Token(id=2361, special=False, text='▁▁▁▁▁▁▁▁▁▁▁▁▁▁')
      Token(id=125913, special=False, text='{')
      Token(id=689, special=False, text='▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁')
      Token(id=125864, special=False, text='"')
      Token(id=14726, special=False, text='role')
      Token(id=956, special=False, text='":')
      Token(id=450, special=False, text='▁"')
      Token(id=2478, special=False, text='user')
      Token(id=789, special=False, text='",')
      Token(id=689, special=False, text='▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁')
      Token(id=125864, special=False, text='"')
      Token(id=1277, special=False, text='text')
      Token(id=956, special=False, text='":')
      Token(id=450, special=False, text='▁"')
      Token(id=125904, special=False, text='А')
      Token(id=500, special=False, text='ши')
      Token(id=4291, special=False, text='пки')
      Token(id=680, special=False, text='▁са')
      Token(id=527, special=False, text='ме')
      Token(id=822, special=False, text='▁си')
      Token(id=1377, special=False, text='бя')
      Token(id=834, special=False, text='▁ни')
      Token(id=1634, special=False, text='▁ис')
      Token(id=125813, special=False, text='р')
      Token(id=125828, special=False, text='п')
      Token(id=30104, special=False, text='вят')
      Token(id=2960, special=False, text='."')
      Token(id=2361, special=False, text='▁▁▁▁▁▁▁▁▁▁▁▁▁▁')
      Token(id=125914, special=False, text='}')
      Token(id=591, special=False, text='▁▁▁▁▁▁▁▁▁▁▁▁')
      Token(id=125895, special=False, text=']')
      Token(id=3, special=True, text='[NL]')
      Token(id=3, special=True, text='[NL]')
      Token(id=125904, special=False, text='А')
      Token(id=845, special=False, text='сси')
      Token(id=57590, special=False, text='стент')
      Token(id=125851, special=False, text=':')
      Token(id=4, special=True, text='[SEP]')
      ```

      {% endcut %}

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../concepts/yandexgpt/tokens.md)
* [{#T}](../../concepts/yandexgpt/index.md)
* Примеры работы с ML SDK на [GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/master/examples/sync/completions)