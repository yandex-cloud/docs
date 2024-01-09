---
title: "Как создать капчу в {{ captcha-full-name }}"
description: "Следуя данной инструкции, вы сможете создать капчу."
---

# Создать капчу

{{ captcha-name }} позволяет создавать капчи нескольких уровней сложности. Вы можете:

* подключить капчу к нескольким сайтам;
* задать параметры всех элементов внешнего вида капчи, таких как фон, возникающие ошибки и стиль кнопки **Я не робот**.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartcaptcha_ru }}**.
  1. Нажмите **{{ ui-key.yacloud.smartcaptcha.button_captcha-settings-create }}** и укажите:
      * **{{ ui-key.yacloud.common.name }}** — имя создаваемой капчи. Требования к имени:

        {% include [name-format](../../_includes/smartcaptcha/name-format.md) %}

      * **{{ ui-key.yacloud.smartcaptcha.label_main-challenge }}** — тип [основного задания](../concepts/tasks.md#main-task), которое предлагается решить пользователю.
      * **{{ ui-key.yacloud.smartcaptcha.label_additional-challenge }}** — тип [дополнительного задания](../concepts/tasks.md#additional-task), которое предлагается решить пользователю.
      * **{{ ui-key.yacloud.smartcaptcha.label_complexity }}** — сложность задания, которое увидит пользователь:
          * `{{ ui-key.yacloud.smartcaptcha.value_complexity-easy }}` — простое задание.
          * `{{ ui-key.yacloud.smartcaptcha.value_complexity-medium }}` — задание среднего уровня сложности.
          * `{{ ui-key.yacloud.smartcaptcha.value_complexity-hard }}` — сложное задание.

          Пример задания можно посмотреть в окне предпросмотра.
      * **{{ ui-key.yacloud.smartcaptcha.label_no-hostname-check }}** — опция позволяет отключить [валидацию домена](../concepts/domain-validation.md).
      * **{{ ui-key.yacloud.smartcaptcha.label_allowed-sites }}** — в формате IP-адресов или доменных имен. Указываются без `http`, `https` и без `/` в конце, например, `example.com`.

          Капча будет работать и во всех поддоменах указанных доменных имен.

      * **{{ ui-key.yacloud.smartcaptcha.label_section-style }}** — готовый внешний вид кнопки **Я не робот** и окна с заданием:
          * `{{ ui-key.yacloud.smartcaptcha.value_config-standard }}` — внешний вид по умолчанию.
          * `Серый`.
          * `Темная тема`.
          * `Синий`.

          В разделе **{{ ui-key.yacloud.smartcaptcha.label_section-customization }}** вы можете задать свои параметры окна задания и других элементов: через форму или через описание стилей в формате `JSON`.

          Все изменения будут отображаться в окне предпросмотра.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

  Капча отобразится на странице сервиса в разделе **{{ ui-key.yacloud.smartcaptcha.label_captcha-settings-list }}**.

{% endlist %}
