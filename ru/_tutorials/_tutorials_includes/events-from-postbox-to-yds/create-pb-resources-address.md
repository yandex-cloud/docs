1. На вашем компьютере сгенерируйте ключ `privatekey.pem` для создания DKIM-подписи. Для этого в терминале выполните команду:

    ```bash
    openssl genrsa -out privatekey.pem 2048
    ```

    {% note info %}

    В операционных системах Linux и macOS утилита `openssl` предустановлена. В Windows эту утилиту необходимо предварительно установить. Подробнее см. на [сайте](https://openssl-library.org/) проекта.

    {% endnote %}

1. Создайте адрес {{ postbox-name }}:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
      1. На панели слева выберите ![at](../../../_assets/console-icons/at.svg) **{{ ui-key.yacloud.postbox.label_identities }}** и нажмите кнопку **{{ ui-key.yacloud.postbox.button_create-identity }}**.
      1. В поле **{{ ui-key.yacloud.postbox.label_address }}** укажите домен, с которого вы будете отправлять письма. Домен может быть любого уровня и должен принадлежать вам.
      1. В поле **{{ ui-key.yacloud.postbox.label_selector }}** укажите селектор, например `postbox`. Указанный селектор должен использоваться только в одной ресурсной записи — той, которую необходимо создать при прохождении [проверки прав на домен](#domain).
      1. В поле **{{ ui-key.yacloud.postbox.label_configuration-set }}** выберите созданную ранее конфигурацию `postbox-events-config`.
      1. В поле **{{ ui-key.yacloud.postbox.label_private-key }}** вставьте содержимое файла приватного ключа `privatekey.pem`, созданного на предыдущем шаге.
      1. Другие параметры адреса оставьте без изменений и нажмите кнопку **{{ ui-key.yacloud.postbox.button_create-identity }}**.
      1. В открывшемся списке адресов нажмите на строку с вновь созданным адресом.
      1. На странице с информацией об адресе в блоке **{{ ui-key.yacloud.postbox.label_signature-verification }}** из поля **{{ ui-key.yacloud.postbox.label_dns-record-value }}** скопируйте и сохраните значение [TXT-записи](../../../dns/concepts/resource-record.md#txt).

    {% endlist %}