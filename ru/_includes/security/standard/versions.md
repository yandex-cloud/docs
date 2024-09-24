# Версии стандарта по защите облачной инфраструктуры {{ yandex-cloud }}

### Изменения в версии 1.2 {#version-1-2}

Дата публикации 25.09.2024.

* **Удален раздел 6. Управление уязвимостями**.

* **Добавлен раздел [{#T}](../../../security/standard/kubernetes-security.md):**
    * [{#T}](../../../security/standard/kubernetes-security.md#not-use-critical-data).
    * [{#T}](../../../security/standard/kubernetes-security.md#maximum-isolation).
    * [{#T}](../../../security/standard/kubernetes-security.md#api-security).
    * [{#T}](../../../security/standard/kubernetes-security.md#kubernetes-auth).
    * [{#T}](../../../security/standard/kubernetes-security.md#kubernetes-safe-config).
    * [{#T}](../../../security/standard/kubernetes-security.md#data-encryption).
    * [{#T}](../../../security/standard/kubernetes-security.md#docker-images-periodic-scan).
    * [{#T}](../../../security/standard/kubernetes-security.md#version-update).
    * [{#T}](../../../security/standard/kubernetes-security.md#backup).
    * [{#T}](../../../security/standard/kubernetes-security.md#check-list).
    * [{#T}](../../../security/standard/kubernetes-security.md#security-standards).
    * [{#T}](../../../security/standard/kubernetes-security.md#audit-logs).

* **Добавлены пункты:**
    * [{#T}](../../../security/standard/authentication.md#group-mapping).
    * [{#T}](../../../security/standard/authentication.md#key-usage-control).
    * [{#T}](../../../security/standard/virtualenv-safe-config.md#use-sts-for-storage-keys).
    * [{#T}](../../../security/standard/virtualenv-safe-config.md#use-presigned-urls).
    * [{#T}](../../../security/standard/virtualenv-safe-config.md#os-login-onto-hosts).
    * [{#T}](../../../security/standard/encryption.md#managed-vm-kms).
    * [{#T}](../../../security/standard/audit-logs.md#data-plane-events).
    * [{#T}](../../../security/standard/app-security.md#use-sws).
    * [{#T}](../../../security/standard/app-security.md#use-waf).
    * [{#T}](../../../security/standard/app-security.md#use-arl).
    * [{#T}](../../../security/standard/app-security.md#setup-code-review).

* **Обновлены пункты:**
    * В пункт [{#T}](../../../security/standard/audit-logs.md#audit-trails) добавлено описание аудитных логов с событиями уровня сервисов.
    * Пункт **6.2 Выполняется сканирование уязвимостей на уровне облачных IP-адресов** перенесен в раздел [3. Безопасная конфигурация виртуальной среды](../../../security/standard/virtualenv-safe-config.md#ip-level).
    * Пункт **6.3 Внешние сканирования безопасности выполняются по правилам облака** перенесен в раздел [3. Безопасная конфигурация виртуальной среды](../../../security/standard/virtualenv-safe-config.md#external-security-scans).
    * Пункт **6.4 Выстроен процесс обновлений безопасности** перенесен в раздел [3. Безопасная конфигурация виртуальной среды](../../../security/standard/virtualenv-safe-config.md#security-updates).
    * Пункт **6.5 Используется Web Application Firewall** обновлен и перенесен в раздел [8. Защита приложений](../../../security/standard/app-security.md#use-waf).
    * В пункт [{#T}](../../../security/standard/app-security.md#pipeline-artifacts-cosign) добавлена рекомендация по сохранению асимметричной ключевой пары электронной подписи [Cosign](https://github.com/sigstore/cosign) в сервисе [{{ kms-full-name }}](../../../kms/quickstart/index.md) и использованию сохраненной ключевой пары для подписания артефактов и проверки подписи.

* **Удалены пункты:**
    * Пункт **4.6 Для критичных ВМ настроено шифрование диска с помощью KMS** удален, так как появился более удобный способ шифрования дисков, описанный в пункте [{#T}](../../../security/standard/encryption.md#managed-vm-kms).

### Изменения в версии 1.1 {#version-1-1}

Дата публикации 25.09.2023.

* **Добавлены пункты:**
    * 1.20 Используется имперсонация, где это возможно.
    * 1.21 На ресурсах используются метки.
    * 1.22 Уведомления безопасности {{ yandex-cloud }} включены.
    * 1.23 Используется роль `auditor` для исключения доступа к данным пользователей.
    * 3.4.2 Контроль среды запуска ВМ.
    * 3.28 Используется антивирусная защита.
    * 3.29 Используются рекомендации по безопасности {{ managed-k8s-full-name }}.
    * 4.16 Администратор облака имеет инструкцию по действиям в случае компрометации секретов его облака.

* **Обновлены пункты:**
    * 1.4, 1.14 — добавлена рекомендация по использованию роли `{{ roles-auditor }}`.
    * 1.9 — добавлена рекомендация по выделению критичных сервисных аккаунтов в отдельный каталог.
    * 1.12 — в список привилегированных ролей добавлен `{{ roles-editor }}` для уровней: организация, облако, каталог.
    * 4.7 — добавлена инструкция по шифрованию данных в {{ mpg-full-name }} и {{ mgp-full-name }} с помощью `pgcrypto` и {{ kms-short-name }}.
    * 4.14 — добавлена рекомендация по использованию {{ lockbox-full-name }} в {{ TF }} без записи в `.tfstate`.


* **Добавлен раздел 9. Защита приложений:**
    * 9.1 Используется {{ captcha-full-name }}.
    * 9.2 Для сканера уязвимостей контейнерных образов включена политика сканирования при загрузке.
    * 9.3 Выполняется периодическое сканирование контейнерных образов.
    * 9.4 Контейнерные образы, используемые в продакшн-среде имеют последнюю дату сканирования не позднее недели.
    * 9.5 При сборке артефактов применяются аттестации.
    * 9.6 Артефакты в рамках пайплайна подписываются с помощью стороннего инструмента Cosign.
    * 9.7 Артефакты проверяются при развертывании в {{ managed-k8s-full-name }}.
    * 9.8 Применяются готовые блоки безопасного пайплайна.
