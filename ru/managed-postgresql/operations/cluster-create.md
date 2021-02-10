# Создание {{ PG }}-кластера

{{ PG }}-кластер — это один или несколько хостов базы данных, между которыми можно настроить репликацию. Репликация работает по умолчанию в любом кластере из более чем 1 хоста: хост-мастер принимает запросы на запись, синхронно дублирует изменения в основной реплике и асинхронно — во всех остальных.

{% note info %}

Если хранилище баз данных заполнится на 95%, кластер перейдет в режим только чтения. Рассчитывайте и увеличивайте необходимый размер хранилища заранее.

{% endnote %}

{% if audience != "internal" %}

Количество хостов, которые можно создать вместе с {{ PG }}-кластером, зависит от выбранного варианта хранилища:

* При использовании сетевых дисков вы можете запросить любое количество хостов (от 1 до пределов текущей [квоты](../concepts/limits.md)).

* При использовании SSD-дисков вместе с кластером можно создать не меньше 3 реплик (минимум 3 реплики необходимо, чтобы обеспечить отказоустойчивость). Если после создания кластера [доступных ресурсов каталога](../concepts/limits.md) останется достаточно, вы можете добавить дополнительные реплики.

{% endif %}

По умолчанию {{ mpg-short-name }} выставляет максимально возможное ограничение на количество подключений к каждому хосту {{ PG }}-кластера. Этот максимум рассчитывается так: `200 × <количество vCPU на каждом хосте>`. Например, для кластера [класса s1.micro](../concepts/instance-types.md) значение параметра `max_connections` по умолчанию равно 400, и не может быть увеличено.

{% include [note-pg-user-connections.md](../../_includes/mdb/note-pg-user-connections.md) %}


## Как создать кластер {{ PG }} {#create-cluster}

{% list tabs %}

