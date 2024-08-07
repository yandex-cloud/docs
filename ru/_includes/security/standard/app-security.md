# 9. Защита приложений

### Рекомендации по защите приложения от роботной активности {#protecting-recommendations}

#### 9.1 Используется {{ captcha-full-name }} {#use-smartcaptcha}

Для снижения рисков, связанных с автоматизированными атаками на приложения, рекомендуем использовать сервис [{{ captcha-full-name }}](/services/smartcaptcha). Сервис проверяет запросы пользователей своими ML-алгоритмами и показывает задание только тем пользователям, запросы которых посчитал подозрительными. При этом на странице необязательно размещать кнопку **Я не робот**.

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. Выберите сервис **{{ captcha-full-name }}**.
  1. Убедитесь, что [создана](../../../smartcaptcha/operations/create-captcha.md) хотя бы одна капча для вашего приложения.

{% endlist %}

**Инструкции и решения по выполнению:**

[Инструкция по созданию капчи в {{ captcha-full-name }}](../../../smartcaptcha/operations/create-captcha.md).

### Рекомендации по построению безопасного пайплайна {#pipeline-recommendations}

{{ yandex-cloud }} позволяет клиентам выстроить соответствие разрабатываемого ПО по всем уровням [Supply-chain Levels for Software Artifacts (SLSA)](https://slsa.dev/), при соблюдении инструкций в данном разделе. При использовании [{{ mgl-full-name }}](../../../managed-gitlab/), клиент автоматически достигает [соответствия до 2 уровня SLSA включительно](https://about.gitlab.com/blog/2022/11/30/achieve-slsa-level-2-compliance-with-gitlab/).

#### 9.2 Сканирование Docker-образов при загрузке в {{ container-registry-full-name }} {#upload-policy}

[Автоматическое сканирование](../../../container-registry/operations/scanning-docker-image.md#automatically) Docker-образов при загрузке имеет решающее значение для раннего обнаружения и устранения уязвимостей, обеспечивая безопасное развертывание контейнеров. После завершения сканирования отчеты содержат краткое описание обнаруженных уязвимостей и проблем, помогая определять приоритеты и устранять риски безопасности в контейнерных приложениях.

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит реестр с Docker-образами.
  1. Выберите реестр в сервисе **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud.cr.registry.label_vulnerabilities-scanner }}** и нажмите кнопку **{{ ui-key.yacloud.cr.registry.button_change-scan-settings }}**.
  1. Убедитесь, что сканирование Docker-образов при загрузке включено.

{% endlist %}

**Инструкции и решения по выполнению:**

[Инструкция по сканированию Docker-образа при загрузке](../../../container-registry/operations/scanning-docker-image.md#automatically).

#### 9.3 Выполнение периодического сканирования Docker-образов, хранящихся в {{ container-registry-name }} {#periodic-scan}

Сканирование Docker-образов по расписанию представляет собой автоматизированный процесс проверки контейнерных образов на наличие уязвимостей и соответствие стандартам безопасности. Такое сканирование выполняется регулярно и автоматически, что обеспечивает консистентность проверки образов на наличие уязвимостей. Это позволяет поддерживать высокий уровень безопасности в долгосрочной перспективе. После завершения сканирования отчеты содержат краткое описание обнаруженных уязвимостей и проблем, помогая определять приоритеты и устранять риски безопасности в контейнерных приложениях.

Рекомендуем настроить расписание сканирования не реже, чем раз в неделю.

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит реестр с Docker-образами.
  1. Выберите реестр в сервисе **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud.cr.registry.label_vulnerabilities-scanner }}** и нажмите кнопку **{{ ui-key.yacloud.cr.registry.button_change-scan-settings }}**.
  1. Убедитесь, что сканирование Docker-образов по расписанию включено и оно проходит не реже, чем раз в неделю.

{% endlist %}

**Инструкции и решения по выполнению:**

