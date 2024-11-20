# Создать ассистента с поисковым индексом

Этот пример показывает, как создать [ассистента](../../concepts/assistant/index.md), который для ответов использует информацию из файлов. В примере будет создан индекс для полнотекстового поиска.

{% list tabs group=instructions %}

- SDK {#sdk}

  1. [Создайте](../../../iam/operations/sa/create.md) сервисный аккаунт и [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) ему роли `ai.assistants.editor` и `ai.languageModels.user`.
  1. Для сервисного аккаунта [получите](../../../iam/operations/api-key/create.md) и сохраните API-ключ.  
  1. Установить библиотеку {{ ml-sdk-name }} можно с помощью менеджера пакетов [pip](https://pip.pypa.io/en/stable/):

     ```bash
     pip install yandex-cloud-ml-sdk
     ```

  1. Скачайте и распакуйте [архив](https://storage.yandexcloud.net/doc-files/tours-example.zip) с примерами файлов, которые будут использоваться как дополнительный источник информации. В файлах содержатся рекламные тексты для туров на Бали и в Казахстан, сгенерированные {{ gpt-pro }}.
  1. Создайте файл `search-assistant.py` и добавьте в него код:

     {% include [searchindex-assistant](../../../_includes/foundation-models/examples/searchindex-assistant.md) %}

  1. Выполните созданный файл:

     ```bash
     python3 search-assistant.py
     ```

{% endlist %}

#### См. также {#see-also}

* [{#T}](./create.md)
* Примеры работы с ML SDK на [GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/master/examples/sync/assistants) 