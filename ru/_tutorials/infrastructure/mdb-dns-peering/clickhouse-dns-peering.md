# Настройка {{ dns-full-name }} для доступа к кластеру {{ mch-name }} из других облачных сетей

В этом руководстве в качестве примера используется кластер {{ mch-name }}. Настройка доступности для других сервисов управляемых баз данных делается аналогично.

Ресурсные записи о кластерах {{ mch-name }} создаются в [сервисных зонах DNS](../../../dns/concepts/dns-zone.md#service-zones), которые работают в пределах одной [облачной сети](../../../vpc/concepts/network.md#network). Из-за этого клиенты, например виртуальные машины, которые находятся в другой облачной сети, не могут подключаться к хостам кластера по [FQDN](../../../managed-clickhouse/concepts/network.md#hostname), даже если между облачными сетями настроена сетевая связность.

Чтобы клиенты из других облачных сетей могли подключаться к кластеру по FQDN, настройте общую DNS-зону в сервисе {{ dns-full-name }}:

1. [Создайте зону в {{ dns-full-name }}](#create-peering-zone).
1. [Проверьте доступность кластера из другой облачной сети](#check-cluster-availability).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

1. [Подготовьте пару SSH-ключей](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) для подключения к виртуальным машинам.
1. Подготовьте инфраструктуру:

    {% list tabs %}

    - Вручную

        1. [Создайте две облачные сети](../../../vpc/operations/network-create.md) с именами `mch-net` и `another-net`.
        1. В каждой сети [создайте подсеть](../../../vpc/operations/subnet-create.md).
        1. В сети `mch-net` [создайте кластер](../../../managed-clickhouse/operations/cluster-create.md) {{ mch-name }} любой подходящей конфигурации с хостами без публичного доступа.
        1. (Опционально) В сети `mch-net` [создайте виртуальную машину на базе Linux](../../../compute/operations/vm-create/create-linux-vm.md) с именем `mch-net-vm`. При создании укажите подготовленный ранее публичный SSH-ключ.
        1. В сети `another-net` [создайте виртуальную машину на базе Linux](../../../compute/operations/vm-create/create-linux-vm.md) с именем `another-net-vm`. При создании укажите подготовленный ранее публичный SSH-ключ.
        1. Настройте правила групп безопасности кластера и ВМ [по инструкции](../../../managed-clickhouse/operations/connect/index.md#configuring-security-groups)

    - С помощью {{ TF }}

        1. {% include [terraform-install](../../../_includes/terraform-install.md) %}
        1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Поместите его в отдельную рабочую директорию и [укажите значения параметров](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
        1. Скачайте в ту же рабочую директорию файл конфигурации [nets-vm-mch.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/nets-vm-mch.tf).

            В этом файле описаны:

            * [сети](../../../vpc/concepts/network.md#network);
            * [подсети](../../../vpc/concepts/network.md#subnet);
            * [группы безопасности](../../../vpc/concepts/security-groups.md), необходимые для кластера {{ mch-name }} и виртуальных машин;
            * виртуальные машины;
            * кластер {{ mch-name }};
            * внутренняя зона DNS.

        1. Укажите в файле `nets-vm-mch.tf`:

            * `ch_dbname` — имя базы данных в кластере {{ mch-name }}.
            * `ch_user` — имя пользователя-администратора в кластере {{ mch-name }}.
            * `ch_password` — пароль пользователя-администратора в кластере {{ mch-name }}.
            * `image_id` — идентификатор публичного образа виртуальной машины. О том, как получить список доступных образов, см. в [инструкции](../../../compute/operations/images-with-pre-installed-software/get-list.md).
            * `vm_username` — имя пользователя виртуальной машины.
            * `vm_ssh_key_path` — абсолютный путь к публичному ключу для виртуальных машин, который вы подготовили ранее.
            * `create_optional_vm` — параметр, который отвечает за создание виртуальной машины в той же сети, в которой расположен кластер. Установите `1`, чтобы в дальнейшем проверить доступность кластера из той же сети (опционально).

        1. Выполните команду `terraform init` в директории с конфигурационными файлами. Эта команда инициализирует провайдер, указанный в конфигурационном файле, и позволяет работать с ресурсами и источниками данных провайдера.
        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Создайте необходимую инфраструктуру:

            {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

            {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

    {% endlist %}

1. (Опционально) [Подключитесь по SSH](../../../compute/operations/vm-connect/ssh.md#vm-connect) к виртуальной машине `mch-net-vm` и [настройте подключение к кластеру](../../../managed-clickhouse/operations/connect/clients.md) через `clickhouse-client`, чтобы убедиться, что группы безопасности настроены верно и подключение к кластеру по FQDN из той же облачной сети доступно.
1. Настройте сетевую связность между облачными сетями `mch-net` и `another-net`, например, с помощью [IPSec-шлюза](../../../tutorials/routing/ipsec/index.md). Другие способы настроить сетевую связность см. в разделе [{#T}](../../../tutorials/routing/index.md).

## Создайте зону в {{ dns-name }} {#create-peering-zone}

1. Создайте зону DNS:

    {% list tabs %}

    - Вручную

        Создайте внутреннюю зону DNS с адресом `{{ dns-zone }}.` [по инструкции](../../../dns/operations/zone-create-private.md). В списке сетей укажите сети `mch-net` и `another-net`.

    - С помощью {{ TF }}

        1. Укажите в файле `nets-vm-mch.tf` значение `1` для параметра `create_zone`.

        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Создайте необходимую инфраструктуру:

            {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

    {% endlist %}

1. Проверьте, что в зоне DNS автоматически появилась запись для кластера:

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, где находится зона DNS.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
    1. Выберите зону из списка.
    1. Убедитесь, что в списке записей есть запись вида: `c-<идентификатор_кластера>.rw.mdb.yandexcloud.net.`.

## Проверьте доступность кластера из другой облачной сети {#check-cluster-availability}

1. [Подключитесь по SSH](../../../compute/operations/vm-connect/ssh.md#vm-connect) к виртуальной машине `another-net-vm`.
1. [Настройте подключение к кластеру](../../../managed-clickhouse/operations/connect/clients.md) через `clickhouse-client` и убедитесь, что подключение к кластеру из другой облачной сети по FQDN работает.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs %}

- Вручную

    1. [Зону DNS](../../../dns/operations/zone-delete.md).
    1. [Кластер {{ mch-name }}](../../../managed-clickhouse/operations/cluster-delete.md).
    1. [Облачные сети](../../../vpc/operations/network-delete.md).

- С помощью {{ TF }}

    Если вы создавали ресурсы с помощью {{ TF }}:

    1. В терминале перейдите в директорию с планом инфраструктуры.
    1. Удалите конфигурационный файл `nets-vm-mch.tf`.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        Все ресурсы, которые были описаны в конфигурационном файле `nets-vm-mch.tf`, будут удалены.

{% endlist %}
