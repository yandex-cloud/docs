# Веб-сайт на LAMP- или LEMP-стеке

[LAMP](https://ru.wikipedia.org/wiki/LAMP) ([Linux](https://www.linux.org/), [Apache HTTP Server](https://httpd.apache.org/), [{{ MY }}](https://www.mysql.com/), [PHP](https://www.php.net/)) и его вариация LEMP (в которой веб-сервер Apache заменяется на [Nginx](https://www.nginx.com/)) — популярные наборы компонентов для развертывания веб-приложений и динамических сайтов.

С помощью этой инструкции вы научитесь разворачивать [LAMP](/marketplace/products/yc/lamp) ([LEMP](/marketplace/products/yc/lemp)) в инфраструктуре {{ yandex-cloud }}: в результате вы запустите [виртуальную машину](../../compute/concepts/vm.md), на которой будет работать веб-сервер вашего сайта.

Чтобы настроить LAMP- или LEMP-сайт:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте облачную сеть](#create-network).
1. [Создайте группу безопасности](#create-security-groups).
1. [Создайте ВМ с предустановленным веб-сервером](#create-vm).
1. [Загрузите файлы веб-сайта](#upload-files).
1. [Настройте DNS](#configure-dns).
1. [Проверьте работу сайта](#test-site).

Если сайт вам больше не нужен, [удалите все используемые им ресурсы](#clear-out).

Также инфраструктуру для размещения веб-сервера LAMP- или LEMP-сайта на ВМ можно развернуть через {{ TF }} с помощью [готового файла конфигурации](#terraform).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки LAMP-сервера входит:
* Плата за постоянно запущенную ВМ (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).
* Плата за использование динамического или статического [внешнего IP-адреса](../../vpc/concepts/address.md#public-addresses) (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).
* Плата за использование DNS (см. [тарифы {{ dns-full-name }}](../../dns/pricing.md)).


## Создайте облачную сеть {#create-network}

Все ресурсы, созданные в сценарии, будут относиться к одной [облачной сети](../../vpc/concepts/network.md).

Чтобы создать сеть:

{% list tabs %}

- Консоль управления 

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ vpc-name }}**.
  1. Нажмите кнопку **Создать сеть**.
  1. Укажите **Имя** сети: `web-network`.
  1. В поле **Дополнительно** выберите опцию **Создать подсети**.
  1. Нажмите кнопку **Создать сеть**.

- {{ TF }}

  См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

{% endlist %}

## Создайте группу безопасности {#create-security-groups}

[Группы безопасности](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) содержат правила, которые разрешают обращаться к ВМ из интернета. В сценарии будет создана группа безопасности `sg-web`.

Чтобы создать группу безопасности:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ vpc-name }}**.
  1. Откройте вкладку **Группы безопасности**.
  1. Создайте группу безопасности для балансировщика:
     1. Нажмите кнопку **Создать группу**.
     1. Укажите **Имя** группы: `sg-web`.
     1. Выберите **Сеть** `web-network`.
     1. В блоке **Правила** создайте следующие правила по инструкции под таблицей:

        Направление<br>трафика | Описание | Диапазон<br>портов | Протокол | Тип источника /<br>назначения | Источник /<br>назначение
        --- | --- | --- | --- | --- | ---
        Исходящий | any | Весь | Любой | CIDR | 0.0.0.0/0
        Входящий | ext-http | 80 | TCP | CIDR | 0.0.0.0/0
        Входящий | ext-https | 443 | TCP | CIDR | 0.0.0.0/0

        1. Выберите вкладку **Исходящий трафик** или **Входящий трафик**.
        1. Нажмите кнопку **Добавить правило**.
        1. В открывшемся окне в поле **Диапазон портов** укажите один порт или диапазон портов, куда или откуда будет поступать трафик.
        1. В поле **Протокол** укажите нужный протокол или оставьте **Любой**, чтобы разрешить передачу трафика по всем протоколам.
        1. В поле **Назначение** или **Источник** выберите назначение правила:
           * **CIDR** — правило будет применено к диапазону IP-адресов. В поле **CIDR блоки** укажите CIDR и маски [подсетей](../../vpc/concepts/network.md#subnet), в которые или из которых будет поступать трафик. Чтобы добавить несколько CIDR, нажимайте кнопку **Добавить CIDR**.
           * **Группа безопасности** — правило будет применено к ВМ из текущей группы или из выбранной группы безопасности.
        1. Нажмите кнопку **Сохранить**. Таким образом создайте все правила из таблицы.
     1. Нажмите кнопку **Сохранить**.

- {{ TF }}

  См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

{% endlist %}

## Создайте ВМ с предустановленным веб-сервером {#create-vm}

{% list tabs %}

- Консоль управления

  1. На странице [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) в [консоли управления]({{ link-console-main }}) нажмите кнопку **Создать ресурс** и выберите пункт **Виртуальная машина**.
  1. В поле **Имя** введите имя ВМ: `lamp-vm` или `lemp-vm`. Требования к имени:

     {% include [name-format](../../_includes/name-format.md) %}

  1. Выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет создана ВМ. Если вы не знаете, какая зона доступности вам нужна, оставьте выбранную по умолчанию.
  1. В блоке **Выбор образа/загрузочного диска** перейдите на вкладку **{{ marketplace-name }}** и выберите образ ВМ с нужным набором компонентов:
     * [LAMP](/marketplace/products/yc/lamp) для Linux, Apache, {{ MY }}, PHP.
     * [LEMP](/marketplace/products/yc/lemp) для Linux, Nginx, {{ MY }}, PHP.

       LEMP рекомендуется использовать для статических сайтов.
  1. В блоке **Вычислительные ресурсы**:
     * Выберите [платформу](../../compute/concepts/vm-platforms.md) ВМ.
     * Укажите необходимое количество vCPU и объем RAM.

     Для функционального тестирования сайта хватит минимальной конфигурации:
     * **Платформа** — Intel Ice Lake.
     * **Гарантированная доля vCPU** — 20%.
     * **vCPU** — 2.
     * **RAM** — 1 ГБ.
  1. В блоке **Сетевые настройки** нужно выбрать сеть `web-network` и подсеть, к которым нужно подключить ВМ.
  1. В поле **Публичный адрес** оставьте значение **Автоматически**, чтобы назначить ВМ случайный внешний IP-адрес из пула {{ yandex-cloud }}, или выберите статический адрес из списка, если вы зарезервировали его заранее.
  1. Укажите данные для доступа на ВМ:
     * В поле **Логин** введите имя пользователя.
     * В поле **SSH-ключ** вставьте содержимое файла открытого ключа.

       Пару ключей для подключения по [SSH](../../glossary/ssh-keygen.md) необходимо создать самостоятельно, см. раздел [{#T}](../../compute/operations/vm-connect/ssh.md).

     {% note alert %}

     IP-адрес и [имя хоста (FQDN)](../../compute/concepts/network.md#hostname) для подключения к ВМ назначается ей при создании. Если вы выбрали вариант **Без адреса** в поле **Публичный адрес**, вы не сможете обращаться к ВМ из интернета.

     {% endnote %}

  1. Нажмите кнопку **Создать ВМ**.

     Создание ВМ может занять несколько минут. Когда ВМ перейдет в статус `RUNNING`, вы можете [загрузить на нее файлы веб-сайта](#upload-files).

- {{ TF }}

  См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

{% endlist %}

## Загрузите файлы веб-сайта {#upload-files}

Чтобы проверить работу веб-сервера, загрузите на ВМ файл `index.html`. Можно использовать [тестовый файл](https://{{ s3-storage-host }}/doc-files/index.html.zip), скачайте и распакуйте архив.
1. В блоке **Сеть** на странице ВМ в [консоли управления]({{ link-console-main }}) найдите публичный IP-адрес ВМ.
1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к ВМ по протоколу SSH.
1. Выдайте права на запись для вашего пользователя на директорию `/var/www/html`: 

   ```bash
   sudo chown -R "$USER":www-data /var/www/html
   ```

1. Загрузите на ВМ файлы веб-сайта с помощью [протокола SCP](https://ru.wikipedia.org/wiki/SCP).

   {% list tabs group=operating_system %}

   - Linux/macOS {#linux-macos}

     Используйте утилиту командной строки `scp`:

     ```bash
     scp -r <путь_до_директории_с_файлами> <имя_пользователя_ВМ>@<IP-адрес_ВМ>:/var/www/html
     ```

   - Windows {#windows}

     С помощью программы [WinSCP](https://winscp.net/eng/download.php) скопируйте локальную директорию с файлами в директорию `/var/www/html` на ВМ.

   {% endlist %}

## Настройте DNS (если есть доменное имя) {#configure-dns}

Если у вас есть зарегистрированное доменное имя, воспользуйтесь сервисом {{ dns-name }} для управления доменом.

Также настроить DNS можно с помощью {{ TF }}, подробнее см. в разделе [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

{% include [configure-a-record-and-cname](../../_tutorials/_tutorials_includes/configure-a-record-and-cname.md) %}

## Проверьте работу сайта {#test-site}

Чтобы проверить работу сайта, введите в браузере его IP-адрес или доменное имя:
* `http://<публичный_IP-адрес_ВМ>`.
* `http://www.example.com`.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
* [Удалите ВМ](../../compute/operations/vm-control/vm-delete.md).
* [Удалите статический публичный IP-адрес](../../vpc/operations/address-delete.md), если вы зарезервировали его специально для этой ВМ.
* Удалите [зону DNS](../../dns/operations/zone-delete.md), если вы настраивали DNS.

## Как создать инфраструктуру с помощью {{ TF }} {#terraform}

{% include [terraform-definition](../terraform-definition.md) %}

Чтобы разместить веб-сервер LAMP- или LEMP-сайта на ВМ с помощью {{ TF }}:
1. [Установите {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform) и [получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials).
1. Укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

   {% list tabs %}

   - Готовый архив

     1. Создайте папку для файлов.
     1. Скачайте [архив](https://{{ s3-storage-host }}/doc-files/lamp-lemp.zip) (1 КБ).
     1. Разархивируйте архив в папку. В результате в ней должны появиться конфигурационный файл `lamp-lemp.tf` и файл с пользовательскими данными `lamp-lemp.auto.tfvars`.

   - Создание вручную

     1. Создайте папку для файла с описанием инфраструктуры.
     1. Создайте в папке конфигурационный файл `lamp-lemp.tf`:

        {% cut "lamp-lemp.tf" %}

        {% include [lamp-lemp-tf-config](../../_includes/web/lamp-lemp-tf-config.md) %}

        {% endcut %}

     1. Создайте в папке файл с пользовательскими данными `lamp-lemp.auto.tfvars`:

        {% cut "lamp-lemp.auto.tfvars" %}

        {% include [joomla-postgresql-tf-config](../../_includes/web/lamp-lemp-tf-variables.md) %}

        {% endcut %}

   {% endlist %}

   Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:
   * [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network)
   * [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet)
   * [yandex_vpc_security_group]({{ tf-provider-resources-link }}/yandex_vpc_security_group)
   * [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance)
   * [yandex_dns_zone]({{ tf-provider-resources-link }}/dns_zone)
   * [yandex_dns_recordset]({{ tf-provider-resources-link }}/dns_recordset)
1. В файле `lamp-lemp.auto.tfvars` задайте пользовательские параметры:
   * `zone` — [зона доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
   * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
   * `family_id` — укажите семейство одного из [образов](../../compute/concepts/image.md) ВМ с нужным набором компонентов:
     * `lamp` — [LAMP](/marketplace/products/yc/lamp) (Linux, Apache, {{ MY }}, PHP).
     * `lemp` — [LEMP](/marketplace/products/yc/lemp) (Linux, Nginx, {{ MY }}, PHP).
   * `vm_user` — имя пользователя ВМ.
   * `ssh_key_path` — путь к файлу с открытым [SSH-ключом](../../glossary/ssh-keygen.md) для аутентификации пользователя на ВМ. Подробнее см. [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
   * `dns_zone` — [зона DNS](../../dns/concepts/dns-zone.md). Укажите ваш зарегистрированный домен с точкой в конце, например `example.com.`.
1. Создайте ресурсы:

   {% include [terraform-validate-plan-apply](../terraform-validate-plan-apply.md) %}

1. [Проверьте работу сайта](#test-site).