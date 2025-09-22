# Требования к защите приложений

## 6. Защита приложений {#app-security}

### Защита от роботной активности {#protecting-recommendations}

#### 6.1 Используется {{ captcha-full-name }} {#use-smartcaptcha}

Для снижения рисков, связанных с автоматизированными атаками на приложения, рекомендуем использовать сервис [{{ captcha-full-name }}](/services/smartcaptcha). Сервис проверяет запросы пользователей своими ML-алгоритмами и показывает задание только тем пользователям, запросы которых посчитал подозрительными. При этом на странице необязательно размещать кнопку **Я не робот**.

| ID требования | Критичность |
| --- | --- |
| APPSEC1 | Информационная |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartcaptcha_ru }}**.
  1. Убедитесь, что [создана](../../../smartcaptcha/operations/create-captcha.md) хотя бы одна капча для вашего приложения.

{% endlist %}

**Инструкции и решения по выполнению:**

[Инструкция по созданию капчи в {{ captcha-full-name }}](../../../smartcaptcha/operations/create-captcha.md).

### Построение безопасного пайплайна {#pipeline-recommendations}

{{ yandex-cloud }} позволяет клиентам выстроить соответствие разрабатываемого ПО по всем уровням [Supply-chain Levels for Software Artifacts (SLSA)](https://slsa.dev/), при соблюдении инструкций в данном разделе. При использовании [{{ mgl-full-name }}](../../../managed-gitlab/), клиент автоматически достигает [соответствия до 2 уровня SLSA включительно](https://about.gitlab.com/blog/2022/11/30/achieve-slsa-level-2-compliance-with-gitlab/).

#### 6.2 При создании реестра в {{ container-registry-full-name }} по умолчанию оставляйте безопасные настройки реестра {#keep-safe-cr-settings}

При создании нового [реестра](../../../container-registry/concepts/registry.md) набор опций по умолчанию помогает соответствовать стандарту безопасности {{ yandex-cloud }}:

* автоматически выполняется сканирование Docker-образов при их загрузке в реестр;
* регулярно выполняется повторное сканирование Docker-образов в реестре: каждые 7 дней с возможностью выбрать в настройках ежедневное сканирование.

| ID требования | Критичность |
| --- | --- |
| APPSEC14 | Средняя |

**Инструкции и решения по выполнению:**

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создан реестр.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.cr.overview.button_create }}**.
  1. В поле **{{ ui-key.yacloud.cr.overview.popup-create_field_name }}** введите имя реестра. Требования к имени:
      
      {% include [name-format](../../name-format.md) %}
  1. В блоке **{{ ui-key.yacloud.cr.overview.popup-create_field_auto_scan }}**:

      * Оставьте включенной опцию **{{ ui-key.yacloud.cr.overview.popup-create_scan_push_text }}**, чтобы сканировать Docker-образы при загрузке в репозиторий.
      * Оставьте включенной опцию **{{ ui-key.yacloud.cr.overview.popup-create_scan_period_enabled }}**, при необходимости настройте периодичность сканирования.

  1. Нажмите кнопку **{{ ui-key.yacloud.cr.overview.popup-create_button_create }}**.

