# Бюллетени безопасности

На этой странице приводятся рекомендации специалистов {{ yandex-cloud }} о вопросах безопасности.

## 24.12.2020 — CVE-2020-25695 - повышение привилегий в PostgreSQL

### Описание

В системе управления базами данных PostgreSQL была обнаружена уязвимость [CVE-2020-25695](https://nvd.nist.gov/vuln/detail/CVE-2020-25695), которая позволяет непревилигерованному пользователю, при наличии у него прав на создание не временных объектов, выполнять произвольные SQL запросы от имени суперпользователя.

### Влияние на сервисы Yandex.Cloud

Все системы управления базами данных PostgreSQL, используемые в рамках сервиса Yandex Managed Service for PostgreSQL, были [обновлены](https://www.postgresql.org/about/news/postgresql-131-125-1110-1015-9620-and-9524-released-2111/).

## 19.11.2020 — Отказ от устаревших TLS протоколов

### Описание

Чтобы повысить безопасность передачи данных, {{ yandex-cloud }} рекомендует всем пользователям перейти на использование технологий, которые обеспечивают шифрование по протоколу [TLS 1.2](https://tools.ietf.org/html/rfc5246) и выше.

### Влияние на сервисы {{ yandex-cloud }}

Все сервисы {{ yandex-cloud }} поддерживают TLS 1.2 и выше. Поддержка устаревших протоколов будет постепенно прекращена. Рекомендуем заранее переключить существующие приложения на использование актуальных версий TLS. 
 
## 20.09.2020 — CVE-2020-1472 (aka Zerologon)

### Описание

Уязвимость в Windows Netlogon Remote Protocol позволяет неаутентифицированному атакующему с сетевым доступом к контроллеру домена скомпрометировать все службы идентификации Active Directory.

Исходный отчёт  Secura: [Zerologon](https://www.secura.com/pathtoimg.php?id=2055).

Описание уязвимости, составленное Microsoft: [CVE-2020-1472](https://portal.msrc.microsoft.com/en-US/security-guidance/advisory/CVE-2020-1472).

Руководство по управлению изменениями от Microsoft: [Управление изменениями в подключениях безопасного канала Netlogon, связанными с CVE-2020-1472](https://support.microsoft.com/ru-ru/help/4557222/how-to-manage-the-changes-in-netlogon-secure-channel-connections-assoc).

### Влияние на сервисы {{ yandex-cloud }}

Образы операционных систем, доступные пользователям {{ compute-full-name }}, уже содержат обновления, устраняющие уязвимость. Все виртуальные машины, созданные в {{ compute-full-name }} после выхода этого сообщения, защищены от описанной атаки.

### Компенсационные меры

В дополнение к обновлениям, для ограничения доступа к контроллеру домена из недоверенных сетей используйте следующие системы контроля доступа к сети:
* Windows Firewall или группы безопасности;
* перемещение контроллера домена за NAT-gateway.

## 15.06.2020 — Special Register Buffer Data Sampling Attack (aka CrossTalk)


### Описание

Для некоторых моделей процессоров Intel компания VUSec [обнаружила новую атаку](https://www.vusec.net/projects/crosstalk/) под названием Special Register Buffer Data Sampling Attack (или CrossTalk). Данная атака позволяет злонамеренному процессу получить результаты, возвращаемые инструкциями RDRAND и RDSEED из другого процесса, при этом злонамеренный и легитимный процессы могут выполняться на разных физических ядрах процессора. Атаке присвоен номер [CVE-2020-0543](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-0543).

Отчет от Intel: [Deep Dive: Special Register Buffer Data Sampling](https://software.intel.com/security-software-guidance/insights/deep-dive-special-register-buffer-data-sampling).


### Влияние на сервисы {{ yandex-cloud }}

Модели процессоров, используемые в {{ yandex-cloud }}, **не подвержены атаке** CrossTalk.


## 28.08.2019 — TCP SACK


### Описание
Специалисты Netflix обнаружили три уязвимости в ядре Linux:
* [CVE-2019-11477](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11477)
* [CVE-2019-11478](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11478)
* [CVE-2019-11479](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11479)

Оригинальный отчёт от Netflix: [NFLX-2019-001](https://github.com/Netflix/security-bulletins/blob/master/advisories/third-party/2019-001.md).

Разбор уязвимости от Red Hat: [TCP SACK PANIC](https://access.redhat.com/security/vulnerabilities/tcpsack).


### Влияние на сервисы {{ yandex-cloud }}
* Инфраструктура {{ yandex-cloud }} была оперативно защищена и обновлена.
* Образы операционных систем, доступные пользователям Yandex Compute Cloud, были обновлены как только появились соответствующие исправления. Таким образом, новые виртуальные машины, создаваемые в Yandex Compute Cloud, не подвержены указанным уязвимостям.


## 19.08.2019 — Несколько доменов Yandex Object Storage внесены в Public Suffix List


### Описание

Список доменов, внесенных в Public Suffix List:
* yandexcloud.net
* storage.yandexcloud.net
* website.yandexcloud.net

Домены из списка Public Suffix List получают свойства доменов верхнего уровня, как, например, домены .ru или .com:
* Браузеры не будут сохранять сookie, установленные на перечисленные домены.
* Браузеры не позволят поменять заголовок запроса `Origin` страницы на корневые домены.

Больше информации можно найти в [нашем блоге](https://cloud.yandex.ru/blog/posts/2019/08/storage-domains).


### Влияние на сервисы {{ yandex-cloud }}

Данные изменения позволят повысить безопасность пользователей {{ yandex-cloud }}.
