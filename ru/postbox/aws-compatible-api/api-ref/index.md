---
title: Методы API Amazon для {{ postbox-full-name }}
description: Из статьи вы узнаете, какие методы API Amazon доступны для управления {{ postbox-name }}.
---

# Методы API Amazon для сервиса {{ postbox-name }}

## Отправка писем {#send-email}

#|
|| **Метод** | **Описание** ||
|| [SendEmail](send-email.md) | Отправляет электронное письмо. ||
|#

## Адреса {#domains}

#|
|| **Метод** | **Описание** ||
|| [ListDomainIdentities](list-domain-identities.md) | Возвращает список [адресов](../../concepts/glossary.md#adress). ||
|| [GetDomainIdentity](get-domain-identity.md) | Возвращает информацию об адресе. ||
|| [CreateDomainIdentity](create-domain-identity.md) | Создает адрес. ||
|| [PutDomainIdentityDkimAttributes](put-domain-identity-dkim-attributes.md) | Включает или отключает [DKIM-подпись](https://ru.wikipedia.org/wiki/DomainKeys_Identified_Mail). Позволяет получателю убедиться, что письмо действительно было отправлено с заявленного домена. ||
|| [DeleteDomainIdentity](delete-domain-identity.md) | Удаляет адрес. ||
|#

## Конфигурации {#configuration-sets}

#|
|| **Метод** | **Описание** ||
|| [ListConfigurationSets](list-configuration-sets.md) | Возвращает список [конфигураций](../../concepts/glossary.md#configuration). ||
|| [GetConfigurationSet](get-configuration-sets.md) | Возвращает информацию о конфигурации. ||
|| [CreateConfigurationSet](create-configuration-set.md) | Создает конфигурацию. ||
|| [PutDomainIdentityConfigurationSetAttributes](put-domain-identity-configuration-set-attributes.md) | Связывает адрес и конфигурацию. ||
|| [DeleteConfigurationSet](delete-configuration-set.md) | Удаляет конфигурацию. ||
|#

## Подписки {#event-destinations}

#|
|| **Метод** | **Описание** ||
|| [GetConfigurationSetEventDestinations](get-configuration-set-event-destinations.md) | Возвращает информацию о [подписках](../../concepts/glossary.md#subscription) для конфигурации. ||
|| [CreateConfigurationSetEventDestination](create-configuration-set-event-destinations.md) | Создает подписку. ||
|| [UpdateConfigurationSetEventDestination](update-configuration-set-event-destination.md) | Обновляет подписку. ||
|| [DeleteConfigurationSetEventDestination](delete-configuration-set-event-destination.md) | Удаляет подписку. ||
|#
