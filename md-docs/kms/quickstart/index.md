# Как начать работать с Key Management Service

В этой инструкции вы создадите свой первый [ключ](../concepts/index.md), а также зашифруете и расшифруете текст с помощью сервиса KMS. 

## Подготовка к работе {#before-you-begin}

Чтобы начать работать с Key Management Service:

1. Войдите в [консоль управления](https://console.yandex.cloud). Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. На странице [**Yandex Cloud Billing**](https://center.yandex.cloud/billing/accounts) убедитесь, что у вас подключен [платежный аккаунт](../../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md#create_billing_account).
1. [Назначьте](../../iam/operations/roles/grant.md) вашему аккаунту в Yandex Cloud роль `owner` или `editor` на нужное облако.

    {% note info %}
    
    Если вы не можете управлять ролями, обратитесь к администратору вашего облака или организации.
    
    {% endnote %}

1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

## Создайте ключ симметричного шифрования {#create-key}

{% list tabs group=instructions %}

- Консоль управления {#console}
    
    Создайте ключ симметричного шифрования: 
    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите создать ключ.
    1. Перейдите в сервис **Key Management Service**.
    1. На панели слева выберите ![image](../../_assets/console-icons/key.svg) **Симметричные ключи**.
    1. Нажмите кнопку **Создать ключ** и задайте параметры ключа:
       * В поле **Имя** укажите `my-first-key`.
       * В поле **Алгоритм шифрования** укажите `AES-256`.
       * В поле **Период ротации, дни** оставьте значение `Нет ротации`.
       * Нажмите кнопку **Создать**.
    1. Нажмите на строку с именем ключа и убедитесь, что в блоке **Версии** есть первая версия ключа.

{% endlist %}

## Зашифруйте текст с помощью ключа {#encrypt}

Придумайте секретный текст, например <q>Запуск состоится 42 мартобря.</q>. Размер текста не должен превышать 32 КБ, для шифрования больших объемов данных используйте шифрование по схеме [envelope encryption](../concepts/envelope.md).

{% list tabs group=instructions %}

- CLI {#cli}

    Зашифруйте текст:
    
    1. Запишите секретный текст в файл `plaintext.txt`.
    1. Из консоли управления скопируйте идентификатор ключа, созданного ранее.
        1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором был создан ключ.
        1. Перейдите в сервис **Key Management Service**.
        1. В открывшемся окне скопируйте ключ из поля **Идентификатор**.
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

{% list tabs group=instructions %}

- CLI {#cli}

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