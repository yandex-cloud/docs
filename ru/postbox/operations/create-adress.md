# Создание адреса

1. Сгенерируйте ключ для создания DKIM-подписи:

    ```bash
    openssl genrsa -out privatekey.pem 2048
    ```

1. Создайте [адрес](../concepts/glossary.md#adress):

    {% list tabs group=instructions %}

    - Консоль управления {#console}

        1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать адрес.
        1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
        1. Нажмите кнопку **{{ ui-key.yacloud.postbox.button_create-identity }}**.
        1. В поле **{{ ui-key.yacloud.postbox.label_address }}** укажите домен, с которого будете отправлять письма. Домен может быть любого уровня.
        1. В поле **{{ ui-key.yacloud.postbox.label_selector }}** укажите селектор, например `postbox`. Указанный селектор должен использоваться только в одной ресурсной записи — той, которую необходимо создать при прохождении [проверки владения доменом](check-domain.md).
        1. (Опционально) [Привяжите конфигурацию к адресу](bind-configuration.md).
        1. В поле **{{ ui-key.yacloud.postbox.label_private-key }}** скопируйте содержимое файла приватного ключа `privatekey.pem`.
        1. Нажмите кнопку **{{ ui-key.yacloud.postbox.button_create-identity }}**.

        Чтобы отправлять письма, пройдите [проверку владения доменом](check-domain.md).

    {% endlist %}
