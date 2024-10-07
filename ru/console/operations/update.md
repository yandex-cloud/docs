# Изменение настроек консоли управления

В [консоли управления]({{ link-console-main }}) вы можете изменить следующие настройки:

* [настройки уведомлений](#notifications);
* [язык и регион](#lang);
* [оформление](#appearance).

## Задать настройки уведомлений {#notifications}

1. В консоли управления на панели слева выберите раздел ![icon](../../_assets/console-icons/gear.svg) **Настройки**.
1. Перейдите в раздел ![icon](../../_assets/console-icons/envelope.svg) **{{ ui-key.yacloud_components.settings.label_title_communications }}**.
1. Привяжите нужный адрес электронной почты:

   1. В поле ![icon](../../_assets/console-icons/at.svg) **{{ ui-key.yacloud_components.settings.field_email }}** нажмите кнопку ![icon](../../_assets/console-icons/pencil.svg).
   1. Во всплывающем окне укажите новую электронную почту. На нее будет отправлен код подтверждения.
   1. Скопируйте код и введите его в консоли управления.
   1. Подтвердите смену электронной почты.

1. Привяжите нужный номер телефона:

   1. В поле ![icon](../../_assets/console-icons/smartphone.svg) **{{ ui-key.yacloud_components.settings.field_phone }}** нажмите кнопку ![icon](../../_assets/console-icons/pencil.svg).
   1. Во всплывающем окне укажите новый номер. На него будет выслан код подтверждения.
   1. Скопируйте код и введите его в консоли управления.
   1. Подтвердите смену номера телефона.

1. Привяжите нужный Telegram-аккаунт:

   1. В поле ![icon](../../_assets/console-icons/logo-telegram.svg) **{{ ui-key.yacloud_components.settings.label_telegram }}** нажмите кнопку **{{ ui-key.yacloud_components.settings.button_add-empty-telegram }}**.
   1. Во всплывающем окне нажмите кнопку **{{ ui-key.yacloud_components.settings.label_telegram-link }}**.

      Откроется чат с ботом {{ yandex-cloud }} Notify в Telegram.

   1. В чате нажмите кнопку **Start**.

      Бот пришлет код подтверждения. Код действует в течение десяти минут.

   1. В консоли управления введите полученный код.

1. В блоке **{{ ui-key.yacloud_components.settings.section_settings }}** выберите, какие уведомления на какие каналы должны отправляться.

   Доступные каналы:

   * ![icon](../../_assets/console-icons/at.svg) — электронная почта;
   * ![icon](../../_assets/console-icons/smartphone.svg) — телефон;
   * ![icon](../../_assets/console-icons/logo-telegram.svg) — Telegram.

   Каналы доступны, только если вы привязали их к консоли управления.

   Доступные уведомления:

   * **{{ ui-key.yacloud_components.settings.label_tech-name }}** — про автоматическую установку обновлений и исправлений в ресурсах, а также про иное сервисное обслуживание.
   * **{{ ui-key.yacloud_components.settings.label_security-name }}** — про обнаруженные уязвимости и их устранение.
   * **{{ ui-key.yacloud_components.settings.label_alerting-name }}** — про сработавшие [алерты](../../monitoring/concepts/alerting.md), если вы настроили их в сервисе {{ monitoring-full-name }}. Например, вы можете [создать алерт](../../managed-postgresql/operations/storage-space.md#set-alert), который уведомляет о переполнении диска в кластере {{ mpg-full-name }}.
   * **{{ ui-key.yacloud_components.settings.label_billing-name }}** — про оплату, пробный период, статус платежного аккаунта и др.
   * **Новости и предложения** — про новые сервисы, скидки, специальные предложения и др.
   * **{{ ui-key.yacloud_components.settings.label_event-name }}** — про очные мероприятия и вебинары {{ yandex-cloud }}.
   * **Предложения от других сервисов Яндекса** — про предложения не от {{ yandex-cloud }}.

## Установить язык и регион {#lang}

1. В консоли управления, на панели слева, выберите раздел ![icon](../../_assets/console-icons/gear.svg) **Настройки**.
1. Перейдите в раздел ![icon](../../_assets/console-icons/globe.svg) **{{ ui-key.yacloud_components.settings.label_title_region }}**.
1. Выберите язык для консоли управления.
1. Выберите часовой пояс.

   По умолчанию он определяется автоматически. По нему отображается время операций в консоли управления.

1. Выберите формат даты и времени, который будет использоваться для операций в консоли управления.

## Настроить оформление в консоли управления {#appearance}

1. В консоли управления, на панели слева, выберите раздел ![icon](../../_assets/console-icons/gear.svg) **Настройки**.
1. Перейдите в раздел ![icon](../../_assets/console-icons/palette.svg) **{{ ui-key.yacloud_components.settings.label_title_appearance }}**.
1. Выберите тему интерфейса в консоли управления.

   При выборе значения **{{ ui-key.yacloud_components.settings.value_theme-system }}** тема консоли будет совпадать с темой вашего устройства.

1. Выберите контрастность.
1. Отключите опцию **{{ ui-key.yacloud_components.settings.label_promo_banner-name }}**, чтобы отключить отображение промоакций, специальных предложений и инструкций по работе с консолью управления. Если вы хотите их оставить, включите опцию.
