---
title: How to use gp_url_tools in {{ mgp-full-name }}
description: Follow this guide to use the gp_url_tools extension in {{ mgp-name }}.
---

# Using gp_url_tools in {{ mgp-name }}

The `gp_url_tools` extension enables you to encode URLs/URIs into a format supported by web browsers and to decode them back to the original format:

* `encode_url(text)`: Encoding a URL.
* `decode_url(text)`: Decoding a URL.
* `encode_uri(text)`: Encoding a URI.
* `decode_uri(text)`: Decoding a URI.

## Installing the gp_url_tools extension in a {{ GP }} cluster {#gp-url-tools-install}

1. [Connect](../connect.md) to the database as the owner or a user with the `CREATE` permission in the database and run this command:

    ```sql
    CREATE EXTENSION gp_url_tools;
    ```

    Installing the extension creates a schema named `url_tools_schema` and adds encoding and decoding functions to it.

1. Make sure that the extension is installed:

    ```sql
    SELECT extname FROM pg_extension;
    ```

## Use cases {#examples}

1. Create a table named `companies`:

    ```sql
    CREATE TABLE companies (
        id int NOT NULL,
        name varchar (50),
        site text,
        contact text,
        PRIMARY KEY (id)
    );
    ```

1. Insert data into the table:

    ```sql
    INSERT INTO companies VALUES
        (1, ‘Sever-1', 'http://север-1.рф/новости', 'mailto:офис@север-1.рф'),
        (2, ‘East Coast', 'east-coast.ru/about', 'mailto:sale@east-cost.ru');
    ```

1. Encode the website and email addresses:

    ```sql
    UPDATE companies SET 
        site = url_tools_schema.encode_url(site),
        contact = url_tools_schema.encode_uri(contact);
    ```

1. Check the result:

    ```sql
    SELECT name, site, contact FROM companies;
    ```

1. Decode the website and email addresses:

    ```sql
    UPDATE companies SET 
        site = url_tools_schema.decode_url(site),
        contact = url_tools_schema.decode_uri(contact);
    ```

1. Check the result:

    ```sql
    SELECT name, site, contact FROM companies;
    ```

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
