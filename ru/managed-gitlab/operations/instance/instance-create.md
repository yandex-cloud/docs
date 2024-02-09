---
title: "Как создать инстанс {{ mgl-full-name }}"
description: "Из статьи вы узнаете, как создать инстанс {{ mgl-name }}."
---

# Создание и активация инстанса {{ mgl-name }}

## Создать инстанс {{ GL }} {#create}

{% list tabs group=instructions %}

- Консоль управления {#console}

   {% include [instance-create-console](../../../_includes/managed-gitlab/instance-create-console.md) %}

{% endlist %}

Чтобы уменьшить вероятность переполнения дискового пространства инстанса:

* [Настройте время жизни артефактов сборки](https://docs.gitlab.com/ee/administration/settings/continuous_integration.html#default-artifacts-expiration) на уровне всего инстанса. По умолчанию оно составляет 30 дней.
* [Создайте и настройте политику очистки тегов](https://docs.gitlab.com/ee/user/packages/container_registry/reduce_container_registry_storage.html#create-a-cleanup-policy) на уровне отдельных проектов, которые используют Container Registry.
* Если вы используете [интеграцию с {{ container-registry-full-name }}](../../tutorials/image-storage.md), создайте и настройте [политику удаления Docker-образов](../../../container-registry/concepts/lifecycle-policy.md) на стороне {{ container-registry-name }}.

## Активировать инстанс {{ GL }} {#activate}

После того как статус инстанса принял значение **Running**, активируйте инстанс:

1. Перейдите по ссылке, полученной на электронную почту администратора после создания инстанса.

   Если по ссылке не открывается веб-интерфейс {{ GL }}, создайте отдельную группу безопасности и [настройте ее](../configure-security-group.md) так, чтобы правила разрешали входящий трафик с нужных портов и IP-адресов.

1. Измените пароль администратора.
1. Авторизуйтесь с помощью логина и пароля администратора.

В дальнейшем, чтобы открыть веб-интерфейс {{ GL }}, [получите детальную информацию об инстансе](instance-list.md#get) и перейдите по ссылке в поле **{{ ui-key.yacloud.gitlab.field_domain }}**.
