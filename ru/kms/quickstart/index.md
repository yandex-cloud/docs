# Как начать работать с {{ kms-name }}

В этой инструкции вы создадите свой первый [ключ](../concepts/index.md), а также зашифруете и расшифруете текст с помощью сервиса {{ kms-short-name }}. 

## Подготовка к работе {#before-you-begin}

Чтобы начать работать с {{ kms-name }}:

1. Войдите в [консоль управления]({{ link-console-main }}). Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. На странице [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md#create_billing_account).
1. Убедитесь, что в нужном облаке у вас есть роль `owner` или `editor`.
1. Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

## Создайте ключ симметричного шифрования {#create-key}

{% list tabs %}

- Консоль управления
    
    Создайте ключ симметричного шифрования: 
    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать ключ.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
    1. На панели слева выберите ![image](../../_assets/console-icons/key.svg) **{{ ui-key.yacloud.kms.switch_symmetric-keys }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.kms.symmetric-keys.button_empty-create }}** и задайте параметры ключа:
       * В поле **{{ ui-key.yacloud.common.name }}** укажите `my-first-key`.
       * В поле **{{ ui-key.yacloud.kms.symmetric-key.form.field_algorithm }}** укажите `AES-256`.
       * В поле **{{ ui-key.yacloud.kms.symmetric-key.form.field_rotation }}** оставьте значение `{{ ui-key.yacloud.kms.symmetric-key.form.value_no-rotation }}`.
       * Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
    1. Нажмите на строку с именем ключа и убедитесь, что в блоке **{{ ui-key.yacloud.kms.symmetric-key.overview.label_title-versions }}** есть первая версия ключа.

{% endlist %}

## Зашифруйте текст с помощью ключа {#encrypt}

Придумайте секретный текст, например <q>Запуск состоится 42 мартобря.</q>. Размер текста не должен превышать 32 КБ, для шифрования больших объемов данных используйте шифрование по схеме [envelope encryption](../concepts/envelope.md).

{% list tabs %}

- CLI

    Зашифруйте текст:
    
    1. Запишите секретный текст в файл `plaintext.txt`.
    1. Из консоли управления скопируйте идентификатор ключа, созданного ранее.
        1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором был создан ключ.
        1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
        1. В открывшемся окне скопируйте ключ из поля **{{ ui-key.yacloud.common.id }}**.
    1. Зашифруйте текст:
    
       ```
       yc kms symmetric-crypto encrypt \
        --id <идентификатор_ключа> \
        --plaintext-file plaintext.txt \
        --ciphertext-file ciphertext
       ```

    Результат — бинарный файл `ciphertext`, содержащий шифртекст.

{% endlist %}

## Расшифруйте текст {#decrypt}

Расшифруйте бинарный файл `ciphertext`, полученный на предыдущем шаге.

{% list tabs %}

- CLI

    Расшифруйте текст:
    
    ```
    yc kms symmetric-crypto decrypt \
    --id <идентификатор_ключа> \
    --ciphertext-file ciphertext \
    --plaintext-file decrypted.txt
    ```
    
    В результате файл `ciphertext` будет расшифрован, и в `decrypted.txt` будет записан расшифрованный текст: <q>Запуск состоится 42 мартобря.</q>.

{% endlist %}

#### См. также {#see-also}

* [Изменение ключа](../operations/key.md#update)
* [Ротация ключа](../operations/key.md#rotate)
* [Сменить версию ключа по умолчанию](../operations/version.md#make-primary)
