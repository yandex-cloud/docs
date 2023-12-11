# Создание партнерского коннектора

Если вы партнер {{ datalens-short-name }}, вы можете создать свой коннектор (тип подключения) и добавить его в [{{ datalens-short-name }} {{ marketplace-short-name }}](../../concepts/marketplace.md) или на страницу [подключений]({{ link-datalens-main }}/connections/new). С помощью коннектора пользователи смогут создавать датасеты, чарты и дашборды на основе ваших данных.

Преимущества работы с коннектором для партнеров {{ datalens-short-name }}:

* простой доступ пользователей к данным;
* разграничение доступа к данным (каждый пользователь видит только те данные, которые вы ему предоставляете);
* развертывание готового дашборда с вашими данными и возможность его изменять.

## Как стать партнером {#how-to-become-a-partner}

На главной странице [{{ marketplace-short-name }}](/marketplace) нажмите кнопку **Предложить продукт** и заполните заявку.

После подачи заявки с вами свяжутся менеджеры {{ datalens-short-name }}.

Передайте менеджерам {{ datalens-short-name }} информацию о продукте:

* Название на русском и английском языках.
* Описание на русском и английском языках.
* Примеры использования на русском и английском языках.
* Инструкцию для пользователей на русском и английском языках.
* Иконку (вектор, SVG).
* Цену и желаемый процесс оплаты (если продукт платный).
* Контакты разработчика.

## Как создать коннектор {#how-to-create-connector}

Коннектор необходимо создать на базе кластера CH, в котором будут храниться данные ваших пользователей.

1. Создайте [кластер {{ CH }}](../../../managed-clickhouse/operations/cluster-create.md) в облаке.

   1. В кластере добавьте пользователя БД `datalens` с параметром [readonly = 2]({{ ch.docs }}/operations/settings/permissions-for-queries/#settings_readonly).

      {% note info %}

      Если кластер переведен под управление SQL, то создать пользователя можно командой:

      ```sql
      CREATE USER IF NOT EXISTS <имя_пользователя> ON CLUSTER <имя_кластера>
          IDENTIFIED WITH plaintext_password by '<пароль_пользователя>'
          SETTINGS readonly = 2;
      ```

      {% endnote %}

   1. В настройках включите **Доступ из {{ datalens-short-name }}** и **Управление базами данных через SQL**.

1. Передайте пароль и список хостов кластера менеджерам {{ datalens-short-name }}, которые свяжутся с вами после оставления заявки в {{ marketplace-short-name }}.
1. Сгенерируйте пару RSA-2048 ключей. Передайте открытый ключ и версию ключа менеджерам {{ datalens-short-name }}.
   Требования для генерации ключа: `public_exponent=65537`, `key_size=2048`. Версия ключа — целое число, версия необходима для бесшовной ротации ключей в будущем.

   {% cut "Python-код для генерации пары ключей" %}

    ```python
    from cryptography.hazmat.primitives.asymmetric import rsa
    from cryptography.hazmat.primitives import serialization
    
    private_key = rsa.generate_private_key(
        public_exponent=65537,
        key_size=2048,
    )
    private_pem = private_key.private_bytes(
        encoding=serialization.Encoding.PEM,
        format=serialization.PrivateFormat.TraditionalOpenSSL,
        encryption_algorithm=serialization.NoEncryption()
    ).decode()
    
    public_key = private_key.public_key()
    public_pem = public_key.public_bytes(
        encoding=serialization.Encoding.PEM,
        format=serialization.PublicFormat.SubjectPublicKeyInfo
    ).decode()
    print(public_pem)
    ```

   {% endcut %}

1. {{ datalens-short-name }} также передаст вам открытую часть своего ключа и его версию.
   После этого {{ datalens-short-name }} создаст для вас коннектор, который будет отправлять запросы в ваш кластер {{ CH }}.

## Как подключить нового пользователя {#how-to-add-new-user}

1. Добавьте в кластер {{ CH }} базы данных для ваших пользователей. Для каждого пользователя создайте в кластере {{ CH }} отдельную БД. К БД выдается доступ на чтение от БД пользователя `datalens`.
1. Подготовьте токен доступа для пользователя:

   {% note warning %}

   Для каждого пользователя должен быть отдельный токен доступа в формате строки.

   {% endnote %}

    1. Сгенерируйте JSON с именем БД клиента, например `{"db_name":"client_1234383"}`.
    1. Зашифруйте JSON открытым ключом {{ datalens-short-name }}. Параметры шифрования: `padding scheme PKCS1 v1.5`.
    1. Подпишите зашифрованную строку своим секретным ключом. Параметры подписи: `padding scheme PKCS1 v1.5, signature hash algorithm: SHA1`.
    1. Сгенерируйте токен доступа по схеме `<datalens_key_version>:<partner_key_version>:<encrypted_data>:<signature>`, где:
        * `datalens_key_version` и `partner_key_version` — версии ключей.
        * `encrypted_data` — зашифрованный JSON (результат шага 2.2), закодированный в Base64.
        * `signature` — подпись зашифрованного сообщения (результат шага 2.3), закодированная в Base64.

    {% cut "Python-код для генерации токена доступа" %}

    ```python
     import json
     from base64 import b64encode, b64decode
     from cryptography.hazmat.primitives import serialization
     from cryptography.hazmat.primitives import hashes
     from cryptography.hazmat.primitives.asymmetric import padding
     
     public_key_datalens_pem = '''-----BEGIN PUBLIC KEY-----...''' # Публичный RSA-ключ DataLens.
     private_key_partner_pem = '''-----BEGIN RSA PRIVATE KEY-----...''' # Ваш приватный RSA-ключ. 
     datalens_key_version, partner_key_version = '1', '1' # Версии ключей.
     
     data = json.dumps({'db_name': 'db_name_123'}) # JSON с БД пользователя в кластере ClickHouse.
     
     public_key_datalens = serialization.load_pem_public_key(public_key_datalens_pem.encode())
     private_key_partner = serialization.load_pem_private_key(
         private_key_partner_pem.encode(),
         password=None,
     )
     ciphertext = public_key_datalens.encrypt(data.encode(), padding.PKCS1v15()) # Зашифрованное JSON-сообщение с БД пользователя.
     signature = private_key_partner.sign(ciphertext, padding.PKCS1v15(), hashes.SHA1()) # Подпись зашифрованного сообщения. 
     
     access_token = ':'.join((
         datalens_key_version,
         partner_key_version,
         b64encode(ciphertext).decode(encoding='utf-8'),
         b64encode(signature).decode(encoding='utf-8'),
     ))
    ```

    {% endcut %}

1. Передайте токен доступа пользователю через ваш сайт или любым другим способом.

## Работа пользователя с коннектором {#work-with-connector}

1. Получает токен доступа для {{ datalens-short-name }} на вашем сайте.
1. Переходит в {{ datalens-short-name }} {{ marketplace-short-name }}, приобретает коннектор или активирует бесплатный продукт.
1. Переходит на страницу [подключений {{ datalens-short-name }}]({{ link-datalens-main }}/connections/new) и выбирает активированный коннектор из списка.
1. Вводит переданный вами токен доступа на странице создания нового подключения. За счет этого подключение привязывается к БД, имя которой зашифровано в токене доступа. 

   {% cut "Пример подключения" %}

    ![image](../../../_assets/datalens/partners-connector.png)

   {% endcut %}

1. Сохраняет подключение. После этого в {{ datalens-short-name }} разворачивается стандартный дашборд на основе данных коннектора.

#### См. также

* [{#T}](../../concepts/marketplace.md)
