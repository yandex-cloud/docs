---
title: Как экспортировать SSH-сертификат
description: Следуя данной инструкции, вы сможете локально экспортировать SSH-сертификат, чтобы использовать его для подключения через {{ oslogin }} к виртуальным машинам, для которых настроен доступ по {{ oslogin }}.
---

# Экспортировать SSH-сертификат

Чтобы пользователь или сторонний инструмент, такой как [Terraform](https://www.terraform.io/) или [Ansible](https://www.ansible.com/), мог подключиться по протоколу SSH к виртуальной машине с включенным доступом по {{ oslogin }}, можно использовать SSH-сертификат [пользователя организации](../../../organization/concepts/membership.md) или сервисного аккаунта. Для этого необходимо локально экспортировать SSH-сертификат и использовать его для доступа к ВМ с помощью стандартного SSH-клиента. Экспортированный сертификат действителен один час.

{% include [oslogin-export-certificate](../../../_includes/compute/oslogin-export-certificate.md) %}

С помощью экспортированного SSH-сертификата вы можете [подключиться](./os-login.md#connect-with-ssh-client) к виртуальной машине, для которой [настроен](../vm-control/vm-update.md#enable-oslogin-access) доступ по {{ oslogin }}.

#### См. также {#see-also}

* [{#T}](../../../organization/operations/os-login-access.md)
* [{#T}](../../../organization/operations/add-ssh.md)
* [{#T}](./os-login.md)
* [Подключиться к узлу {{ k8s }} через {{ oslogin }}](../../../managed-kubernetes/operations/node-connect-oslogin.md)
* [Использовать сервисный аккаунт с профилем {{ oslogin }} для управления ВМ с помощью Ansible](../../../tutorials/security/sa-oslogin-ansible.md)