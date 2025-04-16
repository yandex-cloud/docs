* **Core**{#setting-core} {{ tag-con }} {{ tag-api }}

    Настройки файловой системы и правил безопасности.

    Подробнее см. в [документации Apache Hadoop](https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/core-default.xml).

    * **Default Fs**{#setting-default-fs}

        URI, который определяет файловую систему HDFS.

    * **Security Auth To Local**{#setting-security-auth-to-local}

        Правила сопоставления участников Kerberos с учетными записями пользователей операционной системы.

* **Kerberos**{#setting-kerberos} {{ tag-con }} {{ tag-api }}

    Настройки сетевого протокола аутентификации Kerberos.

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}/7/greenplum-database/admin_guide-kerberos.html).

    * **Enable**{#setting-enable}

        Определяет, будет ли использоваться сервер аутентификации Kerberos. По умолчанию не используется.

    * **Primary**{#setting-primary}

        Хост основного сервера KDC (Key Distribution Center).

    * **Realm**{#setting-realm}

        Область Kerberos для базы данных {{ GP }}.

    * **Kdc Servers**{#setting-kdc-servers}

        Хосты серверов KDC.

    * **Admin server**{#setting-admin-server}

        Хост сервера администрирования. Обычно это основной сервер Kerberos.

    * **Default domain**{#setting-default-domain}

        Домен, который используется для расширения имен хостов. Применим, когда участники-службы Kerberos 4 становятся участниками-службами Kerberos 5 (например, rcmd.hostname заменяется на host/hostname.domain).

    * **Keytab Base64**{#setting-keytab-base64}

        Содержимое keytab-файла в кодировке Base64.

* **User Impersonation**{#setting-user-impersonation} {{ tag-con }} {{ tag-api }}

    Определяет, можно ли аутентифицироваться во внешнем файловом хранилище или СУБД от лица пользователя {{ GP }}.

    По умолчанию аутентификация запрещена.

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}-platform-extension-framework/6-11/gp-pxf/cfg_server.html).

* **Username**{#setting-username} {{ tag-con }} {{ tag-api }}

    Имя пользователя, с помощью которого выполняется подключение к внешнему файловому хранилищу или СУБД, если аутентификация от имени другого пользователя отключена.

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}-platform-extension-framework/6-11/gp-pxf/cfg_server.html#about-the-pxfsitexml-configuration-file-3).

* **Sasl Connection Retries**{#setting-sasl-connection-retries} {{ tag-con }} {{ tag-api }}

    Максимальное количество повторных попыток PXF выполнить запрос на подключение SASL, если возникла ошибка `GSS initiate failed`.

    Значение по умолчанию — `5`.

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}-platform-extension-framework/6-11/gp-pxf/cfg_server.html#about-the-pxfsitexml-configuration-file-3).

* **ZK Hosts**{#setting-zk-hosts} {{ tag-con }} {{ tag-api }}

    Хосты серверов ZooKeeper. Значения указываются в формате `<адрес>:<порт>`.

    Подробнее см. в [документации Apache Hadoop](https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/core-default.xml).