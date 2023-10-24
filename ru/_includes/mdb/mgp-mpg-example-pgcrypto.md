## Примеры использования

### Однонаправленное шифрование

1. Создайте таблицу:

    ```sql
    CREATE TABLE tbl_one_way_crypt(username varchar(100) PRIMARY KEY, cryptpwd text);
    ```

1. Вставьте данные с хешированным текстом в столбце `cryptpwd`:

    ```sql
    INSERT INTO tbl_one_way_crypt(username, cryptpwd)
        VALUES ('bob', crypt('Password123', gen_salt('md5'))),
               ('alice', crypt('Password123', gen_salt('md5')));
    ```

1. Проверьте, что данные в столбце `cryptpwd` зашифрованы:

    ```sql
    SELECT * FROM tbl_one_way_crypt;
    ```

1. Проверьте, что в зашифрованных данных хранится текст `Password123`:

    ```sql
    SELECT username FROM tbl_one_way_crypt
    WHERE cryptpwd = crypt('Password123', cryptpwd);
    ```

### Симметричное шифрование

1. Создайте таблицу:

    ```sql
    CREATE TABLE tbl_sym_crypt (username varchar(100) PRIMARY KEY, crypttext text);
    ```

1. Вставьте данные с зашифрованным текстом в столбце `crypttext`:

    ```sql
    INSERT INTO tbl_sym_crypt (username, crypttext) 
        VALUES ('bob', pgp_sym_encrypt('Text to encrypt','!qazSymKeyXsw2')),
               ('alice', pgp_sym_encrypt('Secret Data','!qazSymKeyXsw2'));
    ```

1. Проверьте, что данные в столбце `crypttext` зашифрованы:

    ```sql
    SELECT * FROM tbl_sym_crypt;
    ```

1. Получите расшифрованные данные, явно указав тип данных `bytea`:

    ```sql
    SELECT username, pgp_sym_decrypt(crypttext::bytea, '!qazSymKeyXsw2')
    FROM tbl_sym_crypt;
    ```

### Ассиметричное шифрование

1. Подготовьте пару ключей с помощью утилиты [GnuPG](https://www.gnupg.org/download/index.html):

    1. Создайте пару ключей:

        ```bash
        gpg --gen-key
        ```

        Укажите `USER-ID` ключа (`Real name` и `Email address`) и `Passphrase`.

    1. Экспортируйте ключи в файлы:

        ```bash
        gpg -a --export <Real_name_ключа> > public.key && \
        gpg -a --export-secret-keys <Real_name_ключа> > private.key
        ```

1. Создайте таблицу:

    ```sql
    CREATE TABLE tbl_asym_crypt(ssn_id SERIAL PRIMARY KEY,
        username varchar(100), ssn bytea);
    ```

1. Вставьте данные с зашифрованным текстом в столбце `ssn` с помощью публичного ключа:

    ```sql
    INSERT INTO tbl_asym_crypt (username, ssn)
    SELECT tmp.username, pgp_pub_encrypt(tmp.ssn, keys.pubkey) AS tbl
    FROM (
        VALUES ('Alice', '123-45-6788'), ('Bob', '123-45-6799'))
        AS tmp(username, ssn)
    CROSS JOIN (SELECT  dearmor('<содержимое_файла_public.key>') AS pubkey) AS keys;
    ```

1. Проверьте, что данные с столбце `ssn` зашифрованы:

    ```sql
    SELECT * FROM tbl_asym_crypt;
    ```

1. Расшифруйте данные в столбце `ssn` с помощью закрытого ключа:

    ```sql
    SELECT username, pgp_pub_decrypt(ssn, keys.privkey, '<Passphrase_ключа>')
        AS decrypted_ssn FROM tbl_asym_crypt
    CROSS JOIN (SELECT dearmor('<содержимое_файла_private.key>') AS privkey) AS keys;
    ```
