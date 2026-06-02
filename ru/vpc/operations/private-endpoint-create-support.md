---
title: Как создать сервисное подключение в {{ vpc-full-name }} через поддержку
description: Инструкция по созданию сервисного подключения (Private Endpoint) в {{ vpc-name }} через поддержку.
---

# Обращение в поддержку для создания нового сервисного подключения {#pe-ticket}

Чтобы создать сервисное подключение, оформите [обращение в поддержку]({{ link-console-support }}).


Обращение должно быть оформлено следующим образом:

```s
Тема: [VPC-PE] Создание нового сервисного подключения

Текст обращения:
Прошу создать новое сервисное подключение (VPC-PE) со следующими параметрами:

service_name: Cloud Registry  
folder_id: b1gl8**********p3qnf
network_id: enpm3**********4gtp7
private_dns_records_enabled: false
```


Где:

* `service_name` — [название сервиса](../concepts/private-endpoint.md#pe-services);
* `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором нужно создать сервисное подключение;
* `network_id` — [идентификатор облачной сети](network-get-info.md#console_1), в которой нужно создать сервисное подключение;
* `private_dns_records_enabled` — нужно ли создавать в DNS Primary-запись для работы обычного FQDN сервиса через сервисное подключение.

