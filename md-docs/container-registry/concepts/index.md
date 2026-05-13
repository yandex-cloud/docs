# Концепции Yandex Container Registry

Container Registry — сервис для хранения и распространения [Docker-образов](https://yandex.cloud/ru/blog/posts/2022/03/docker-containers).

Container Registry предоставляет надежное и независимое от внешних блокировок хранилище. Docker-образы в Container Registry размещаются в тех же [дата-центрах](../../overview/concepts/geo-scope.md) Yandex Cloud, в которых размещена остальная облачная инфраструктура, что обеспечивает высокую скорость работы с образами и отсутствие затрат на внешний трафик.

В целях безопасности Docker-образы в Container Registry передаются по протоколу [HTTPS](../../glossary/ssl-certificate.md) с использованием SSL-сертификатов, управляемых из Yandex Cloud. Кроме того, Container Registry предоставляет встроенный [сканер уязвимостей](vulnerability-scanner.md), с помощью которого можно сканировать Docker-образы как в момент их загрузки в реестр, так и позднее по расписанию, а также гибко управлять результатами сканирования.

Сервис позволяет управлять следующими объектами:

* [Docker-образ](docker-image.md)
* [Том Docker](docker-volume.md)
* [Реестр](registry.md)
* [Репозиторий](repository.md)

Для работы с Container Registry требуется доступ в интернет.

Предоставить доступ в интернет можно следующими способами:

* Назначить виртуальной машине [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses).
* [Настроить виртуальную машину в качестве NAT-инстанса](../../tutorials/routing/nat-instance/index.md).
* [Настроить NAT-шлюз](../../vpc/operations/create-nat-gateway.md).

Сервис поддерживает [Docker Registry HTTP API V2](https://docs.docker.com/registry/spec/api/), поэтому доступны команды, предусмотренные Docker CLI.