- CLI {#cli}

  Выполните команду, чтобы создать реестр с безопасными настройками сканирования образов по умолчанию:

  ```bash
  yc container registry create \
    --name <имя_реестра> \
    --secure
  ```

{% endlist %}

#### 6.3 Docker-образы сканируются при загрузке в {{ container-registry-name }} {#upload-policy}

{% include [scan-docker-upload](scan-docker-upload-description.md) %}

| ID требования | Критичность |
| --- | --- |
| APPSEC2 | Средняя |

{% include [scan-docker-upload](scan-docker-upload-test.md) %}

#### 6.4 Выполняется периодическое сканирование Docker-образов, хранящихся в {{ container-registry-name }} {#periodic-scan}

{% include [scan-docker-periodic](scan-docker-periodic-description.md) %}

| ID требования | Критичность |
| --- | --- |
| APPSEC3 | Высокая |

{% include [scan-docker-periodic](scan-docker-periodic-test.md) %}

#### 6.5 Контейнерные образы, используемые в продакшн-среде, имеют последнюю дату сканирования не позднее недели {#last-scan-date}

Проверка Docker-образов, используемых в рабочей среде, с датой последнего сканирования не позднее недели гарантирует, что вы постоянно отслеживаете и обновляете меры безопасности, устраняя потенциальные уязвимости, которые могли возникнуть с момента последнего сканирования, а также помогает убедиться, что вы не разворачиваете контейнеры с недавно обнаруженными уязвимостями, тем самым повышая уровень защищенности. Автоматизировать этот процесс можно с помощью [настройки расписания](#periodic-scan) в Сканере уязвимостей.

| ID требования | Критичность |
| --- | --- |
| APPSEC4 | Средняя |

{% list tabs group=instructions %}

- Проверка через CLI {#cli}

  Выполните команду для поиска контейнерных образов, которые имеют последнюю дату сканирования не позднее недели:

  ```bash
  export ORG_ID=<ID_организации>
  for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
  do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
  do for REGISTRY_ID in $(yc container registry list --folder-id $FOLDER_ID --format=json | jq -r '.[].id');
  do for IMAGE_ID in $(yc container image list --registry-id $REGISTRY_ID --format=json | jq -r '.[].id';)
  do LAST_SCAN_DATE=$(yc container image get-last-scan-result --image-id $IMAGE_ID --format=json 2>/dev/null | jq -r '.scanned_at');
  [ ! -z "$LAST_SCAN_DATE" ] && [ $(date --date "$LAST_SCAN_DATE" +'%s') -lt $(date --date '7 days ago' +'%s') ] && echo "Regitry ID - $REGISTRY_ID, Image ID - $IMAGE_ID, Last scan date - $LAST_SCAN_DATE"
  done;
  done;
  done;
  done
  ```

{% endlist %}

#### 6.6 При сборке артефактов применяются аттестации {#provenance-attestation}

Аттестации применяются при сборке артефактов, чтобы обеспечить безопасную и поддающуюся проверке запись о происхождении артефакта, его целостности и соответствии политикам безопасности SBOM. Это помогает обеспечить надежность артефакта на протяжении всего жизненного цикла. SBOM необходим для обеспечения безопасности цепочки поставок, управления уязвимостями, соответствия требованиям, оценки рисков, прозрачности и эффективного реагирования на инциденты.

При использовании {{ mgl-name }} процесс применения аттестаций становится проще, потому что сервис имеет функцию генерации [provenance attestation](https://about.gitlab.com/releases/2022/06/22/gitlab-15-1-released/#slsa-2-attestation-included-for-build-artifacts). SBOM может быть сгенерирован с использованием стороннего ПО [syft](https://github.com/anchore/syft).

| ID требования | Критичность |
| --- | --- |
| APPSEC5 | Высокая |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Убедитесь, что выполняется аттестация артефактов при сборке приложения.

{% endlist %}

**Инструкции и решения по выполнению:**

[Инструкция от Gitlab по аттестации артефактов](https://docs.gitlab.com/ee/ci/runners/configure_runners.html#artifact-attestation).

#### 6.7 Обеспечивается целостность артефактов {#pipeline-artifacts-cosign}

{% include [artifacts-cosign](artifacts-cosign-description.md) %}

| ID требования | Критичность |
| --- | --- |
| APPSEC6 | Высокая |

{% include [artifacts-cosign](artifacts-cosign-test.md) %}

#### 6.8 Выполняется проверка подлинности артефактов при развертывании {#artifacts-checked}

Чтобы обеспечить надежность, безопасность и совместимость приложений в [{{ managed-k8s-name }}](../../../managed-kubernetes/), сервисе для автоматического масштабирования и развертывания приложений, необходимо свести к минимуму риск возникновения проблем, уязвимостей и сбоев во время развертывания и выполнения. Для этого используется [подпись и проверка подписи](../../../container-registry/tutorials/sign-cr-with-cosign.md) в {{ managed-k8s-name }} с помощью Cosign и [Kyverno](../../../managed-kubernetes/operations/applications/kyverno.md).

| ID требования | Критичность |
| --- | --- |
| APPSEC7 | Средняя |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Убедитесь, что выполняется проверка подлинности артефактов при сборке приложения.

{% endlist %}

**Инструкции и решения по выполнению:**

[Инструкция по настройке подписи артефактов](../../../container-registry/tutorials/sign-cr-with-cosign.md).

#### 6.9 Применяются защищенные шаблоны безопасного пайплайна {#pipeline-blocks}

При работе с {{ mgl-name }} убедитесь, что вы применяете встроенные механизмы безопасности GitLab для защиты вашего пайплайна. Доступны следующие [варианты использования](../../../managed-gitlab/concepts/security.md#security-pipeline-usage) пайплайна в ваших проектах:

* Создание пайплайна в отдельном проекте и подключение его к другим проектам с помощью [функции `include`](https://docs.gitlab.com/ee/ci/yaml/includes.html). Доступно для всех типов лицензий.
* Использование [механизма `Compliance framework and pipeline`](https://docs.gitlab.com/ee/user/project/settings/index.html#compliance-frameworks), который будет выполняться в любом проекте группы. Механизм доступен для типа лицензии `Ultimate`.
* Копирование секции пайплайна в файлы `.gitlab-ci.yml` ваших проектов.

| ID требования | Критичность |
| --- | --- |
| APPSEC8 | Информационная |

#### 6.10 Используется профиль безопасности {{ sws-full-name }} {#use-sws}

[{{ sws-full-name }}](../../../smartwebsecurity/quickstart.md) — сервис для защиты от [DDoS, web-атак](../../../glossary/ddos.md) и ботов на прикладном уровне L7 [сетевой модели OSI](https://ru.wikipedia.org/wiki/Сетевая_модель_OSI). {{ sws-name }} [подключается](../../../smartwebsecurity/quickstart.md) к {{ alb-full-name }}.

Функциональность сервиса сводится к проверке HTTP-запросов к защищаемому ресурсу на соответствие [правилам](../../../smartwebsecurity/concepts/rules.md), заданным в [профиле безопасности](../../../smartwebsecurity/concepts/profiles.md). В зависимости от результатов проверки запросы пропускаются на защищаемый ресурс, блокируются или отправляются в сервис [{{ captcha-full-name }}](../../../smartcaptcha/index.yaml) для дополнительной верификации.

| ID требования | Критичность |
| --- | --- |
| APPSEC9 | Высокая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите проверить статус {{ sws-name }}.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Убедитесь, что у вас есть созданные профили безопасности.
  1. Если профили безопасности есть, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

- Проверка через CLI {#cli}

  Выполните команду:

  ```bash
  yc smartwebsecurity security-profile list
  ```

  Если команда вернет информацию об имеющихся профилях безопасности, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению:**

[Создание профиля безопасности и подключение его к виртуальному хосту L7-балансировщика](../../../smartwebsecurity/quickstart.md).

#### 6.11 Используется Web Application Firewall {#use-waf}

Для снижения рисков, связанных с веб-атаками, рекомендуем использовать {{ sws-full-name }} [Web Application Firewall (WAF)](../../../glossary/waf.md). Web Application Firewall анализирует входящие HTTP-запросы к веб-приложению по предварительно настроенным правилам. На основе результатов анализа к HTTP-запросам применяются определенные [действия](../../../smartwebsecurity/concepts/rules.md#rule-action).

Вы можете управлять межсетевым экраном веб-приложений с помощью [профиля WAF](../../../smartwebsecurity/concepts/waf.md), который подключается к [профилю безопасности](../../../smartwebsecurity/concepts/profiles.md) {{ sws-name }} в виде отдельного [правила](../../../smartwebsecurity/concepts/rules.md).

| ID требования | Критичность |
| --- | --- |
| APPSEC10 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором необходимо проверить наличие правила WAF в профиле безопасности.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Убедитесь, что у вас в профиле безопасности есть правило безопасности с типом **Web Application Firewall**.

{% endlist %}

**Инструкции и решения по выполнению:**

[Создание профиля WAF и подключение его к профилю безопасности {{ sws-name }}](../../../smartwebsecurity/quickstart.md#waf).

#### 6.12 Используется Advanced Rate Limiter {#use-arl}

[Advanced Rate Limiter (ARL)](../../../smartwebsecurity/concepts/arl.md) — модуль {{ sws-full-name }} для контроля и ограничения нагрузки на веб-приложения. Модуль позволяет установить лимит на количество HTTP-запросов за определенный промежуток времени. Все запросы сверх лимита будут блокироваться. Можно установить как единый лимит на весь трафик, так и настраивать отдельные лимиты для сегментирования запросов по определенным параметрам. Запросы для лимитов можно считать по одному или объединять в группы по заданному признаку.

Профиль ARL необходимо подключить к [профилю безопасности](../../../smartwebsecurity/concepts/profiles.md) {{ sws-name }}.

| ID требования | Критичность |
| --- | --- |
| APPSEC11 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором необходимо проверить наличие профилей ARL.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../../_assets/smartwebsecurity/arl.svg) **Профили ARL** и убедитесь, что у вас есть профили ARL, подключенные к профилю безопасности.

{% endlist %}

**Инструкции и решения по выполнению:**

[Создание профиля ARL и подключение его к профилю безопасности {{ sws-name }}](../../../smartwebsecurity/quickstart.md#arl).

#### 6.13 Настроены правила ревью кода {#setup-code-review}

[{{ mgl-full-name }}](../../../managed-gitlab/index.yaml) позволяет гибко настраивать обязательные [правила ревью кода](../../../managed-gitlab/concepts/approval-rules.md), прежде чем этот код может быть добавлен в целевую [ветку проекта](../../../glossary/vcs.md#branch). Функциональность является альтернативой встроенному в GitLab Enterprise Edition инструменту [Approval Rules](https://docs.gitlab.com/ee/user/project/merge_requests/approvals/rules.html) и доступна вне зависимости от [версии](https://about.gitlab.com/pricing) GitLab.

Если в [инстансе {{ GL }}](../../../managed-gitlab/concepts/index.md#instance) включены правила ревью кода, {{ mgl-name }} анализирует подтверждения от ревьюеров на соответствие заданным правилам. Если подтверждений недостаточно, в мерж-реквесте создается техническая дискуссия, блокирующая его интеграцию в целевую ветку. При изменении мерж-реквеста в дискуссии создается или обновляется комментарий с текущим статусом соответствия правилам. Когда все необходимые подтверждения получены, дискуссия закрывается.

Если закрыть техническую дискуссию вручную, она будет создана заново. В случае интеграции мерж-реквеста в обход заданных правил пользователи с ролью `Maintainer` и выше получат уведомление на электронную почту о нарушении установленного процесса ревью кода.

| ID требования | Критичность |
| --- | --- |
| APPSEC12 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором расположен инстанс {{ GL }}.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Выберите нужный инстанс и в правом верхнем углу страницы нажмите **{{ ui-key.yacloud.common.edit }}**.
  1. Убедитесь, что в поле **{{ ui-key.yacloud.gitlab.field_approval-rules }}** выбрана настроенная [конфигурация](../../../managed-gitlab/concepts/approval-rules.md#packages) правил ревью кода.

{% endlist %}

**Инструкции и решения по выполнению:**

[Активация правил ревью кода в инстансе {{ GL }}](../../../managed-gitlab/operations/approval-rules.md#enable).

#### 6.14 Доверенные и нежелательные IP-адреса группируются в списки {#app-sws-lists}

В [{{ sws-full-name }}](../../../smartwebsecurity/index.yaml) есть возможность сформировать собственные наборы IP-адресов — [пользовательские списки](../../../smartwebsecurity/concepts/lists.md#user-rules). Списки можно добавлять в качестве [условий](../../../smartwebsecurity/concepts/conditions.md) в [правила](../../../smartwebsecurity/concepts/rules.md), чтобы пропустить, заблокировать или направить в [{{ captcha-name }}](../../../smartcaptcha/index.yaml) часть трафика на этапе проверки IP-адреса.

| ID требования | Критичность |
| --- | --- |
| APPSEC13 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. Откройте консоль {{ yandex-cloud }} в вашем браузере.
  1. Перейдите в нужный каталог.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Перейдите в раздел **{{ ui-key.yacloud.smart-web-security.match-lists.label_match-lists }}**.
  1. Убедитесь, что у вас есть созданные списки.
  1. Если списки есть, рекомендация выполняется. Если нет, перейдите к пункту «Инструкции и решения по выполнению».

- Ручная проверка {#manual}

  Чтобы убедиться, что у вас есть списки в {{ sws-name }}, обратитесь к вашему персональному менеджеру.

{% endlist %}

**Инструкции и решения по выполнению:**

Используйте черные и белые списки IP-адресов для фильтрации трафика. Подробнее см. в разделе [{#T}](../../../smartwebsecurity/operations/list-create.md).