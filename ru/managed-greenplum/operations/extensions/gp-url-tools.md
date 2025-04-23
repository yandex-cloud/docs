---
title: Как использовать расширение gp_url_tools в {{ mgp-full-name }}
description: Следуя данной инструкции, вы сможете использовать расширение gp_url_tools в {{ mgp-name }}.
---

# Использование gp_url_tools в {{ mgp-name }}

Расширение `gp_url_tools` предоставляет функции, которые позволяют кодировать адреса URL/URI в формат, принимаемый веб-браузерами, и декодировать их в исходный формат:

* `encode_url(text)` — кодирование URL;
* `decode_url(text)` — декодирование URL;
* `encode_uri(text)` — кодирование URI;
* `decode_uri(text)` — декодирование URI.

## Установить расширение gp_url_tools в кластер {{ GP }} {#gp-url-tools-install}

1. [Подключитесь](../connect.md) к базе данных от имени владельца или пользователя, имеющего в базе данных разрешение `CREATE`, и выполните команду:

    ```sql
    CREATE EXTENSION gp_url_tools;
    ```

    При установке расширения создается схема `url_tools_schema`, в которую добавляются функции кодирования и декодирования.

1. Проверьте, что расширение было установлено:

    ```sql
    SELECT extname FROM pg_extension;
    ```

## Примеры использования {#examples}

1. Создайте таблицу `companies`:

    ```sql
    CREATE TABLE companies (
        id int NOT NULL,
        name varchar (50),
        site text,
        contact text,
        PRIMARY KEY (id)
    );
    ```

1. Вставьте данные в таблицу:

    ```sql
    INSERT INTO companies VALUES
        (1, 'Север-1', 'http://север-1.рф/новости', 'mailto:офис@север-1.рф'),
        (2, 'Восточный берег', 'east-coast.ru/about', 'mailto:sale@east-cost.ru');
    ```

1. Закодируйте адреса сайтов и электронной почты:

    ```sql
    UPDATE companies SET 
        site = url_tools_schema.encode_url(site),
        contact = url_tools_schema.encode_uri(contact);
    ```

1. Проверьте результат:

    ```sql
    SELECT name, site, contact FROM companies;
    ```

1. Декодируйте адреса сайтов и электронной почты:

    ```sql
    UPDATE companies SET 
        site = url_tools_schema.decode_url(site),
        contact = url_tools_schema.decode_uri(contact);
    ```

1. Проверьте результат:

    ```sql
    SELECT name, site, contact FROM companies;
    ```

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
