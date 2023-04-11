# Диагностика ошибок в федерациях, работающих по протоколу SAML 2.0

## Ошибка при создании нового пользователя {#automatic-user-creation}

Новый пользователь попытался присоединиться к федерации с отключенной опцией автоматического создания пользователей. [Добавьте пользователя вручную](add-account.md#add-user-sso) или включите опцию **Автоматически создавать пользователей** в настройках федерации.

## Не зашифрованы утверждения в SAMLResponse {#response-not-encrypted}

В федерации включена опция **Подписывать запросы аутентификации**. При включении этой опции требуется обязательное шифрование утверждений в `SAMLResponse`.

## Полученный XML не является SAMLResponse {#not-saml2-response}

Полученный ответ от сервера IdP - корректный XML, но не является корректным `SAMLResponse`. Подробнее про требования к `SAMLResponse` читайте в [стандарте SAML V2.0](https://docs.oasis-open.org/security/saml/v2.0/saml-core-2.0-os.pdf#page=46).

## SAMLResponse является некорректным XML {#invalid-xml-response}

Произошла ошибка распознавания XML. Данные `SAMLResponse` неполны или были искажены.

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

## Утверждения содержит некорректный элемент `subject` {#username-not-found}

`SAMLResponse` содержит элемент `subject`, но в элементе отсутствует поле `NameID` или `EncryptedID`.

## Ошибка дешифрования {#decryption}

Не удалось расшифровать утверждение или идентификатор имени в `SAMLResponse`. Проверьте сертификаты.

## Некорректный элемент `Issuer` {#invalid_issuer}

`SAMLResponse` содержит некорректный элемент `Issuer`. Подробнее об этом элементе читайте в [стандарте SAML V2.0](https://docs.oasis-open.org/security/saml/v2.0/saml-core-2.0-os.pdf#page=15).

## Параметр `SAMLResponse` не найден {#saml-response-not-found}

Не найден параметр `SAMLResponse` в ответе от IdP. Это обязательный параметр и он должен содержаться в теле HTTP ответа.

## Параметр `RelayState` не найден {#relay-state-not-found}

Не найден параметр `RelayState` в ответе от IdP. Это обязательный параметр и он должен содержаться в теле HTTP ответа.

## Федерация не поддерживаются {#federations-not-supported}

Данный тип федераций больше не поддерживается, обратитесь в [службу поддержки]({{ link-console-support }}).
