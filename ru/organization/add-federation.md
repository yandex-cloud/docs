# Настроить федерацию удостоверений

Если в вашей компании есть система управления пользователями и доступом (например, Active Directory или Google Workspace), вы можете использовать ее для авторизации сотрудников в {{org-full-name}}. Тогда не нужно будет создавать новый аккаунт в Яндексе для каждого сотрудника компании, сотрудники смогут получить доступ к сервисам {{yandex-cloud}} с помощью своих корпоративных аккаунтов.

{% note warning %}

Сервис {{org-full-name}} находится на стадии [Preview](../overview/concepts/launch-stages.md), управление сервисами организации недоступно.

{% endnote %}

Федерация удостоверений — это технология, которая позволяет реализовать систему единого входа (Single Sign-On, SSO) и использовать корпоративные аккаунты для авторизации в {{org-name}}. В этом случае ваша корпоративная система управления учетными записями пользователей выступает в роли поставщика удостоверений (IdP — identity provider).

В {{org-name}} можно создать федерацию удостоверений с любым сервисом управления учетными данными (поставщиком удостоверений), который поддерживает протокол [SAML]({{link-saml}}).

Информация о логинах и паролях пользователей хранится у поставщика удостоверений. При входе в {{org-name}} система направляет пользователя для аутентификации на сервер поставщика удостоверений (IdP). В случае успешной аутентификации пользователь получает доступ к сервисам {{yandex-cloud}}.

## Создать федерацию {#create}

1. [Войдите в аккаунт]({{link-passport}}) администратора организации.

1. Перейдите в сервис [{{org-full-name}}]({{link-org-main}}).

1. На левой панели выберите раздел [Федерации]({{link-org-federations}}) ![icon-federation](../_assets/organization/icon-federation.png).

1. Нажмите кнопку **Создать федерацию**.

1. Введите название и описание федерации.

1. В поле **Время жизни cookie** укажите время, в течении которого браузер не должен требовать у пользователя повторной аутентификации.

1. В поле **IdP Issuer** укажите идентификатор IdP-сервера, на котором будет происходить аутентификация пользователя. Этот же идентификатор IdP-сервер должен указывать в ответе сервису {{org-name}} во время аутентификации пользователя.

    {% note info %}

    Формат идентификатора зависит от типа IdP-сервера, который вы используете (например, Active Directory или Google Workspace).

    {% endnote %}

1. В поле **SSO метод** выберите **POST**.

1. В поле **Ссылка на страницу для входа в IdP** укажите адрес страницы, на которую браузер должен перенаправить пользователя для аутентификации.

