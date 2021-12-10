# Бюллетени безопасности

На этой странице приводятся рекомендации специалистов {{ yandex-cloud }} по вопросам безопасности.

## 10.12.2021 — CVE-2021-44228 – Удаленное выполнение кода (Log4Shell, Apache Log4j) 

### Описание

Уязвимость [CVE-2021-44228](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-44228) содержится в библиотеке Apache Log4j, в версиях от 2.14.1 и ниже.

Был обнаружен эксплойт нулевого дня, который приводит к удаленному выполнению кода (RCE) путем записи в журнал определенной строки. 

Злоумышленник, который может управлять сообщениями журнала или параметрами сообщений журнала, может выполнить произвольный код, загруженный с серверов LDAP, когда включена функция `message lookup substitution` . Начиная с версии log4j 2.15.0, это поведение отключено по умолчанию. 

Подробное описание эксплойта и поведения представлено в [материале Lunasec](https://www.lunasec.io/docs/blog/log4j-zero-day/). 

Исходный отчёт от logging.apache.org: [Fixed in Log4j 2.15.0](https://logging.apache.org/log4j/2.x/security.html). 

Описание уязвимости: [CVE-2021-44228](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-44228). 

CVSSv3.1 рейтинг: 9.8 [CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:H/E:P/RL:O/RC:C] Подробнее: https://www.securitylab.ru/vulnerability/527362.php 

### Влияние

#### Общее влияние

Библиотека Log4j включена в почти все enterprise-решения Apache Software Foundation, такие как: Apache Struts, Apache Flink, Apache Druid, Apache Flume, Apache Solr, Apache Flink, Apache Kafka, Apache Dubbo и т.д. 

Предположительно, влияние уязвимости есть в таких open-source продуктах, как Redis, ElasticSearch, Elastic Logstash, the NSA’s Ghidra и т.д.

#### Влияние на сервисы {{ yandex-cloud }}

Версия библиотеки, подверженная уязвимости, была использована в некоторых сервисах {{ yandex-cloud }}. Наиболее критичные сервисы, которые были подвержены уязвимости: {{ mes-full-name }}, {{ dataproc-full-name }}, а также ряд базовых сервисов платформы. 

Критичные сервисы успешно обновлены в соответствии с рекомендациями производителя. Остальные сервисы находятся в процессе обновления.  

Со стороны {{ yandex-cloud }} была собрана информация по пользователям, которые использовали подобные сервисы, и были отправлены соответствующие оповещения. 

В настоящее время ведется поиск дополнительных сервисов, которые могут быть подвержены уязвимости, с целью их обновления.  

По результатам финальных работ будет выполнено обновление данного бюллетеня.  

### Компенсационные меры

Если в вашей инфраструктуре используется данная библиотека или продукты, которые упомянуты в разделе «Общее влияние», выполните следующие действия.  

Обновите уязвимое ПО до версии log4j-2.15.0-rc2 или выше. Если вы используете уязвимую версии ПО от 2.10 и выше, уязвимости можно избежать путем установки параметра `log4j2.formatMsgNoLookups` в значение `true` или удалением `JndiLookup class` из  `classpath` (пример: `zip -q -d log4j-core-*.jar org/apache/logging/log4j/core/lookup/JndiLookup.class`).   

Если используется [Java 8u121](https://www.oracle.com/java/technologies/javase/8u121-relnotes.html), защититесь от RCE установкой параметров `com.sun.jndi.rmi.object.trustURLCodebase` и `com.sun.jndi.cosnaming.object.trustURLCodebase` в `false`. Источник:  https://logging.apache.org/log4j/2.x/security.html

## 12.10.2021 – CVE-2021-25741 – Возможность получить доступ к файловой системе хоста

### Описание

В Kubernetes обнаружена [уязвимость](https://github.com/kubernetes/kubernetes/issues/104980), которая позволяет получить несанкционированный доступ к файловой системе ноды при авторизации пользователя в кластере.

### Влияние на сервисы Yandex.Cloud

{{ managed-k8s-full-name }} не поддерживает анонимный доступ в кластер и не подвержен уязвимости со стороны внешнего нарушителя.

### Компенсационные меры

Для устранения вектора атак со стороны внутреннего нарушителя обновите все существующие кластеры и группы узлов в сервисе до версии 1.19 или выше. Если ваши кластеры и группы узлов уже обновлены до версии 1.19 или выше, обновите ревизии. Обновление, которое закрывает уязвимости, доступно во всех релизных каналах.

Также рекомендуем:
* Автоматически обновлять кластеры и группы узлов до последних версий или ревизий.
* Планировать ручные обновления хотя бы раз в месяц, если вы не можете применять автоматические обновления.
* Запретить запускать поды от имени пользователя root для недоверенных загрузок.

Для этого можно использовать следующие инструменты:
* [OPA Gatekeeper](https://github.com/open-policy-agent/gatekeeper-library/tree/master/library/pod-security-policy/users)
* [Kyverno](https://kyverno.io/policies/pod-security/restricted/require-run-as-nonroot/require-run-as-nonroot/)

### Дополнительная информация

Чеклист для безопасной конфигурации Kubernetes доступен [по ссылке](../security/domains/checklist#kubernetes-security).

## 03.03.2021 — CVE-2021-21309 — удаленное выполнение кода через уязвимость в {{ RD }}

### Описание

В 32-битной версии {{ RD }} версии 4.0 и выше обнаружена уязвимость типа integer overflow, которая при определенных условиях может привести к удаленному выполнению кода.

### Влияние на сервисы Yandex.Cloud

{{ mrd-full-name }} использует 64 битную версию {{ RD }} и не подвережен уязвимости.

## 26.01.2021 — CVE-2021-3156 - повышение привилегий через уязвимости в sudo.

### Описание

В приложении `sudo` был найден ряд уязвимостей [CVE-2021-3156](https://nvd.nist.gov/vuln/detail/CVE-2021-3156), которые позволяют непривилигированному пользвателю системы повысить свои привилегии до пользователя `root`.

### Влияние на сервисы Yandex.Cloud

Были обновлены следующие образы операционных систем Linux:
* все образы от издателя {{ yandex-cloud }}, доступные в {{ marketplace-name }};
* образ {{ coi }};
* образ, который используется для создания узлов в сервисе {{ managed-k8s-short-name }};
* образы, которые используются для создания кластеров управляемых баз данных;
* образ, который используется для создания кластеров {{ dataproc-short-name }}.

### Дополнительная информация

* [Buffer overflow in command line unescaping](https://www.sudo.ws/alerts/unescape_overflow.html)
* [CVE-2021-3156: Heap-Based Buffer Overflow in Sudo (Baron Samedit)](https://blog.qualys.com/vulnerabilities-research/2021/01/26/cve-2021-3156-heap-based-buffer-overflow-in-sudo-baron-samedit)

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

Исходный отчёт  Secura: [Zerologon](https://www.secura.com/whitepapers/zerologon-whitepaper).

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
