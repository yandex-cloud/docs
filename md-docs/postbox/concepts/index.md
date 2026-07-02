[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Postbox](../index.md) > Концепции > Обзор

# Обзор сервиса Yandex Cloud Postbox

Yandex Cloud Postbox — это сервис электронной почты, который предоставляет простой и экономичный способ отправки писем с пользовательских [адресов](glossary.md#adress) и позволяет гибко настроить [уведомления](notification.md) о доставке писем.

Yandex Cloud Postbox ориентирован на отправку транзакционных писем, уведомлений, информационных и маркетинговых рассылок и других типов корреспонденции. Предусмотрена возможность отписки от электронной рассылки, а также пересылки писем, на которые ответили пользователи.

Вы можете разрабатывать собственные программные решения. Например: генерировать тикеты поддержки клиентов из входящих писем, строить [интеграции](#integration) с облачными и своими информационными системами. 

## Интеграция с другими продуктами {#integration}

Объединяя Yandex Cloud Postbox с другими сервисами и технологиями, вы можете:

* Гибко [разграничивать](../security/index.md) полномочия сотрудников, используя возможности [Yandex Identity and Access Management](../../iam/index.md).
* Реализовать отправку электронной почты из любых своих приложений.
* Осуществлять рассылку с помощью [AWS CLI](../tools/aws-cli.md) или вызовов [API](../aws-compatible-api/api-ref/index.md).
* Отправлять электронную почту с помощью протокола [SMTP](https://ru.wikipedia.org/wiki/SMTP).
* Собирать [статистику](../operations/logs-write.md) уведомлений о приеме письма сервисом, о доставленных и недоставленных письмах.
* Настраивать аутентификацию писем с помощью [DKIM](https://ru.wikipedia.org/wiki/DomainKeys_Identified_Mail).
* Создавать сервисные записи DNS в [Yandex Cloud DNS](../../dns/index.md) или у своего интернет-провайдера.
* Автоматически реагировать на определенные письма, используя [Yandex Cloud Functions](../../functions/index.md).
* [Публиковать](../tutorials/events-from-postbox-to-yds.md) события отправки писем в поток [Yandex Data Streams](../../data-streams/index.md) и анализировать их с помощью [Yandex DataLens](../../datalens/index.md).

## Примеры использования {#examples}

* [Передача событий Yandex Cloud Postbox в Yandex Data Streams и их анализ с помощью Yandex DataLens](../tutorials/events-from-postbox-to-yds.md)

#### Полезные ссылки {#see-also}

* [Как начать работать с Yandex Cloud Postbox](../quickstart.md)
* [Правила тарификации для Yandex Cloud Postbox](../pricing.md)