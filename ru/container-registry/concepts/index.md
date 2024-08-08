# Концепции {{ container-registry-full-name }}

{{ container-registry-name }} — сервис для хранения и распространения [Docker-образов](/blog/posts/2022/03/docker-containers).

{{ container-registry-name }} предоставляет надежное и независимое от внешних блокировок хранилище. Docker-образы в {{ container-registry-name }} размещаются в тех же [дата-центрах](../../overview/concepts/geo-scope.md) {{ yandex-cloud }}, в которых размещена остальная облачная инфраструктура, что обеспечивает высокую скорость работы с образами и отсутствие затрат на внешний трафик.

В целях безопасности Docker-образы в {{ container-registry-name }} передаются по протоколу [HTTPS](../../glossary/ssl-certificate.md) с использованием SSL-сертификатов, управляемых из {{ yandex-cloud }}. Кроме того, {{ container-registry-name }} предоставляет встроенный [сканер уязвимостей](./vulnerability-scanner.md), с помощью которого можно сканировать Docker-образы как в момент их загрузки в реестр, так и позднее по расписанию, а также гибко управлять результатами сканирования.

Сервис позволяет управлять следующими объектами:

* [Docker-образ](docker-image.md)
* [Том Docker](docker-volume.md)
* [Реестр](registry.md)
* [Репозиторий](repository.md)

Для работы с {{ container-registry-name }} требуется доступ в интернет.

Предоставить доступ в интернет можно следующими способами:

* Назначить виртуальной машине [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses).
* [Настроить виртуальную машину в качестве NAT-инстанса](../../tutorials/routing/nat-instance.md).
* [Настроить NAT-шлюз](../../vpc/operations/create-nat-gateway.md).

Сервис поддерживает [Docker Registry HTTP API V2](https://docs.docker.com/registry/spec/api/), поэтому доступны команды, предусмотренные Docker CLI.