1. Добавьте для созданной федерации [сертификат поставщика удостоверений](#add-cert).

1. Включите опцию **Автоматически создавать пользователей**, чтобы аутентифицированный пользователь автоматически добавлялся в организацию.
   
   Если вы не включите эту опцию, федеративных пользователей потребуется [добавить вручную](add-account.md#add-user-sso).

1. Настройте сервер поставщика удостоверений, чтобы он передавал в {{yandex-cloud}} информацию об успешной аутентификации и атрибуты пользователя.

   Атрибуты пользователей, которые поддерживают сервисы {{org-full-name}}, перечислены в разделе [{#T}](#claims-mapping).

Подробные инструкции о том, как настроить федерацию удостоверений для разных поставщиков удостоверений, можно найти в документации сервиса [Yandex Identity and Access Management](../iam/index.yaml):

* [Active Directory](../iam/operations/federations/integration-adfs.md).
* [Google Workspace](../iam/operations/federations/integration-gsuite.md).
* [Другие SAML-совместимые поставщики удостоверений](../iam/operations/federations/integration-common.md).

## Добавить сертификат {#add-cert}

Когда поставщик удостоверений (IdP) сообщает {{org-full-name}}, что пользователь прошел аутентификацию, он подписывает сообщение своим сертификатом. Чтобы сервис {{org-name}} мог проверить этот сертификат, добавьте его в созданную федерацию.

1. Получите сертификат вашего поставщика удостоверений.

    {% note info %}

    Чтобы узнать, как получить сертификат, обратитесь к документации или в службу поддержки сервиса, который вы используете в качестве поставщика удостоверений.

    {% endnote %}

1. Перейдите в сервис [{{org-full-name}}]({{link-org-main}}).
1. На левой панели выберите раздел [Настройки]({{link-org-settings}}) ![icon-settings](../_assets/organization/icon-settings.png).
1. Нажмите имя федерации, для которой нужно добавить сертификат.
1. Внизу страницы нажмите на кнопку **Добавить сертификат**.
1. Введите название и описание сертификата.
1. Выберите способ добавления сертификата:
    * Чтобы добавить сертификат в виде файла, нажмите **Выбрать файл** и укажите путь к нему.
    * Чтобы вставить скопированное содержимое сертификата, выберите способ **Текст** и вставьте содержимое.
1. Нажмите кнопку **Добавить**.

{% note tip %}

Сертификаты имеют ограниченные сроки действия. Перед окончанием срока действия текущего сертификата рекомендуем добавить новый сертификат.

{% endnote %}

## Настроить сопоставление атрибутов пользователей {#claims-mapping}

После аутентификации пользователя сервер поставщика удостоверений отправляет в {{yandex-cloud}} [SAML-сообщение](#saml-message), которое содержит информацию об успешной аутентификации и атрибуты пользователя, такие как идентификатор, имя, адрес электронной почты и так далее.

Чтобы корректно передавать в сервис {{org-full-name}} информацию о пользователе, настройте сопоставление между атрибутами SAML-сообщения и персональными данными пользователя, которые хранятся на сервере поставщика удостоверений. 

Типы персональных данных, которые поддерживает {{org-full-name}}, и примеры сопоставления атрибутов для сервера AD FS и Google Workspace приведены ниже.

#### Сопоставление атрибутов на сервере AD FS {#adfs}

На сервере AD FS настройте правила для сопоставления LDAP-атрибутов пользователя и утверждений SAML (Outgoing Claim Type). Пример настройки сервера AD FS приведен в [документации сервиса Yandex Identity and Access Management](../iam/operations/federations/integration-adfs.md).

Данные пользователя | Комментарий | Outgoing Claim Type
------------------- | ----------- | -------------------
Уникальный идентификатор пользователя | Обязательный атрибут. Рекомендуется использовать User Principal Name (UPN) или адрес электронной почты. | Name Identifier 
Фамилия | Отображается в сервисах {{yandex-cloud}}. | Surname
Имя | Отображается в сервисах {{yandex-cloud}}. | Given Name
Полное имя | Отображается в сервисах {{yandex-cloud}}.<br>Пример: Иван Иванов | Name
Почта | Используется для отправки уведомлений из сервисов {{yandex-cloud}}.<br>Пример:&nbsp;`ivanov@example.com` | E-Mail Address
Телефон | Используется для отправки уведомлений из сервисов {{yandex-cloud}}.<br>Пример: +71234567890 | Добавьте новый атрибут с идентификатором<br>`http://schemas.xmlsoap.org/ws/2005/05/identity/claims/mobilephone`.<br>См. [документацию AD FS]({{ link-adfs-add-claim }})
Аватар | Отображается в сервисах {{yandex-cloud}}.<br>Изображение передается в кодировке Base64. [Пример](#avatar-example) | Добавьте новый атрибут с идентификатором `thumbnailPhoto`.<br>См. [документацию AD FS]({{ link-adfs-add-claim }})

>Пример сопоставления атрибутов:
>
>![image](../_assets/iam/federations/specify-claims-mapping-ad.png)

{% endcut %}

#### Сопоставление атрибутов в Google Workspace {#google}

В Google Workspace настройте SAML-приложение и задайте сопоставление атрибутов SAML. Пример настройки SAML-приложения приведен в [документации сервиса Yandex Identity and Access Management](../iam/operations/federations/integration-gsuite.md).

Данные пользователя | Комментарий | Атрибуты приложений
------------------- | ----------- | -------------------
Уникальный идентификатор пользователя | Обязательный атрибут. Рекомендуется использовать адрес электронной почты. | Поле **Идентификатор названия** в настройках поставщика услуг
Фамилия | Отображается в сервисах {{yandex-cloud}}. | `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname`
Имя | Отображается в сервисах {{yandex-cloud}}. | `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname`
Полное имя | Отображается в сервисах {{yandex-cloud}}.<br>Пример: Иван Иванов | Атрибут недоступен
Почта | Используется для отправки уведомлений из сервисов {{yandex-cloud}}.<br>Пример:&nbsp;`ivanov@example.com` | `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress`
Телефон | Используется для отправки уведомлений из сервисов {{yandex-cloud}}.<br>Пример: +71234567890 | `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/mobilephone`
Аватар | Отображается в сервисах {{yandex-cloud}}. | Атрибут недоступен

>Пример сопоставления атрибутов:
>
>![image](../_assets/organization/google-saml-mapping.png)

{% endcut %}

#### Сопоставление атрибутов в других SAML-совместимых поставщиках удостоверений {#saml-message}

Настройте сервер поставщика удостоверений, чтобы после успешной аутентификации сервер отправлял в {{yandex-cloud}} SAML-сообщение. Пример SAML-сообщения приведен в [документации сервиса Yandex Identity and Access Management](../iam/operations/federations/integration-common.md#configure-sso).

Данные пользователя | Комментарий | Элементы SAML-сообщения
------------------- | ----------- | ----------------------
Уникальный идентификатор пользователя | Обязательный атрибут. Рекомендуется использовать User Principal Name (UPN) или адрес электронной почты. | `<NameID>`
Фамилия | Отображается в сервисах {{yandex-cloud}}. | `<Attribute>`  с параметром<br>`Name="http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname"`
Имя | Отображается в сервисах {{yandex-cloud}}. | `<Attribute>`  с параметром<br>`Name="http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname"`
Полное имя | Отображается в сервисах {{yandex-cloud}}.<br>Пример: Иван Иванов | `<Attribute>`  с параметром<br>`Name="http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"`
Почта | Используется для отправки уведомлений из сервисов {{yandex-cloud}}.<br>Пример:&nbsp;`ivanov@example.com` | `<Attribute>`  с параметром<br>`Name="http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"`
Телефон | Используется для отправки уведомлений из сервисов {{yandex-cloud}}.<br>Пример: +71234567890 | `<Attribute>`  с параметром<br>`Name="http://schemas.xmlsoap.org/ws/2005/05/identity/claims/mobilephone"`
Аватар | Отображается в сервисах {{yandex-cloud}}.<br>Изображение передается в кодировке Base64. [Пример](#avatar-example) | `<Attribute>`  с параметром<br>`Name="thumbnailPhoto"`

#### Пример изображения в кодировке Base64 {#avatar-example}

Изображение для аватара передается в текстовом виде в кодировке [Base64]({{link-base64}}).

{% cut "Пример закодированного изображения" %}

```
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
UYGmIgo9HwAAAABJRU5ErkJggg==
```

{% endcut %}