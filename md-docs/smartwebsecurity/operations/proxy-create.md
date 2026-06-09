# Создать прокси-сервер

{% note info %}

Чтобы создать [прокси-сервер](../concepts/domain-protect.md#proxy), пользователю должны быть [назначены](../../iam/operations/roles/grant.md#cloud-or-folder) роли [`smart-web-security.admin`](../security/index.md#smart-web-security-admin), [`resource-manager.admin`](../../resource-manager/security/index.md#resource-manager-admin) и [`iam.serviceAccounts.admin`](../../iam/security/index.md#iam-serviceAccounts-admin) на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создается прокси-сервер.

{% endnote %}

{% list tabs group=instructions %}

[Прокси-сервер](../concepts/domain-protect.md#proxy) принимает запросы от пользователей к вашему сайту или веб-приложению и направляет их на проверку. 

Вы можете добавить несколько прокси-серверов, например, чтобы разделить стабильную версию приложения и версию, которая находится в разработке.

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![domain-protection-icon](../../_assets/smartwebsecurity/domain-protection-icon.svg) **{{ ui-key.yacloud.smart-web-security.label_domain-protection }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.smart-web-security.ProxyServers.createProxyServer_jatYQ }}**.
  1. Введите произвольное имя прокси-сервера.
  1. (Опционально) Введите описание.
  1. (Опционально) Добавьте [метки](../../resource-manager/concepts/labels.md).
  1. (Опционально) Чтобы сохранять подробную информацию об операциях с запросами:

      1. Включите опцию **{{ ui-key.yacloud.smart-web-security.ProxyServerForm.swith-enable-logging_e42nT }}**.
      1. Выберите существующую лог-группу или [создайте новую](../../logging/operations/create-group.md).
      1. (Опционально) Чтобы уменьшить объем хранимых логов, добавьте правила отбрасывания логов:

          1. Нажмите кнопку **{{ ui-key.yacloud.smart-web-security.ProxyServerForm.add-rule_fnmLk }}**.
          1. Выберите **HTTP-коды** и (опционально) **Классы HTTP-кодов**, для которых будут отбрасываться логи.
          1. Укажите в процентах, какую часть логов нужно отбрасывать.
          1. Если для разных HTTP-кодов требуется отбрасывать разные доли логов, добавьте дополнительные правила.
  1. Нажмите кнопку **{{ ui-key.yacloud.smart-web-security.ProxyServerFormCreate.createServer_sycVk }}**.

Для работы с прокси-сервером будет создан сервисный аккаунт с ролями `monitoring.editor`, `smart-web-security.admin`, `certificate-manager.admin`, `logging.writer`.
        
Создание прокси-сервера может занять несколько минут. Дождитесь, когда сервер перейдет в статус `Active`. После этого можно добавить домен.

{% endlist %}

{% note info %}

На прокси-сервере установлено ограничение MTU для всех пакетов — 1450 байт.

{% endnote %}

### См. также {#see-also}

* [{#T}](domain-create.md)