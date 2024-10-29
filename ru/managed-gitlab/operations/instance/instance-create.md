---
title: Как создать инстанс {{ mgl-full-name }}
description: Из статьи вы узнаете, как создать инстанс {{ mgl-name }}.
---

# Создание и активация инстанса {{ mgl-name }}

## Создать инстанс {{ GL }} {#create}

Для создания инстанса {{ mgl-name }} нужна роль [{{ roles-vpc-user }}](../../../vpc/security/index.md#vpc-user) и роль [{{ roles.gitlab.editor }} или выше](../../security/index.md#roles-list). О том, как назначить роль, см. [документацию {{ iam-name }}](../../../iam/operations/roles/grant.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

   {% include [instance-create-console](../../../_includes/managed-gitlab/instance-create-console.md) %}

{% endlist %}

{% include [HTTPS info](../../../_includes/managed-gitlab/note-https.md) %}

## Активировать инстанс {{ GL }} {#activate}

После того как статус инстанса принял значение **Running**, активируйте инстанс:

1. Перейдите по ссылке, полученной на электронную почту администратора после создания инстанса.

   Если по ссылке не открывается веб-интерфейс {{ GL }}, создайте отдельную группу безопасности и [настройте ее](../configure-security-group.md) так, чтобы правила разрешали входящий трафик с нужных портов и IP-адресов.

1. Измените пароль администратора.
1. Авторизуйтесь с помощью логина и пароля администратора.

В дальнейшем, чтобы открыть веб-интерфейс {{ GL }}, [получите детальную информацию об инстансе](instance-list.md#get) и перейдите по ссылке в поле **{{ ui-key.yacloud.gitlab.field_domain }}**.
