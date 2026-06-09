# Как начать работать с {{ mrd-name }}

Чтобы начать работу с сервисом:


1. [Создайте кластер](#cluster-create).
1. [Подключитесь к кластеру](#connect).



## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.

1. Если у вас еще нет каталога, создайте его:

   1. В [консоли управления]({{ link-console-main }}) на панели сверху нажмите ![image](../_assets/console-icons/layout-side-content-left.svg) или ![image](../_assets/console-icons/chevron-down.svg) и выберите нужное [облако](../resource-manager/concepts/resources-hierarchy.md#cloud).
   1. Справа от названия облака нажмите ![image](../_assets/console-icons/ellipsis.svg).
   1. Выберите ![image](../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
   
      ![create-folder1](../_assets/resource-manager/create-folder-1.png)
   
   1. Введите имя [каталога](../resource-manager/concepts/resources-hierarchy.md#folder). Требования к имени:
   
       * длина — от 3 до 63 символов;
       * может содержать строчные буквы латинского алфавита, цифры и дефисы;
       * первый символ — буква, последний — не дефис.
   
   1. (Опционально) Введите описание каталога.
   1. Выберите опцию **{{ ui-key.yacloud.iam.cloud.folders-create.field_default-net }}**. Будет создана [сеть](../vpc/concepts/network.md#network) с подсетями в каждой зоне доступности. Также в этой сети будет создана [группа безопасности по умолчанию](../vpc/concepts/security-groups.md#default-security-group), внутри которой весь сетевой трафик разрешен.
   1. Нажмите кнопку **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.
   
      ![create-folder2](../_assets/resource-manager/create-folder-2.png)

1. [Назначьте](../iam/operations/roles/grant.md) вашему аккаунту в {{ yandex-cloud }} роль [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user) и роль [{{ roles.mrd.editor }} или выше](security/index.md#roles-list). Эти роли позволяют создать кластер.

    {% note info %}
    
    Если вы не можете управлять ролями, обратитесь к администратору вашего облака или организации.
    
    {% endnote %}

1. [Создайте виртуальную машину Linux](../compute/operations/vm-create/create-linux-vm.md#console_1).

    Укажите следующие параметры:

    * **{{ ui-key.yacloud.compute.instances.create.section_image }}** — `Ubuntu 24.04` из {{ marketplace-short-name }}.
    * **{{ ui-key.yacloud.component.compute.network-select.field_external }}** — `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.
    * **{{ ui-key.yacloud.compute.instances.create.field_security-groups }}** — оставьте поле пустым.

        Виртуальной машине будет автоматически назначена [группа безопасности по умолчанию](../vpc/concepts/security-groups.md#default-security-group) (с префиксом `default-sg`). Такая группа разрешает подключение к виртуальной машине по SSH, а также разрешает любой исходящий трафик.

    Прочие параметры выберите на свое усмотрение.

1. [Создайте группу безопасности](../vpc/operations/security-group-create.md) в той же сети, в которой находится виртуальная машина. Эта группа безопасности будет назначена кластеру {{ VLK }} при его создании.

    Добавьте в группу [правило](operations/connect/index.md#configuring-security-groups), разрешающее подключение к [нешардированному кластеру](concepts/sharding.md) {{ VLK }}. Настройте правило так, чтобы был разрешен входящий трафик из группы безопасности по умолчанию, назначенной виртуальной машине.


## Создайте кластер {#cluster-create}


Создайте нешардированный кластер {{ VLK }} [без публичного доступа](concepts/network.md#public-access-to-host). К такому кластеру можно [подключиться](#connect) только с виртуальной машины, размещенной в сети кластера.


Чтобы создать кластер:

1. В консоли управления выберите каталог, в котором нужно создать кластер {{ VLK }}.
1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
1. Укажите следующие параметры кластера:

    * **{{ ui-key.yacloud.mdb.forms.section_base }}**:

        * **{{ ui-key.yacloud.mdb.forms.base_field_name }}** — имя кластера. Оно должно быть уникальным в рамках каталога.
        * **{{ ui-key.yacloud.mdb.forms.field_cluster-mode }}** — оставьте опцию выключенной.
        * **{{ ui-key.yacloud.redis.field_tls-support }}** — включите опцию.
        * **{{ ui-key.yacloud.redis.field_announce-hostnames }}** — включите опцию.

    * **{{ ui-key.yacloud.mdb.forms.section_network }}**:

        * **Сеть** — укажите сеть, в которой находится [созданная ранее](#before-you-begin) виртуальная машина.
        * **{{ ui-key.yacloud.mdb.forms.field_security-group }}** — укажите [созданную ранее](#before-you-begin) группу безопасности для кластера.

    * **{{ ui-key.yacloud.mdb.forms.section_host }}** → **{{ ui-key.yacloud.mdb.forms.host_column_assign_public_ip }}** — убедитесь, что эта опция выключена (имеет значение `Нет`) для всех хостов кластера.

    * **{{ ui-key.yacloud.mdb.forms.section_settings }}** → **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}** — пароль пользователя.

        Допустимая длина пароля — от 8 до 128 символов. Пароль должен удовлетворять регулярному выражению `[a-zA-Z0-9@=+?*.,!&#$^<>_-]*`.

1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create }}**.
1. Дождитесь, когда кластер будет готов к работе: его статус на панели {{ mrd-name }} сменится на **Running**, а состояние — на **Alive**. Это может занять некоторое время.

Подробнее о создании кластера см. в разделе [{#T}](operations/cluster-create.md).


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
        redis-cli -h c-<идентификатор_кластера>.rw.{{ dns-zone }} \
          -p {{ port-mrd }} \
          -a <пароль_{{ VLK }}>
        ```

    - Подключение с SSL {#with-ssl}

        1. Получите [SSL-сертификат](../glossary/ssl-certificate.md):

            ```bash
            mkdir -p ~/.redis && \
            wget "{{ crt-web-path }}" \
                 --output-document ~/.redis/{{ crt-local-file }} && \
            chmod 0655 ~/.redis/{{ crt-local-file }}
            ```
            
            Сертификат будет сохранен в файле `~/.redis/{{ crt-local-file }}`.

        1. Выполните команду:

            ```bash
            redis-cli -h c-<идентификатор_кластера>.rw.{{ dns-zone }} \
              -p {{ port-mrd-tls }} \
              -a <пароль_{{ VLK }}> \
              --tls \
              --cacert ~/.redis/{{ crt-local-file }}
            ```

    {% endlist %}

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](operations/cluster-list.md#list-clusters).

    Примеры кода с заполненным FQDN хоста доступны в [консоли управления]({{ link-console-main }}) по нажатию кнопки **{{ ui-key.yacloud.mdb.clusters.button_action-connect }}** на странице кластера.

1. После успешного подключения отправьте команду `PING`. {{ VLK }} должен вернуть ответ `PONG`.


## Что дальше {#whats-next}

* Изучите [концепции сервиса](concepts/index.md).
* Узнайте подробнее о [создании кластера](operations/cluster-create.md) и [подключении к кластеру](operations/connect/index.md).
* Ознакомьтесь с [вопросами и ответами](qa/general.md).