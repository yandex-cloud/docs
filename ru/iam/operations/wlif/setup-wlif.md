---
title: Как настроить федерацию сервисных аккаунтов в {{ iam-full-name }}
description: С помощью этой инструкции вы научитесь настраивать федерации сервисных аккаунтов в {{ iam-name }}.
---

# Настройка федерации сервисных аккаунтов

{% include [note-preview-by-request](../../../_includes/note-preview-by-request.md) %}

{% include [move-groups-api](../../../_includes/iam/wlif-instructions-intro.md) %}

Чтобы настроить аутентификацию в API {{ yandex-cloud }} через федерацию сервисных аккаунтов:

1. [Подготовьте облако к работе](#prepare-cloud).
1. [Создайте федерацию сервисных аккаунтов](#create-wlif).
1. [Создайте привязку](#create-federated-credential).
1. [Обменяйте JWT-токен внешнего субъекта на IAM-токен сервисного аккаунта](#exchange-jwt-for-iam).

Примеры настройки аутентификации для отдельных OIDC-провайдеров приведены в практических руководствах:

* [GitHub](../../tutorials/wlif-github-integration.md).
* [{{ GL }}](../../tutorials/wlif-gitlab-integration.md).

## Подготовьте облако к работе {#prepare-cloud}

{% include [before-you-begin](../../../_tutorials/_tutorials_includes/before-you-begin.md) %}

Для настройки федерации сервисных аккаунтов вам понадобится [сервисный аккаунт](../../concepts/users/service-accounts.md). Если у вас нет сервисного аккаунта, [создайте](../sa/create.md) его.

## Создайте федерацию сервисных аккаунтов {#create-wlif}

{% note info %}

Чтобы создать федерацию сервисных аккаунтов, пользователю необходима [роль](../../security/index.md#iam-workloadIdentityFederations-editor) `iam.workloadIdentityFederations.editor` или выше на каталог.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать федерацию сервисных аккаунтов.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. На панели слева выберите ![cpus](../../../_assets/console-icons/cpus.svg) **{{ ui-key.yacloud.iam.label_federations }}**.
  1. Нажмите **{{ ui-key.yacloud.iam.label_create-wli-federation }}** и в открывшейся форме:
      1. В поле **{{ ui-key.yacloud.iam.federations.field_issuer }}** введите URL OIDC-провайдера.

          Чтобы узнать это значение, обратитесь к документации или в службу технической поддержки используемого OIDC-провайдера.
      1. В поле **{{ ui-key.yacloud.iam.federations.field_audiences }}** введите ресурс, для которого будет предназначен получаемый токен.

          Чтобы узнать это значение, обратитесь к документации или в службу технической поддержки используемого OIDC-провайдера.

          Вы можете задать одновременно несколько ресурсов-получателей IAM-токена.
      1. В поле **{{ ui-key.yacloud.iam.federations.field_jwks }}** введите URL, по которому можно получить актуальный открытый ключ, выпущенный OIDC-провайдером и используемый для проверки подписи [JWT](https://ru.wikipedia.org/wiki/JSON_Web_Token).

          Чтобы узнать это значение, обратитесь к документации или в службу технической поддержки используемого OIDC-провайдера.
      1. В поле **{{ ui-key.yacloud.iam.federations.field_name }}** введите имя создаваемой федерации, например `sample-iam-federation`.
      1. Нажмите кнопку **{{ ui-key.yacloud_billing.iam.cloud.create.popup-create-cloud_button_add }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды создания федерации сервисных аккаунтов:

      ```bash
      yc iam workload-identity oidc federation create --help
      ```

  1. Создайте федерацию сервисных аккаунтов в каталоге по умолчанию:

      ```bash
      yc iam workload-identity oidc federation create \
        --name <имя_федерации> \
        --issuer "<URL_OIDC-провайдера>" \
        --audiences "<ресурс_1>","<ресурс_2>",...,"<ресурс_n>" \
        --jwks-url "<адрес_JWKS>"
      ```

      Где:

      * `--name` — имя создаваемой федерации. Например: `sample-iam-federation`. Требования к имени:

          {% include [name-format](../../../_includes/name-format.md) %}
      * `--issuer` — URL OIDC-провайдера.

          Чтобы узнать это значение, обратитесь к документации или в службу технической поддержки используемого OIDC-провайдера.
      * `--audiences` — ресурсы, для которых будет предназначен получаемый токен. Вы можете через запятую задать одновременно несколько ресурсов-получателей IAM-токена.

          Чтобы узнать это значение, обратитесь к документации или в службу технической поддержки используемого OIDC-провайдера.
      * `--jwks-url` — URL, по которому можно получить актуальный открытый ключ, выпущенный OIDC-провайдером и используемый для проверки подписи [JWT](https://ru.wikipedia.org/wiki/JSON_Web_Token).

          Чтобы узнать это значение, обратитесь к документации или в службу технической поддержки используемого OIDC-провайдера.

      Результат:

      ```text
      id: aje2c4qv19lf********
      name: sample-iam-federation
      folder_id: b1gfq9pe6rd2********
      enabled: true
      audiences:
        - https://gitlab.example.ru
        - https://gitlab.example.com
      issuer: https://gitlab.com
      jwks_url: https://gitlab.com/oauth/discovery/keys
      created_at: "2024-12-28T16:04:31.530652473Z"
      ```

      Сохраните значение идентификатора созданной федерации сервисных аккаунтов, оно понадобится при создании привязки.

      Подробнее о команде `yc iam workload-identity oidc federation create` см. в [справочнике CLI](../../../cli/cli-ref/iam/cli-ref/workload-identity/oidc/federation/create.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле {{ TF }} параметры федерации, которую необходимо создать:

      ```hcl
      resource "yandex_iam_workload_identity_oidc_federation" "wlif" {
        name        = "<имя_федерации>"
        folder_id   = "<идентификатор_каталога>"
        audiences   = ["<ресурс_1>","<ресурс_2>",...,"<ресурс_n>"]
        issuer      = "<URL_OIDC-провайдера>"
        jwks_url    = "<адрес_JWKS>"
      }
      ```

      Где:

      * `name` — имя создаваемой федерации. Например: `sample-iam-federation`. Требования к имени:

          {% include [name-format](../../../_includes/name-format.md) %}
      * `folder_id` — [идентификатор](../../../resource-manager/operations/folder/get-id.md) каталога, в котором создается федерация сервисных аккаунтов.
      * `audiences` — ресурсы, для которых будет предназначен получаемый токен. Вы можете через запятую задать одновременно несколько ресурсов-получателей IAM-токена.

          Чтобы узнать это значение, обратитесь к документации или в службу технической поддержки используемого OIDC-провайдера.
      * `issuer` — URL OIDC-провайдера.

          Чтобы узнать это значение, обратитесь к документации или в службу технической поддержки используемого OIDC-провайдера.
      * `jwks_url` — URL, по которому можно получить актуальный открытый ключ, выпущенный OIDC-провайдером и используемый для проверки подписи [JWT](https://ru.wikipedia.org/wiki/JSON_Web_Token).

          Чтобы узнать это значение, обратитесь к документации или в службу технической поддержки используемого OIDC-провайдера.

      Более подробную информацию о параметрах ресурса `yandex_iam_workload_identity_oidc_federation` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/iam_workload_identity_oidc_federation).

  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст федерацию сервисных аккаунтов. Убедиться в создании федерации можно в [консоли управления]({{ link-console-main }}) или с помощью команды CLI:

     ```bash
     yc iam workload-identity oidc federation list
     ```

- API {#api}

  Чтобы создать федерацию сервисных аккаунтов, воспользуйтесь методом REST API [create](../../workload/oidc/workload-identity/api-ref/Federation/create.md) для ресурса [Federation](../../workload/oidc/workload-identity/api-ref/Federation/index.md) или вызовом gRPC API [FederationService/Create](../../workload/oidc/workload-identity/api-ref/grpc/Federation/create.md).

{% endlist %}

## Создайте привязку {#create-federated-credential}

Привязка — это связь, настроенная между федерацией сервисных аккаунтов, одним сервисным аккаунтом {{ yandex-cloud }} и одним внешним субъектом. Привязки необходимы для идентификации внешних субъектов в {{ iam-full-name }}.

{% note info %}

Чтобы создать привязку, пользователю необходимы:
* [роль](../../security/index.md#iam-serviceAccounts-federatedCredentialEditor) `iam.serviceAccounts.federatedCredentialEditor` или выше, выданная на сервисный аккаунт, который будет использоваться в привязке.
* [роль](../../security/index.md#iam-workloadIdentityFederations-user) `iam.workloadIdentityFederations.user` или выше на каталог, в котором находится федерация сервисных аккаунтов.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится сервисный аккаунт
  
      При необходимости [создайте](../sa/create.md) новый сервисный аккаунт.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. В списке выберите нужный сервисный аккаунт.
  1. Перейдите на вкладку **{{ ui-key.yacloud.iam.label_federations }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.connected-federation.action_connect-federation }}**.
  1. В поле **{{ ui-key.yacloud.iam.connected-federation.field_federation }}** выберите ранее созданную федерацию.
  1. В поле **{{ ui-key.yacloud.iam.connected-federation.field_subject }}** укажите идентификатор внешнего субъекта.

      Чтобы узнать это значение, обратитесь к документации или в службу технической поддержки используемого OIDC-провайдера.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.connected-federation.action_connect }}**.

- CLI {#cli}

  1. Посмотрите описание команды создания привязки:

      ```bash
      yc iam workload-identity federated-credential create --help
      ```

  1. Создайте привязку, указав идентификатор нужного сервисного аккаунта:

      ```bash
      yc iam workload-identity federated-credential create \
        --service-account-id <идентификатор_сервисного_аккаунта> \
        --federation-id <идентификатор_федерации> \
        --external-subject-id "<идентификатор_внешнего_субъекта>"
      ```

      Где:

      * `--service-account-id` — [идентификатор](../sa/get-id.md) сервисного аккаунта {{ yandex-cloud }}.

          Сервисный аккаунт может быть расположен в каталоге, отличном от каталога федерации сервисных аккаунтов.
      * `--federation-id` — идентификатор федерации сервисных аккаунтов, полученный на предыдущем шаге.
      * `--external-subject-id` — идентификатор внешнего субъекта.

          Чтобы узнать это значение, обратитесь к документации или в службу технической поддержки используемого OIDC-провайдера.

      Результат:

      ```text
      id: aje401v1sup8********
      service_account_id: ajek7v5j65cg********
      federation_id: aje2c4qv19lf********
      external_subject_id: project_path:root/test-iam-wlif:ref_type:branch:ref:master
      created_at: "2024-12-28T16:33:47.057632267Z"
      ```
            
      Подробнее о команде `yc iam workload-identity federated-credential create` см. в [справочнике CLI](../../../cli/cli-ref/iam/cli-ref/workload-identity/federated-credential/create.md).

- {{ TF }} {#tf}

  1. Опишите в конфигурационном файле {{ TF }} параметры привязки, которую необходимо создать:

      ```hcl
      resource "yandex_iam_workload_identity_federated_credential" "fc" {
        service_account_id  = "<идентификатор_сервисного_аккаунта>"
        federation_id       = "<идентификатор_федерации>"
        external_subject_id = "<идентификатор_внешнего_субъекта>"
      }
      ```

      Где:

      * `service_account_id` — [идентификатор](../sa/get-id.md) сервисного аккаунта {{ yandex-cloud }}.

          Сервисный аккаунт может быть расположен в каталоге, отличном от каталога федерации сервисных аккаунтов.
      * `federation_id` — идентификатор федерации сервисных аккаунтов.
      * `external_subject_id` — идентификатор внешнего субъекта.

          Чтобы узнать это значение, обратитесь к документации или в службу технической поддержки используемого OIDC-провайдера.

      Более подробную информацию о параметрах ресурса `yandex_iam_workload_identity_federated_credential` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/iam_workload_identity_federated_credential).

  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст указанную привязку. Убедиться в создании привязки для сервисного аккаунта можно в [консоли управления]({{ link-console-main }}) или с помощью команды CLI:

     ```bash
     yc iam workload-identity federated-credential list \
       --service-account-id <идентификатор_сервисного_аккаунта>
     ```

- API {#api}

  Чтобы создать привязку, воспользуйтесь методом REST API [create](../../workload/workload-identity/api-ref/FederatedCredential/create.md) для ресурса [FederatedCredential](../../workload/workload-identity/api-ref/FederatedCredential/index.md) или вызовом gRPC API [FederatedCredentialService/Create](../../workload/workload-identity/api-ref/grpc/FederatedCredential/create.md).

{% endlist %}

## Обменяйте JWT-токен на IAM-токен сервисного аккаунта {#exchange-jwt-for-iam}

Отправьте запрос к сервису обмена токенов {{ yandex-cloud }}:

```text
POST https://{{ auth-main-host }}/oauth/token HTTP/1.1
     Content-Type: application/x-www-form-urlencoded

     grant_type=urn:ietf:params:oauth:grant-type:token-exchange&
     requested_token_type=urn:ietf:params:oauth:token-type:access_token&
     audience=<идентификатор_сервисного_аккаунта>&
     subject_token=<JWT-токен>&
     subject_token_type=urn:ietf:params:oauth:token-type:id_token
```

Где:

* `grant_type` — тип запроса, имеет фиксированное значение `urn:ietf:params:oauth:grant-type:token-exchange`.
* `requested_token_type` — тип запрашиваемого токена, имеет фиксированное значение `urn:ietf:params:oauth:token-type:access_token`.
* `audience` — [идентификатор](../sa/get-id.md) сервисного аккаунта {{ yandex-cloud }}.
* `subject_token` — JWT-токен внешнего субъекта.
* `subject_token_type` — тип токена внешнего субъекта, имеет фиксированное значение `urn:ietf:params:oauth:token-type:id_token`.

Результат:

```text
HTTP/1.1 200 OK
Content-Type: application/json

{
    "access_token": "t1.9euelZqZlJyXlJGNno6JlIzGmsyUzO3rnpWazY6elMidm8-Nk8iPlZyZkJLl8_d_IUBE-e8AIgRS_d3z9z9QPUT57wAiBFL9zef1656Vmo2RyZqOm5KSj82KkZHNi5WL7_zN5_XrnpWaj46TnZvNksmNks2dj43MmJPv-MXrnpWajZHJmo6bkpKPzYqRkc2LlYu9656Vmp2PyJqYnprLk8aRxpqXzZbPteuGnNGWnpLRkI********************",
    "token_type": "Bearer",
    "expires_in": 43200
}
```

Где значение поля `access_token` — запрашиваемый IAM-токен сервисного аккаунта, который вы можете использовать для аутентификации при выполнении действий в [API {{ yandex-cloud }}](../../../api-design-guide/index.yaml).

## См. также {#see-also}

* [{#T}](../../concepts/workload-identity.md).
* [{#T}](../../tutorials/wlif-github-integration.md).
* [{#T}](../../tutorials/wlif-gitlab-integration.md).