# Yandex Cloud Postbox

Yandex Cloud Postbox — сервис отправки почтовых сообщений.

Cloud Postbox позволяет не тратить бюджет и время на управление сервером, настройку сети и мониторинг репутации IP-адресов. Сервис предоставляет: <ul><li>Готовую инфраструктуру, которой Яндекс пользуется для своих задач.</li> <li>Гибкую систему мониторинга и логирования с помощью интеграции с сервисами <a href="../monitoring/index.md">Yandex Monitoring</a> и <a href="../logging/index.md">Yandex Cloud Logging</a>.</li> <li>Соответствие требованиям международных и национальных стандартов.</li> <li>Упрощенную интеграцию с другими сервисами {{ yandex-cloud }} и вашими приложениями.</li></ul>

# Yandex Cloud Postbox

 - [Начало работы](quickstart.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

 - [Создание адреса](operations/create-address.md)

 - [Проверка владения доменом](operations/check-domain.md)

 - [Настройка DMARC-политики](operations/setup-dmarc.md)

 - [Отправка письма](operations/send-email.md)

 - [Шаблонизация письма](operations/send-templated-email.md)

 - [Создание конфигурации](operations/create-configuration.md)

 - [Привязка конфигурации к адресу](operations/bind-configuration.md)

 - [Ограничение списка отправителей](operations/restrict-senders.md)

 - [Запись логов](operations/logs-write.md)

 - [Просмотр информации об отправленных письмах](operations/messages.md)

## Концепции

 - [Обзор](concepts/index.md)

 - [Уведомления об операциях с письмами](concepts/notification.md)

 - [Отслеживание открытия писем](concepts/mail-opened.md)

 - [Отслеживание переходов по ссылкам в письмах](concepts/click-tracking.md)

 - [Механизм отписки от рассылок](concepts/unsubscribe.md)

 - [Термины и определения](concepts/glossary.md)

 - [Статистика](concepts/statistics.md)

 - [Ограничения на вложения в письмах](concepts/restrictions.md)

 - [Квоты и лимиты](concepts/limits.md)

## Практические руководства

 - [Все практические руководства](tutorials/index.md)

 - [Передача событий {{ postbox-full-name }} в {{ yds-full-name }} и их анализ с помощью {{ datalens-full-name }}](tutorials/events-from-postbox-to-yds.md)

 - [Создание адреса {{ postbox-full-name }} и проверка владения доменом с помощью {{ TF }}](tutorials/domain-identity-creating.md)

 - [Интеграция {{ postbox-full-name }} с внешними системами через вебхуки](tutorials/postbox-webhook.md)

### Отправка писем с помощью AWS SDK

 - [.NET Core](tutorials/send-emails-aws-sdk-csharp.md)

 - [Go](tutorials/send-emails-aws-sdk-go.md)

 - [JavaScript](tutorials/send-emails-aws-sdk-js.md)

 - [Python](tutorials/send-emails-aws-sdk-python.md)

### Интеграция с почтовыми серверами

 - [Postfix](tutorials/postfix-integration.md)

## Инструменты

 - [AWS CLI](tools/aws-cli.md)

 - [Управление доступом](security/index.md)

 - [Правила тарификации](pricing.md)

## Справочник API

 - [Аутентификация в API](api-ref/authentication.md)

 - [Как пользоваться API](aws-compatible-api/index.md)

 - [Подписывание запросов](aws-compatible-api/signing-requests.md)

### REST

 - [Все методы](aws-compatible-api/api-ref/index.md)

 - [Отправка писем](aws-compatible-api/api-ref/send-email.md)

#### Адреса

 - [Метод ListDomainIdentities](aws-compatible-api/api-ref/list-domain-identities.md)

 - [Метод GetDomainIdentity](aws-compatible-api/api-ref/get-domain-identity.md)

 - [Метод CreateDomainIdentity](aws-compatible-api/api-ref/create-domain-identity.md)

 - [Метод PutDomainIdentityDkimAttributes](aws-compatible-api/api-ref/put-domain-identity-dkim-attributes.md)

 - [Метод DeleteDomainIdentity](aws-compatible-api/api-ref/delete-domain-identity.md)

#### Конфигурации

 - [Метод ListConfigurationSets](aws-compatible-api/api-ref/list-configuration-sets.md)

 - [Метод GetConfigurationSet](aws-compatible-api/api-ref/get-configuration-sets.md)

 - [Метод CreateConfigurationSet](aws-compatible-api/api-ref/create-configuration-set.md)

 - [Метод PutDomainIdentityConfigurationSetAttributes](aws-compatible-api/api-ref/put-domain-identity-configuration-set-attributes.md)

 - [Метод DeleteConfigurationSet](aws-compatible-api/api-ref/delete-configuration-set.md)

 - [Метод PutConfigurationSetDeliveryOptions](aws-compatible-api/api-ref/put-configuration-set-delivery-options.md)

#### Подписки

 - [Метод GetConfigurationSetEventDestinations](aws-compatible-api/api-ref/get-configuration-set-event-destinations.md)

 - [Метод CreateConfigurationSetEventDestination](aws-compatible-api/api-ref/create-configuration-set-event-destinations.md)

 - [Метод UpdateConfigurationSetEventDestination](aws-compatible-api/api-ref/update-configuration-set-event-destination.md)

 - [Метод DeleteConfigurationSetEventDestination](aws-compatible-api/api-ref/delete-configuration-set-event-destination.md)

 - [Заголовки запросов](aws-compatible-api/api-ref/request-headers.md)

 - [Метрики {{ monitoring-name }}](metrics.md)

 - [Аудитные логи {{ at-name }}](at-ref.md)

 - [Публичные материалы](public-talks.md)

 - [История изменений](release-notes.md)

 - [Вопросы и ответы](qa/index.md)