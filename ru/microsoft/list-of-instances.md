# Образы виртуальных машин с операционной системой Windows


В {{ marketplace-name }} вам доступен большой выбор продуктов:

* ВМ с предустановленной операционной системой Windows Server; 
* ВМ c активированной службой Remote Desktop Service с поддержкой различного количества удаленных рабочих столов; 
* заранее настроенные образы Microsoft SQL Server.




## Образы Windows Server {#win-server}

В {{ marketplace-name }} доступны образы Microsoft Windows Server только в редакции Datacenter — см. [список](/marketplace?type=COMPUTE_IMAGE&operationSystems=WINDOWS&sortBy=name-a-z&categories=os&search=Windows+Server).




### Служба удаленных рабочих столов RDS {#rds}

В {{ marketplace-name }} вам доступны образы [Windows RDS](/marketplace?tab=software&search=windows+rds) на основе [Windows Server 2019 Datacenter](/marketplace?tab=software&search=Windows+Server+2019+Datacenter) с предварительно активированной ролью Remote Desktop Licensing Server и пакетом пользовательских лицензий. На выбор доступны пакеты лицензий RDS на [5](/marketplace/products/yc/windows-rds-5-licenses), [10](/marketplace/products/yc/windows-rds-10-licenses), [25](/marketplace/products/yc/windows-rds-25-licenses), [50](/marketplace/products/yc/windows-rds-50-licenses), [100](/marketplace/products/yc/windows-rds-100-licenses), [250](/marketplace/products/yc/windows-rds-250-licenses) и [500](/marketplace/products/yc/windows-rds-500-licenses) лицензий. 

{% note warning %}
 
В образах с предактивированным RDS не проводится оптимизация с помощью утилиты `sysprep` и не меняется SID. В противном случае, если в одном домене запущены две ВМ с одинаковым количеством лицензий, могут возникать конфликты. Кроме того, оптимизация с помощью утилиты `sysprep` сбросит активацию сервера лицензирования Remote Desktop Services без возможности восстановления.

{% endnote %}



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

* Установлено значение параметра `RealTimeIsUniversal`, при котором аппаратное время в системе равно [UTC+0](https://ru.wikipedia.org/wiki/Всемирное_координированное_время). 

#### Прочие преобразования {#conversions}

* Параметр реестра `ShutDownWithoutLogon` разрешает реагировать на ACPI Call без наличия интерактивной сессии.
* Отключена поддержка SMBv1.
* Разрешено использование [серийной консоли]({{ ms.docs }}/windows-hardware/drivers/devtest/boot-parameters-to-enable-ems-redirection).
* Проведена оптимизация системы с помощью утилиты [Ngen](https://ru.wikipedia.org/wiki/Ngen).
* Установлена утилита `cloudbase-init` для автоматизации операций в процессе запуска виртуальной машины.

### Драйверы {#drivers}

Для работы ВМ на базе Microsoft Windows необходимы драйверы `virtIO` для сетевых и дисковых устройств. Драйверы предоставляет Fedora Project. В образах ВМ используется последняя стабильная версия драйверов, доступная для [загрузки](https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.185-2/) на сайте разработчика.



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

