---
title: OIDC-приложения в {{ org-full-name }}
description: В {{ org-full-name }} вы можете аутентифицировать пользователей {{ yandex-cloud }} во внешних приложениях с помощью OIDC-приложений с использованием технологии единого входа OpenID Connect.
---

# OIDC-приложения


В {{ org-full-name }} вы можете [создавать](../../operations/applications/oidc-create.md) OIDC-приложения, которые позволяют настроить единый вход по стандарту OpenID Connect (OIDC) на стороне {{ org-full-name }}, а также предоставляют необходимые значения для настройки интеграции на стороне поставщика услуг.

Доступ к внешнему приложению разрешен только тем пользователям организации {{ yandex-cloud }}, которые явно [добавлены](../../operations/applications/oidc-create.md#users-and-groups) в соответствующее OIDC-приложение или входят в [группы пользователей](../groups.md), явно добавленные в это OIDC-приложение.

{% include [auth-policy-applications-tip](../../../_includes/organization/auth-policy-applications-tip.md) %}

{% include [oidc-app-admin-role](../../../_includes/organization/oidc-app-admin-role.md) %}

Необходимым компонентом OIDC-приложения является OAuth-клиент, который создается в указанном пользователем [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) и неразрывно связан с OIDC-приложением. OAuth-клиент создается и удаляется автоматически — соответственно при создании и удалении OIDC-приложения.

## Схема взаимодействия сторон по стандарту OIDC {#oidc-scheme}

Обмен данными между сторонами по стандарту OIDC происходит в формате [JSON](https://ru.wikipedia.org/wiki/JSON).

В базовом представлении аутентификация пользователя с использованием механизма единого входа по стандарту OpenID Connect происходит по следующей схеме:

{% include [OIDC authentication diagram](../../../_mermaid/other/identity-hub/oidc-authentication.md) %}

1. На странице аутентификации внешнего приложения (поставщика услуг) пользователь {{ yandex-cloud }} выбирает аутентификацию с помощью единого входа.
1. Поставщик услуг направляет запрос аутентификации в {{ org-full-name }} (поставщик удостоверений) и перенаправляет пользователя на URL входа {{ org-full-name }}, указанный в поле `{{ ui-key.yacloud_org.application.overview.oauth_field_auth_endpoint }}`.
1. Пользователь аутентифицируется в {{ org-full-name }}, используя свои учетные данные.
1. Если в {{ org-full-name }} существует OIDC-приложение, соответствующее данному внешнему приложению, аутентифицировавшийся пользователь добавлен в это OIDC-приложение, а полученный запрос аутентификации корректен, то {{ org-full-name }} направляет поставщику услуг код авторизации и перенаправляет пользователя обратно во внешнее приложение.
1. По адресу, заданному в поле `{{ ui-key.yacloud_org.application.overview.oauth_field_token_endpoint }}`, поставщик услуг запрашивает в {{ org-full-name }} [ID-токен](../../../iam/concepts/authorization/id-token.md) и токен доступа. В запросе указывается [секрет приложения](#oidc-secret), по которому {{ org-full-name }} проверяет подлинность запроса.
1. Если переданный поставщиком услуг секрет действителен, {{ org-full-name }} направляет поставщику услуг ID-токен и токен доступа.
1. Поставщик услуг проверяет переданный ID-токен с помощью публичного ключа, [получив](https://{{ auth-main-host }}/oauth/jwks/keys) его в {{ yandex-cloud }} по идентификатору, указанному в поле `kid` заголовка ID-токена. В случае успеха поставщик услуг предоставляет пользователю доступ к внешнему приложению.

{% note info %}

На схеме представлено взаимодействие сторон при использовании OIDC-приложения типа [{{ ui-key.yacloud_org.organization.apps.web-title_aeKTZ }}](#oidc-web). При использовании приложений типов [{{ ui-key.yacloud_org.organization.apps.spa-title_1mhon }}](#oidc-single-page) и [{{ ui-key.yacloud_org.organization.apps.native-title_1VrmN }}](#oidc-native) из процесса взаимодействия исключаются запрос секрета приложения и его проверка.

{% endnote %}

## Типы OIDC-приложений в {{ org-full-name }} {#oidc-application-types}

OIDC-приложения в {{ org-full-name }} в зависимости от предустановленных настроек могут относиться к одному из следующих типов:

* [{{ ui-key.yacloud_org.organization.apps.web-title_aeKTZ }}](#oidc-web);
* [{{ ui-key.yacloud_org.organization.apps.spa-title_1mhon }}](#oidc-single-page);
* [{{ ui-key.yacloud_org.organization.apps.native-title_1VrmN }}](#oidc-native).

Тип приложения выбирается при его создании, изменить выбранный тип после создания приложения нельзя.

{% include [oidc-app-types-ui-notice](../../../_includes/organization/oidc-app-types-ui-notice.md) %}

### Приложения {{ ui-key.yacloud_org.organization.apps.web-title_aeKTZ }} {#oidc-web}

OIDC-приложения типа `{{ ui-key.yacloud_org.organization.apps.web-title_aeKTZ }}` оптимально подходят для аутентификации пользователей во внешних веб-приложениях, имеющих серверную часть (бэкенд), в которой может безопасно храниться [секрет приложения](#oidc-secret).

Приложения `{{ ui-key.yacloud_org.organization.apps.web-title_aeKTZ }}` поддерживают использование секрета приложения: в зависимости от заданных настроек секрет может [передаваться](#secret-delivery) в HTTP-заголовке `Authorization: Basic` и/или в теле POST-запроса. По умолчанию в приложениях включена возможность передачи секрета всеми доступными способами.

Приложения `{{ ui-key.yacloud_org.organization.apps.web-title_aeKTZ }}` по умолчанию требуют от поставщиков услуг применять расширение безопасности [PKCE](#pkce), при этом в настройках приложения можно отключить это требование.

[Redirect URI](#oidc-redirect-uri) приложений `{{ ui-key.yacloud_org.organization.apps.web-title_aeKTZ }}` должен соответствовать схеме `https`. Использовать протокол без шифрования допускается только в целях тестирования на локальном хосте (значения `http://127.0.0.1` и `http://localhost`).

### Приложения {{ ui-key.yacloud_org.organization.apps.spa-title_1mhon }} {#oidc-single-page}

OIDC-приложения типа `{{ ui-key.yacloud_org.organization.apps.spa-title_1mhon }}` оптимально подходят для аутентификации пользователей во внешних приложениях, построенных по технологии [SPA](https://ru.wikipedia.org/wiki/Одностраничное_приложение). Как правило, SPA-приложения — это приложения, построенные на [JavaScript](https://ru.wikipedia.org/wiki/JavaScript)- или [TypeScript](https://www.typescriptlang.org/)-фреймворках ([React](https://react.dev/), [Vue](https://vuejs.org/), [Angular](https://angular.dev/) и т.п.) и работающие в браузере.

Приложения `{{ ui-key.yacloud_org.organization.apps.spa-title_1mhon }}` не поддерживают использование секрета приложения.

Приложения `{{ ui-key.yacloud_org.organization.apps.spa-title_1mhon }}` требуют от поставщиков услуг применять расширение безопасности [PKCE](#pkce), и отключить это требование в настройках приложения нельзя.

[Redirect URI](#oidc-redirect-uri) приложений `{{ ui-key.yacloud_org.organization.apps.spa-title_1mhon }}` должен соответствовать схеме `https`. Использовать протокол без шифрования допускается только в целях тестирования на локальном хосте (значения `http://127.0.0.1` и `http://localhost`).

### Приложения {{ ui-key.yacloud_org.organization.apps.native-title_1VrmN }} {#oidc-native}

OIDC-приложения типа `{{ ui-key.yacloud_org.organization.apps.native-title_1VrmN }}` оптимально подходят для аутентификации пользователей во внешних мобильных или настольных приложениях, установленных на устройствах пользователей.

Приложения `{{ ui-key.yacloud_org.organization.apps.native-title_1VrmN }}` не поддерживают использование секрета приложения.

Приложения `{{ ui-key.yacloud_org.organization.apps.native-title_1VrmN }}` требуют от поставщиков услуг применять расширение безопасности [PKCE](#pkce), и отключить это требование в настройках приложения нельзя.

В [Redirect URI](#oidc-redirect-uri) приложений `{{ ui-key.yacloud_org.organization.apps.native-title_1VrmN }}` допускаются любые корректные схемы URI.

## Секрет OIDC-приложения {#oidc-secret}

_Секрет приложения_ генерируется пользователем на стороне OIDC-приложения в {{ org-full-name }} и представляет собой случайную строку определенной длины, начинающуюся с префикса `yccs__`.

Секрет может использоваться только в приложениях типа [{{ ui-key.yacloud_org.organization.apps.web-title_aeKTZ }}](#oidc-web). В приложениях типов [{{ ui-key.yacloud_org.organization.apps.spa-title_1mhon }}](#oidc-single-page) и [{{ ui-key.yacloud_org.organization.apps.native-title_1VrmN }}](#oidc-native) секрет приложения не используется.

Секрет приложения должен быть указан в настройках интеграции на стороне поставщика услуг и будет использоваться для проверки подлинности поступающих от поставщика услуг запросов.

Срок жизни секрета OIDC-приложения не ограничен. При этом вы в любой момент можете [сгенерировать](../../operations/applications/oidc-update.md#update-secret) в приложении любое количество новых секретов, а также удалить их.

{% note warning %}

После удаления секрета в OIDC-приложении не забудьте указать новый секрет в настройках интеграции на стороне поставщика услуг.

{% endnote %}

Секреты OIDC-приложений не сохраняются на стороне {{ yandex-cloud }} и отображаются пользователю только в момент создания. После обновления или закрытия страницы браузера, на которой был сгенерирован секрет, содержимое секрета становится недоступно.

### Способы передачи секрета приложения {#secret-delivery}

В процессе аутентификации пользователя передача секрета приложения от поставщика услуг поставщику удостоверений может осуществляться следующими способами:

* `{{ ui-key.yacloud_org.application.overview.oauth_field_auth_method_client_secret_basic }}` — секрет приложения передается в HTTP-заголовке `Authorization: Basic`;
* `{{ ui-key.yacloud_org.application.overview.oauth_field_auth_method_client_secret_post }}` — секрет приложения передается в теле POST-запроса.

В приложениях типа `{{ ui-key.yacloud_org.organization.apps.web-title_aeKTZ }}` вы можете выбрать один или одновременно оба способа передачи секрета.

В приложениях `{{ ui-key.yacloud_org.organization.apps.spa-title_1mhon }}` и `{{ ui-key.yacloud_org.organization.apps.native-title_1VrmN }}` секрет не используется, и настроить способ передачи секрета нельзя.

## PKCE {#pkce}

[PKCE](https://www.rfc-editor.org/info/rfc7636/) (_Proof Key for Code Exchange_) — это расширение безопасности, применяемое в стандарте [OAuth 2.0](https://www.rfc-editor.org/info/rfc6749/) с целью минимизировать риски перехвата аутентификационных данных.

По умолчанию OIDC-приложения всех [типов](#oidc-web) требуют от поставщика услуг использовать расширение PKCE (передавать `code_challenge` при запросе авторизации и `code_verifier` при обмене кода на токены). При этом для приложений [{{ ui-key.yacloud_org.organization.apps.web-title_aeKTZ }}](#oidc-web) вы можете отключить это требование. Для приложений [{{ ui-key.yacloud_org.organization.apps.spa-title_1mhon }}](#oidc-single-page) и [{{ ui-key.yacloud_org.organization.apps.native-title_1VrmN }}](#oidc-native) отключить требование использования PKCE нельзя.

## Настройка на стороне поставщика удостоверений ({{ org-full-name }}) {#oidc-idp-setup}

Для корректной работы интеграции на стороне {{ org-full-name }} в OIDC-приложении необходимо [указать](../../operations/applications/oidc-create.md#setup-idp) адрес (адреса) [Redirect URI](#oidc-redirect-uri), выбрать [набор атрибутов](#oidc-user-attributes) пользователя, которые будут передаваться поставщику услуг, а также сгенерировать [секрет приложения](#oidc-secret). Прежде чем настраивать OIDC-приложение на стороне {{ org-full-name }}, получите адрес (адреса) Redirect URI у вашего поставщика услуг.

### Redirect URI {#oidc-redirect-uri}

_Redirect URI_ — адрес на стороне внешнего приложения, куда пользователь будет перенаправляться в результате успешного прохождения аутентификации в {{ org-full-name }}.

Для работы с приложениями типов [{{ ui-key.yacloud_org.organization.apps.web-title_aeKTZ }}](#oidc-web) и [{{ ui-key.yacloud_org.organization.apps.spa-title_1mhon }}](#oidc-single-page) Redirect URI должен соответствовать схеме `https`. Использовать протокол без шифрования в приложениях этих типов допускается только в целях тестирования на локальном хосте (значения `http://127.0.0.1` и `http://localhost`).

Для работы с приложениями типа [{{ ui-key.yacloud_org.organization.apps.native-title_1VrmN }}](#oidc-native) в Redirect URI допускаются любые корректные схемы URI.

В OIDC-приложениях вы можете задать одновременно несколько адресов Redirect URI.

### Атрибуты пользователя {#oidc-attributes}

В настройках OIDC-приложения вы можете задать состав атрибутов пользователя, которые определяются выбранными в поле **{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.field-scopes_hEuar }}** значениями и будут передаваться поставщику услуг в ID-токене:

{% include [oidc-app-attribute-scopes](../../../_includes/organization/oidc-app-attribute-scopes.md) %}

В новом OIDC-приложении по умолчанию выбраны все атрибуты, за исключением `groups`.

## Настройка на стороне поставщика услуг (внешнее приложение) {#oidc-sp-setup}

Для корректной работы интеграции на стороне поставщика услуг также необходимо настроить ряд параметров интеграции. В зависимости от возможностей вашего поставщика услуг вы можете [выполнить эти настройки](../../operations/applications/oidc-create.md#setup-sp) как вручную, так и автоматически, указав URL с конфигурацией.

URL с конфигурацией предоставляет поставщику услуг значения всех необходимых для настройки интеграции параметров и доступен в поле **{{ ui-key.yacloud_org.application.overview.oauth_field_open_id }}** в блоке **{{ ui-key.yacloud_org.application.overview.oauth_service_section_title }}** на странице с информацией об OIDC-приложении в [интерфейсе {{ cloud-center }}]({{ link-org-cloud-center }}/apps). На этой же странице доступны значения параметров интеграции для настройки вручную:

{% include [oidc-app-sp-parameter-list](../../../_includes/organization/oidc-app-sp-parameter-list.md) %}

В дополнение к указанным выше параметрам при настройке интеграции с приложениями типа [{{ ui-key.yacloud_org.organization.apps.web-title_aeKTZ }}](#oidc-web) на стороне поставщика услуг также необходимо указать [секрет приложения](#oidc-secret).

#### Полезные ссылки {#see-also}

* [{#T}](../../operations/applications/oidc-create.md)
* [{#T}](../../operations/applications/oidc-update.md)
* [{#T}](../../operations/applications/oidc-deactivate-remove.md)
* [{#T}](../../../security/domains/iam-checklist.md)
* [{#T}](./saml.md)
