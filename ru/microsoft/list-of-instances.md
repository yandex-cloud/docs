# Образы виртуальных машин с операционной системой Windows

{% if product == "yandex-cloud" %}

В {{ marketplace-name }} вам доступен большой выбор продуктов:

* ВМ с предустановленной операционной системой Windows Server; 
* ВМ c активированной службой Remote Desktop Service с поддержкой различного количества удаленных рабочих столов; 
* заранее настроенные образы Microsoft SQL Server.

{% endif %}

{% if product == "cloud-il" %}

В {{ marketplace-name }} вам доступны ВМ с предустановленной операционной системой Windows Server.

{% endif %}


## Образы Windows Server {#win-server}

В [{{ marketplace-name }}](/marketplace?categories=os&operationSystems=WINDOWS) доступен образ Microsoft Windows Server только в редакции Datacenter: 

* Windows Server 2012 R2
* Windows Server 2016
* Windows Server 2019


{% if product == "yandex-cloud" %}

### Служба удаленных рабочих столов RDS {#rds}

В {{ marketplace-name }} вам доступны образы [Windows RDS](/marketplace?search=RDS) на основе Windows Server 2019 Datacenter с предварительно активированной ролью Remote Desktop Licensing Server и пакетом пользовательских лицензий. На выбор доступны пакеты лицензий RDS на 5, 10, 25, 50, 100, 250 и 500 лицензий. 

{% note warning %}

В образах с предактивированным RDS не проводится оптимизация с помощью утилиты `sysprep` и не меняется SID. Из-за этого могут возникать конфликты, если в одном домене запущены две ВМ с одинаковым количество лицензий.

{% endnote %}

{% endif %}


### Изменения в образах ВМ с операционной системой Windows {#changes}

Для работы в облаке в операционную систему вносятся изменения, которые позволяют обезличить систему и удалить временные файлы.

#### Конфигурация сетевых служб {#configuration}

* Разрешено удаленное управление Windows с помощью службы WinRM. Созданы разрешающие правила для WinRM по протоколу HTTPS.
* Созданы разрешающие правила для протокола ICMP.
* Названия сетевых интерфейсов соответствуют названиям на платформе {{ yandex-cloud }}.
* В реестре системы разрешен протокол RDP, настроены правила и соответствующие сетевые порты.

#### Настройки энергосбережения {#power-saving-settings}

* Производительность системы установлена в режим <q>Высокая производительность</q> (power plan — high performance).

#### Настройки времени {#time-settings}

* Установлено значение параметра `RealTimeIsUniversal`, при котором аппаратное время в системе равно [UTC+0]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/Всемирное_координированное_время){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Coordinated_Universal_Time){% endif %}. 

#### Прочие преобразования {#conversions}

* Параметр реестра `ShutDownWithoutLogon` разрешает реагировать на ACPI Call без наличия интерактивной сессии.
* Отключена поддержка SMBv1.
* Разрешено использование [серийной консоли]{% if lang == "ru" %}(https://docs.microsoft.com/ru-ru/windows-hardware/drivers/devtest/boot-parameters-to-enable-ems-redirection){% endif %}{% if lang == "en" %}(https://docs.microsoft.com/en-us/windows-hardware/drivers/devtest/boot-parameters-to-enable-ems-redirection){% endif %}.
* Проведена оптимизация системы с помощью утилиты [Ngen]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/Ngen){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Native_Image_Generator){% endif %}.
* Установлена утилита `cloudbase-init` для автоматизации операций в процессе запуска виртуальной машины.

### Драйверы {#drivers}

Для работы ВМ на базе Microsoft Windows необходимы драйверы `virtIO` для сетевых и дисковых устройств. Драйверы предоставляет Fedora Project. В образах ВМ используется последняя стабильная версия драйверов, доступная для [загрузки](https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.185-2/) на сайте разработчика.


{% if product == "yandex-cloud" %}

## Образы Microsoft SQL Server {#sql}

Образы Microsoft SQL Server, доступные в {{ marketplace-name }} — это виртуальные машины с уже установленной Windows Server и Microsoft SQL Server. Лицензии в образах предварительно активированы, ключ активации хранится в самом образе. Если вам необходимо изменить или добавить компоненты в систему, дистрибутив Microsoft SQL Server находится в отдельной папке в корне системного диска (по умолчанию — диск `C:\`).

{% endif %}
