# Защита {{ api-gw-name }} при помощи {{ sws-name }}


{{ api-gw-full-name }} поддерживает интеграцию с сервисом [{{ sws-full-name }}](../../smartwebsecurity/concepts/index.md). Благодаря этому вы можете настроить для API-шлюза защиту от [DDoS-атак](../../glossary/ddos.md) и ботов на прикладном уровне L7 [модели OSI](https://ru.wikipedia.org/wiki/Сетевая_модель_OSI).

Профили безопасности {{ sws-name }} позволяют настроить защиту с различными условиями. Например, вы можете установить [лимит запросов](../../smartwebsecurity/concepts/arl.md) с группировкой запросов по параметрам, а также настроить блокировку запросов по IP-адресу пользователя. Для этого:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте профиль ARL и профиль безопасности {{ sws-name }}](#create-arl-and-sws-profiles).
1. [Создайте API-шлюз](#create-api-gateway).
1. [Проверьте работу созданных ресурсов](#check-rules).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

## Создайте профиль ARL и профиль безопасности {{ sws-name }} {#create-arl-and-sws-profiles}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Создайте профиль ARL](../../smartwebsecurity/operations/arl-profile-create.md) с именем `arl-profile`.

  1. [Добавьте в профиль правило](../../smartwebsecurity/operations/arl-rule-add.md) с лимитом запросов и группировкой запросов по параметру `token`. Укажите следующие параметры:

      * **Имя** — `query-limit-rule`;
      * **{{ ui-key.yacloud.smart-web-security.arl.column_rule-priority }}** — `999900`;
      * **Группировать запросы** — **По характеристикам**;
      * **Характеристика** — `Query params`;
      * **Группировать по** — `token`;
      * **Лимит запросов на группу** — `1` за `1 минуту`.

  1. [Создайте профиль безопасности](../../smartwebsecurity/operations/profile-create.md) `sws-profile` по преднастроенному шаблону. При создании выберите в поле **{{ ui-key.yacloud.smart-web-security.form.label_arl-profile }}** созданный ранее профиль `arl-profile`.

  1. Чтобы настроить блокировку по IP-адресу пользователя, [добавьте правило](../../smartwebsecurity/operations/rule-add.md) к профилю безопасности {{ sws-name }} со следующими параметрами:

      * **Имя** — `ip-block-rule`;
      * **{{ ui-key.yacloud.smart-web-security.arl.column_rule-priority }}** — `999700`;
      * **Тип правила** — **Базовое**;
      * **{{ ui-key.yacloud.smart-web-security.overview.column_action-type }}** — **Разрешить**;
      * **{{ ui-key.yacloud.smart-web-security.arl.column_rule-conditions }}**:

          * **Трафик** — **При условии**;
          * **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}** — `IP`;
          * **Условия на IP** — `Совпадает или принадлежит диапазону`;
          * **IP совпадает или принадлежит диапазону** — укажите ваш IP-адрес.

- {{ TF }} {#tf}

  1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
  1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
  1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
  1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

  1. Скачайте в ту же рабочую директорию файл конфигурации [api-gw-sws-integration.tf](https://github.com/yandex-cloud-examples/yc-serverless-gateway-protection-with-sws/blob/main/api-gw-sws-integration.tf).

      В этом файле описаны:

      * Профиль ARL, устанавливающий лимит запросов и группировку запросов по параметру `token`.
      * Профиль безопасности {{ sws-name }}, который использует профиль ARL и дополнительно устанавливает блокировку по IP-адресу.
      * API-шлюз, настроенный на работу с профилем безопасности {{ sws-name }}.

  1. В блоке с локальными переменными файла `api-gw-sws-integration.tf` укажите следующие параметры:

      * `arl_name` — имя профиля ARL.
      * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором будет создан профиль ARL.
      * `sws_name` — имя профиля {{ sws-name }}.
      * `allowed_ips` — список IP-адресов, с которых разрешен доступ к API-шлюзу.
      * `api-gw-name` — имя API-шлюза.

  1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

      ```bash
      terraform validate
      ```

      Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Создайте необходимую инфраструктуру:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Создайте API-шлюз {#create-api-gateway}

{% list tabs group=instructions %}

- Консоль управления {#console}

  [Создайте API-шлюз](../../api-gateway/operations/api-gw-create.md) `my-gateway`. При создании добавьте в поле **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** следующую спецификацию:

  ```yaml
  openapi: "3.0.0"

  x-yc-apigateway:
    smartWebSecurity:
      securityProfileId: <идентификатор_профиля_безопасности_SWS>

  info:
    version: 1.0.0
    title: Protected application
    license:
      name: MIT
  paths:
    /:
      get:
        x-yc-apigateway-integration:
          type: dummy
          content:
            '*': "This application is protected by SWS!"
          httpCode: 200
  ```

  Остальные параметры оставьте без изменений.

- {{ TF }} {#tf}

  1. В файле `api-gw-sws-integration.tf`:

      1. В параметре `securityProfileId` спецификации API-шлюза укажите идентификатор созданного ранее профиля безопасности {{ sws-name }}.

      1. В блоке локальных переменных укажите значение `create-api-gw = 1`.

  1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

      ```bash
      terraform validate
      ```

      Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Создайте необходимую инфраструктуру:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Проверьте работу созданных ресурсов {#check-rules}

Протестируйте работу настроек {{ sws-name }}:

* [Лимит запросов](#check-requests-limiter).
* [Группировка запросов](#check-query-groupping).
* [Блокировка запроса по IP-адресу](#check-ip-block).

### Проверка лимита запросов {#check-requests-limiter}

1. Выполните GET-запрос к API-шлюзу:

    ```bash
    curl <служебный_домен_API-шлюза>
    ```

    Результат выполнения команды:

    ```bash
    This application is protected by SWS!
    ```

1. Сразу же повторите запрос. В ответ вы получите веб-страницу с кодом ошибки 429. Это значит, что лимит количества запросов сработал и заблокировал ваш запрос.

1. Подождите минуту и повторите запрос. Ответ должен быть идентичен ответу на первый запрос:

    ```bash
    This application is protected by SWS!
    ```

### Проверка группировки запросов {#check-query-groupping}

1. Выполните GET-запрос к API-шлюзу с параметром `token=token`:

    ```bash
    curl <служебный_домен_API-шлюза>?token=token
    ```

    Результат выполнения команды:

    ```bash
    This application is protected by SWS!
    ```

1. Сразу же повторите запрос. В ответ вы получите веб-страницу с кодом ошибки 429. Это значит, что лимит количества запросов сработал и заблокировал ваш запрос.

1. В эту же минуту повторите запрос, но измените значение параметра `token`:

    ```bash
    curl <служебный_домен_API-шлюза>?token=token2
    ```

    Результат выполнения команды:

    ```bash
    This application is protected by SWS!
    ```

    Это значит, что ваш запрос попал в новую группу, для которой еще не срабатывал лимит количества запросов. Поэтому запрос был успешно выполнен.

### Проверка блокировки по IP {#check-ip-block}

1. Выполните GET-запрос к API-шлюзу с IP-адреса, который вы указали в профиле безопасности {{ sws-name }}:

    ```bash
    curl <служебный_домен_API-шлюза>
    ```

    Результат выполнения команды:

    ```bash
    This application is protected by SWS!
    ```

1. Выполните запрос с другого IP-адреса, например с ВМ в облаке:

    ```bash
    curl --verbose <служебный_домен_API-шлюза>
    ```

    В ответ вы получите веб-страницу с капчей. Это значит, что {{ sws-name }} заблокировал запрос с IP-адреса, который не входит в список разрешенных.

# Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать, в зависимости от способа их создания:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Удалите API-шлюз](../../api-gateway/operations/api-gw-delete.md).
  1. [Удалите профиль безопасности {{ sws-name }}](../../smartwebsecurity/operations/profile-delete.md).
  1. [Удалите профиль ARL](../../smartwebsecurity/operations/arl-profile-delete.md).

- {{ TF }} {#tf}

  {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
