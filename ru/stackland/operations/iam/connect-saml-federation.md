# Подключить SAML-федерацию

SAML-федерация позволяет пользователям входить в систему с помощью учетных записей из внешнего провайдера идентификации (IdP).

{% note info %}

Для настройки SAML-федерации необходимы права администратора кластера.

{% endnote %}

## Перед началом работы {#before-you-begin}

Подготовьте следующую информацию о вашем провайдере идентификации:

* URL для единого входа (SSO URL).
* Идентификатор издателя (Issuer).
* Сертификат в формате PEM для проверки подписи SAML-ответов.

## Создать SAML-федерацию {#create-federation}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Создайте файл с описанием SAML-федерации `saml-federation.yaml`:

      ```yaml
      apiVersion: iam.stackland.yandex.cloud/v1alpha1
      kind: SAMLFederation
      metadata:
        name: my-federation
      spec:
        description: "SAML Federation for corporate users"
        cookieMaxAge: "43200s"  # 12 часов
        issuer: "https://idp.example.com/realms/my-realm"
        ssoBinding: POST
        ssoUrl: "https://idp.example.com/realms/my-realm/protocol/saml"
        autoCreateAccountOnLogin: true
        caseInsensitiveNameIds: false
        securitySettings:
          encryptedAssertions: false
          forceAuthn: true
        certificates:
          - name: "idp-certificate"
            description: "IdP signing certificate"
            data: |
              -----BEGIN CERTIFICATE-----
              <содержимое сертификата>
              -----END CERTIFICATE-----
      ```

      Где:

      * `name` — имя федерации.
      * `description` — описание федерации.
      * `cookieMaxAge` — время жизни cookie сессии.
      * `issuer` — идентификатор издателя из настроек IdP.
      * `ssoUrl` — URL для единого входа из настроек IdP.
      * `autoCreateAccountOnLogin` — автоматически создавать пользователя при первом входе.
      * `forceAuthn` — требовать повторную аутентификацию при каждом входе.
      * `certificates` — список сертификатов для проверки подписи SAML-ответов.

  1. Примените конфигурацию:

      ```bash
      kubectl apply -f saml-federation.yaml
      ```

  1. Проверьте статус федерации:

      ```bash
      kubectl get samlfederation my-federation -o yaml
      ```

{% endlist %}

## Настроить маппинг групп {#group-mapping}

Маппинг групп позволяет автоматически добавлять пользователей из федерации в локальные группы на основе их членства в группах IdP.

{% list tabs group=instructions %}

- CLI {#cli}

  1. Создайте локальные группы в {{ iam-name }} через консоль управления или дождитесь их создания.

  1. Добавьте настройки маппинга групп в спецификацию федерации:

      ```yaml
      apiVersion: iam.stackland.yandex.cloud/v1alpha1
      kind: SAMLFederation
      metadata:
        name: my-federation
      spec:
        # ... остальные настройки ...
        groupMapping:
          enabled: true
          mapping:
            - externalId: idp-admins
              internalName: stackland-cluster-admins
            - externalId: idp-developers
              internalName: developers
      ```

      Где:

      * `externalId` — имя группы в IdP.
      * `internalName` — имя локальной группы в {{ iam-name }}.

  1. Примените изменения:

      ```bash
      kubectl apply -f saml-federation.yaml
      ```

  1. Проверьте статус синхронизации групп:

      ```bash
      kubectl get samlfederation my-federation -o jsonpath='{.status.groupMapping}'
      ```

{% endlist %}

## Настроить IdP {#configure-idp}

После создания федерации в Stackland настройте ваш провайдер идентификации:

1. Получите URL для приема SAML-ответов (ACS URL):

    ```bash
    kubectl get samlfederation my-federation -o jsonpath='{.status.federation.acsDomain}'
    ```

1. В настройках вашего IdP:
   * Укажите полученный ACS URL.
   * Настройте отправку атрибута `preferred_username` в SAML-ответе.
   * Если используете маппинг групп, настройте отправку информации о группах пользователя.

## Проверить работу федерации {#test-federation}

1. Откройте консоль управления Stackland.
1. На странице входа выберите вход через федерацию.
1. Выполните вход с учетными данными из вашего IdP.
1. После успешного входа проверьте, что пользователь появился в списке пользователей {{ iam-name }}.

## Обновить сертификат {#update-certificate}

Для обновления сертификата без простоя:

1. Добавьте новый сертификат в список `certificates` с другим именем.
1. Примените изменения.
1. После успешной синхронизации удалите старый сертификат из списка.
1. Примените изменения повторно.

## Что дальше {#what-is-next}

* [Создайте группы пользователей](create-group.md)
* [Назначьте права доступа](assign-role.md)
