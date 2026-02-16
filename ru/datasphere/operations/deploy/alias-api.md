---
title: Как отправить запрос в алиас в {{ ml-platform-full-name }}
description: Следуя данной инструкции, вы сможете отправить запрос в алиас.
---

# Отправить запрос в алиас

{% include [models-node-request](../../../_includes/datasphere/models-node-request.md) %}

Отправлять запросы к публичному алиасу могут все пользователи, авторизованные в {{ yandex-cloud }}. Чтобы отправить запрос к приватному алиасу, необходимы следующие роли:

* Для пользователей минимальная роль — `{{ roles-datasphere-project-developer }}` в проекте.
* Для сервисных аккаутов необходима роль `{{ roles-datasphere-project-developer }}` в проекте либо сервисный аккаунт должен быть создан в каталоге, указанном при создании алиаса.

{% list tabs %}

- Интерфейс {{ ml-platform-full-name }}

  Тип запроса в [алиас](../../concepts/deploy/index.md#alias) зависит от вашей [ноды](../../concepts/deploy/index.md#node). Вы можете отправить тестовый запрос в интерфейсе, если в ответе ожидаете получить простые данные, например числа или строковые переменные.
  
  1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
  1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** выберите **{{ ui-key.yc-ui-datasphere.common.alias }}**.
  1. Выберите алиас, к которому нужно отправить запрос.
  1. Перейдите на вкладку **{{ ui-key.yc-ui-datasphere.node-page.tab.request }}**.
  1. В блоке **{{ ui-key.yc-ui-datasphere.node-page.request.create-test-request }}**:
     * В поле **Method** выберите тип запроса.
     * В поле **{{ ui-key.yc-ui-datasphere.common.input }}** введите входные переменные запроса в формате `{"a":2,"b":3}` и нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.execute }}**.
  1. Посмотрите результат обработки запроса в блоке **{{ ui-key.yc-ui-datasphere.common.response }}**.
  
  {% note info %}
  
  В блоке **{{ ui-key.yc-ui-datasphere.node-page.request.curl }}** приведены примеры запросов в алиас для утилит cURL и gRPCurl.
  
  {% endnote %}

- gRPC API

  Для отправки вызовов gRPC можно воспользоваться утилитой [gRPCurl](https://github.com/fullstorydev/grpcurl).
  
  ```bash
  grpcurl \
     --header "x-node-alias: datasphere.user.<имя_алиаса>" \
     --header "Authorization: Bearer <IAM-токен>" \
     --header "x-folder-id: <идентификатор_каталога>" \
     --data '<входные_переменные>' \
     {{ ds-node-endpoint }}:443
  ```
  
  Где:
  
  * `<имя_алиаса>` — имя алиаса.
  * `<IAM-токен>` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md) для аутентификации.
  * `<идентификатор_каталога>` — идентификатор каталога, в котором созданы проект и алиас.
  * `<входные_переменные>` — объект в формате `{"a":2,"b":3}`, в котором ключи соответствуют входным переменным.
  
  В успешном ответе будет возвращен объект:
  
  ```json
  {
     "output": {
        <выходные_переменные>
     }
  }
  ```

- REST API

  Для отправки REST-запросов можно воспользоваться утилитой [cURL](https://curl.se).
  
  ```bash
  curl \
     --header "x-node-alias: datasphere.user.<имя_алиаса>" \
     --header "Authorization: Bearer <IAM-токен>" \
     --header "x-folder-id: <идентификатор_каталога>" \
     --request <тип_запроса> \
     --data '<входные_переменные>' \
     https://{{ ds-node-endpoint }}/
  ```
  
  Где:
  
  * `<имя_алиаса>` — имя алиаса.
  * `<IAM-токен>` — IAM-токен для аутентификации.
  * `<идентификатор_каталога>` — идентификатор каталога, в котором созданы проект и алиас.
  * `<тип_запроса>` — тип HTTP-запроса.
  * `<входные_переменные>` — объект в формате `{"a":2,"b":3}`, в котором ключи соответствуют входным переменным.
  
  В ответ возвращается JSON-объект с выходными переменными.

{% endlist %}