# Подключение к базе данных в кластере {{ MY }}

К хостам кластера {{ mmy-short-name }} можно подключиться:

{% include [cluster-connect-note](../../_includes/mdb/cluster-connect-note.md) %}

{% note info %}

Если публичный доступ в вашем кластере настроен только для некоторых хостов, автоматическая смена мастера может привести к тому, что вы не сможете подключиться к мастеру из интернета.

{% endnote %}


## Настройка SSL-сертификата {#configuring-an-ssl-certificate}

{{ MY }}-хосты с публичным доступом поддерживают только соединения с SSL-сертификатом. Подготовить сертификат можно так:


```bash
mkdir ~/.mysql && \
wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" -O ~/.mysql/root.crt && \
chmod 0600 ~/.mysql/root.crt
```



## Примеры строк подключения {#connection-string}

{% include [conn-strings-environment](../../_includes/mdb/mdb-conn-strings-env.md) %}

Вы можете подключаться к {{ MY }}-хостам в публичном доступе только с использованием SSL-сертификата. Перед подключением к таким хостам [подготовьте сертификат](#configuring-an-ssl-certificate).

В этих примерах предполагается, что сертификат `root.crt` расположен в директории `/home/<домашняя директория>/.mysql/`. 

Подключение без использования SSL-сертификата поддерживается только для хостов, находящихся не в публичном доступе. В этом случае трафик внутри виртуальной сети при подключении к БД шифроваться не будет.

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [mmy-connection-strings](../../_includes/mdb/mmy-conn-strings.md) %}

При успешном подключении к кластеру и выполнении тестового запроса будет выведена версия {{ MY }}.

## Подключение к мастеру {#Connecting-to-master}

На текущий мастер в кластере всегда указывает хост вида `c-<идентификатор кластера>.rw.{{ dns-zone }}`. Например, для кластера с идентификатором `c9qash3nb1v9ulc8j9nm` к мастеру можно подключиться так:

```bash
mysql --host=c-c9qash3nb1v9ulc8j9nm.rw.mdb.yandexcloud.net
      --port=3306
      --ssl-ca=~/.mysql/root.crt
      --ssl-mode=REQUIRED
      --user=<имя пользователя базы данных>
      --password <имя базы данных>
```
