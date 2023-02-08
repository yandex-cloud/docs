# Концепции {{ container-registry-full-name }}

{{ container-registry-name }} — сервис для хранения и распространения [Docker-образов](/blog/posts/2022/03/docker-containers).

Сервис позволяет управлять следующими объектами:
* [Docker-образ](docker-image.md)
* [Том Docker](docker-volume.md)
* [Реестр](registry.md)
* [Репозиторий](repository.md)

Для работы с {{ container-registry-name }} требуется доступ в интернет.

Предоставить доступ в интернет можно следующими способами:
* Назначить виртуальной машине [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses).
* [Настроить виртуальную машину в качестве NAT-инстанса](../../tutorials/routing/nat-instance.md).
* [Включить функцию NAT в интернет](../../vpc/operations/enable-nat.md).

Сервис поддерживает [Docker Registry HTTP API V2](https://docs.docker.com/registry/spec/api/), поэтому доступны команды, предусмотренные Docker CLI.