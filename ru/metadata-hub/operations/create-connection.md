---
title: Как создать подключение {{ metadata-hub-name }}. Пошаговые инструкции
description: Пошаговые инструкции по работе с {{ connection-manager-name }} в {{ yandex-cloud }}. Из статьи вы узнаете, как создавать подключения.
---

# Создание подключения

{% include notitle [preview](../../_includes/note-preview.md) %}

Вы можете создать подключения следующих типов:
* [к кластеру с управляемой базой данных](#mdb-connection):
  * [{{ mpg-name }}](#mdb-postgresql)
  * [{{ mch-name }}](#mdb-clickhouse)
  * [{{ mmy-name }}](#mdb-mysql)
  * [{{ mrd-name }}](#mdb-redis)
  * [{{ mos-name }}](#mdb-opensearch)
  * [{{ mmg-name }}](#mdb-mongodb)
* [к пользовательской инсталляции базы данных](#on-premise-connection):
  * [{{ PG }}](#postgresql-on-premise)
  * [{{ CH }}](#clickhouse-on-premise)
  * [{{ MY }}](#mysql-on-premise)
  * [{{ RD }}](#redis-on-premise)
  * [{{ VLK }}](#valkey-on-premise)
  * [{{ TR }}](#trino-on-premise)
  * [{{ OS }}](#opensearch-on-premise)
  * [{{ MG }}](#mongodb-on-premise)

## Подключение к кластеру с управляемой базой данных {#mdb-connection}

### {{ mpg-name }} {#mdb-postgresql}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
  1. Выберите сервис **{{ metadata-hub-full-name }}**.
  1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
  1. Укажите имя подключения.
  1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
  1. Выберите **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
  1. В разделе **Подключение к {{ PG }}** выберите **Кластер {{ mpg-short-name }}** в качестве типа подключения и укажите нужный кластер.
  1. В разделе **Аутентификация**:
      1. Укажите **Имя пользователя**, от лица которого будете подключаться к кластеру.
      1. Выберите способ задания пароля:
          * **Ввести вручную** — вы сами задаете пароль.
          * **Сгенерировать** — пароль генерируется автоматически. Вы можете настроить правила генерации пароля [{{ lockbox-short-name }}](../../lockbox/quickstart.md) или оставить правила, заданные по умолчанию.
  1. (Опционально) Перечислите базы данных, подключениями к которым вы хотите управлять. Подключиться можно только к существующим в этом кластере базам данных. У вас должен быть [настроен доступ к ним](../../managed-postgresql/security/index.md).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### {{ mch-name }} {#mdb-clickhouse}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
    1. Выберите сервис **{{ metadata-hub-full-name }}**.
    1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
    1. Укажите имя подключения.
    1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
    1. Выберите **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
    1. В разделе **Подключение к {{ CH }}** выберите **Кластер {{ mch-short-name }}** в качестве типа подключения и укажите нужный кластер.
    1. В разделе **Аутентификация**:
        1. Укажите **Имя пользователя**, от лица которого будете подключаться к кластеру.
        1. Выберите способ задания пароля:
            * **Ввести вручную** — вы сами задаете пароль.
            * **Сгенерировать** — пароль генерируется автоматически. Вы можете настроить правила генерации пароля [{{ lockbox-short-name }}](../../lockbox/quickstart.md) или оставить правила, заданные по умолчанию.
    1. (Опционально) Перечислите базы данных, подключениями к которым вы хотите управлять. У вас должен быть настроен доступ к ним.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### {{ mmy-name }} {#mdb-mysql}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
   1. Выберите сервис **{{ metadata-hub-full-name }}**.
   1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
   1. Укажите имя подключения.
   1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
   1. Выберите **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
   1. В разделе **Подключение к {{ MY }}** выберите **Кластер {{ mmy-short-name }}** в качестве типа подключения и укажите нужный кластер.
   1. В разделе **Аутентификация**:
        1. Укажите **Имя пользователя**, от лица которого будете подключаться к кластеру.
        1. Выберите способ задания пароля:
            * **Ввести вручную** — вы сами задаете пароль.
            * **Сгенерировать** — пароль генерируется автоматически. Вы можете настроить правила генерации пароля [{{ lockbox-short-name }}](../../lockbox/quickstart.md) или оставить правила, заданные по умолчанию.
   1. (Опционально) Перечислите базы данных, подключениями к которым вы хотите управлять. Подключиться можно только к существующим в этом кластере базам данных. У вас должен быть [настроен доступ к ним](../../managed-mysql/security/index.md).
   1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### {{ mrd-name }} {#mdb-redis}

{% list tabs group=instructions %}

- Консоль управления {#console}
    
    1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
    1. Выберите сервис **{{ metadata-hub-full-name }}**.
    1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
    1. Укажите имя подключения.
    1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
    1. В списке **{{ ui-key.yacloud.connection-manager.label_connection-type }}** выберите **{{ VLK }}**.
    1. В разделе **Подключение к {{ VLK }}** выберите **Кластер {{ mrd-short-name }}** в качестве типа подключения и укажите нужный кластер.
    1. В разделе **Аутентификация** выберите способ задания пароля:
         * **Ввести вручную** — введите значение пароля.
         * **Сгенерировать** — укажите опции для создания автоматически сгенерированного пароля [{{ lockbox-short-name }}](../../lockbox/quickstart.md).
    1. (Опционально) Перечислите базы данных, подключениями к которым вы хотите управлять. У вас должен быть настроен доступ к ним.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### {{ mos-name }} {#mdb-opensearch}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
   1. Выберите сервис **{{ metadata-hub-full-name }}**.
   1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
   1. Укажите имя подключения.
   1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
   1. Выберите **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
   1. В разделе **Подключение к {{ OS }}** выберите **Кластер {{ mos-short-name }}** в качестве типа подключения и укажите нужный кластер.
   1. В разделе **Аутентификация**:
        1. Укажите **Имя пользователя**, от лица которого будете подключаться к кластеру.
        1. Выберите способ задания пароля:
            * **Ввести вручную** — вы сами задаете пароль.
            * **Сгенерировать** — пароль генерируется автоматически. Вы можете настроить правила генерации пароля [{{ lockbox-short-name }}](../../lockbox/quickstart.md) или оставить правила, заданные по умолчанию.
   1. (Опционально) Перечислите базы данных, подключениями к которым вы хотите управлять. Подключиться можно только к существующим в этом кластере базам данных. У вас должен быть [настроен доступ к ним](../../managed-mysql/security/index.md).
   1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### {{ mmg-name }} {#mdb-mongodb}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
   1. Выберите сервис **{{ metadata-hub-full-name }}**.
   1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
   1. Укажите имя подключения.
   1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
   1. Выберите **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
   1. В разделе **Подключение к {{ MG }}** выберите **Кластер {{ mmg-short-name }}** в качестве типа подключения и укажите нужный кластер.
   1. В разделе **Аутентификация**:
        1. Укажите **Имя пользователя**, от лица которого будете подключаться к кластеру.
        1. Выберите способ задания пароля:
            * **Ввести вручную** — вы сами задаете пароль.
            * **Сгенерировать** — пароль генерируется автоматически. Вы можете настроить правила генерации пароля [{{ lockbox-short-name }}](../../lockbox/quickstart.md) или оставить правила, заданные по умолчанию.
   1. (Опционально) Перечислите базы данных, подключениями к которым вы хотите управлять. Подключиться можно только к существующим в этом кластере базам данных. У вас должен быть [настроен доступ к ним](../../managed-mysql/security/index.md).
   1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Подключение к пользовательской инсталляции базы данных {#on-premise-connection}

### {{ PG }} {#postgresql-on-premise}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
  1. Выберите сервис **{{ metadata-hub-full-name }}**.
  1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
  1. Укажите имя подключения.
  1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
  1. Выберите **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
  1. В разделе **Подключение к {{ PG }}** укажите параметры подключения:
      1. В поле **{{ ui-key.yacloud.connection-manager.label_connection-type }}** выберите **Пользовательская инсталляция**.
      1. В поле **Хосты** укажите адрес хоста c базой данных и номер порта для подключения.

          Если вы создаете подключение к пользовательской инсталляции базы данных для использования с [{{ datalens-full-name }}](../../datalens/concepts/index.md), укажите внешний адрес хоста.

      1. (Опционально) Включите использование [TLS](../../glossary/tls.md).
          Если в вашей компании есть [центр сертификации (CA)](../../glossary/tls.md#authentication), по умолчанию будет использоваться выпущенный им сертификат. Если в компании нет СА, загрузите TLS-сертификат сервера.
          
  1. В разделе **Аутентификация**:
      1. Укажите **Имя пользователя**, от лица которого будете подключаться к базе данных.
      1. Выберите способ задания пароля:
          * **Ввести вручную** — вы сами задаете пароль.
          * **Сгенерировать** — пароль генерируется автоматически. Вы можете настроить правила генерации пароля [{{ lockbox-short-name }}](../../lockbox/quickstart.md) или оставить правила, заданные по умолчанию.
  1. (Опционально) Перечислите базы данных, подключениями к которым вы хотите управлять. У вас должен быть настроен доступ к ним.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### {{ CH }} {#clickhouse-on-premise}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
    1. Выберите сервис **{{ metadata-hub-full-name }}**.
    1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
    1. Укажите имя подключения.
    1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
    1. Выберите **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
    1. В разделе **Подключение к {{ CH }}** укажите параметры подключения:
        1. В поле **{{ ui-key.yacloud.connection-manager.label_connection-type }}** выберите **Пользовательская инсталляция**.
        1. В поле **Хосты** укажите [FQDN](../../glossary/fqdn.md) или IP-адреса хостов, входящих в шард, номер HTTP- или TCP-порта для подключения и имя [шарда](../../managed-clickhouse/operations/shards.md#list-shards).

            Если вы создаете подключение к пользовательской инсталляции базы данных для использования с [{{ datalens-full-name }}](../../datalens/concepts/index.md), укажите внешние IP-адреса хостов.

        1. (Опционально) Включите использование [TLS](../../glossary/tls.md).
            Если в вашей компании есть [центр сертификации (CA)](../../glossary/tls.md#authentication), по умолчанию будет использоваться выпущенный им сертификат. Если в компании нет СА, загрузите TLS-сертификат сервера.
    1. В разделе **Аутентификация**:
        1. Укажите **Имя пользователя**, от лица которого будете подключаться к базе данных.
        1. Выберите способ задания пароля:
            * **Ввести вручную** — вы сами задаете пароль.
            * **Сгенерировать** — пароль генерируется автоматически. Вы можете настроить правила генерации пароля [{{ lockbox-short-name }}](../../lockbox/quickstart.md) или оставить правила, заданные по умолчанию.
    1. (Опционально) Перечислите базы данных, подключениями к которым вы хотите управлять. У вас должен быть настроен доступ к ним.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### {{ MY }} {#mysql-on-premise}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
   1. Выберите сервис **{{ metadata-hub-full-name }}**.
   1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
   1. Укажите имя подключения.
   1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
   1. Выберите **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
   1. В разделе **Подключение к {{ MY }}** укажите параметры подключения:
       1. В поле **{{ ui-key.yacloud.connection-manager.label_connection-type }}** выберите **Пользовательская инсталляция**.
       1. В поле **Хосты** укажите адрес хоста c базой данных и номер порта для подключения.

           Если вы создаете подключение к пользовательской инсталляции базы данных для использования с [{{ datalens-full-name }}](../../datalens/concepts/index.md), укажите внешний адрес хоста.

       1. (Опционально) Включите использование [TLS](../../glossary/tls.md).
           Если в вашей компании есть [центр сертификации (CA)](../../glossary/tls.md#authentication), по умолчанию будет использоваться выпущенный им сертификат. Если в компании нет СА, загрузите TLS-сертификат сервера.
           
   1. В разделе **Аутентификация**:
       1. Укажите **Имя пользователя**, от лица которого будете подключаться к базе данных.
       1. Выберите способ задания пароля:
           * **Ввести вручную** — вы сами задаете пароль.
           * **Сгенерировать** — пароль генерируется автоматически. Вы можете настроить правила генерации пароля [{{ lockbox-short-name }}](../../lockbox/quickstart.md) или оставить правила, заданные по умолчанию.
   1. (Опционально) Перечислите базы данных, подключениями к которым вы хотите управлять. У вас должен быть настроен доступ к ним.
   1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### {{ RD }} {#redis-on-premise}

{% list tabs group=instructions %}

- Консоль управления {#console}
    
    1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
    1. Выберите сервис **{{ metadata-hub-full-name }}**.
    1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
    1. Укажите имя подключения.
    1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
    1. В списке **{{ ui-key.yacloud.connection-manager.label_connection-type }}** выберите **{{ RD }}**.
    1. В разделе **Подключение к {{ RD }}** укажите параметры подключения:
       1. В поле **{{ ui-key.yacloud.connection-manager.label_connection-type }}** выберите **Пользовательская инсталляция**.
       1. В поле **Хосты** укажите [FQDN](../../glossary/fqdn.md) или IP-адреса хостов, входящих в шард, номер HTTP- или TCP-порта для подключения и имя шарда.
       1. (Опционально) Включите использование [TLS](../../glossary/tls.md).
    1. В разделе **Аутентификация** укажите имя пользователя и выберите способ задания пароля: 
        * **Ввести вручную** — введите значение пароля.
        * **Сгенерировать** — укажите опции для создания автоматически сгенерированного пароля [{{ lockbox-short-name }}](../../lockbox/quickstart.md).
    1. (Опционально) Перечислите базы данных, подключениями к которым вы хотите управлять. У вас должен быть настроен доступ к ним.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### {{ VLK }} {#valkey-on-premise}

{% list tabs group=instructions %}

- Консоль управления {#console}
    
    1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
    1. Выберите сервис **{{ metadata-hub-full-name }}**.
    1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
    1. Укажите имя подключения.
    1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
    1. В списке **{{ ui-key.yacloud.connection-manager.label_connection-type }}** выберите **{{ VLK }}**.
    1. В разделе **Подключение к {{ VLK }}** укажите параметры подключения:
       1. В поле **{{ ui-key.yacloud.connection-manager.label_connection-type }}** выберите **Пользовательская инсталляция**.
       1. В поле **Хосты** укажите [FQDN](../../glossary/fqdn.md) или IP-адреса хостов, входящих в шард, номер HTTP- или TCP-порта для подключения и имя [шарда](../../managed-redis/operations/connect/sharded.md).

           Если вы создаете подключение к пользовательской инсталляции базы данных для использования с [{{ datalens-full-name }}](../../datalens/concepts/index.md), укажите внешние IP-адреса хостов.

       1. (Опционально) Включите использование [TLS](../../glossary/tls.md).
    1. В разделе **Аутентификация** укажите имя пользователя и выберите способ задания пароля: 
        * **Ввести вручную** — введите значение пароля.
        * **Сгенерировать** — укажите опции для создания автоматически сгенерированного пароля [{{ lockbox-short-name }}](../../lockbox/quickstart.md).
    1. (Опционально) Перечислите базы данных, подключениями к которым вы хотите управлять. У вас должен быть настроен доступ к ним.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### {{ TR }} {#trino-on-premise}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
  1. Выберите сервис **{{ metadata-hub-full-name }}**.
  1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
  1. Укажите имя подключения.
  1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
  1. Выберите **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
  1. В разделе **Подключение к {{ TR }}** укажите параметры подключения:
      1. В поле **Координатор** укажите адрес хоста [координатора](https://trino.io/docs/current/overview/concepts.html#coordinator) и номер порта для подключения. 
      1. (Опционально) Включите использование [TLS](../../glossary/tls.md).
          Если в вашей компании есть [центр сертификации (CA)](../../glossary/tls.md#authentication), по умолчанию будет использоваться выпущенный им сертификат. Если в компании нет СА, загрузите TLS-сертификат сервера.
  1. В разделе **Аутентификация**:
      1. Укажите **Имя пользователя**, от лица которого будете подключаться к базе данных.
      1. Выберите способ задания пароля:
          * **Ввести вручную** — вы сами задаете пароль.
          * **Сгенерировать** — пароль генерируется автоматически. Вы можете настроить правила генерации пароля [{{ lockbox-short-name }}](../../lockbox/quickstart.md) или оставить правила, заданные по умолчанию.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### {{ OS }} {#opensearch-on-premise}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
   1. Выберите сервис **{{ metadata-hub-full-name }}**.
   1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
   1. Укажите имя подключения.
   1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
   1. Выберите **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
   1. В разделе **Подключение к {{ OS }}** укажите параметры подключения:
       1. В поле **{{ ui-key.yacloud.connection-manager.label_connection-type }}** выберите **Пользовательская инсталляция**.
       1. В поле **Хосты** укажите адрес хоста с базой данных и номер порта для подключения.
       1. (Опционально) Включите использование [TLS](../../glossary/tls.md).
           Если в вашей компании есть [центр сертификации (CA)](../../glossary/tls.md#authentication), по умолчанию будет использоваться выпущенный им сертификат. Если в компании нет СА, загрузите TLS-сертификат сервера.
   1. В разделе **Аутентификация**:
       1. Укажите **Имя пользователя**, от лица которого будете подключаться к базе данных.
       1. Выберите способ задания пароля:
           * **Ввести вручную** — вы сами задаете пароль.
           * **Сгенерировать** — пароль генерируется автоматически. Вы можете настроить правила генерации пароля [{{ lockbox-short-name }}](../../lockbox/quickstart.md) или оставить правила, заданные по умолчанию.
   1. (Опционально) Перечислите базы данных, подключениями к которым вы хотите управлять. У вас должен быть настроен доступ к ним.
   1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### {{ MG }} {#mongodb-on-premise}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
   1. Выберите сервис **{{ metadata-hub-full-name }}**.
   1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
   1. Укажите имя подключения.
   1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
   1. Выберите **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
   1. В разделе **Подключение к {{ MG }}** укажите параметры подключения:
       1. В поле **{{ ui-key.yacloud.connection-manager.label_connection-type }}** выберите **Пользовательская инсталляция**.
       1. В поле **Хосты** укажите адрес хоста с базой данных и номер порта для подключения.
       1. (Опционально) Включите использование [TLS](../../glossary/tls.md). 
           Если в вашей компании есть [центр сертификации (CA)](../../glossary/tls.md#authentication), по умолчанию будет использоваться выпущенный им сертификат. Если в компании нет СА, загрузите TLS-сертификат сервера.
   1. В разделе **Аутентификация**:
       1. Укажите **Имя пользователя**, от лица которого будете подключаться к базе данных.
       1. Выберите способ задания пароля:
           * **Ввести вручную** — вы сами задаете пароль.
           * **Сгенерировать** — пароль генерируется автоматически. Вы можете настроить правила генерации пароля [{{ lockbox-short-name }}](../../lockbox/quickstart.md) или оставить правила, заданные по умолчанию.
   1. (Опционально) Перечислите базы данных, подключениями к которым вы хотите управлять. У вас должен быть настроен доступ к ним.
   1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}


{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
