[Документация Yandex Cloud](../../index.md) > [Yandex Smart Web Security](../index.md) > [Пошаговые инструкции](index.md) > Домены > Создать прокси-сервер

# Создать прокси-сервер

{% note info %}

Чтобы создать [прокси-сервер](../concepts/domain-protect.md#proxy), пользователю должны быть [назначены](../../iam/operations/roles/grant.md#cloud-or-folder) роли [`smart-web-security.admin`](../security/index.md#smart-web-security-admin), [`resource-manager.admin`](../../resource-manager/security/index.md#resource-manager-admin) и [`iam.serviceAccounts.admin`](../../iam/security/index.md#iam-serviceAccounts-admin) на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создается прокси-сервер.

{% endnote %}

{% list tabs group=instructions %}

[Прокси-сервер](../concepts/domain-protect.md#proxy) принимает запросы от пользователей к вашему сайту или веб-приложению и направляет их на проверку.

Вы можете добавить несколько прокси-серверов, например, чтобы разделить стабильную версию приложения и версию, которая находится в разработке.

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](https://console.yandex.cloud/link/smartwebsecurity) в сервис **Smart Web Security**.
  1. На панели слева выберите ![domain-protection-icon](../../_assets/smartwebsecurity/domain-protection-icon.svg) **Защита доменов**.
  1. Нажмите **Создать прокси-сервер**.
  1. Введите произвольное имя прокси-сервера.
  1. (Опционально) Введите описание.
  1. (Опционально) Добавьте [метки](../../resource-manager/concepts/labels.md).
  1. (Опционально) Чтобы сохранять подробную информацию об операциях с запросами:

      1. Включите опцию **Логировать запросы**.
      1. Выберите [лог-группу](../../logging/concepts/log-group.md) Cloud Logging, в которую будут записываться логи, или [создайте новую](../../logging/operations/create-group.md).
      1. (Опционально) Чтобы уменьшить объем хранимых логов, добавьте правила отбрасывания логов:

          1. В блоке **Правила отбрасывания логов** нажмите **Добавить правило**.
          1. Выберите **HTTP-коды** или **Классы HTTP-кодов**, для которых нужно сократить запись логов.
          1. Укажите **Долю отбрасываемых логов**: `0%` — записывать все логи выбранных кодов, `100%` — отбрасывать все.

          Если для разных HTTP-кодов нужны разные доли отбрасывания, добавьте отдельные правила.

  1. Нажмите **Создать сервер**.

Для работы с прокси-сервером будет создан сервисный аккаунт с ролями `monitoring.editor`, `smart-web-security.admin`, `certificate-manager.admin`, `logging.writer`.

Создание прокси-сервера может занять несколько минут. Дождитесь, когда сервер перейдет в статус `Active`. После этого можно добавить домен.

{% endlist %}

{% note info %}

На прокси-сервере установлено ограничение MTU для всех пакетов — 1450 байт.

{% endnote %}

#### Полезные ссылки {#see-also}

[Добавить домен](domain-create.md)