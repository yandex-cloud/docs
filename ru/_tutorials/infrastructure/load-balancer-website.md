# Отказоустойчивый сайт с балансировкой нагрузки с помощью {{ network-load-balancer-full-name }}


Создайте и настройте веб-сайт на стеке [LAMP](https://ru.wikipedia.org/wiki/LAMP) ([Linux](https://www.linux.org/), [Apache HTTP Server](https://httpd.apache.org/), [{{ MY }}](https://www.mysql.com/), [PHP](https://www.php.net/)) или LEMP (веб-сервер Apache заменяется на [Nginx](https://www.nginx.com/)) с балансировкой нагрузки через [{{ network-load-balancer-name }}](../../network-load-balancer/) между двумя [зонами доступности](../../overview/concepts/geo-scope.md), защищенный от сбоев в одной зоне.
1. [Подготовьте облако к работе](#before-you-begin).
1. [Подготовьте сетевую инфраструктуру](#prepare-network).
1. [Создайте группу ВМ](#create-vms).
1. [Загрузите файлы веб-сайта](#upload-files).
1. [Создайте сетевой балансировщик](#create-load-balancer).
1. [Протестируйте отказоустойчивость](#test-availability).

Если сайт вам больше не нужен, [удалите все используемые им ресурсы](#clear-out).

Также инфраструктуру для размещения в [группе виртуальных машин](../../compute/concepts/instance-groups/index.md) отказоустойчивого сайта с балансировкой нагрузки можно развернуть через {{ TF }} с помощью [готового файла конфигурации](#terraform).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки веб-сайта входит:
* Плата за [диски](../../compute/concepts/disk.md) и постоянно запущенные [ВМ](../../compute/concepts/vm.md) (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).
* Плата за использование динамических [публичных IP-адресов](../../vpc/concepts/address.md#public-addresses) (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).
* Плата за [сетевые балансировщики](../../network-load-balancer/concepts/index.md) и балансировку трафика (см. [тарифы {{ network-load-balancer-name }}](../../network-load-balancer/pricing.md)).

## Подготовьте сетевую инфраструктуру {#prepare-network}

Перед тем, как создавать ВМ:
1. Перейдите в [консоль управления]({{ link-console-main }}) {{ yandex-cloud }} и выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будете выполнять операции.
1. Убедитесь, что в выбранном каталоге есть [сеть](../../vpc/concepts/network.md#network) с [подсетями](../../vpc/concepts/network.md#subnet) в зонах доступности `{{ region-id }}-a` и `{{ region-id }}-b`. Для этого на странице каталога выберите сервис **{{ vpc-name }}**. Если нужной [сети](../../vpc/operations/network-create.md) или [подсетей](../../vpc/operations/subnet-create.md) нет, создайте их.

## Создайте группу ВМ {#create-vms}

Чтобы создать группу ВМ с предустановленным веб-сервером:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ compute-name }}**.
  1. Откройте вкладку **Группы виртуальных машин** и нажмите кнопку **Создать группу**.
  1. В блоке **Базовые параметры**:
     * Введите имя группы ВМ, например `nlb-vm-group`.
     * Выберите [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) из списка или создайте новый. Чтобы иметь возможность создавать, обновлять и удалять ВМ в группе, назначьте сервисному аккаунту [роль](../../iam/concepts/access-control/roles.md) `editor`. По умолчанию все операции с группами ВМ выполняются от имени сервисного аккаунта.
  1. В блоке **Распределение** выберите зоны доступности `{{ region-id }}-a` и `{{ region-id }}-b`, чтобы обеспечить отказоустойчивость хостинга.
  1. В блоке **Шаблон виртуальной машины** нажмите кнопку **Задать** и укажите конфигурацию базовой ВМ:
     * В блоке **Базовые параметры** введите **Описание** [шаблона](../../compute/concepts/instance-groups/instance-template.md).
     * В блоке **Выбор образа/загрузочного диска** откройте вкладку **{{ marketplace-full-name }}** и нажмите кнопку **Посмотреть больше**. Выберите продукт:
       * [LEMP](/marketplace/products/yc/lemp) для Linux, Nginx, {{ MY }}, PHP.
       * [LAMP](/marketplace/products/yc/lamp) для Linux, Apache, {{ MY }}, PHP.

       Нажмите кнопку **Использовать**.
     * В блоке **Диски** укажите:
       * **Тип** [диска](../../compute/concepts/disk.md) — HDD.
       * **Размер** — 3 ГБ.
     * В блоке **Вычислительные ресурсы** укажите:
       * **Платформа** — Intel Ice Lake.
       * **vCPU** — 2.
       * **Гарантированная доля vCPU** — 20%.
       * **RAM** — 1 ГБ.
     * В блоке **Сетевые настройки**:
       * Выберите облачную сеть и ее подсети.
       * В поле **Публичный адрес** выберите **Автоматически**.
     * В блоке **Доступ** укажите данные для доступа на ВМ:
       * В поле **Сервисный аккаунт** выберите сервисный аккаунт для привязки к ВМ.
       * В поле **Логин** введите имя пользователя.
       * В поле **SSH-ключ** вставьте содержимое файла открытого ключа.

       Для подключения по [SSH](../../glossary/ssh-keygen.md) необходимо создать пару ключей. Подробнее в разделе [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
     * Нажмите кнопку **Сохранить**.
  1. В блоке **Масштабирование** укажите **Размер** группы ВМ — 2.
  1. В блоке **Интеграция с {{ network-load-balancer-name }}** выберите опцию **Создать целевую группу** и укажите имя группы: `nlb-tg`.
  1. Нажмите кнопку **Создать**.

  Создание группы ВМ может занять несколько минут. Когда все ВМ перейдут в [статус](../../compute/concepts/vm-statuses.md) `RUNNING`, вы можете [загрузить на них файлы веб-сайта](#upload-files).

- {{ TF }} {#tf}

  См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

{% endlist %}

#### См. также

* [{#T}](../../compute/operations/vm-connect/ssh.md).

## Загрузите файлы веб-сайта {#upload-files}

Чтобы проверить работу веб-сервера, необходимо загрузить файлы сайта на каждую ВМ. Для примера вы можете использовать файл `index.html` из [архива](https://{{ s3-storage-host }}/doc-files/index.html.zip).

Для каждой ВМ в [созданной группе](#create-vms) выполните следующее:
1. На вкладке **Виртуальные машины** нажмите на имя нужной ВМ в списке. В блоке **Сеть** найдите публичный IP-адрес.
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

## Создайте сетевой балансировщик {#create-load-balancer}

При создании сетевого балансировщика нужно добавить [обработчик](../../network-load-balancer/concepts/listener.md), на котором балансировщик будет принимать трафик, подключить [целевую группу](../../network-load-balancer/concepts/target-resources.md), созданную вместе с группой ВМ, и настроить в ней проверку состояния ресурсов.

Чтобы создать сетевой балансировщик:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) откройте раздел **{{ network-load-balancer-short-name }}**.
  1. Нажмите кнопку **Создать сетевой балансировщик**.
  1. Задайте имя балансировщика, например `nlb-1`.
  1. В блоке **Обработчики** нажмите кнопку **Добавить обработчик** и укажите параметры:
     * **Имя обработчика** — `nlb-listener`.
     * **Порт** — `80`.
     * **Целевой порт** — `80`.
  1. Нажмите кнопку **Добавить**.
  1. В блоке **Целевые группы**:
     1. Нажмите кнопку **Добавить целевую группу** и выберите [созданную ранее](#create-vms) целевую группу `nlb-tg`. Если группа одна, она будет выбрана автоматически.
     1. В блоке **Проверка состояния** нажмите кнопку **Настроить** и измените параметры:
        * **Имя** проверки — `health-check-1`.
        * **Порог работоспособности** — количество успешных проверок, после которого ВМ будет считаться готовой к приему трафика: `5`.
        * **Порог неработоспособности** — количество проваленных проверок, после которого на ВМ перестанет подаваться трафик: `5`.
      1. Нажмите кнопку **Применить**.
  1. Нажмите кнопку **Создать**.

- {{ TF }} {#tf}

  См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

{% endlist %}

## Протестируйте отказоустойчивость {#test-availability}

1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ compute-name }}**.
1. Перейдите на страницу ВМ из созданной ранее группы. В блоке **Сеть** найдите публичный IP-адрес.
1. [Подключитесь](../../compute/operations/vm-connect/ssh.md#vm-connect) к ВМ по протоколу SSH.
1. Остановите веб-сервис, чтобы сымитировать сбой в работе веб-сервера:

   {% list tabs %}

   - LAMP

     ```bash
     sudo service apache2 stop
     ```

   - LEMP

     ```bash
     sudo service nginx stop
     ```

   {% endlist %}

1. Перейдите в раздел **{{ network-load-balancer-name }}** и выберите созданный ранее балансировщик `nlb-1`.
1. В блоке **Обработчики** найдите IP-адрес обработчика. Откройте сайт в браузере, используя адрес обработчика.

   Несмотря на сбой в работе одного из веб-серверов, подключение должно пройти успешно.
1. После завершения проверки снова запустите веб-сервис:

   {% list tabs %}

   - LAMP

     ```bash
     sudo service apache2 start
     ```

   - LEMP
     ```bash
     sudo service nginx start
     ```

   {% endlist %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы остановить работу хостинга и перестать платить за созданные ресурсы:
1. [Удалите](../../network-load-balancer/operations/load-balancer-delete.md) сетевой балансировщик `nlb-1`.
1. [Удалите](../../compute/operations/instance-groups/delete.md) группу ВМ `nlb-vm-group`.

## Как создать инфраструктуру с помощью {{ TF }} {#terraform}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

Чтобы разместить в группе ВМ отказоустойчивый сайт с балансировкой нагрузки с помощью {{ TF }}:
1. [Установите {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

   {% list tabs group=infrastructure_description %}

   - Готовый архив {#ready}

     1. Создайте папку для файлов.
     1. Скачайте [архив](https://{{ s3-storage-host }}/doc-files/load-balancer.zip) (2 КБ).
     1. Разархивируйте архив в папку. В результате в ней появится конфигурационный файл `load-balancer.tf`.

   - Вручную {#manual}

     1. Создайте папку для файлов.
     1. Создайте в папке конфигурационный файл `load-balancer.tf`:

        {% cut "load-balancer.tf" %}

        {% include [load-balancer-tf-config](../../_includes/web/load-balancer-tf-config.md) %}

        {% endcut %}

   {% endlist %}

   Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:
   * [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account)
   * [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member)
   * [yandex_compute_instance_group]({{ tf-provider-resources-link }}/compute_instance_group)
   * [yandex_lb_network_load_balancer]({{ tf-provider-resources-link }}/lb_network_load_balancer)
   * [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network)
   * [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet)
1. В блоке `variable` укажите значение переменной `folder_id` — идентификатор каталога, в котором создаются необходимые ресурсы.
1. В блоке `metadata` укажите [метаданные](../../compute/concepts/vm-metadata.md) для создания ВМ и содержимое SSH-ключа. Ключ указывается в формате `<любое_имя>:<содержимое_SSH-ключа>`. Указанное имя пользователя не играет роли, ключ будет присвоен пользователю, который задан в конфигурации образа LAMP (LEMP). В разных образах это разные пользователи. Подробнее см. в разделе [{#T}](../../compute/concepts/vm-metadata.md#keys-processed-in-public-images).
1. В блоке `boot_disk` укажите идентификатор одного из [образов](../../compute/operations/images-with-pre-installed-software/get-list.md) ВМ с нужным набором компонентов:
   * [LAMP](/marketplace/products/yc/lamp) (Linux, Apache, {{ MY }}, PHP).
   * [LEMP](/marketplace/products/yc/lemp) (Linux, Nginx, {{ MY }}, PHP).
1. Создайте ресурсы:

   {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

1. [Протестируйте отказоустойчивость](#test-availability).