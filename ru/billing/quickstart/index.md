---
title: Регистрация аккаунта в облаке
description: Чтобы пользоваться сервисами облака {{ yandex-cloud }}, зарегистрируйте и создайте платежный аккаунт. Аккаунт необходим, даже если вы планируете пользоваться только бесплатными сервисами.
keywords:
  - как зарегистрироваться в облаке
  - как зарегистрироваться в облаке яндекс
  - регистрация в облаке
  - создание аккаунта в облаке
---

# Регистрация аккаунта в {{ yandex-cloud }}

Чтобы пользоваться сервисами {{ yandex-cloud }}, создайте платежный аккаунт. 

Платежный аккаунт необходим, даже если вы планируете пользоваться только бесплатными сервисами. При создании платежного аккаунта нужно ввести данные плательщика, но {{ yandex-cloud }} не списывает деньги с карты и не выставляет счета, пока вы не перешли на [платную версию](../operations/activate-commercial.md).

В рамках одного аккаунта на Яндексе либо все плательщики должны быть резидентами РФ, либо все резидентами РК, либо все нерезидентами. Подробнее о [платежном аккаунте](../concepts/billing-account.md).

{% list tabs %}

- Физическое лицо

   Чтобы создать платежный аккаунт:

   1. Откройте [консоль управления]({{ link-console-main }}) {{ yandex-cloud }}.

   1. Войдите в свой Яндекс ID или аккаунт в Яндекс.Коннекте. Если у вас еще нет аккаунта, зарегистрируйтесь.

      * К аккаунту обязательно должен быть привязан ваш номер телефона. Подробные инструкции смотрите в Справке [Яндекс ID]{% if lang == "ru" %}(https://yandex.ru/support/passport/authorization/registration.html){% endif %}{% if lang == "en" %}(https://yandex.com/support/passport/authorization/registration.html){% endif %} и [Яндекс.Коннекта]{% if lang == "ru" %}(https://yandex.ru/support/connect/personal.html#personal__section_aq5_hcq_23b){% endif %}{% if lang == "en" %}(https://yandex.com/support/connect/personal.html#personal__section_aq5_hcq_23b){% endif %}.
      * Если для входа на Яндекс вы используете профиль в социальной сети, [заведите логин и пароль]{% if lang == "ru" %}(https://passport.yandex.ru/passport?mode=postregistration&create_login=1){% endif %}{% if lang == "en" %}(https://passport.yandex.com/passport?mode=postregistration&create_login=1){% endif %}.

   1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}

   1. На странице **Список аккаунтов** нажмите кнопку **Создать аккаунт**. Заполните данные:

      * Выберите страну плательщика.
      * Укажите имя платежного аккаунта. Имя будет отображаться в списке ваших платежных аккаунтов и поможет выбрать нужный.

   1. Если в блоке **Плательщики** показан список доступных плательщиков, вы можете выбрать одного из них или добавить нового.

      Чтобы добавить плательщика:

      * Выберите тип плательщика: **Физическое лицо**.
      * Укажите ваше имя, фамилию и отчество.

      {% include [pin-card-data](../../_includes/billing/pin-card-data.md) %}

        {% include [payment-card-types](../../_includes/billing/payment-card-types.md) %}

        {% include [payment-card-validation](../../_includes/billing/payment-card-validation.md) %}

   1. Нажмите кнопку **Активировать**.

- Юридическое лицо, ИП или нерезидент РФ и РК

   Чтобы создать платежный аккаунт:

   1. Откройте [консоль управления]({{ link-console-main }}) {{ yandex-cloud }}.

   1. Войдите в свой Яндекс ID или аккаунт в Яндекс.Коннекте. Если у вас еще нет аккаунта, зарегистрируйтесь.

      - К аккаунту обязательно должен быть привязан ваш номер телефона. Подробные инструкции смотрите в Справке [Яндекс ID]{% if lang == "ru" %}(https://yandex.ru/support/passport/authorization/registration.html){% endif %}{% if lang == "en" %}(https://yandex.com/support/passport/authorization/registration.html){% endif %} и [Яндекс.Коннекта]{% if lang == "ru" %}(https://yandex.ru/support/connect/personal.html#personal__section_aq5_hcq_23b){% endif %}{% if lang == "en" %}(https://yandex.com/support/connect/personal.html#personal__section_aq5_hcq_23b){% endif %}.
      - Если для входа на Яндекс вы используете профиль в социальной сети, [заведите логин и пароль]{% if lang == "ru" %}(https://passport.yandex.ru/passport?mode=postregistration&create_login=1){% endif %}{% if lang == "en" %}(https://passport.yandex.com/passport?mode=postregistration&create_login=1){% endif %}.

   1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}

   1. На странице **Список аккаунтов** нажмите кнопку **Создать аккаунт**. Заполните данные:

      * Выберите страну плательщика.
      * Укажите имя платежного аккаунта. Имя будет отображаться в списке ваших платежных аккаунтов и поможет выбрать нужный.

   1. Если в блоке **Плательщики** показан список доступных плательщиков, вы можете выбрать одного из них или добавить нового.

      Чтобы добавить плательщика:
      
        * Выберите тип плательщика: **Юридическое лицо или ИП**.
          Если плательщик — нерезидент РФ и РК, доступен только один тип плательщика: **Юридическое лицо (нерезидент РФ)**.

        * Выберите способ оплаты: **Банковская карта** или **Банковский перевод**. В любой момент после создания платежного аккаунта вы можете [изменить способ оплаты](../operations/change-payment-method.md).
        * Укажите юридическую информацию о вашей организации.

            {% include [contacts-note](../../_includes/billing/contacts-note.md) %}
   
        * Если вы выбрали способ оплаты **Банковская карта**, привяжите корпоративную банковскую карту:
      
            {% include [pin-card-data](../../_includes/billing/pin-card-data.md) %}

            * Подтвердите, что карта является корпоративной и вы уполномочены ею распоряжаться.

            {% include [payment-card-types](../../_includes/billing/payment-card-types.md) %}

            {% include [yandex-account](../../_includes/billing/payment-card-validation.md) %}

   1. Нажмите кнопку **Активировать**.

      Если вы выбрали способ оплаты **Банковский перевод** или если плательщик — нерезидент РФ и РК, вы получите письмо с описанием дальнейших действий на почту, указанную в аккаунте Яндекса или Яндекс.Коннекта. В этом случае активация платежного аккаунта может занять до трех рабочих дней.

{% endlist %}

{% include [account-roles](../_includes/account-roles.md) %}

### Узнайте больше

- [Платежный аккаунт](../concepts/billing-account.md)
- [Пробный период](../../free-trial/concepts/quickstart.md)

### Начните знакомство с {{ yandex-cloud }} {#start}

   {% include [quickstart-all-no-billing](../../_includes/quickstart-all-no-billing.md) %}