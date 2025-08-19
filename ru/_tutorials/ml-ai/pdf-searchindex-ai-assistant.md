# Создать AI-ассистента с RAG по PDF-файлам со сложным форматированием

{% include [assistants-preview-stage](../../_includes/foundation-models/assistants-preview-stage.md) %}

В этом практическом руководстве приведен пример создания [AI-ассистента](../../foundation-models/concepts/assistant/index.md), который выполняет поиск по информации в источнике, содержащем сложное форматирование и табличные данные, и анализирует полученные данные с помощью [модели генерации текста](../../foundation-models/concepts/yandexgpt/models.md) {{ gpt-pro }} RC.

В качестве примера исходного файла со сложным форматированием приведен файл в формате [PDF](https://ru.wikipedia.org/wiki/Portable_Document_Format). Исходный файл будет преобразован в формат [Markdown](https://ru.wikipedia.org/wiki/Markdown). Многие модели обучаются на данных в формате Markdown и лучше всего работают с ним, поэтому файлы этого формата эффективнее всего использовать в качестве источника для поискового индекса. Поисковые индексы, которые вы создадите из файла-источника, будут использовать два [варианта поиска](../../foundation-models/concepts/assistant/search-index.md#search-types) — текстовый и гибридный.

Обращаться к [{{ assistant-api }}](../../foundation-models/assistants/api-ref/index.md) и [Text Generation API](../../foundation-models/text-generation/api-ref/index.md) вы будете через [{{ ml-sdk-full-name }}](../../foundation-models/sdk/index.md) для Python.


## Перед началом работы {#before-you-begin}

{% note info %}

Рекомендуется выполнять руководство на машине, имеющей не менее 4 ГБ RAM и 12 ГБ свободного места на диске.

Для подготовки окружения может потребоваться до 1 часа.

{% endnote %}

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт и [назначьте](../../iam/operations/sa/assign-role-for-sa.md) ему [роли](../../foundation-models/security/index.md#service-roles) `ai.assistants.editor` и `ai.languageModels.user`.
1. [Получите](../../iam/operations/authentication/manage-api-keys.md#create-api-key) и сохраните API-ключ сервисного аккаунта.

    {% include [sdk-auth-details-paragraph](../../_includes/foundation-models/sdk-auth-details-paragraph.md) %}

1. Установите Python версии [3.10](https://www.python.org/downloads/release/python-3100/) или [3.11](https://www.python.org/downloads/release/python-3110/).
1. Установите утилиту Python [venv](https://docs.python.org/3/library/venv.html) для создания изолированных виртуальных окружений в Python.
1. Создайте и войдите в новое виртуальное окружение Python:

    ```bash
    python3 -m venv new-env
    source new-env/bin/activate
    ```

1. С помощью менеджера пакетов [pip](https://pypi.org/project/pip/) установите библиотеку [docling](https://github.com/DS4SD/docling) для преобразования документов из формата PDF в формат Markdown:

    ```bash
    pip install docling
    ```

1. Установите библиотеку [{{ ml-sdk-full-name }}](https://github.com/yandex-cloud/yandex-cloud-ml-sdk) для работы с инструментами {{ foundation-models-full-name }}:

    ```bash
    pip install yandex-cloud-ml-sdk
    ```

1. [Скачайте](https://{{ s3-storage-host-doc-files }}/ml/assistant-example.pdf) файл `assistant-example.pdf` с документом, который будет использоваться в качестве источника информации для AI-ассистента, и преобразуйте его в формат Markdown с помощью установленной ранее библиотеки `docling`:

    1. Создайте файл `convert.py`, содержащий следующий код:

        ```python
        from docling.document_converter import DocumentConverter

        converter = DocumentConverter()
        result = converter.convert("assistant-example.pdf")
        content = result.document.export_to_markdown()
        with open("assistant-example.md", "wt") as f:
           f.write(content)
        ```

    1. Выполните файл `convert.py`:

        ```bash
        python3 convert.py
        ```

        В результате в текущей директории будет сохранен файл `assistant-example.md`, содержащий контент из исходного PDF-файла в формате Markdown.


### Необходимые платные ресурсы {#paid-resources}

В стоимость использования AI-ассистента входит плата за генерацию текста (см. [тарифы {{ foundation-models-full-name }}](../../foundation-models/pricing.md)).


## Создайте AI-ассистента и протестируйте его работу {#create-assistant}

Вы создадите поисковый индекс, источником для которого будет служить файл в формате Markdown. Затем вы зададите созданному ассистенту несколько вопросов, основанных на источнике информации:


### Создайте AI-ассистента с текстовым поисковым индексом {#test-search-assistant}

1. Создайте файл `assistant-text.py`, содержащий следующий код:

    {% include [searchindex-ai-assistant-text](../../_includes/foundation-models/assistants/searchindex-ai-assistant-text.md) %}

    {% include [sdk-code-legend](../../_includes/foundation-models/assistants/sdk-code-legend.md) %}

1. Выполните файл `assistant-text.py`, чтобы создать ассистента и получить от него ответы на вопросы:

    ```bash
    python3 assistant-text.py
    ```

    Результат:

    ```text
    Какие сервисы входят в Райдтех?
    В Райдтех входят:
    * сервис онлайн-заказа такси;
    * сервис каршеринга Яндекс Драйв;
    * сервис аренды самокатов;
    * другие перспективные сервисы.

    Какая рентабельность скорректированного показателя EBITDA у сервисов объявлений?
    Рентабельность скорректированного показателя EBITDA у сервисов объявлений составляет 51,3%.

    На сколько млрд рублей выдал Яндекс займов за 9 месяцев до 30 сентября 2024?
    В предоставленном контексте нет информации о том, сколько миллиардов рублей Яндекс выдал займов за 9 месяцев до 30 сентября 2024 года.
    ```

    Как видно из результата, текстовый поиск справился только с первым, самым простым вопросом. На второй вопрос ответ неверный, а на третий вопрос ответ совсем не представлен.

### Создайте AI-ассистента с гибридным поисковым индексом {#hybrid-search-assistant}

1. Создайте файл `assistant-hybrid.py`, содержащий следующий код:

    {% include [searchindex-ai-assistant-hybrid](../../_includes/foundation-models/assistants/searchindex-ai-assistant-hybrid.md) %}

    {% include [sdk-code-legend](../../_includes/foundation-models/assistants/sdk-code-legend.md) %}

1. Выполните файл `assistant-hybrid.py`, чтобы создать ассистента и получить от него ответы на вопросы:

    ```bash
    python3 assistant-hybrid.py
    ```

    Результат:

    ```text
    В Райдтех входят:
    * сервис онлайн-заказа такси и дистрибуция таких технологий за рубежом;
    * сервис каршеринга Яндекс Драйв;
    * сервис аренды самокатов;
    * другие перспективные сервисы.

    Какая рентабельность скорректированного показателя EBITDA у сервисов объявлений?
    Рентабельность скорректированного показателя EBITDA у сервисов объявлений за третий квартал 2024 года составила 6,5%.

    На сколько млрд рублей выдал Яндекс займов за 9 месяцев до 30 сентября 2024?
    За девять месяцев до 30 сентября 2024 года Яндекс выдал займов на сумму 6,5 млрд рублей.
    ```

    Как видно из результата, гибридный поиск обеспечил более качественный результат: ответы на все три вопроса — верные.


### Усовершенствуйте ассистента {#improve-assistant}

Расширьте возможности созданного ассистента, превратив его из простого информатора в умного помощника, анализирующего найденные данные и на их основе предоставляющего оценочные суждения.

1. Создайте файл `assistant-analyst.py`, содержащий следующий код:

    {% include [searchindex-ai-assistant-analyst](../../_includes/foundation-models/assistants/searchindex-ai-assistant-analyst.md) %}

    {% include [sdk-code-legend](../../_includes/foundation-models/assistants/sdk-code-legend.md) %}

1. Выполните файл `assistant-analyst.py`, чтобы создать ассистента и получить от него ответы на вопросы:

    ```bash
    python3 assistant-analyst.py
    ```

    Результат:

    ```text
    Какая рентабельность скорректированного показателя EBITDA у сервисов объявлений?
    Рентабельность скорректированного показателя EBITDA у сервисов объявлений за третий квартал 2024 года
    составила 6,5%. Это значительное улучшение по сравнению с аналогичным периодом прошлого года, когда
    рентабельность была 3,3%. Такой рост свидетельствует об эффективности работы сегмента и улучшении его
    финансовых показателей.
    ```