---
title: "Как экспортировать сертификат OS Login"
description: "Следуя данной инструкции, вы сможете локально экспортировать сертификат OS Login, чтобы использовать его для подключения по SSH к виртуальным машинам, для которых настроен доступ по OS Login."
---

# Экспортировать сертификат OS Login

Чтобы пользователь или сторонний инструмент, такой как [Terraform](https://www.terraform.io/) или [Ansible](https://www.ansible.com/), мог подключиться по протоколу SSH к виртуальной машине с включенным доступом по OS Login, можно использовать сертификат. Для этого необходимо локально экспортировать сертификат OS Login и использовать его для доступа к ВМ с помощью стандартного SSH-клиента. Экспортированный сертификат действителен один час.

{% include [oslogin-export-certificate](../../../_includes/compute/oslogin-export-certificate.md) %}

С помощью экспортированного сертификата OS Login вы можете [подключиться](./os-login.md#connect-via-exported-certificate) к виртуальной машине, для которой [настроен](../vm-control/vm-update.md#enable-oslogin-access) доступ по OS Login.

#### См. также {#see-also}

* [{#T}](../../../organization/operations/os-login-access.md)
* [{#T}](../../../organization/operations/add-ssh.md)
* [{#T}](./os-login.md)
* [Подключиться к узлу {{ k8s }} через OS Login](../../../managed-kubernetes/operations/node-connect-oslogin.md)
* [Использовать сервисный аккаунт с профилем OS Login для управления ВМ с помощью Ansible](../../../tutorials/security/sa-oslogin-ansible.md)