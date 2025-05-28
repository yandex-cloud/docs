# Как начать работать с {{ speechsense-full-name }}

Сервис {{ speechsense-full-name }} позволяет анализировать каналы коммуникации вашего бизнеса на основе записей разговоров или текстовых сообщений из чатов и интегрируется с вашими АТС и CRM-системами. {{ speechsense-name }} использует голосовые технологии {{ speechkit-full-name }} для расшифровки и статистического и качественного анализа аудиозаписей диалогов.

{{ speechsense-name }} поддерживает анализ аудиозаписей и текстовых диалогов на русском и казахском языках.

Вы можете загрузить в {{ speechsense-name }} свои данные или воспользоваться [демонстрационным примером](https://storage.yandexcloud.net/doc-files/speechsense-demo-dialog.wav), который был синтезирован с помощью {{ speechkit-name }}.

## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы. О том, как начать работать с {{ yandex-cloud }}, см. в документе [Начало работы с {{ yandex-cloud }}](../getting-started/).
1. Примите пользовательское соглашение.
1. В сервисе [{{ billing-name }}]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md) и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md#create_billing_account).
1. [Назначьте](../iam/operations/roles/grant.md) вашему аккаунту в {{ yandex-cloud }} роль `speech-sense.spaces.creator`.

    {% include [note-managing-roles](../_includes/mdb/note-managing-roles.md) %}

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Выберите организацию, в которой вы будете работать со {{ speechsense-name }}, или [создайте](../organization/operations/enable-org.md) новую.

## Настройте окружение {#set-space}

1. Создайте [пространство](concepts/resources-hierarchy.md#space), в котором будут находиться все ваши [проекты](concepts/resources-hierarchy.md#project): выберите **{{ ui-key.yc-ui-talkanalytics.spaces.create-space }}**, введите название, (опционально) добавьте описание и нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.common.create }}**.
1. К пространству [привяжите платежный аккаунт](operations/space/link-ba.md), с которого будет оплачиваться использование {{ speechsense-name }}.

   {% note tip %}

   Управлять платежным аккаунтом могут только пользователи с [аккаунтом на Яндексе](../iam/concepts/users/accounts.md#passport). Если вы работаете с {{ yandex-cloud }} через [федерацию удостоверений](../organization/concepts/add-federation.md), [обратитесь]({{ link-console-support }}) в техническую поддержку.

   {% endnote %}

1. Перейдите на вкладку **{{ ui-key.yc-ui-talkanalytics.connections.connections }}** и создайте [подключение](concepts/resources-hierarchy.md#connection) на основе метаинформации ваших аудиозаписей или переписок из чатов:

   1. Введите **{{ ui-key.yc-ui-talkanalytics.connections.connection-name }}**.
   1. Выберите тип данных **{{ ui-key.yc-ui-talkanalytics.connections.type.two-channel-key-value }}**, **{{ ui-key.yc-ui-talkanalytics.connections.type.one-channel-key-value }}** или **{{ ui-key.yc-ui-talkanalytics.connections.type.chat-key-value }}**.
   1. Задайте параметры подключения. Процесс подробно рассмотрен в разделе [Создать подключение](operations/connection/create.md).
   1. Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.connections.create-connection-key-value }}**.

   {% cut "Пример metadata.json для загрузки аудиоданных" %}

   {% include [data-format](../_includes/speechsense/data/data-format.md) %}

   ```json
   {
      "direction_outgoung": "true",
      "client_id": "456",
      "client_name": "Павел Иванов",
      "date": "2023-09-29T09:08:38.958Z",
      "date_to": "2023-09-29T09:15:07.897Z",
      "language": "RU",
      "operator_id": "123",
      "operator_name": "Мария Федорова"
   }
   ```

   {% endcut %}

1. Создайте проект: на странице пространства нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.projects.create-project }}**, введите имя проекта, добавьте в проект подключение. Для каждого подключения вы можете выбрать правила фильтрации на основе метаинформации подключения и критериев [{{ gpt-pro }}](../foundation-models/concepts/yandexgpt/index.md). Фильтры будут добавлять в проект только нужные диалоги. После добавления всех нужных подключений и настройки фильтров нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.projects.create-project }}**.

## Загрузите данные {#upload-data}

Для загрузки данных в {{ speechsense-name }} используется [gRPC API](api-ref/grpc/index.md).

Чтобы загрузить данные:

1. [Создайте сервисный аккаунт](../iam/operations/sa/create.md).
1. [Добавьте сервисный аккаунт в пространство](operations/space/add-user-to-space.md) с ролью `speech-sense.data.editor`. Подробнее о ролях, действующих в сервисе, см. раздел [{#T}](security/index.md).
1. [Создайте API-ключ](../iam/operations/authentication/manage-api-keys.md#create-api-key) или [IAM-токен](../iam/operations/iam-token/create-for-sa.md) для сервисного аккаунта, чтобы аутентифицироваться в API. [Подробнее об аутентификации в API {{ speechsense-name }}](api-ref/authentication.md).
1. Загрузите аудиоданные ([без разбиения](operations/data/upload-data.md) или [с разбиением на отрезки](operations/data/upload-data-split.md)) или [переписку из чата](operations/data/upload-chat-text.md) с помощью Python-скрипта отправки данных.

    Аудио передается целиком в одном сообщении.

    {% include [supported-formats](../_includes/speechsense/formats.md) %}

    {% include [max-duration](../_includes/speechsense/data/max-duration.md) %}