[Инструкция по сканированию Docker-образа по расписанию](../../../container-registry/operations/scanning-docker-image.md#scheduled).

#### 9.4 Контейнерные образы, используемые в продакшн-среде, имеют последнюю дату сканирования не позднее недели {#last-scan-date}

Проверка Docker-образов, используемых в рабочей среде, с датой последнего сканирования не позднее недели гарантирует, что вы постоянно отслеживаете и обновляете меры безопасности, устраняя потенциальные уязвимости, которые могли возникнуть с момента последнего сканирования, а также помогает убедиться, что вы не разворачиваете контейнеры с недавно обнаруженными уязвимостями, тем самым повышая уровень защищенности. Автоматизировать этот процесс можно с помощью [настройки расписания](#periodic-scan) в Сканере уязвимостей.

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

#### 9.5 При сборке артефактов применяются аттестации {#provenance-attestation}

Аттестации применяются при сборке артефактов, чтобы обеспечить безопасную и поддающуюся проверке запись о происхождении артефакта, его целостности и соответствии политикам безопасности SBOM. Это помогает обеспечить надежность артефакта на протяжении всего жизненного цикла. SBOM необходим для обеспечения безопасности цепочки поставок, управления уязвимостями, соответствия требованиям, оценки рисков, прозрачности и эффективного реагирования на инциденты.

При использовании {{ mgl-name }} процесс применения аттестаций становится проще, потому что сервис имеет функцию генерации [provenance attestation](https://about.gitlab.com/releases/2022/06/22/gitlab-15-1-released/#slsa-2-attestation-included-for-build-artifacts). SBOM может быть сгенерирован с использованием стороннего ПО [syft](https://github.com/anchore/syft).

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Убедитесь, что выполняется аттестация артефактов при сборке приложения.

{% endlist %}

**Инструкции и решения по выполнению:**

[Инструкция от Gitlab по аттестации артефактов](https://docs.gitlab.com/ee/ci/runners/configure_runners.html#artifact-attestation).

#### 9.6 Обеспечение целостности артефактов {#pipeline-artifacts-cosign}

Подписание артефактов повышает безопасность, обеспечивая подлинность, целостность, доверие и соответствие требованиям в вашем программном обеспечении.

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Убедитесь, что выполняется подписание артефактов при сборке приложения.

{% endlist %}

**Инструкции и решения по выполнению:**

Артефакты в рамках пайплайна можно подписывать с помощью стороннего ПО [Cosign](https://github.com/sigstore/cosign) для подписи [артефактов](https://docs.sigstore.dev/signing/quickstart/), образов, [in-to-to аттестаций](https://github.com/in-toto/attestation/tree/main/spec/predicates), чтобы в дальнейшем загрузить их в {{ container-registry-full-name }}.

#### 9.7 Выполняется проверка подлинности артефактов при развертывании {#artifacts-checked}

Чтобы обеспечить надежность, безопасность и совместимость приложений в [{{ managed-k8s-name }}](../../../managed-kubernetes/), сервисе для автоматического масштабирования и развертывания приложений, необходимо свести к минимуму риск возникновения проблем, уязвимостей и сбоев во время развертывания и выполнения. Для этого используется [подпись и проверка подписи](../../../container-registry/tutorials/sign-with-cosign.md) в {{ managed-k8s-name }} с помощью Cosign и [Kyverno](../../../managed-kubernetes/operations/applications/kyverno.md).

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Убедитесь, что выполняется проверка подлинности артефактов при сборке приложения.

{% endlist %}

**Инструкции и решения по выполнению:**

[Инструкция по настройке подписи артефактов](../../../container-registry/tutorials/sign-with-cosign.md).

#### 9.8 Применяются защищенные шаблоны безопасного пайплайна {#pipeline-blocks}

При работе с {{ mgl-name }} убедитесь, что вы применяете встроенные механизмы безопасности GitLab для защиты вашего пайплайна. Доступны следующие [варианты использования](../../../managed-gitlab/concepts/security.md#security-pipeline-usage) пайплайна в ваших проектах:

* Создание пайплайна в отдельном проекте и подключение его к другим проектам с помощью [функции `include`](https://docs.gitlab.com/ee/ci/yaml/includes.html). Доступно для всех типов лицензий.
* Использование [механизма `Compliance framework and pipeline`](https://docs.gitlab.com/ee/user/project/settings/index.html#compliance-frameworks), который будет выполняться в любом проекте группы. Механизм доступен для типа лицензии `Ultimate`.
* Копирование секции пайплайна в файлы `.gitlab-ci.yml` ваших проектов.