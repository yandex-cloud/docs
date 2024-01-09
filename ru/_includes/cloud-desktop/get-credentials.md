{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится рабочий стол.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/display.svg) **{{ ui-key.yacloud.vdi.label_desktops }}**.
  1. Выберите рабочий стол, к которому хотите подключиться.
  1. В блоке **{{ ui-key.yacloud.vdi.section_access }}** напротив пользовательского аккаунта нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.vdi.button_reset-password }}**.
  1. Подтвердите сброс пароля.
  1. Сохраните новый пароль из всплывающего окна и закройте его.
  1. Справа сверху нажмите ![image](../../_assets/console-icons/arrow-down-to-line.svg) **{{ ui-key.yacloud.vdi.button_download-rdp }}**.

- Витрина пользовательских рабочих столов {#desktop-showcase}

  1. Откройте [Витрину пользовательских рабочих столов]({{ link-cloud-desktop-showcase }}).
  1. Аутентифицируйтесь с помощью [Яндекс ID](https://yandex.ru/support/id/index.html) или через [систему единого входа (SSO)](../../organization/concepts/add-federation.md).
  1. Если рабочий стол, к которому вы хотите подключиться, находится в статусе `Stopped`, запустите его — нажмите ![image](../../_assets/console-icons/play.svg) и подтвердите запуск.

      Дождитесь перехода рабочего стола в статус `Active`.
  1. Нажмите ![image](../../_assets/console-icons/lock-open.svg) и подтвердите сброс пароля.
  1. Сохраните новый пароль из всплывающего окна и закройте его.
  1. Нажмите ![image](../../_assets/console-icons/arrow-down-to-line.svg) **{{ ui-key.yacloud.vdi.button_download-rdp }}**.

{% endlist %}
