---
title: Как создать профиль OS Login
description: Следуя данной инструкции, вы сможете создать профиль OS Login.
---

# Создать профиль OS Login

По умолчанию профили OS Login будут созданы для всех пользователей организации при [включении настройки](./os-login-access.md). При необходимости вы можете создать дополнительные профили или отредактировать существующие. Профили OS Login можно использовать в качестве профилей пользователей при работе внутри [ВМ](../../compute/concepts/vm.md) или узлов [кластеров](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) {{ k8s }}.

Чтобы создать профиль OS Login для пользователя:

{% list tabs group=instructions %}

- Интерфейс {{ org-name }} {#console}

  1. [Войдите в аккаунт]({{ link-passport-login }}) администратора или владельца организации.
  1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-main }}).
  1. При необходимости [переключитесь](./manage-organizations.md#switch-to-another-org) на нужную организацию или федерацию.
  1. На панели слева выберите раздел [{{ ui-key.yacloud_org.pages.users }}]({{ link-org-users }}) ![icon-users](../../_assets/console-icons/person.svg).
  1. Выберите пользователя из списка.
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.page.user.title_tab-os-login }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud_org.entity.oslogin-profile.action.create }}**.
  1. Введите имя пользователя.

      {% include [note-info-user-name-limits](../../_includes/organization/note-info-user-name-limits.md) %}

  1. Введите уникальный числовой идентификатор пользователя (UID) в диапазоне от `1000` до `65534`.
  1. (Опционально) Укажите путь к домашнему каталогу пользователя.
  1. (Опционально) Укажите путь до исполняемого файла командной оболочки.
  1. Нажмите кнопку **{{ ui-key.yacloud_org.forms.action.create }}**.

- API {#api}

  Воспользуйтесь методом REST API [createProfile](../../organization/api-ref/OsLogin/createProfile.md) для ресурса [OsLogin](../../organization/api-ref/OsLogin/index.md) или вызовом gRPC API [OsLoginService/CreateProfile](../../organization/api-ref/grpc/os_login_service.md#CreateProfile).

{% endlist %}

{% note info %}

Если вы задаете UID вручную, используйте значения в диапазоне от `1000` до `65534`. Использование этого диапазона позволит избежать совпадения UID профиля OS Login и системных профилей операционной системы.

{% endnote %}

#### См. также {#see-also}

* [{#T}](../operations/os-login-access.md)
* [{#T}](../operations/add-ssh.md)
* [{#T}](../../compute/operations/vm-connect/os-login.md)
* [Подключиться к узлу {{ k8s }} через OS Login](../../managed-kubernetes/operations/node-connect-oslogin.md)
* [Использовать сервисный аккаунт с профилем OS Login для управления ВМ с помощью Ansible](../tutorials/sa-oslogin-ansible.md)