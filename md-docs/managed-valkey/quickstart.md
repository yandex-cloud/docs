[Документация Yandex Cloud](../index.md) > [Yandex Managed Service for Valkey™](index.md) > Начало работы

# Как начать работать с Yandex Managed Service for Valkey™

Чтобы начать работу с сервисом:


1. [Создайте кластер](#cluster-create).
1. [Подключитесь к кластеру](#connect).



## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь, если вы еще не зарегистрированы.

1. Если у вас еще нет каталога, создайте его:

   1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![image](../_assets/console-icons/layout-side-content-left.svg) или ![image](../_assets/console-icons/chevron-down.svg) и выберите нужное [облако](../resource-manager/concepts/resources-hierarchy.md#cloud).
   1. Справа от названия облака нажмите ![image](../_assets/console-icons/ellipsis.svg).
   1. Выберите ![image](../_assets/console-icons/plus.svg) **Создать каталог**.
   
      ![create-folder1](../_assets/resource-manager/create-folder-1.png)
   
   1. Введите имя [каталога](../resource-manager/concepts/resources-hierarchy.md#folder). Требования к имени:
   
       * длина — от 3 до 63 символов;
       * может содержать строчные буквы латинского алфавита, цифры и дефисы;
       * первый символ — буква, последний — не дефис.
   
   1. (Опционально) Введите описание каталога.
   1. Выберите опцию **Создать сеть по умолчанию**. Будет создана [сеть](../vpc/concepts/network.md#network) с подсетями в каждой зоне доступности. Также в этой сети будет создана [группа безопасности по умолчанию](../vpc/concepts/security-groups.md#default-security-group), внутри которой весь сетевой трафик разрешен.
   1. Нажмите кнопку **Создать**.
   
      ![create-folder2](../_assets/resource-manager/create-folder-2.png)

1. [Назначьте](../iam/operations/roles/grant.md) вашему аккаунту в Yandex Cloud роли:

    * [managed-redis.editor](security/index.md#managed-redis-editor) или выше — чтобы создать кластер;
    * [vpc.user](../vpc/security/index.md#vpc-user) — чтобы работать с [сетью](../vpc/concepts/network.md#network) кластера;
    * [mdb.viewer](../iam/roles-reference.md#mdb-viewer) — чтобы просматривать кластеры управляемых баз данных (MDB) на дашборде в [консоли управления](https://console.yandex.cloud).

    {% note info %}
    
    Если вы не можете управлять ролями, обратитесь к администратору вашего облака или организации.
    
    {% endnote %}

1. [Создайте виртуальную машину Linux](../compute/operations/vm-create/create-linux-vm.md#console_1).

    Укажите следующие параметры:

    * **Образ загрузочного диска** — `Ubuntu 24.04` из Marketplace.
    * **Публичный IP-адрес** — `Автоматически`.
    * **Группы безопасности** — оставьте поле пустым.

        Виртуальной машине будет автоматически назначена [группа безопасности по умолчанию](../vpc/concepts/security-groups.md#default-security-group) (с префиксом `default-sg`). Такая группа разрешает подключение к виртуальной машине по SSH, а также разрешает любой исходящий трафик.

    Прочие параметры выберите на свое усмотрение.

1. [Создайте группу безопасности](../vpc/operations/security-group-create.md) в той же сети, в которой находится виртуальная машина. Эта группа безопасности будет назначена кластеру Valkey™ при его создании.

    Добавьте в группу [правило](operations/connect/index.md#configuring-security-groups), разрешающее подключение к [нешардированному кластеру](concepts/sharding.md) Valkey™. Настройте правило так, чтобы был разрешен входящий трафик из группы безопасности по умолчанию, назначенной виртуальной машине.


## Создайте кластер {#cluster-create}


Создайте нешардированный кластер Valkey™ [без публичного доступа](concepts/network.md#public-access-to-host). К такому кластеру можно [подключиться](#connect) только с виртуальной машины, размещенной в сети кластера.


Чтобы создать кластер:

1. В консоли управления выберите каталог, в котором нужно создать кластер Valkey™.
1. Перейдите в сервис **Yandex Managed Service for&nbsp;Valkey™**.
1. Нажмите кнопку **Создать кластер**.
1. Укажите следующие параметры кластера:

    * **Базовые параметры**:

        * **Имя кластера** — имя кластера. Оно должно быть уникальным в рамках каталога.
        * **Шардирование кластера** — оставьте опцию выключенной.
        * **Поддержка TLS** — включите опцию.
        * **Использовать FQDN вместо IP-адресов** — включите опцию.

    * **Сетевые настройки**:

        * **Сеть** — укажите сеть, в которой находится [созданная ранее](#before-you-begin) виртуальная машина.
        * **Группы безопасности** — укажите [созданную ранее](#before-you-begin) группу безопасности для кластера.

    * **Хосты** → **Публичный доступ** — убедитесь, что эта опция выключена (имеет значение `Нет`) для всех хостов кластера.

    * **Настройки СУБД** → **Пароль** — пароль пользователя.

        Допустимая длина пароля — от 8 до 128 символов. Пароль должен удовлетворять регулярному выражению `[a-zA-Z0-9@=+?*.,!&#$^<>_-]*`.

1. Нажмите кнопку **Создать кластер**.
1. Дождитесь, когда кластер будет готов к работе: его статус на панели Yandex Managed Service for Valkey™ сменится на **Running**, а состояние — на **Alive**. Это может занять некоторое время.

Подробнее о создании кластера читайте в разделе [Создание кластера Valkey™](operations/cluster-create.md).


## Подключитесь к кластеру {#connect}

1. [Подключитесь](../compute/operations/vm-connect/ssh.md) по SSH к [созданной ранее виртуальной машине](#before-you-begin).

1. Установите утилиту `redis-cli`:

    ```bash
    sudo apt update && sudo apt install --yes redis-tools
    ```

1. Подключитесь напрямую к мастеру:

    {% list tabs group=connection %}

    - Подключение без SSL {#without-ssl}

        ```bash
        redis-cli -h c-<идентификатор_кластера>.rw.mdb.yandexcloud.net \
          -p 6379 \
          -a <пароль_Valkey™>
        ```

    - Подключение с SSL {#with-ssl}

        1. Получите [SSL-сертификат](../glossary/ssl-certificate.md):

            ```bash
            mkdir -p ~/.redis && \
            wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" \
                 --output-document ~/.redis/YandexInternalRootCA.crt && \
            chmod 0655 ~/.redis/YandexInternalRootCA.crt
            ```
            
            Сертификат будет сохранен в файле `~/.redis/YandexInternalRootCA.crt`.

        1. Выполните команду:

            ```bash
            redis-cli -h c-<идентификатор_кластера>.rw.mdb.yandexcloud.net \
              -p 6380 \
              -a <пароль_Valkey™> \
              --tls \
              --cacert ~/.redis/YandexInternalRootCA.crt
            ```

    {% endlist %}

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](operations/cluster-list.md#list-clusters).

    Примеры кода с заполненным FQDN хоста доступны в [консоли управления](https://console.yandex.cloud) по нажатию кнопки **Подключиться** на странице кластера.

1. После успешного подключения отправьте команду `PING`. Valkey™ должен вернуть ответ `PONG`.


## Что дальше {#whats-next}

* Изучите [концепции сервиса](concepts/index.md).
* Узнайте подробнее о [создании кластера](operations/cluster-create.md) и [подключении к кластеру](operations/connect/index.md).
* Ознакомьтесь с [вопросами и ответами](qa/general.md).