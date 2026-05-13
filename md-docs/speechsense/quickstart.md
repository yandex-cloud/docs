# Как начать работать с Yandex SpeechSense

Сервис Yandex SpeechSense позволяет анализировать каналы коммуникации вашего бизнеса на основе записей разговоров или текстовых сообщений из чатов и интегрируется с вашими АТС и CRM-системами. SpeechSense использует голосовые технологии Yandex SpeechKit для расшифровки и статистического и качественного анализа аудиозаписей диалогов.

SpeechSense поддерживает анализ аудиозаписей и текстовых диалогов на русском и казахском языках.

Вы можете загрузить в SpeechSense свои данные или воспользоваться [демонстрационным примером](https://storage.yandexcloud.net/doc-files/speechsense-demo-dialog.wav), который был синтезирован с помощью SpeechKit.

## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь, если вы еще не зарегистрированы. О том, как начать работать с Yandex Cloud, см. в документе [Начало работы с Yandex Cloud](../getting-started/index.md).
1. Примите пользовательское соглашение.
1. В сервисе [Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md) и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md#create_billing_account).
1. [Назначьте](../iam/operations/roles/grant.md) вашему аккаунту в Yandex Cloud роль `speech-sense.spaces.creator`.

    {% note info %}
    
    Если вы не можете управлять ролями, обратитесь к администратору вашего облака или организации.
    
    {% endnote %}

1. Откройте [главную страницу](https://speechsense.yandex.cloud/) SpeechSense.
1. Выберите организацию, в которой вы будете работать со SpeechSense, или [создайте](../organization/operations/enable-org.md) новую.

## Настройте окружение {#set-space}

1. Создайте [пространство](concepts/resources-hierarchy.md#space), в котором будут находиться все ваши [проекты](concepts/resources-hierarchy.md#project): выберите **Создать пространство**, введите название, (опционально) добавьте описание и нажмите кнопку **Создать**.
1. К пространству [привяжите платежный аккаунт](operations/space/link-ba.md), с которого будет оплачиваться использование SpeechSense.

   {% note info %}
   
   Для управления платежным аккаунтом у пользователя должна быть [назначена](../billing/security/index.md#set-role) роль `billing.accounts.editor`, `billing.accounts.admin` или `billing.accounts.owner` на нужный платежный аккаунт.
   
   {% endnote %}

1. Перейдите на вкладку **Подключения** и выберите шаблон для создания [подключения](concepts/resources-hierarchy.md#connection) на основе метаинформации ваших аудиозаписей или переписок из чатов:

   * **Пустая форма** — подключение с возможностью добавить ваши собственные ключи для метаданных.
   * **Bitrix24** — подключение с предустановленным набором ключей для Битрикс24. Дополнительно можно добавить собственные ключи.
   * **AmoCRM** — подключение с предустановленным набором ключей для amoCRM. Дополнительно можно добавить собственные ключи.

   1. Введите **Название подключения**.
   1. Выберите тип данных **Двухканальное аудио**, **Одноканальное аудио** или **Чат**.
   1. Задайте параметры подключения. Процесс подробно рассмотрен в разделе [Создать подключение](operations/connection/create.md).
   1. Нажмите кнопку **Создать подключение**.

   {% cut "Пример metadata.json для загрузки аудиоданных" %}

   Даты указываются в формате ISO 8601 UTC с нулевым смещением времени. Если необходимо указать московское время, добавьте `+03:00` вместо `Z` в конец строки: `2025-04-24T14:34:19+03:00`.

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

1. Создайте проект: на странице пространства нажмите кнопку **Создать проект**, введите имя проекта, добавьте в проект подключение. Для каждого подключения вы можете выбрать правила фильтрации на основе метаинформации подключения и критериев [YandexGPT Pro](https://aistudio.yandex.ru/docs/ru/ai-studio/concepts/generation/index). Фильтры будут добавлять в проект только нужные диалоги. После добавления всех нужных подключений и настройки фильтров нажмите кнопку **Создать проект**.

## Загрузите данные {#upload-data}

Для загрузки данных в SpeechSense используется [gRPC API](api-ref/grpc/index.md).

Чтобы загрузить данные:

1. [Создайте сервисный аккаунт](../iam/operations/sa/create.md).
1. [Добавьте сервисный аккаунт в пространство](operations/space/add-user-to-space.md) с ролью `speech-sense.data.editor`. Подробнее о ролях, действующих в сервисе, см. раздел [Управление доступом в SpeechSense](security/index.md).
1. Создайте для сервисного аккаунта [API-ключ](../iam/operations/authentication/manage-api-keys.md#create-api-key) с заданной [областью действия](../iam/concepts/authorization/api-key.md#scoped-api-keys) `yc.speech-sense.use` или [IAM-токен](../iam/operations/iam-token/create-for-sa.md), чтобы аутентифицироваться в API. [Подробнее об аутентификации в API SpeechSense](api-ref/authentication.md).
1. Загрузите аудиоданные ([без разбиения](operations/data/upload-data.md) или [с разбиением на отрезки](operations/data/upload-data-split.md)) или [переписку из чата](operations/data/upload-chat-text.md) с помощью Python-скрипта отправки данных.

    Аудио передается целиком в одном сообщении.

    SpeechSense поддерживает следующие форматы аудиофайлов:
    
    * [LPCM](https://ru.wikipedia.org/wiki/Импульсно-кодовая_модуляция) — `AUDIO_ENCODING_LINEAR16_PCM`
    * [WAV](https://ru.wikipedia.org/wiki/WAV) — `CONTAINER_AUDIO_TYPE_WAV`
    * [OggOpus](https://wiki.xiph.org/OggOpus) — `CONTAINER_AUDIO_TYPE_OGG_OPUS`
    * [MP3](https://ru.wikipedia.org/wiki/MP3) — `CONTAINER_AUDIO_TYPE_MP3`

    Максимальная длительность аудио — 4 часа.