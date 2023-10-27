# Создать капчу

{{ captcha-name }} позволяет создавать капчи нескольких уровней сложности. Вы можете:

* подключить капчу к нескольким сайтам;
* настроить внешний вид кнопки **Я не робот** и окна с заданием.

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartcaptcha_ru }}**.
  1. Нажмите **{{ ui-key.yacloud.smartcaptcha.button_captcha-settings-create }}** и укажите:
      * **{{ ui-key.yacloud.common.name }}** — имя создаваемой капчи.
      * **{{ ui-key.yacloud.smartcaptcha.label_main-challenge }}** — тип [основного задания](../concepts/tasks.md#main-task), которое предлагается решить пользователю.
      * **{{ ui-key.yacloud.smartcaptcha.label_additional-challenge }}** — тип [дополнительного задания](../concepts/tasks.md#additional-task), которое предлагается решить пользователю.
      * **{{ ui-key.yacloud.smartcaptcha.label_complexity }}** — сложность задания, которое увидит пользователь:
          * `{{ ui-key.yacloud.smartcaptcha.value_complexity-easy }}` — простое задание.
          * `{{ ui-key.yacloud.smartcaptcha.value_complexity-medium }}` — задание среднего уровня сложности.
          * `{{ ui-key.yacloud.smartcaptcha.value_complexity-hard }}` — сложное задание.

          Пример задания можно посмотреть в окне предпросмотра.
      * **{{ ui-key.yacloud.smartcaptcha.label_allowed-sites }}** — в формате IP-адресов или доменных имен. Указываются без `http`, `https` и без `/` в конце, например, `example.com`.

          Капча будет работать и во всех поддоменах указанных доменных имен.

      * **{{ ui-key.yacloud.smartcaptcha.label_section-style }}** — готовый внешний вид кнопки **Я не робот** и окна с заданием:
          * `{{ ui-key.yacloud.smartcaptcha.value_config-standard }}` — внешний вид по умолчанию.
          * `Серый`.
          * `Темная тема`.
          * `Синий`.

          В разделе **{{ ui-key.yacloud.smartcaptcha.label_section-customization }}** вы можете задать свои параметры: через форму или через описание стилей в формате `JSON`.

          Все изменения будут отображаться в окне предпросмотра.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

  Капча отобразится на странице сервиса в разделе **{{ ui-key.yacloud.smartcaptcha.label_captcha-settings-list }}**.

{% endlist %}
