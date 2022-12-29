# Microsoft в {{ yandex-cloud }}

Вы можете запустить привычные программы и свои продукты на базе Windows в {{ yandex-cloud }} и использовать все преимущества облачных технологий. Работайте с надежным облачным хранилищем и сетевой инфраструктурой и масштабируйте вычислительные мощности под свои нужды.

{{ compute-full-name }} предоставляет инструменты, которые помогут вам создать Windows-приложения и сервисы в облаке:

* Создавайте виртуальные машины под управлением операционной системы Microsoft Windows из готовых образов [{{ marketplace-name }}](/marketplace).
{% if product == "yandex-cloud" %}
* Используйте возможности SQL Server в [{{ mms-short-name }}](/services/managed-sqlserver) или заранее настроенных продуктах {{ marketplace-name }}. Также вы можете использовать свои лицензии SQL Server в инфраструктуре {{ yandex-cloud }}.
{% endif %}
* Настраивайте Active Directory и Microsoft Exchange на ВМ.
* Запускайте .NET-приложения на виртуальных машинах [{{ compute-name }}](/services/compute){% if product == "yandex-cloud" %} или в виде функций в [{{ sf-name }}](/services/functions){% endif %}.

Об особенностях образов виртуальных машин в {{ yandex-cloud }} можно узнать на странице [{#T}](list-of-instances.md).

О возможностях использования собственных лицензий читайте на странице [{#T}](licensing.md#byol).

{% include [ms-licensing-personal-data-note](../_includes/ms-licensing-personal-data-note.md) %}

## Windows Server {#win-server}

Создавайте виртуальные машины с операционной системой Microsoft Windows Server, чтобы запускать приложения для Windows. В {{ marketplace-name }} доступны несколько версий системы в редакции Datacenter — см. [список](/marketplace?type=COMPUTE_IMAGE&operationSystems=WINDOWS&sortBy=name-a-z&categories=os&search=Windows+Server).

При создании виртуальных машин необходимо указывать [уровень производительности](../compute/concepts/performance-levels.md) и количество ядер vCPU, который будет гарантированно зарезервирован за вашей ВМ. При этом процессор будет обрабатывать и вычислительные, и сетевые операции только в пределах зарезервированного уровня производительности. Используйте виртуальные машины с гарантированной долей vCPU меньше 100% для тестирования или запуска приложений, не требующих высокой производительности.

{% include [initialization-windows-vm](../_includes/initialization-windows-vm.md) %}

### Графические ускорители GPU {#gpus}

В {{ marketplace-name }} доступны версии Windows Server в редакции Datacenter с драйверами для подключения графических ускорителей — см. [список](/marketplace?type=COMPUTE_IMAGE&operationSystems=WINDOWS&sortBy=name-a-z&categories=os&search=Windows+Server+GPU).

GPU используются для задач машинного обучения и искусственного интеллекта, обработки трехмерной графики. Ускорители работают в режиме [TCC](https://docs.nvidia.com/nsight-visual-studio-edition/reference/index.html#tesla-compute-cluster) и поддерживают технологию CUDA<sup>®</sup>. Для работы с GPU не требуются лицензия и сервер лицензий.

Подробнее о работе с GPU в {{ yandex-cloud }} читайте на странице [{#T}](../compute/concepts/gpus.md).


{% if product == "yandex-cloud" %}

### Служба удаленных рабочих столов RDS {#rds}
 
Remote Desktop Licensing Server (RDS) — это служба Windows Server, с помощью которой можно настроить безопасный доступ к виртуальным и удалённым рабочим столам в облаке. RDS позволяет запускать одновременно несколько сессий подключения к виртуальным машинам.

Все образы виртуальных машин, доступные в {{ marketplace-name }}, имеют две лицензии RDS для администрирования. Если для решения ваших задач необходима возможность поддерживать большее количество удаленных сессий, воспользуйтесь образами с заранее активированной службой [RDS](/marketplace?tab=software&search=windows+rds), доступными в {{ marketplace-name }}.

Образы с активированной службой RDS основаны на Windows Server 2019 Datacenter и подходят для увеличения числа сессий для всех доступных в {{ marketplace-name }} версий Windows Server.

{% endif %}


{% if product == "yandex-cloud" %}

## SQL Server {#sql-server}

Microsoft SQL Server — это система управления базами данных. Вы можете использовать SQL Server на базе нашей инфраструктуры или в качестве дополнения для обеспечения высокой доступности ваших систем.

{{ marketplace-name }} предоставляет образы Microsoft SQL Server, предустановленные на Windows Server. Доступны версии SQL Server в редакциях:

* Web:
  * [Microsoft SQL Server 2016](/marketplace/products/yc/sql-server-2016-web)
  * [Microsoft SQL Server 2017](/marketplace/products/yc/sql-server-2017-web)
  * [Microsoft SQL Server 2019](/marketplace/products/yc/sql-server-2019-web)

* Standard:
  * [Microsoft SQL Server 2016](/marketplace/products/yc/sql-server-2016-standard)
  * [Microsoft SQL Server 2017](/marketplace/products/yc/sql-server-2017-standard)
  * [Microsoft SQL Server 2019](/marketplace/products/yc/sql-server-2019-standard)

* Enterprise:
  * [Microsoft SQL Server 2016](/marketplace/products/yc/sql-server-2016-enterprise)
  * [Microsoft SQL Server 2017](/marketplace/products/yc/sql-server-2017-enterprise)
  * [Microsoft SQL Server 2019](/marketplace/products/yc/sql-server-2019-enterprise)

Вместо предактивированных образов ВМ из {{ marketplace-name }} вы можете воспользоваться сервисом {{ mms-name }} и доверить нам обслуживание базы данных. 

Если у вас уже есть лицензия Microsoft SQL Server, вы можете перенести их на виртуальные машины {{ compute-name }}. Подробнее о лицензиях Microsoft SQL Server в виртуальной среде — на странице [{#T}](licensing.md#SQLmobility).

{% endif %}


{% if product == "yandex-cloud" %}

## Создание отказоустойчивого кластера {#clustering}

Отказоустойчивый кластер — это группа независимых виртуальных машин, которые работают совместно для обеспечения высокой доступности и непрерывности сервиса.

Windows Failover Cluster использует динамические IP-адреса, переназначаемые узлам кластера за счёт отправки пакетов `gARP`. Эти пакеты оповещают о смене привязки IP и MAC-адреса в рамках широковещательного домена. Как правило, облачные провайдеры не поддерживают совсем или ограничено поддерживают передачу такого рода пакетов.

Создать отказоустойчивый кластер SQL Server в {{ yandex-cloud }} можно двумя способами:

1. Использовать [multisubnetfailover](../tutorials/windows/mssql-alwayson-lb.md#configure-always-on) и дополнительные IP-адреса сетевых интерфейсов, на которых настроены статические маршруты. Узлы кластера будут размещаться в разных подсетях. Для этого необходимо задать несколько IP-адресов в параметре `connection string`.
1. С помощью [внутреннего балансировщика нагрузки](../network-load-balancer/concepts/internal-load-balancer.md). Трафик будет перенаправляться в зависимости от [проверок состояний](../network-load-balancer/concepts/health-check.md) на портах, однако эти порты будут [доступны](../network-load-balancer/concepts/internal-load-balancer.md#notes) только для самого {{ network-load-balancer-name }}.

{% endif %}
