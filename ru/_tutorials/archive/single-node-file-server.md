# Однонодовый файловый сервер


В этом руководстве вы создадите однонодовый файловый сервер [NFS](https://docs.microsoft.com/ru-ru/windows-server/storage/nfs/nfs-overview) с помощью пакета программ [Samba](https://www.samba.org/) и сетевой инфраструктуры [{{ vpc-full-name }}](../../vpc/). Сервер разместится на виртуальной машине [Ubuntu](/marketplace?tab=software&search=Ubuntu&categories=os), а подключаться к нему можно будет с компьютеров на Linux, macOS и Windows.

Вы можете создать инфраструктуру для однонодового файлового сервера с помощью одного из инструментов:
* [Консоль управления](../../tutorials/archive/single-node-file-server/console.md) — используйте этот способ, чтобы пошагово создать инфраструктуру в консоли управления {{ yandex-cloud }}.
* [{{ TF }}](../../tutorials/archive/single-node-file-server/terraform.md) — используйте этот способ, чтобы упростить создание ресурсов и управление ими, используя подход «инфраструктура как код» (IaC). Скачайте пример конфигурации {{ TF }}, а затем разверните инфраструктуру с помощью [{{ TF }}-провайдера {{ yandex-cloud }}]({{ tf-docs-link }}).
