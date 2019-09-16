# Бюллетени безопасности

На этой странице приводятся рекомендации специалистов Яндекс.Облака о вопросах безопасности.


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

### Влияние на сервисы Яндекс.Облака

Данные изменения позволят повысить безопасность пользователей Яндекс.Облака.


## 28.08.2019 — TCP SACK

### Описание
Специалисты Netflix обнаружили три уязвимости в ядре Linux:
* [CVE-2019-11477](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11477)
* [CVE-2019-11478](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11478)
* [CVE-2019-11479](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11479)

Оригинальный отчёт от Netflix: [NFLX-2019-001](https://github.com/Netflix/security-bulletins/blob/master/advisories/third-party/2019-001.md).

Разбор уязвимости от Red Hat: [TCP SACK PANIC](https://access.redhat.com/security/vulnerabilities/tcpsack).

### Влияние на сервисы Яндекс.Облака
* Инфраструктура Яндекс.Облака была оперативно защищена и обновлена.
* Образы операционных систем, доступные пользователям Yandex Compute Cloud, были обновлены как только появились соответствующие исправления. Таким образом, новые виртуальные машины, создаваемые в Yandex Compute Cloud, не подвержены указанным уязвимостям.
