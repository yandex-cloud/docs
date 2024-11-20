# Создать простого ассистента

Этот пример показывает, как создать [ассистента](../../concepts/assistant/index.md), который будет хранить переписку с моделью {{ gpt-pro }} RC.

{% list tabs group=instructions %}

- SDK {#sdk}

  1. [Создайте](../../../iam/operations/sa/create.md) сервисный аккаунт и [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) ему роли `ai.assistants.editor` и `ai.languageModels.user`.
  1. Для сервисного аккаунта [получите](../../../iam/operations/api-key/create.md) и сохраните API-ключ.  
  1. Установить библиотеку {{ ml-sdk-name }} можно с помощью менеджера пакетов [pip](https://pip.pypa.io/en/stable/):

     ```bash
     pip install yandex-cloud-ml-sdk
     ```

  1. Создайте файл `simple-assistant.py` и добавьте в него код:

     {% include [simple-assistant](../../../_includes/foundation-models/examples/simple-assistant.md) %}

  1. Выполните созданный файл:

     ```bash
     python3 simple-assistant.py
     ```

{% endlist %}

#### См. также {#see-also}

* [{#T}](./create-with-searchindex.md)
* Примеры работы с ML SDK на [GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/master/examples/sync/assistants) 