---
title: Приложения в {{ org-full-name }}
description: В {{ org-name }} вы можете аутентифицировать пользователей {{ yandex-cloud }} во внешних приложениях с помощью SAML- и OIDC-приложений с использованием технологии единого входа.
---

# Приложения в {{ org-full-name }}

{% include [note-preview](../../_includes/note-preview.md) %}

Пользователи вашей [организации](./organization.md) могут аутентифицироваться во внешних приложениях с помощью [технологии единого входа](https://ru.wikipedia.org/wiki/Технология_единого_входа) (SSO). Для этого {{ org-name }} позволяет создавать _приложения_ — [ресурсы](../../overview/roles-and-resources.md#resources) {{ yandex-cloud }}, которые содержат настройки интеграции {{ org-full-name }} как _поставщика удостоверений_ (Identity Provider, IdP) с одной стороны и стороннего _поставщика услуг_ (Service Provider, SP) — с другой.

В качестве поставщика услуг могут выступать различные сервисы, поддерживающие технологию единого входа, которые могут работать как по модели [SaaS](https://ru.wikipedia.org/wiki/Программное_обеспечение_как_услуга), так и по модели [on-premise](https://en.wikipedia.org/wiki/On-premises_software). Например: [{{ yandex-360 }}](https://360.yandex.ru/), [GitHub](https://github.com/), [GitLab](https://about.gitlab.com/), [Jenkins](https://www.jenkins.io/), [Jira](https://www.atlassian.com/software/jira) и множество других.

## SAML-приложения {#saml}

В {{ org-name }} есть возможность [создавать](../operations/applications/saml-create.md) SAML-приложения, которые позволяют настроить единый вход по стандарту [SAML](https://ru.wikipedia.org/wiki/SAML) на стороне {{ org-name }}, а также предоставляют необходимые значения для настройки интеграции на стороне поставщика услуг.

Доступ к внешнему приложению разрешен только тем пользователям организации {{ yandex-cloud }}, которые явно [добавлены](../operations/applications/saml-create.md#users-and-groups) в соответствующее SAML-приложение или входят в [группы пользователей](./groups.md), явно добавленные в это SAML-приложение.

{% include [saml-app-admin-role](../../_includes/organization/saml-app-admin-role.md) %}

### Схема взаимодействия сторон по стандарту SAML {#saml-scheme}

В базовом представлении аутентификация пользователя с использованием механизма единого входа по стандарту SAML происходит по следующей схеме:

1. На странице аутентификации внешнего приложения (поставщика услуг) пользователь {{ yandex-cloud }} выбирает аутентификацию с помощью единого входа.
1. Поставщик услуг направляет SAML-запрос в {{ org-name }} (поставщик удостоверений) и перенаправляет пользователя на URL входа {{ org-name }}.
1. Пользователь аутентифицируется в {{ org-name }}, используя свои учетные данные.
1. Если в {{ org-name }} существует SAML-приложение, соответствующее данному внешнему приложению, аутентифицировавшийся пользователь [добавлен](../operations/applications/saml-create.md#users-and-groups) в это SAML-приложение, а полученный SAML-запрос корректен, то {{ org-name }} направляет поставщику услуг подписанный SAML-ответ, содержащий атрибуты пользователя.
1. Поставщик услуг проверяет корректность SAML-ответа и его подписи и в случае успеха предоставляет пользователю доступ к внешнему приложению.
1. При выходе пользователя из внешнего приложения поставщик услуг направляет SAML-запрос в {{ org-name }} и перенаправляет пользователя на URL выхода {{ org-name }}.

Обмен данными между сторонами по стандарту SAML происходит в формате [XML](https://ru.wikipedia.org/wiki/XML).

### Настройка на стороне поставщика удостоверений ({{ org-name }}) {#saml-idp-setup}

Для корректной работы интеграции на стороне {{ org-name }} необходимо [настроить](../operations/applications/saml-create.md#setup-idp) ряд параметров интеграции в SAML-приложении. Получите необходимые значения этих параметров у вашего поставщика услуг:

* `{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }}` — уникальный идентификатор поставщика услуг (Service Provider).

    Значение должно совпадать на стороне поставщика услуг и на стороне {{ org-name }}.
* `{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-acs-urls_eQcJr }}` — URL-адрес, на который {{ org-name }} будет отправлять SAML-ответ.

    ACS URL должен соответствовать схеме `https`. Использовать протокол без шифрования допускается только в целях тестирования на локальном хосте (значения `http://127.0.0.1` и `http://localhost`).

    {% include [saml-app-acs-url-paragraph](../../_includes/organization/saml-app-acs-url-paragraph.md) %}

    Вы можете указать одновременно несколько URL/индексов ACS.

    {% include [saml-app-acs-url-warn](../../_includes/organization/saml-app-acs-url-warn.md) %}

* `{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-signature-mode_ipXQ7 }}` — элементы SAML-ответа, которые будут подписываться электронной подписью:

    {% include [saml-app-sign-mode](../../_includes/organization/saml-app-sign-mode.md) %}

#### Атрибуты пользователя и групп {#saml-attributes}

Новое SAML-приложение по умолчанию создается с определенным набором относящихся к пользователю _атрибутов_, которые будут передаваться из {{ org-name }} поставщику услуг. Этот набор включает в себя:

Имя атрибута | Значение атрибута | Передаваемое значение
--- | --- | ---
`NameID` | `SubjectClaims.preferred_username` | идентификатор пользователя
`givenname` | `SubjectClaims.given_name` | полное имя пользователя
`fullname` | `SubjectClaims.name` | имя пользователя
`surname` | `SubjectClaims.family_name` | фамилия пользователя
`emailaddress` | `SubjectClaims.email` | адрес электронной почты пользователя

После создания SAML-приложения вы можете [добавлять, изменять и удалять](../operations/applications/saml-create.md#setup-attributes) следующие атрибуты пользователя:

{% include [saml-app-assertion-list](../../_includes/organization/saml-app-assertion-list.md) %}

{% include [saml-app-nameid-assertion](../../_includes/organization/saml-app-nameid-assertion.md) %}

В дополнение к указанным выше атрибутам пользователя в SAML-ответе может быть передан атрибут групп, значением которого является список [групп](./groups.md), в которые входит пользователь. Для этого атрибута вы можете задать произвольное имя и одно из значений:

{% include [saml-app-group-assertion](../../_includes/organization/saml-app-group-assertion.md) %}

{% note info %}

Если на стороне {{ org-name }} для атрибута пользователя не задано значение, в SAML-ответе такой атрибут будет отсутствовать.

{% endnote %}

### Настройка на стороне поставщика услуг (внешнее приложение) {#saml-sp-setup}

Для корректной работы интеграции на стороне поставщика услуг также необходимо настроить ряд параметров интеграции. В зависимости от возможностей вашего поставщика услуг вы можете [выполнить эти настройки](../operations/applications/saml-create.md#setup-sp) как вручную, так и автоматически, загрузив XML-файл с метаданными или указав URL с метаданными.

Ссылка на скачивание XML-файла с метаданными и URL с метаданными доступны на странице с информацией о SAML-приложении в [интерфейсе {{ cloud-center }}]({{ link-org-cloud-center }}/apps). Там же доступны значения параметров интеграции для настройки вручную:

{% include [saml-app-sp-parameter-list](../../_includes/organization/saml-app-sp-parameter-list.md) %}

Кроме того, на стороне поставщика услуг должны быть настроены и корректно обрабатываться атрибуты пользователя, настроенные на стороне {{ org-name }}.

#### Сертификат ключа проверки электронной подписи {#saml-certificate}

В дополнение к настройке указанных выше параметров в конфигурацию поставщика услуг необходимо также добавить сертификат, с помощью которого поставщик услуг сможет верифицировать электронную подпись, которой {{ org-name }} подписывает SAML-ответы.

{% include [saml-app-cert-intro-phrase](../../_includes/organization/saml-app-cert-intro-phrase.md) %}

При автоматической настройке с помощью файла или URL с метаданными устанавливать сертификат вручную не требуется: метаданные уже содержат нужный сертификат, и он устанавливается автоматически.

В любой момент вы можете [выпускать](../operations/applications/saml-update.md#update-cert) новые сертификаты ключа проверки электронной подписи для SAML-приложения и активировать их.

{% include [saml-app-cert-update-warn](../../_includes/organization/saml-app-cert-update-warn.md) %}

Дополнительно на стороне поставщика услуг необходимо указать, какие данные в SAML-ответах поставщика удостоверений будут подписываться:
* только передаваемые атрибуты пользователя;
* весь SAML-ответ целиком;
* целиком весь SAML-ответ и (отдельно) передаваемые атрибуты.

Заданный режим подписи на стороне поставщика услуг должен соответствовать режиму подписи, заданному на стороне {{ org-name }}.

#### См. также {#see-also}

* [{#T}](../operations/applications/saml-create.md)
* [{#T}](../operations/applications/saml-update.md)
* [{#T}](../operations/applications/saml-deactivate-remove.md)