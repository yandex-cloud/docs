---
title: Как отправить запрос в ноду в {{ ml-platform-full-name }}
description: Следуя данной инструкции, вы сможете отправить запрос в ноду.
---

# Отправить запрос в ноду

{% include [models-node-request](../../../_includes/datasphere/models-node-request.md) %}

Отправлять запросы в ноду могут пользователи и [сервисные аккаунты](../../../iam/concepts/users/service-accounts.md) с минимальной ролью в проекте `{{ roles-datasphere-project-developer }}`. Сервисный аккаунт также должен находиться в том же каталоге, что и нода.

{% list tabs %}

- Интерфейс {{ ml-platform-full-name }}

  Отправьте тестовый запрос в [ноду](../../concepts/deploy/index.md#node) из интерфейса {{ ml-platform-name }}:
  1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
  1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** выберите **{{ ui-key.yc-ui-datasphere.resources.node }}**.
  1. Выберите ноду, к которой нужно отправить запрос.
  1. Перейдите на вкладку **{{ ui-key.yc-ui-datasphere.node-page.tab.request }}**.
  1. В блоке **{{ ui-key.yc-ui-datasphere.node-page.request.create-test-request }}** в поле **{{ ui-key.yc-ui-datasphere.common.input }}** введите входные переменные запроса в формате `{"a":2,"b":3}` и нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.execute }}**.
  1. Посмотрите результат обработки запроса в блоке **{{ ui-key.yc-ui-datasphere.common.response }}**.
  
  {% note info %}
  
  В блоке **{{ ui-key.yc-ui-datasphere.node-page.request.curl }}** приведены примеры запросов в ноду для утилит cURL и gRPCurl.
  
  В блоке **{{ ui-key.yc-ui-datasphere.node-page.request.server-response }}** приведены коды и описание ответов ноды.
  
  {% endnote %}

- gRPC API

  ```bash
  grpcurl \
     --header "x-node-id: <идентификатор_ноды>" \
     --header "Authorization: Bearer <IAM-токен>" \
     --header "x-folder-id: <идентификатор_каталога>" \
     --data '<входные_переменные>' \
     {{ ds-node-endpoint }}:443
  ```
  
  Где:
  
  * `<идентификатор_ноды` — идентификатор ноды.
  * `<IAM-токен>` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md) для аутентификации.
  * `<идентификатор_каталога>` — идентификатор каталога, в котором созданы проект и нода.
  * `<входные_переменные>` — объект в формате `{"a":2,"b":3}`, в котором ключи соответствуют входным переменным.
  
  В успешном ответе будет возвращен объект:
  
  ```json
  {
     "output": {
        <выходные_переменные>
     }
  }
  ```

  Где `<выходные_переменные>` — объект, в котором ключи соответствуют выходным переменным.

- REST API

  Для отправки REST-запросов можно воспользоваться утилитой [cURL](https://curl.se).
  
  ```bash
  curl \
     --header "x-node-id: <идентификатор_ноды>" \
     --header "Authorization: Bearer <IAM-токен>" \
     --header "x-folder-id: <идентификатор_каталога>" \
     --request <метод> \
     --data '<входные_переменные>' \
     https://{{ ds-node-endpoint }}/
  ```
  
  Где:
  
  * `<идентификатор_ноды>` — идентификатор ноды.
  * `<IAM-токен>` — IAM-токен для аутентификации.
  * `<идентификатор_каталога>` — идентификатор каталога, в котором созданы проект и нода.
  * `<тип_запроса>` — тип HTTP-запроса.
  * `<входные_переменные>` — объект в формате `{"a":2,"b":3}`, в котором ключи соответствуют входным переменным.
  
  В ответ возвращается JSON-объект с выходными переменными.

{% endlist %}