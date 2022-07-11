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

В {{ marketplace-name }} доступен образ Microsoft Windows Server только в редакции Datacenter: 

* [Windows Server 2012 R2](/marketplace/products/yc/windows-server-2012r2-datacenter)
* [Windows Server 2016](/marketplace/products/yc/windows-server-2016-datacenter)
* [Windows Server 2019](/marketplace/products/yc/windows-server-2019-datacenter)


{% if product == "yandex-cloud" %}

### Служба удаленных рабочих столов RDS {#rds}

В {{ marketplace-name }} вам доступны образы [Windows RDS](/marketplace?tab=software&search=windows+rds) на основе [Windows Server 2019 Datacenter](/marketplace?tab=software&search=Windows+Server+2019+Datacenter) с предварительно активированной ролью Remote Desktop Licensing Server и пакетом пользовательских лицензий. На выбор доступны пакеты лицензий RDS на [5](/marketplace/products/yc/windows-rds-5-licenses), [10](/marketplace/products/yc/windows-rds-10-licenses), [25](/marketplace/products/yc/windows-rds-25-licenses), [50](/marketplace/products/yc/windows-rds-50-licenses), [100](/marketplace/products/yc/windows-rds-100-licenses), [250](/marketplace/products/yc/windows-rds-250-licenses) и [500](/marketplace/products/yc/windows-rds-500-licenses) лицензий. 

{% note warning %}
 
В образах с предактивированным RDS не проводится оптимизация с помощью утилиты `sysprep` и не меняется SID. В противном случае, если в одном домене запущены две ВМ с одинаковым количеством лицензий, могут возникать конфликты. Кроме того, оптимизация с помощью утилиты `sysprep` сбросит активацию сервера лицензирования Remote Desktop Services без возможности восстановления.

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
* Разрешено использование [серийной консоли]{% if lang == "ru" %}({{ ms.docs }}/windows-hardware/drivers/devtest/boot-parameters-to-enable-ems-redirection){% endif %}{% if lang == "en" %}(https://docs.microsoft.com/en-us/windows-hardware/drivers/devtest/boot-parameters-to-enable-ems-redirection){% endif %}.
* Проведена оптимизация системы с помощью утилиты [Ngen]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/Ngen){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Native_Image_Generator){% endif %}.
* Установлена утилита `cloudbase-init` для автоматизации операций в процессе запуска виртуальной машины.

### Драйверы {#drivers}

Для работы ВМ на базе Microsoft Windows необходимы драйверы `virtIO` для сетевых и дисковых устройств. Драйверы предоставляет Fedora Project. В образах ВМ используется последняя стабильная версия драйверов, доступная для [загрузки](https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.185-2/) на сайте разработчика.


{% if product == "yandex-cloud" %}

## Образы Microsoft SQL Server {#sql}

Образы Microsoft SQL Server — это виртуальные машины с уже установленной Windows Server и Microsoft SQL Server. В {{ marketplace-name }} доступны версии SQL Server в редакциях:

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

Лицензии в образах предварительно активированы, ключ активации хранится в самом образе. Если вам необходимо изменить или добавить компоненты в систему, дистрибутив Microsoft SQL Server находится в отдельной папке в корне системного диска (по умолчанию — диск `C:\`).

{% endif %}
