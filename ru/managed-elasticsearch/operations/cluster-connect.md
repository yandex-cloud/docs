# Подключение к кластеру

К хостам кластера {{ mes-name }} с [ролью _Data node_](../concepts/hosts-roles.md#data-node) можно подключиться:

- Через интернет, если вы настроили публичный доступ для нужного хоста.
- С виртуальных машин {{ yandex-cloud }}, расположенных в той же [виртуальной сети](../../vpc/concepts/network.md).

Вне зависимости от способа подключения, {{ mes-name }} поддерживает только соединения с [SSL-сертификатом](#configuring-an-ssl-certificate) к хостам кластера.

## Настройка SSL-сертификата {#configuring-an-ssl-certificate}

Подготовить SSL-сертификат можно так:


```bash
mkdir ~/.elasticsearch && \
wget  "https://{{ s3-storage-host }}{{ pem-path }}" -O ~/.elasticsearch/root.crt && \
chmod 0600 ~/.elasticsearch/root.crt
```

## Автоматический выбор хоста для подключения {#automatic-host-selection}

При подключении к кластеру {{ ES }} вы можете:
- Явно задать имена хостов с ролью _Data node_ в строках подключения. 
  
  Этот способ подходит для любого способа подключения. Например, его можно использовать для подключения через интернет в случае, когда только нескольким хостам назначен публичный IP-адрес.
  
- Использовать специальный FQDN вида `c-<идентификатор кластера {{ ES }}>.rw.mdb.yandexcloud.net` (например, `https://c-e4ut2....rw.mdb.yandexcloud.net`).

  Этот способ подходит только в том случае, если все хосты с ролью _Data node_ имеют публичный IP-адрес или же подключение осуществляется только с виртуальных машин {{ yandex-cloud }}. Это связано с тем, что хост для подключения, на который указывает этот FQDN, выбирается случайным образом среди все хостов с ролью _Data node_. 

## Примеры строк подключения {#connection-string}

{% include [conn-strings-environment](../../_includes/mdb/mes-conn-strings-env.md) %}

Перед подключением [подготовьте сертификат](#configuring-an-ssl-certificate). В этих примерах предполагается, что сертификат `root.crt` расположен в директории `/home/<домашняя директория>/.elasticsearch/`. 

Для подключения нужно использовать имя пользователя и пароль, которые были заданы при [создании кластера](cluster-create.md#create-cluster).

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [mes-connection-strings](../../_includes/mdb/mes-conn-strings.md) %}

При успешном подключении будет выведена общая информация о кластере {{ ES }}.
