# Безопасность в {{ mgl-name }}

## Обнаружение уязвимостей в CI/CD {#vulnerability-detection}

{{ mgl-name }} предоставляет защиту вашего пайплайна встроенными в {{ GL }} средствами.

Набор средств зависит от [типа лицензии {{ GL }}](https://about.gitlab.com/pricing/). В бесплатную лицензию входит ряд средств защиты, например, [Static Application Security Testing (SAST)](https://docs.gitlab.com/ee/user/application_security/sast/) и [Secret Detection](https://docs.gitlab.com/ee/user/application_security/secret_detection/index.html). Также вы можете разрабатывать собственные задания на базе инструментов с открытым исходным кодом.

Полный список средств защиты пайплайна в зависимости от типа лицензии приведен в таблице:

Средства защиты пайплайна | Free | Premium | Ultimate
--- | :---: | :---: | :---:
[API Fuzzing](https://docs.gitlab.com/ee/user/application_security/api_fuzzing/index.html) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg)
[Cluster Image Scanning](https://docs.gitlab.com/ee/user/application_security/cluster_image_scanning/index.html) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg)
[Container Scanning](https://docs.gitlab.com/ee/user/application_security/container_scanning/index.html) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg)
[Dependency Scanning](https://docs.gitlab.com/ee/user/application_security/dependency_scanning/index.html) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg)
[Dynamic Application Security Testing (DAST)](https://docs.gitlab.com/ee/user/application_security/dast/index.html) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg)
[License Compliance](https://docs.gitlab.com/ee/user/compliance/license_compliance/index.html) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg)
[Secret Detection](https://docs.gitlab.com/ee/user/application_security/secret_detection/index.html) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg)
[Security Dashboard](https://docs.gitlab.com/ee/user/application_security/security_dashboard/index.html) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg)
[Static Application Security Testing (SAST)](https://docs.gitlab.com/ee/user/application_security/sast/index.html) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg)

С развитием {{ mgl-name }} список средств защиты может меняться.

## Использование примеров безопасности пайплайна {#security-pipeline-usage}

Доступны следующие варианты использования пайплайна в ваших проектах:
* Создайте пайплайн в отдельном проекте и подключите его к другим проектам с помощью [функции `include`](https://docs.gitlab.com/ee/ci/yaml/includes.html). Доступно для всех типов лицензий.
* Используйте [механизм `Compliance framework and pipeline`](https://docs.gitlab.com/ee/user/project/settings/index.html#compliance-frameworks) — он будет выполняться в любом проекте группы. Механизм доступен для типа лицензии `Ultimate`.
* Скопируйте секции пайплайна в файл `.gitlab-ci.yml` ваших проектов.

## Дополнительные материалы {#additional-content}

Изучите примеры безопасности пайплайна, подготовленные в рамках [{{ yandex-cloud }} Security Solution Library](https://github.com/yandex-cloud/yc-solution-library-for-security):
* [Обнаружение уязвимостей в CI/CD (тип лицензии `Ultimate`)](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/secure_ci_cd/secure_ci_cd_with_webinar/ultimate_secure_ci_cd).
* [Обнаружение уязвимостей в CI/CD (тип лицензии `Free`)](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/secure_ci_cd/secure_ci_cd_with_webinar/free_secure_ci_cd).

## Рекомендации по настройке безопасности инстанса {{ GL }} {#secure-instance}

{% note tip %}

Перед настройкой инстанса изучите [общие рекомендации по безопасности {{ GL }}](https://docs.gitlab.com/ee/security/).

{% endnote %}

Используйте эти наборы рекомендаций для обеспечения безопасности вашего инстанса {{ GL }}:
* Для аудита и анализа событий безопасности [настройте экспорт логов аудита](https://docs.gitlab.com/ee/administration/audit_event_streaming.html) в стороннюю систему анализа событий, например, [{{ mes-full-name }}](../../managed-elasticsearch/) или [Splunk](https://www.splunk.com/).
* Подписывайте коммиты с помощью [GPG-ключа](https://docs.gitlab.com/ee/user/project/repository/gpg_signed_commits/).
* Организуйте [`approve` изменений в коде](https://docs.gitlab.com/ee/user/project/merge_requests/approvals/) как минимум двумя сотрудниками — это поможет снизить количество ошибок.

### Работа с Docker изнутри {{ GL }} {#using-docker}

* Изучите [лучшие практики по безопасной работе с образами Docker](https://docs.docker.com/engine/security/).
* Работайте с Docker [в режиме `non-privileged`](https://docs.gitlab.com/runner/security/#usage-of-docker-executor). Используйте настройки `cap_add` и `cap_drop` для более тонкой настройки привилегий контейнеров.
* Для безопасной сборки контейнеров используйте утилиту [kaniko](https://docs.gitlab.com/ee/ci/docker/using_kaniko.html).
* Не используйте `Shell executor`, `Docker-in-Docker` и `Docker socket binding` — это дает доступ к `Docker socket` и `privileged mode`. Подробнее см. в [статье Securing GitLab CI pipelines with Sysbox](https://blog.nestybox.com/2020/10/21/gitlab-dind.html).

### Интеграция с {{ managed-k8s-full-name }} {#using-kubernetes}

* Для безопасной интеграции используйте [{{ GL }} Agent for {{ k8s }}](https://docs.gitlab.com/ee/user/clusters/agent/).
* Чтобы исключить использование [сервисных аккаунтов](../../iam/concepts/users/service-accounts.md) с ролью `cluster-admin` и открытия API {{ k8s }} в интернет, не используйте [certificate-based интеграцию](https://docs.gitlab.com/ee/user/infrastructure/clusters/).
* Чтобы исключить связанность агента {{ GL }} Runner и {{ k8s }}, используйте развертывание с помощью [CI/CD tunnel](https://docs.gitlab.com/ee/user/clusters/agent/ci_cd_tunnel.html).

### Использование переменных {#using-env-vars}

* Для ограничения доступа к переменным [используйте настройку `Protect variable`](https://docs.gitlab.com/ee/ci/variables/#protect-a-cicd-variable).
* Для маскирования переменных в логах [используйте настройку `Mask variable`](https://docs.gitlab.com/ee/ci/variables/#mask-a-cicd-variable).
* Не храните секреты (ключи, пароли, API-токены и т. д.) в коде. Для поиска секретов в коде используйте инструмент [Secret Scanning](https://docs.gitlab.com/ee/user/application_security/secret_detection/).

### Разграничение доступа {#access-control}

* Выдавайте доступ к вашим проектам ограниченному количеству сотрудников. Предоставляйте сотрудникам только минимально необходимые права.
* Настраивайте доступ к проектам с помощью [механизма групп {{ GL }}](https://docs.gitlab.com/ee/user/group/).
* Ограничьте подключения к проектам только с конкретных IP-адресов, а также включите двухфакторную аутентификацию. Для этого перейдите во вкладку **Settings** → **General** → **Permissions, LFS, 2FA** в свойствах нужной группы.
* Чтобы предоставить доступ к проектам пользователям вашей организации, настройте [SAML SSO](https://docs.gitlab.com/ee/user/group/saml_sso/).
* По возможности заблокируйте использование `fork`.

### Безопасная конфигурация инстанса {{ GL }} {#securing-instance}

* По возможности [ограничьте сетевой доступ](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/secure_ci_cd/secure_ci_cd_with_webinar/gitlab_instance_sec_checklist/gitlab_instance_isolate.md) до вашего инстанса пределами облака.
* Для предотвращения отказа обслуживания используйте [ограничения `User and IP rate limits`](https://docs.gitlab.com/ee/user/admin_area/settings/user_and_ip_rate_limits.html).

### Безопасная конфигурация агента {{ GL }} Runner {#configuring-runners}

* Используйте наиболее изолированные и безопасные [управляющие программы `Docker` и `{{ k8s }}`](https://docs.gitlab.com/runner/executors/). Не рекомендуется использовать устаревший `Shell executor`.
* Чтобы ограничить сетевой доступ к агенту {{ GL }} Runner, используйте [группы безопасности](../../vpc/concepts/security-groups.md).
* Используйте безопасный механизм [назначения сервисных аккаунтов виртуальной машине](../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance) для взаимодействия с облачным API внутри заданий. Такой способ более безопасен, чем указание учетных данных через `env`.