- Консоль управления

  1. В консоли управления выберите каталог, в котором нужно создать кластер баз данных.
  1. Выберите сервис **{{ mpg-name }}**.
  1. Нажмите кнопку **Создать кластер**.
  1. Введите имя кластера в поле **Имя кластера**. Имя кластера должно быть уникальным в рамках {{ yandex-cloud }}.
  1. Выберите окружение, в котором нужно создать кластер (после создания кластера окружение изменить невозможно):
      - `PRODUCTION` — для стабильных версий ваших приложений.
      - `PRESTABLE` — для тестирования, в том числе самого сервиса {{ mpg-short-name }}. В Prestable-окружении раньше появляются новая функциональность, улучшения и исправления ошибок. При этом не все обновления обеспечивают обратную совместимость.
  1. Выберите версию СУБД.
     {% note info %}

     Используя версию `10-1c` ({{ PG }} 10 для 1C), для комфортной работы 50 пользователей рекомендуется выбрать класс хоста `s2.medium`, для 30 пользователей и менее скорее всего будет достаточно класса `s2.small`.

     {% endnote %}

  1. Выберите класс хостов — он определяет технические характеристики виртуальных машин, на которых будут развернуты хосты баз данных. Все доступные варианты перечислены в разделе [{#T}](../concepts/instance-types.md). При изменении класса хостов для кластера меняются характеристики всех уже созданных хостов.
  1. В блоке **Размер хранилища**:

{% if audience != "internal" %} 

      - Выберите тип хранилища — более гибкое сетевое (**network-hdd** или **network-ssd**) или более быстрое локальное хранилище (**local-ssd**). Размер локального хранилища можно менять только с шагом 100 ГБ. 

{% endif %}

      - Выберите объем, который будет использоваться для данных и резервных копий. Подробнее о том, как занимают пространство резервные копии, см. раздел [{#T}](../concepts/backup.md).

  1. В блоке **База данных** укажите атрибуты базы данных:

      - Имя базы данных. Это имя должно быть уникальным в рамках каталога и содержать только латинские буквы, цифры и подчеркивания.
      - Имя пользователя — владельца базы данных. Это имя должно содержать только латинские буквы, цифры и подчеркивания. По умолчанию новому пользователю выделяется 50 подключений к каждому хосту кластера.
      - Пароль пользователя, от 8 до 128 символов.
      - Локаль сортировки и локаль набора символов. Эти настройки определяют правила, по которым производится сортировка строк (`LC_COLLATE`) и классификация символов (`LC_CTYPE`). В {{ mpg-name }} настройки локали действуют на уровне отдельно взятой базы данных.

           {% include [postgresql-locale](../../_includes/mdb/mpg-locale-settings.md) %}

  1. В блоке **Хосты** выберите параметры хостов баз данных, создаваемых вместе с кластером (помните, что используя SSD-диски при создании {{ PG }}-кластера можно задать не меньше 3 хостов). Открыв блок **Расширенные настройки**, вы можете выбрать конкретные подсети для каждого хоста — по умолчанию каждый хост создается в отдельной подсети.
  
  1. При необходимости задайте дополнительные настройки кластера:
  
     {% include [mpg-extra-settings](../../_includes/mdb/mpg-extra-settings-web-console.md) %}
  
  1. Нажмите кнопку **Создать кластер**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать кластер:

  {% if audience != "internal" %}

  1. Проверьте, есть ли в каталоге подсети для хостов кластера:

     ```
     $ yc vpc subnet list
     ```

     Если ни одной подсети в каталоге нет, [создайте нужные подсети](../../vpc/operations/subnet-create.md) в сервисе {{ vpc-short-name }}. 
  
  {% endif %}

  1. Посмотрите описание команды CLI для создания кластера:

      ```
      $ {{ yc-mdb-pg }} cluster create --help
      ```

  1. Укажите параметры кластера в команде создания (в примере приведены не все параметры):

  {% if audience != "internal" %}

      ```bash
      $ {{ yc-mdb-pg }} cluster create \
         --name <имя кластера> \
         --environment <окружение, prestable или production> \
         --network-name <имя сети> \
         --host zone-id=<зона доступности>,subnet-id=<идентификатор подсети> \
         --resource-preset <класс хоста> \
         --user name=<имя пользователя>,password=<пароль пользователя> \
         --database name=<имя базы данных>,owner=<имя владельца базы данных> \
         --disk-size <размер хранилища в гигабайтах>
      ```

      Идентификатор подсети `subnet-id` необходимо указывать, если в выбранной зоне доступности создано 2 и больше подсетей.

  {% else %}

      ```bash
      $ {{ yc-mdb-pg }} cluster create \
         --name <имя кластера> \
         --environment <окружение, prestable или production> \
         --network-id {{ network-name }} \
         --host zone-id=<зона доступности> \
         --resource-preset <класс хоста> \
         --user name=<имя пользователя>,password=<пароль пользователя> \
         --database name=<имя базы данных>,owner=<имя владельца базы данных> \
         --disk-size <размер хранилища в гигабайтах>
      ```

  {% endif %}
      
      Также вы можете указать несколько дополнительных опций в параметре `--host` для управления репликацией в кластере:
      - Источник репликации для хоста в опции `replication-source` для того, чтобы [вручную управлять потоками репликации](../concepts/replication.md#replication-manual).
      - Приоритет хоста в опции `priority` для того, чтобы [влиять на процесс выбора синхронной реплики](../concepts/replication.md#selecting-the-master-and-a-synchronous-replica):
        - Хост с наибольшим значением приоритета в кластере становится синхронной репликой.
        - Если в кластере есть несколько хостов с наибольшим приоритетом, то среди них проводятся выборы синхронной реплики. 
        - Наименьший приоритет — `0` (по умолчанию), наивысший — `100`.
      
        

- Terraform

  {% include [terraform-definition](../../solutions/_solutions_includes/terraform-definition.md) %}
  
  Если у вас ещё нет Terraform, [установите его и настройте провайдер](../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы создать кластер:

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     {% include [terraform-create-cluster-step-1](../../_includes/mdb/terraform-create-cluster-step-1.md) %}

     Пример структуры конфигурационного файла:

     ```
     resource "yandex_mdb_postgresql_cluster" "<имя кластера>" {
       name        = "<имя кластера>"
       environment = "<окружение, PRESTABLE или PRODUCTION>"
       network_id  = "<идентификатор сети>"

       config {
         version = "<версия PostgreSQL: 10, 10-1с, 11, 11-1c, 12 или 13>"
         resources {
           resource_preset_id = "<класс хоста>"
           disk_type_id       = "<тип хранилища>"
           disk_size          = "<размер хранилища в гигабайтах>"
         }
       }

       database {
         name  = "<имя базы данных>"
         owner = "<имя владельца базы данных>"
       }

       user {
         name     = "<имя пользователя>"
         password = "<пароль пользователя>"
         permission {
           database_name = "<имя базы данных>"
         }
       }

       host {
         zone      = "<зона доступности>"
         subnet_id = "<идентификатор подсети>"
       }
     }
       
     resource "yandex_vpc_network" "<имя сети>" { name = "<имя сети>" }
       
     resource "yandex_vpc_subnet" "<имя подсети>" {
       name           = "<имя подсети>"
       zone           = "<зона доступности>"
       network_id     = "<идентификатор сети>"
       v4_cidr_blocks = ["<диапазон>"]
     }
     ```
   
     Более подробную информацию о ресурсах, которые вы можете создать с помощью Terraform, см. в [документации провайдера](https://www.terraform.io/docs/providers/yandex/r/mdb_postgresql_cluster.html).
 
  1. Проверьте корректность конфигурационных файлов.

     {% include [terraform-create-cluster-step-2](../../_includes/mdb/terraform-create-cluster-step-2.md) %} 
   
  1. Создайте кластер.

     {% include [terraform-create-cluster-step-3](../../_includes/mdb/terraform-create-cluster-step-3.md) %}

{% endlist %}


## Примеры {#examples}

### Создание кластера с одним хостом {#creating-a-single-host-cluster}

{% list tabs %}

- CLI

  Чтобы создать кластер с одним хостом, следует передать один параметр `--host`.

  Допустим, нужно создать {{ PG }}-кластер со следующими характеристиками:

  {% if audience != "internal" %}

  - С именем `mypg`.
  - В окружении `production`.
  - В сети `default`.
  - С одним хостом класса `{{ host-class }}` в подсети `b0rcctk2rvtr8efcch64`, в зоне доступности `{{ zone-id }}`.
  - С быстрым сетевым хранилищем (`{{ disk-type-example }}`) объемом 20 ГБ.
  - С одним пользователем (`user1`), с паролем `user1user1`.
  - С одной базой данных `db1`, принадлежащей пользователю `user1`.

  {% else %}

  - С именем `mypg`.
  - В окружении `production`.
  - С одним хостом класса `db1.micro`, в зоне доступности `man`.
  - С быстрым локальным хранилищем (`local-ssd`) объемом 20 ГБ.
  - С одним пользователем (`user1`), с паролем `user1user1`.
  - С одной базой данных `db1`, принадлежащей пользователю `user1`.

  {% endif %}

  Запустите следующую команду:

  {% if audience != "internal" %}

  ```
  $ {{ yc-mdb-pg }} cluster create \
       --name mypg \
       --environment production \
       --network-name default \
       --resource-preset {{ host-class }} \
       --host zone-id={{ zone-id }},subnet-id=b0rcctk2rvtr8efcch64 \
       --disk-type {{ disk-type-example }} \
       --disk-size 20 \
       --user name=user1,password=user1user1 \
       --database name=db1,owner=user1
  ```

  {% else %}

  ```
  $ {{ yc-mdb-pg }} cluster create \
       --name mypg \
       --environment production \
       --network-id ' ' \
       --host zone-id=man \
       --resource-preset db1.micro \
       --disk-type local-ssd \
       --disk-size 20 \
       --user name=user1,password=user1user1 \
       --database name=db1,owner=user1
  ```

  {% endif %}

- Terraform

  Допустим, нужно создать {{ PG }}-кластер и сеть для него со следующими характеристиками:
  - С именем `mypg`.
  - Версии `13`.
  - В окружении `PRESTABLE`.
  - В облаке с идентификатором `{{ tf-cloud-id }}`.
  - В каталоге `myfolder`.
  - В новой сети `mynet`.
  - С одним хостом класса `{{ host-class }}` в новой подсети `mysubnet`, в зоне доступности `{{ zone-id }}`. Подсеть `mysubnet` будет иметь диапазон `10.5.0.0/24`.
  - С быстрым сетевым хранилищем (`{{ disk-type-example }}`) объемом 20 ГБ.
  - С одним пользователем (`user1`), с паролем `user1user1`.
  - С одной базой данных `db1`, принадлежащей пользователю `user1`.
  
  Конфигурационный файл кластера выглядит так:
  
  ```
  provider "yandex" {
    token     = "<OAuth или статический ключ сервисного аккаунта>"
    cloud_id  = "{{ tf-cloud-id }}"
    folder_id = "${data.yandex_resourcemanager_folder.myfolder.id}"
    zone      = "{{ zone-id }}"
  }
  
  resource "yandex_mdb_postgresql_cluster" "mypg" {
    name        = "mypg"
    environment = "PRESTABLE"
    network_id  = "${yandex_vpc_network.mynet.id}"

    config {
      version = 13
      resources {
        resource_preset_id = "{{ host-class }}"
        disk_type_id       = "{{ disk-type-example }}"
        disk_size          = 20
      }
    }

    database {
      name  = "db1"
      owner = "user1"
    }

    user {
      name     = "user1"
      password = "user1user1"
      permission {
        database_name = "db1"
      }
    }

    host {
      zone      = "{{ zone-id }}"
      subnet_id = "${yandex_vpc_subnet.mysubnet.id}"
    }
  }

  resource "yandex_vpc_network" "mynet" {  name = "mynet" }

  resource "yandex_vpc_subnet" "mysubnet" {
    name           = "mysubnet"
    zone           = "{{ zone-id }}"
    network_id     = "${yandex_vpc_network.mynet.id}"
    v4_cidr_blocks = ["10.5.0.0/24"]
  }
  ```

{% endlist %}
