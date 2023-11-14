# Диагностика ошибок в федерациях, работающих по протоколу SAML 2.0

## Ошибка при создании нового пользователя {#automatic-user-creation}

Новый пользователь попытался присоединиться к федерации с отключенной опцией автоматического создания пользователей. [Добавьте пользователя вручную](operations/add-account.md#add-user-sso) или включите опцию **{{ ui-key.yacloud_org.entity.federation.field.autocreateUsers }}** в настройках федерации.

## Не зашифрованы утверждения в SAMLResponse {#response-not-encrypted}

В федерации включена опция **{{ ui-key.yacloud_org.entity.federation.field.encryptedAssertions }}**. При включении этой опции требуется обязательное шифрование утверждений в `SAMLResponse`.

## Полученный XML не является SAMLResponse {#not-saml2-response}

Полученный ответ от сервера IdP - корректный XML, но не является корректным `SAMLResponse`. Подробнее про требования к `SAMLResponse` читайте в [стандарте SAML V2.0](https://docs.oasis-open.org/security/saml/v2.0/saml-core-2.0-os.pdf#page=46).

## SAMLResponse является некорректным XML {#invalid-xml-response}

Произошла ошибка распознавания XML. Данные `SAMLResponse` неполны или были искажены.

## SAMLResponse не содержит утверждений {#assertions-not-found}

Полученный `SAMLResponse` не содержит утверждений `assertions`. Актуальный статус-код должен быть указан в сообщении об ошибке, например: `No assertions found in response. The status code is 'Responder'`.

## Ошибка при обработке ответа {#invalid-response}

Не удалось декодировать строку из `SAMLResponse`.

## Недопустимый адрес отправителя {#invalid-destination}

Адрес отправителя `SAMLResponse` не соответствует URL-адресу получателя `SamlRequest`. Подробнее о требованиях читайте в [стандарте SAML V2.0](https://docs.oasis-open.org/security/saml/v2.0/saml-core-2.0-os.pdf#page=3).

## Утверждения в SAMLResponse некорректны {#invalid-assertion}

Утверждения в `SAMLResponse` не прошли обязательные проверки при аутентификации.

## Подпись ответа недействительна {#invalid-signature}

Подпись `SAMLResponse` недействительна.

## Утверждения не содержат элемент `subject` {#subject-not-found}

Отсутствует элемент `subject` в `SAMLResponse`.

## Утверждение содержит некорректный элемент `subject` {#username-not-found}

`SAMLResponse` содержит элемент `subject`, но в элементе отсутствует поле `NameID` или `EncryptedID`.

## Ошибка дешифрования {#decryption}

Не удалось расшифровать утверждение или идентификатор имени в `SAMLResponse`. Проверьте сертификаты.

## Некорректный элемент `Issuer` {#invalid_issuer}

`SAMLResponse` содержит некорректный элемент `Issuer`. Подробнее об этом элементе читайте в [стандарте SAML V2.0](https://docs.oasis-open.org/security/saml/v2.0/saml-core-2.0-os.pdf#page=15).

## Параметр `SAMLResponse` не найден {#saml-response-not-found}

Не найден параметр `SAMLResponse` в ответе от IdP. Это обязательный параметр и он должен содержаться в теле HTTP ответа.

## Параметр `RelayState` не найден {#relay-state-not-found}

Не найден параметр `RelayState` в ответе от IdP. Это обязательный параметр и он должен содержаться в теле HTTP ответа.

## Федерация не поддерживается {#federations-not-supported}

Данный тип федераций больше не поддерживается, обратитесь в [службу поддержки]({{ link-console-support }}).

## Некорректный протокол SSO URL {#sso-url-incorrect-scheme}

`Sso url: isn't valid schema. The scheme must be HTTPS or HTTP`

{% list tabs %}

- Консоль управления

  В поле **{{ ui-key.yacloud_org.entity.federation.field.ssoUrl }}** указан некорректный протокол URL. Допускаются только протоколы HTTP и HTTPS.

- CLI

  В поле `sso-url` указан некорректный протокол URL. Допускаются только протоколы HTTP и HTTPS.

- API

  В поле `ssoUrl` указан некорректный протокол URL. Допускаются только протоколы HTTP и HTTPS.

- {{ TF }}

  В поле `sso_url` указан некорректный протокол URL. Допускаются только протоколы HTTP и HTTPS.

{% endlist %}

## Некорректный SSO URL {#sso-url-invalid-url}

`Sso url: isn't valid (the link to the IdP login page)`

{% list tabs %}

- Консоль управления

  В поле **{{ ui-key.yacloud_org.entity.federation.field.ssoUrl }}** указана некорректная ссылка. Проверьте ссылку.

- CLI

  В поле `sso-url` указана некорректная ссылка. Проверьте ссылку.

- API

  В поле `ssoUrl` указана некорректная ссылка. Проверьте ссылку.

- {{ TF }}

  В поле `sso_url` указана некорректная ссылка. Проверьте ссылку.

{% endlist %}

## Некорректный NameID {#invalid-name-id}

Значение NameID должно соответствовать следующему формату: `"^[a-z0-9A-Z/@_.\\-=+*\\\\]+$"`.
