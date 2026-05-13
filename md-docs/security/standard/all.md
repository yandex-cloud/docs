# Стандарт по защите облачной инфраструктуры Yandex Cloud, версия 1.4.2

## Введение {#intro}

Этот документ содержит рекомендации по техническим мерам защиты и помогает выбрать меры обеспечения информационной безопасности (ИБ) при развертывании информационных систем на облачной платформе Yandex Cloud.

Физическую безопасность дата-центров обеспечивает Платформа Yandex Cloud, см. [подробное описание мер физической безопасности](../standarts.md). Если критичные данные передаются за пределы Yandex Cloud, то клиент отвечает за управление физическим доступом для всех мест обработки данных.

Рекомендации и меры обеспечения безопасности в стандарте сопровождаются ссылками на **Инструкции и решения по настройке** безопасных конфигураций ресурсов с помощью штатных средств защиты информации и дополнительных средств защиты, доступных пользователям Yandex Cloud.

Также стандарт описывает способы и средства проверки выполнения рекомендаций, в том числе:

* с помощью интерфейса консоли управления;
* с помощью интерфейса командной строки Yandex Cloud CLI;
* вручную.

### Область применения {#application}


Рекомендации предназначены для архитекторов, технических специалистов и специалистов по ИБ, которые используют при создании защищенных облачных систем и разработке политик безопасности для работы на облачной платформе следующие сервисы:

* [Yandex Application Load Balancer](../../application-load-balancer/index.md)
* [Yandex Audit Trails](../../audit-trails/index.md)
* [Yandex Certificate Manager](../../certificate-manager/index.md)
* [Yandex Cloud DNS](../../dns/index.md)
* [Yandex Cloud Logging](../../logging/index.md)
* [Yandex Identity Hub](../../organization/index.md)
* [Yandex Compute Cloud](../../compute/index.md)
* [Yandex Container Registry](../../container-registry/index.md)
* [Yandex Identity and Access Management (IAM)](../../iam/index.md)
* [Yandex Key Management Service](../../kms/index.md)
* [Yandex Lockbox](../../lockbox/index.md)
* [Yandex Managed Service for ClickHouse®](../../managed-clickhouse/index.md)
* [Yandex Managed Service for GitLab](../../managed-gitlab/index.md)
* [Yandex Managed Service for Kubernetes](../../managed-kubernetes/index.md)
* [Yandex StoreDoc](../../storedoc/index.md)
* [Yandex Managed Service for MySQL®](../../managed-mysql/index.md)
* [Yandex Managed Service for PostgreSQL](../../managed-postgresql/index.md)
* [Yandex Managed Service for Valkey™](../../managed-valkey/index.md)
* [Yandex Managed Service for YDB](../../ydb/index.md)
* [Yandex Network Load Balancer](../../network-load-balancer/index.md)
* [Yandex Object Storage](../../storage/index.md)
* [Yandex Resource Manager](../../resource-manager/index.md)
* [Yandex Smart Web Security](../../smartwebsecurity/index.md)
* [Yandex SmartCaptcha](../../smartcaptcha/index.md)
* [Yandex Virtual Private Cloud](../../vpc/index.md)

Стандарт можно рассматривать как основу для разработки рекомендаций, специфичных для организации. Не все меры обеспечения ИБ и рекомендации из настоящего документа могут быть применимы. Кроме того, могут потребоваться дополнительные меры и рекомендации, не включенные в настоящий стандарт.

### Структура стандарта {#structure}

Стандарт описывает рекомендации для следующих задач обеспечения безопасности:
* Аутентификация и управление доступом.
* Сетевая безопасность.
* Безопасная конфигурация виртуальной среды.
* Шифрование данных и управление ключами.
* Сбор, мониторинг и анализ аудитных логов.
* Резервное копирование.
* Физическая безопасность.
* Защита приложений.
* Безопасность Kubernetes.

### Требования и подготовка {#requirements-and-preparation}

Для проверок убедитесь, что:
* установлен и настроен CLI по [инструкции](../../cli/quickstart.md);
* вы вошли в [консоль управления](https://console.yandex.cloud);
* установлена утилита jq.

Вы можете автоматизировать аудит выполнения всех рекомендаций с помощью [Yandex Security Deck](../../security-deck/index.md) — это комплексная CNAPP-платформа, включающая в себя модули:
* [Отслеживания действий команды Yandex Cloud с ресурсами пользователя](../../security-deck/concepts/access-transparency.md) (Access Transparency).
* [Контроля данных](../../security-deck/concepts/dspm.md) (DSPM).
* [Контроля конфигурации](../../security-deck/concepts/cspm.md) (CSPM).
* [Контроля Kubernetes](../../security-deck/concepts/kspm.md) (KSPM).
* [Диагностики доступов](../../security-deck/concepts/ciem.md) (CIEM).
* [Просмотра алертов](../../security-deck/concepts/alerts.md).
* [Портал соответствия требованиям](../../security-deck/concepts/compliance.md).

Сервис также предоставляет [AI-ассистента](../../security-deck/concepts/ai-assistant.md) на базе YandexGPT для получения рекомендаций по безопасности.


### Ограничение ответственности {#liability-limit}

В Yandex Cloud применяется [концепция разделения ответственности](https://yandex.cloud/ru/security/shared-responsibility). Граница разделения ответственности за обеспечение безопасности зависит от сервисов, которые используются системой в облаке, от модели использования этих сервисов ([IaaS](https://yandex.cloud/ru/blog/posts/2022/01/iaas) — инфраструктура как услуга, [PaaS](https://yandex.cloud/ru/blog/posts/2023/03/paas) — платформа как услуга, [SaaS](https://yandex.cloud/ru/blog/posts/2023/03/saas) — программное обеспечение как услуга) и имеющихся у облачного провайдера защитных механизмов и политик.

### Термины и сокращения {#terms}

В настоящем документе используются термины и определения, введенные стандартом ISO/IEC 27000:2018 и ISO/IEC 29100:2011, а также термины, используемые в [глоссарии](../../glossary/index.md) Yandex Cloud.

### Идентификаторы {#ids}

У проверок есть идентификаторы следующего вида: `ID:IAM1`. Эти идентификаторы используются для создания ссылок на секции стандарта для использования в инструментах класса Cloud Security Posture Management (CSPM) и не несут никакой иной информации.

# Требования к аутентификации и управлению доступом

## 1. Аутентификация и управление доступом {#authentication}


В Yandex Cloud управление идентификацией, аутентификацией и контролем доступа выполняется сервисами [Yandex Identity and Access Management (IAM)](../../iam/index.md) и [Yandex Identity Hub](../../organization/index.md).

Платформа работает с четырьмя категориями учетных записей:

* [аккаунты на Яндексе](../../iam/concepts/users/accounts.md#passport) — учетные записи в системе Яндекс ID, в том числе аккаунты в Яндекс 360;
* [федеративные аккаунты](../../iam/concepts/users/accounts.md#saml-federation) — учетные записи в корпоративной [SAML-совместимой федерации удостоверений](../../organization/concepts/add-federation.md), например Active Directory;
* [локальные аккаунты](../../iam/concepts/users/accounts.md#local) — учетные записи, данные которых хранятся только в Yandex Cloud.
* [сервисные аккаунты](../../iam/concepts/users/accounts.md#sa) — учетные записи, от имени которых программы могут управлять ресурсами.

Аккаунты Яндекс ID и федеративные аккаунты аутентифицируются в собственных системах. Yandex Cloud не имеет доступа к паролям этих пользователей и аутентифицирует только сервисные аккаунты с помощью сервиса IAM. Для аккаунтов Яндекс ID и Яндекс 360 рекомендуем настроить двухфакторную аутентификацию (2FA) согласно [инструкции](https://yandex.ru/support/id/authorization/twofa.html).

Доступ пользователей к ресурсам облака регулируется с помощью [ролей](../../iam/concepts/access-control/roles.md). Сервисы Yandex Cloud могут предлагать разный уровень гранулярности назначения прав: в одних случаях роль можно назначить непосредственно на сам ресурс в сервисе, в других случаях права назначаются только на уровне каталога или облака, в котором размещен ресурс сервиса.

Таким образом, в инфраструктуре Yandex Cloud взаимодействуют различные категории ресурсов, ролей и пользователей. Контроль доступа к ресурсам выполняется сервисом IAM. Сервис IAM контролирует каждый запрос, чтобы все операции над ресурсами выполнялась только пользователями с необходимыми правами.

{% note info %}

При использовании Yandex Cloud совместно с сервисами Яндекс 360 выполните [рекомендации по безопасности](https://yandex.ru/support/yandex-360/business/admin/ru/security/security-recommendations) Яндекс 360: укажите в Яндекс ID данные для восстановления доступа к аккаунту и привяжите актуальный номер телефона для восстановления и получения уведомлений, а также [настройте](https://yandex.ru/support/yandex-360/business/admin/ru/admin-audit-log) аудитные логи.

{% endnote %}

### Федерации удостоверений {#federations}

#### 1.1 Настроена федерация удостоверений (Single Sign-On, SSO) {#saml-federation}

[Yandex Identity Hub](../../organization/index.md) — это единый сервис для управления составом организации, настройки интеграции с каталогом сотрудников и разграничения доступов пользователей к облачным ресурсам организации.

Для централизованного управления учетными данными используйте [SAML-совместимые федерации удостоверений](../../organization/concepts/add-federation.md). С помощью федераций удостоверений компания может настроить Single Sign-On аутентификацию в Yandex Cloud через свой сервер IdP. При таком подходе сотрудники имеют возможность использовать свои корпоративные аккаунты, на которые распространяются политики безопасности компании, такие как:

* отзыв и блокирование аккаунтов;
* парольные политики;
* ограничение количества неуспешных попыток входа;
* блокирование сеанса доступа после установленного времени бездействия;
* двухфакторная аутентификация.

{% note tip %}

Используйте федеративные аккаунты вместо аккаунтов Яндекс ID, где это возможно. Помните, что для управления федерацией существует отдельная роль `organization-manager.federations.admin`.

{% endnote %}

Чтобы все запросы аутентификации от Yandex Cloud содержали цифровую подпись, включите опцию **Подписывать запросы аутентификации**. Для завершения настройки потребуется скачать и установить сертификат Yandex Cloud. Скачать сертификат можно в поле **Подписывать запросы аутентификации** сразу после сохранения федерации.

| ID требования | Критичность |
| --- | --- |
| IAM1 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. Откройте консоль Yandex Cloud в вашем браузере.
  1. Перейдите во вкладку **Все сервисы** → **Yandex Identity Hub** → **Федерации**.
  1. Если в списке есть хотя бы одна настроенная федерация удостоверений, то рекомендация выполнена. Если нет, то перейдите к п. <q>Инструкции и решения по выполнению</q>.

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый ID:

      ```bash
      yc organization-manager organization list
      ```

  1. Посмотрите информацию о настроенных федерациях:

      ```bash
      yc organization-manager federation saml list \
        --organization-id=<ID_организации>
      ```

  1. Если в списке есть хотя бы одна настроенная федерация удостоверений, то рекомендация выполнена. Если нет, перейдите к п. <q>Инструкции и решения по выполнению</q>.

{% endlist %}

**Инструкции и решения по выполнению:**

* [Инструкция по настройке SAML федерации удостоверений](../../organization/concepts/add-federation.md#federation-usage).
* [Инструкция по настройке SAML федерации с KeyCloak](https://www.youtube.com/watch?v=m-oe7V9PvC4).

##### 1.1.1 Настроено сопоставление групп пользователей в федерации удостоверений {#group-mapping}

Для организаций, в которых много участников, одинаковые права доступа к ресурсам Yandex Cloud могут потребоваться сразу нескольким пользователям. В этом случае роли и доступы эффективнее выдавать не персонально, а для группы.

Если вы используете группы пользователей в вашем поставщике удостоверений или собираетесь это сделать, [настройте сопоставление групп](../../organization/operations/federation-group-mapping.md) пользователей между поставщиком удостоверений и Yandex Identity Hub. Пользователи в группах поставщика удостоверений будут иметь права доступа к ресурсам Yandex Cloud из сопоставленных групп в Yandex Identity Hub.

| ID требования | Критичность |
| --- | --- |
| IAM2 | Средняя |

#### 1.2 Учетные записи Яндекс ID используются только в исключительных случаях {#yandex-id-accounts}

Наиболее правильный с точки зрения безопасности подход к управлению учетными записями — это использование федерации удостоверений (подробнее в рекомендации № 1.1). В связи с этим необходимо стремиться к тому, чтобы в списке пользователей вашей организации находились только федеративные пользователи (пользователи c атрибутом <q>FEDERATION ID</q>) и минимум учетных записей с Яндекс ID. Список допустимых исключений:

* Учетная запись с правами `billing.accounts.owner` (технически на текущий момент данную роль может иметь только учетная запись Яндекс ID).
* Учетная запись с правами `organization-manager.organizations.owner` и `resource-manager.clouds.owner`, если вы используете ее только для аварийного применения, например, когда сломалась настройка федерации. При необходимости можно [удалить](../operations/account-deletion.md) привилегированный [аккаунт на Яндексе](../../iam/concepts/users/accounts.md#passport) с ролью `organization-manager.organizations.owner` из организации.
* Внешние учетные записи, например, контрагентов или подрядчиков, которые по каким-либо причинам вы не можете завести в вашей IdP.

| ID требования | Критичность |
| --- | --- |
| IAM3 | Высокая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. Откройте консоль Yandex Cloud в вашем браузере.
  1. Перейдите во вкладку **Все сервисы** → **Yandex Identity Hub** → **Пользователи**.
  1. Если у всех учетных записей в колонке **Федерация** выставлено значение **federation** (кроме записей, указанных в списке допустимых исключений выше), то рекомендация выполняется. Если нет, перейдите к п. <q>Инструкции и решения по выполнению</q>.

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый ID:

      ```bash
      yc organization-manager organization list
      ```

  1. Выполните команду для поиска нефедеративных учетных записей в вашей организации, за исключением ID учетной записи, которая входит в список валидных исключений:

      ```bash
      yc organization-manager user list --organization-id=<ID_организации> \
        --format=json | jq -r '.[] | select(.subject_claims.sub!="<ID учетной записи, которая входит в список валидных исключений>")' | jq -r 'select(.subject_claims.federation | not)'
      ```

  1. Если в списке нет учетных записей, то рекомендация выполнена. Если нет, то перейдите к п. <q>Инструкции и решения по выполнению</q>.

{% endlist %}

**Инструкции и решения по выполнению:**

Удалите из вашей организации все учетные записи с Яндекс ID, кроме случаев из списка допустимых исключений. Для всех оставшихся аккаунтов Яндекс ID настройте двухфакторную аутентификацию (2FA) согласно [инструкции](https://yandex.ru/support/id/authorization/twofa.html).

#### 1.3 Таймаут жизни cookie в федерации меньше 6 часов {#cookie-timeout}

В настройках [федерации удостоверений](../../organization/concepts/add-federation.md) необходимо убедиться, что значение параметра **Время жизни cookie** меньше либо равно 6 часов. Это необходимо, чтобы минимизировать риск компрометации рабочих станций пользователей облака.

| ID требования | Критичность |
| --- | --- |
| IAM4 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. Откройте консоль управления Yandex Cloud в вашем браузере.
  1. Перейдите во вкладку **Organizations**.
  1. Далее перейдите во вкладку **Федерации** и выберите вашу федерацию.
  1. Найдите параметр **Время жизни cookie**.
  1. Если значение этого параметра меньше либо равно 6 часам, то рекомендация выполняется. Если нет, то перейдите к п. <q>Инструкции и решения по выполнению</q>.

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый ID:

      ```bash
      yc organization-manager organization list
      ```

  1. Выполните команду для поиска учетных записей с назначенными примитивными ролями на уровне организации:

      ```bash
      export ORG_ID=<ID_организации>
      for FED in $(yc organization-manager federation saml list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do yc organization-manager federation saml get --id $FED --format=json | jq -r '. | select(.cookie_max_age>"21600s")'
      done
      ```

  1. Если выдается пустая строка, то рекомендация выполняется. Если выдается результат с настройкой текущей федерации, где параметр `cookie_max_age` > 21600s, то перейдите к п. <q>Инструкции и решения по выполнению</q>.

{% endlist %}

**Инструкции и решения по выполнению:**

Задайте значение параметра **Время жизни cookie** равным 6 часам (21600 секундам) или меньше.

### Особенности управления доступом {#access-control}

#### 1.4 Только необходимые администраторы управляют членством в IAM-группах {#iam-admins}

Для управления доступом к ресурсам удобно использовать [группы пользователей](../../organization/operations/create-group.md). Необходимо контролировать права доступа к самой группе как к ресурсу. Пользователь с правами доступа к группе может управлять членством других пользователей. Случаи, в которых пользователь получает такие права:

* Пользователю назначена роль `organization-manager.groups.memberAdmin` на организацию.
* Пользователю назначена роль `organization-manager.groups.memberAdmin` на конкретную группу как на ресурс.
* Пользователю назначена роль `organization-manager.organizations.owner` или `admin` или другая привилегированная роль на всю организацию.
* Пользователю назначена роль `admin` или `editor` на конкретную группу как на ресурс (нерекомендованный сценарий).

| ID требования | Критичность |
| --- | --- |
| IAM5 | Высокая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. Откройте консоль Yandex Cloud в вашем браузере.
  1. Перейдите во вкладку **Все сервисы** → **Yandex Identity Hub** → **Группы** → **Выберите нужную группу** → **Права доступа к группе**.
  1. Нажмите тумблер **Наследуемые роли**.
  1. Если в списке отсутствуют учетные записи, которые не должны иметь прав управления членством в группе, то рекомендация выполнена. Если нет, то перейдите к п. <q>Инструкции и решения по выполнению</q>.

{% endlist %}

**Инструкции и решения по выполнению:**

Удалите права на доступ к группе у учетных записей, которым это не требуется.

#### 1.5 Используются сервисные роли вместо примитивных: admin, editor, viewer, auditor {#min-privileges}

[Принцип минимальных привилегий](../../iam/best-practices/using-iam-securely.md#restrict-access) требует назначать минимально необходимые для работы роли. Не рекомендуется использовать примитивные роли `admin`, `editor`, `viewer` и `auditor`, действующие во всех сервисах, так как это противоречит принципу минимальных привилегий. Для более избирательного управления доступом и реализации принципа минимальных привилегий используйте сервисные роли, которые содержат разрешения только для определенного типа ресурсов в указанном сервисе. Со списком всех сервисных ролей можно ознакомиться в [справочнике ролей Yandex Cloud](../../iam/roles-reference.md).

Используйте роль [auditor](../../iam/roles-reference.md#auditor) без возможности доступа к данным везде, где это возможно.

| ID требования | Критичность |
| --- | --- |
| IAM6 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. Откройте консоль Yandex Cloud в вашем браузере.
  1. Перейдите во вкладку **Все сервисы** → **Yandex Identity Hub** → **Пользователи**.
  1. Если у всех учетных записей в колонке **Права доступа** отсутствуют примитивные роли `admin`, `editor` и `viewer`, то рекомендация выполняется. Если нет, то перейдите к п. <q>Инструкции и решения по выполнению</q>.
  1. Далее перейдите в общее меню облака (нажать на облако в исходном меню облака). Выберите вкладку **Права доступа**.
  1. Если у всех учетных записей в колонке **Роли** отсутствуют примитивные роли `admin`, `editor` и `viewer`, то рекомендация выполняется. Если нет, то перейдите к п. <q>Инструкции и решения по выполнению</q>.
  1. Далее перейдите в каждый каталог каждого облака и по аналогии перейдите во вкладку **Права доступа**.
  1. Если у всех учетных записей в колонке роли отсутствуют примитивные роли `admin`, `editor` и `viewer`, то рекомендация выполняется. Если нет, то перейдите к п. <q>Инструкции и решения по выполнению</q>.
 
- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый ID:

      ```bash
      yc organization-manager organization list
      ```

  1. Выполните команду для поиска учетных записей с назначенными примитивными ролями на уровне организации:

      {% cut "**Bash**" %}

      ```bash
      export ORG_ID=<ID_организации>
      yc organization-manager organization list-access-bindings \
        --id=${ORG_ID} \
        --format=json | jq -r '.[] | select(.role_id=="admin" or .role_id=="editor" or .role_id=="viewer")'
      ```

      {% endcut %}

      {% cut "**PowerShell**" %}

      ```powershell
      $ORG_ID = "<ID_организации>"

      if(!(Get-Module -Name Join-Object)) {
        # Force enable TLS12 in PowerShell session (important for Windows Server 2016 and earlier)
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Install-Module -Name Join-Object -Confirm:$false -Force
      }

      $OrgUsers = yc organization-manager users list --organization-id $ORG_ID --format=json | ConvertFrom-Json
      $OrgGroups = yc organization-manager group list --organization-id $ORG_ID --format=json | ConvertFrom-Json

      $PrimitiveRoles = yc organization-manager organization list-access-bindings --id=$ORG_ID --format=json | ConvertFrom-Json | where {$_.role_id -eq "admin" -or $_.role_id -eq "editor" -or $_.role_id -eq "viewer" -or $_.role_id -eq "auditor"} | select role_id -ExpandProperty subject

      $Result = @()
      $Result += Join-Object -Left $($OrgUsers.subject_claims | Where-Object { $_.sub -in $PrimitiveRoles.id } ) -LeftJoinProperty sub -Right $PrimitiveRoles -RightJoinProperty id -Type OnlyIfInBoth
      $Result += Join-Object -Left $($OrgGroups | Where-Object {$_.id -in $PrimitiveRoles.id}) -LeftJoinProperty id -Right $PrimitiveRoles -RightJoinProperty id -Type OnlyIfInBoth | Select @{n="sub";e={$_.id}}, name, preferred_username, picture, email, sub_type, type, role_id 
      $Result
      ```

      {% endcut %}

  1. Если в списке отсутствуют учетные записи, то рекомендация выполнена. Если нет, то перейдите к п. <q>Инструкции и решения по выполнению</q>.
  1. Выполните команду для поиска учетных записей с назначенными примитивными ролями на уровне облаков:

      {% cut "**Bash**" %}

      ```bash
      export ORG_ID=<ID_организации>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do yc resource-manager cloud list-access-bindings --id=$CLOUD_ID --format=json | jq -r '.[] | select(.role_id=="admin" or .role_id=="editor" or .role_id=="viewer")'
      done
      ```

      {% endcut %}

      {% cut "**PowerShell**" %}

      ```powershell
      Install-Module -Name Join-Object

      $ORG_ID = "<ID_организации>"

      $OrgUsers = yc organization-manager users list --organization-id $ORG_ID --format=json | ConvertFrom-Json
      $OrgGroups = yc organization-manager group list --organization-id $ORG_ID --format=json | ConvertFrom-Json

      $Clouds = yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | ConvertFrom-Json | Select @{n="CloudID";e={$_.id}}, created_at, @{n="CloudName";e={$_.name}}, organization_id

      $CloudBindings = @()
      foreach ($Cloud in $Clouds) {
        $CloudBindings += yc resource-manager cloud list-access-bindings --id $Cloud.CloudID --format=json | ConvertFrom-Json | where {$_.role_id -eq "admin" -or $_.role_id -eq "editor" -or $_.role_id -eq "viewer" -or $_.role_id -eq "auditor"} | select role_id -ExpandProperty subject | Select @{n="CloudID";e={$Cloud.CloudID}},  @{n="CloudName";e={$Cloud.CloudName}}, @{n="UserID";e={$_.id}}, type, role_id 
      }

      $Result = @()
      $Result += Join-Object -Left $($OrgUsers.subject_claims | Where-Object {$_.sub -in $CloudBindings.UserID}) -LeftJoinProperty sub -Right $CloudBindings -RightJoinProperty UserID -Type OnlyIfInBoth | Select CloudID, CloudName, sub, preferred_username, email, @{n="FedID";e={$_.federation.id}}, @{n="FedName";e={$_.federation.name}}, sub_type, type, role_id
      $Result += Join-Object -Left $($OrgGroups | Where-Object {$_.id -in $CloudBindings.UserID}) -LeftJoinProperty id -Right $CloudBindings -RightJoinProperty UserID -Type OnlyIfInBoth | Select CloudID, CloudName, @{n="sub";e={$_.id}}, name, preferred_username, email, @{n="FedID";e={$_.federation.id}}, @{n="FedName";e={$_.federation.name}}, sub_type, type, role_id 
      $Result
      ```

      {% endcut %}

  1. Если в списке отсутствуют учетные записи, то рекомендация выполнена. Если нет, то перейдите к п. <q>Инструкции и решения по выполнению</q>.
  1. Выполните команду для поиска учетных записей с назначенными примитивными ролями на уровне всех каталогов в ваших облаках:

      {% cut "**Bash**" %}

      ```bash
      export ORG_ID=<ID_организации>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); \
      do yc resource-manager folder list-access-bindings --id=$FOLDER_ID --format=json | jq -r '.[] | select(.role_id=="admin" or .role_id=="editor" or .role_id=="viewer")'
      done;
      done
      ```

      {% endcut %}


      {% cut "**PowerShell**" %}

      ```powershell
      $ORG_ID = "<ID_организации>"

      $OrgUsers = yc organization-manager users list --organization-id $ORG_ID --format=json | ConvertFrom-Json
      $OrgGroups = yc organization-manager group list --organization-id $ORG_ID --format=json | ConvertFrom-Json

      $Clouds = yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | ConvertFrom-Json | Select @{n="CloudID";e={$_.id}}, created_at, @{n="CloudName";e={$_.name}}, organization_id

      $FolderBindings = @()

      foreach ($Cloud in $Clouds) {
        $Folders = yc resource-manager folder list --cloud-id $Cloud.CloudID --format=json | ConvertFrom-Json

        foreach($Folder in $Folders) {
          $FolderBindings += yc resource-manager folder list-access-bindings --id $Folder.id --format=json | ConvertFrom-Json | where {$_.role_id -eq "admin" -or $_.role_id -eq "editor" -or $_.role_id -eq "viewer" -or $_.role_id -eq "auditor"} | select role_id -ExpandProperty subject | Select @{n="CloudID";e={$Cloud.CloudID}},  @{n="CloudName";e={$Cloud.CloudName}}, @{n="FolderID";e={$Folder.id}}, @{n="FolderName";e={$Folder.name}}, @{n="FolderStatus";e={$Folder.status}}, @{n="UserID";e={$_.id}}, type, role_id 
        }
      }

      $Result = @()
      $Result += Join-Object -Left $($OrgUsers.subject_claims | Where-Object {$_.sub -in $FolderBindings.UserID}) -LeftJoinProperty sub -Right $FolderBindings -RightJoinProperty UserID -Type OnlyIfInBoth | Select CloudID, CloudName, FolderID, FolderName, FolderStatus, sub, name, email, sub_type, type, role_id
      $Result += Join-Object -Left $($OrgGroups | Where-Object {$_.id -in $FolderBindings.UserID}) -LeftJoinProperty id -Right $FolderBindings -RightJoinProperty UserID -Type OnlyIfInBoth | Select CloudID, CloudName, FolderID, FolderName, FolderStatus, @{n="sub";e={$_.id}}, name, email, sub_type, type, role_id
      $Result
      ```

      {% endcut %}

  1. Если в списке отсутствуют учетные записи, то рекомендация выполнена. Если нет, то перейдите к п. <q>Инструкции и решения по выполнению</q>.

{% endlist %}

**Инструкции и решения по выполнению:**

Проанализируйте найденные учетные записи с назначенными примитивными ролями `admin`, `editor` и `viewer` и замените их на [сервисные гранулярные роли](../../iam/roles-reference.md) в соответствии с вашей матрицей ролей.

Чтобы просмотреть полный список доступов субъекта, воспользуйтесь [инструкцией](../../security-deck/operations/ciem/view-permissions.md).

#### 1.6 Используется роль auditor для исключения доступа к данным пользователей {#roles-auditor}

Для пользователей, которые не нуждаются в доступе к данным (таких как внешние подрядчики или аудиторы), необходимо назначить роль `auditor`.
Роль `auditor` это роль с минимальными привилегиями и без доступа к данным сервисов. Она дает разрешение на чтение конфигурации и метаданных сервисов.
Роль `auditor` позволяет выполнять следующие операции:

* Просмотр информации о ресурсе.
* Просмотр метаданных ресурса.
* Просмотр списка операций с ресурсом.

Использование роли `auditor` по умолчанию позволяет более избирательно управлять доступом и реализовывать принцип минимальных привилегий.

| ID требования | Критичность |
| --- | --- |
| IAM7 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в нужный каталог.
  1. Перейдите на вкладку **Права доступа**.
  1. Нажмите кнопку **Назначить роли**.
  1. В окне **Настройка прав доступа** нажмите кнопку **Выбрать пользователя**.
  1. Выберите пользователя из списка или воспользуйтесь поиском по пользователям.
  1. Нажмите кнопку **Добавить роль**.
  1. Выберите роль `auditor` в каталоге.
  1. Нажмите кнопку **Сохранить**.

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый ID:

     ```bash
     yc organization-manager organization list
     ```

  1. Выполните команду для поиска учетных записей с ролью `auditor` на уровне организации:

     ```bash
     export ORG_ID=<ID_организации>
     yc organization-manager organization list-access-bindings \
     --id=${ORG_ID} \
     --format=json | jq -r '.[] | select(.role_id=="auditor")'
     ```

     Если в списке отсутствуют учетные записи, то перейдите к п. <q>Инструкции и решения по выполнению</q>.

  1. Выполните команду для поиска учетных записей с ролью `auditor` на уровне облаков:

     ```bash
     export ORG_ID=<ID_организации>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do yc resource-manager cloud list-access-bindings --id=$CLOUD_ID --format=json | jq -r '.[] | select(.role_id=="auditor")'
     done
     ```

     Если в списке отсутствуют учетные записи, то перейдите к п. <q>Инструкции и решения по выполнению</q>.

  1. Выполните команду для поиска учетных записей с ролью `auditor` на уровне всех каталогов в ваших облаках:

     ```bash
     export ORG_ID=<ID_организации>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); \
     do yc resource-manager folder list-access-bindings --id=$FOLDER_ID --format=json | jq -r '.[] | select(.role_id=="auditor")'
     done;
     done
     ```

     Если в списке отсутствуют учетные записи, то перейдите к п. <q>Инструкции и решения по выполнению</q>.

{% endlist %}

**Инструкции и решения по выполнению:**

1. [Назначьте](../../iam/operations/roles/grant.md) роль `auditor` пользователям, которые не нуждаются в доступе к данным.
1. Удалите избыточные права аккаунта с помощью сервиса IAM.

### Сервисные аккаунты {#service-accounts}

#### 1.7 Облачные сущности с сервисными аккаунтами учтены и ограничены {#sa}

[Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) — аккаунт, от имени которого программы могут управлять ресурсами в Yandex Cloud. Сервисный аккаунт служит для выполнения запросов от имени приложения.

* Не используйте вместо сервисных аккаунтов аккаунты сотрудников. Например, если сотрудник уволится или сменит подразделение, его аккаунт потеряет права, что может привести к сбою приложения.
* Не записывайте ключи сервисных аккаунтов напрямую в код приложения, конфигурационные файлы или переменные окружения.

**При использовании сервисных аккаунтов**:

* Применяйте механизм [назначения сервисного аккаунта](../../compute/operations/vm-connect/auth-inside-vm.md) виртуальной машине и получения токена через сервис метаданных.
* Дополнительно: настройте локальный файрвол на ВМ так, чтобы только необходимые процессы и пользователи системы имели доступ к сервису метаданных (IP-адрес: `169.254.169.254`).

  Пример блокирования доступа от всех пользователей, кроме указанного (в данном случае `root`):

  ```bash
  sudo iptables --append OUTPUT --proto tcp \
  --destination 169.254.169.254 --match owner ! --uid-owner root \
  --jump REJECT
  ```

Облачные сущности, на которые назначены сервисные аккаунты, должны быть учтены и ограничены, т.к., например, если сервисный аккаунт назначен на ВМ, то злоумышленник может получить токен сервисного аккаунта из сервиса метаданных изнутри ВМ.

| ID требования | Критичность |
| --- | --- |
| IAM8 | Высокая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. Откройте консоль Yandex Cloud в вашем браузере.
  1. Перейдите в нужный каталог и откройте настройки нужной ВМ.
  1. Нажмите **Изменить**. 
  1. На экране появится информация о сервисном аккаунте.
  1. Повторите действия для всех ВМ во всех каталогах.

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый ID:

      ```bash
      yc organization-manager organization list
      ```

  1. Выполните команду для поиска ВМ, на которые назначены сервисные аккаунты в вашей организации:

      ```bash
      export ORG_ID=<ID_организации>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do for VM_ID in $(yc compute instance list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); \
      do yc compute instance get --id=$VM_ID --format=json | jq -r '. | select(.service_account_id)' | jq -r '.id' 
      done;
      done;
      done
      ```

  1. Если в списке отсутствуют строки или показаны только учтенные сущности, то рекомендация выполнена. Если нет, то перейдите к п. <q>Инструкции и решения по выполнению</q>.

{% endlist %}

**Инструкции и решения по выполнению:**

Удалите сервисные аккаунты у облачных сущностей, которым они не требуются.

#### 1.8 Сервисным аккаунтам назначены минимальные привилегии {#sa-privileges}

Следуйте принципу минимальных привилегий и [назначайте сервисному аккаунту](../../iam/operations/roles/grant.md) только те роли, которые необходимы для функционирования приложения.

| ID требования | Критичность |
| --- | --- |
| IAM9 | Высокая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. Откройте консоль Yandex Cloud в вашем браузере.
  1. Перейдите в нужный каталог.
  1. В списке сервисов выберите **Identity and Access Management**.
  1. На панели слева выберите ![FaceRobot](../../_assets/console-icons/face-robot.svg) **Сервисные аккаунты**.
  1. Проверьте список сервисных аккаунтов.
  1. Повторите действия для других каталогов.
  1. Перейдите во вкладку **Права доступа** на уровнях облаков и каталогов.

  Права доступа на уровне организации можно посмотреть только в CLI.

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый ID:

      ```bash
      yc organization-manager organization list
      ```

  1. Выполните команду для отображения всех сервисных аккаунтов организации в формате `<id_сервисного_аккаунта>:<имя_сервисного_аккаунта>`:

      ```bash
      export ORG_ID=<ID_организации>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do for SA in $(yc compute instance list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); do yc iam service-account list --folder-id=$FOLDER_ID --format=json  | jq -r '.[].id + ":" + .[].name' 
      done;
      done;
      done
      ```

  1. Выполните команду для отображения всех прав доступа конкретного сервисного аккаунта на организацию:

      ```bash
      export ORG_ID=<ID_организации>
      yc organization-manager organization list-access-bindings \
        --id=${ORG_ID} \
        --format=json | jq -r '.[] | select(.subject.type=="serviceAccount")'
      ```

  1. Просмотрите права доступа сервисного аккаунта на всех облаках:

      ```bash
      export ORG_ID=<ID_организации>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do yc resource-manager cloud list-access-bindings --id=$CLOUD_ID  --format=json | jq -r '.[] | select(.subject.type=="serviceAccount")' && echo $CLOUD_ID
      done;
      ```

  1. Просмотрите права доступа сервисного аккаунта на всех каталогах:

      ```bash
      export ORG_ID=<ID_организации>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do yc resource-manager folder list-access-bindings --id=$FOLDER_ID  --format=json | jq -r '.[] | select(.subject.type=="serviceAccount")' && echo $FOLDER_ID
      done;
      done
      ```

  1. Если в списках отсутствуют избыточные права, то рекомендация выполняется. Если нет, то перейдите к п. <q>Инструкции и решения по выполнению</q>.

{% endlist %}

**Инструкции и решения по выполнению:**

* [Посмотрите](../../security-deck/operations/ciem/view-permissions.md) полный список доступов сервисного аккаунта с помощью сервиса Yandex Security Deck.
* [Отзовите](../../security-deck/operations/ciem/revoke-permissions.md) избыточные доступы у сервисного аккаунта с помощью сервиса Security Deck.
* [Удалите](../../iam/operations/roles/revoke.md) избыточные права у сервисного аккаунта с помощью сервиса IAM.

#### 1.9 Только доверенные администраторы имеют доступ к сервисным аккаунтам {#sa-admins}

Существует возможность назначать права на использование сервисного аккаунта от имени другого пользователя или сервисного аккаунта.
Следуйте принципу минимальных привилегий при выдаче доступа к сервисному аккаунту как к ресурсу: при наличии у пользователя прав на сервисный аккаунт, у него также появляется доступ и ко всем его правам. [Назначайте](../../iam/operations/sa/set-access-bindings.md) роли на использование и управление сервисными аккаунтами минимальному кругу пользователей.
Каждый сервисный аккаунт с расширенными правами нужно размещать как ресурс в отдельном каталоге. Это необходимо для того, чтобы случайно не выдать пользователю права на такой сервисный аккаунт вместе с правами на каталог с компонентом сервиса.

| ID требования | Критичность |
| --- | --- |
| IAM10 | Высокая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. Откройте консоль Yandex Cloud в вашем браузере.
  1. Перейдите в нужный каталог.
  1. В списке сервисов выберите **Identity and Access Management**.
  1. На панели слева выберите ![FaceRobot](../../_assets/console-icons/face-robot.svg) **Сервисные аккаунты**.
  1. Нажмите на сервисный аккаунт и перейдите во вкладку **Права доступа**.
  1. Проверьте права, назначенные на сервисный аккаунт.
  1. Если в списке находятся только валидные администраторы, рекомендация выполняется. Если нет, то перейдите к п. <q>Инструкции и решения по выполнению</q>.

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый ID:

      ```bash
      yc organization-manager organization list
      ```

  1. Выполните команду для отображения всех сервисных аккаунтов в облаках:

      ```bash
      export ORG_ID=<ID_организации>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do yc resource-manager cloud list-access-bindings --id=$CLOUD_ID  --format=json | jq -r '.[] | select(.subject.type=="serviceAccount")' && echo $CLOUD_ID
      done;
      ```

  1. Выполните команду для отображения всех прав доступа на конкретный сервисный аккаунт как на ресурс:

      ```bash
      yc iam service-account list-access-bindings \
        --id <ID_сервисного_аккаунта>
      ```
 
  1. Если в списке находятся только валидные администраторы, рекомендация выполняется. Если нет, то перейдите к п. <q>Инструкции и решения по выполнению</q>.

{% endlist %}

**Инструкции и решения по выполнению:**

[Удалите](../../iam/operations/roles/revoke.md) избыточные права сервисного аккаунта с помощью сервиса IAM.

#### 1.10 Выполняется периодическая ротация ключей сервисных аккаунтов {#sa-key-rotation}

В Yandex Cloud поддерживаются следующие ключи доступа, которые могут быть созданы для сервисных аккаунтов:

* [IAM-токены](../../iam/concepts/authorization/iam-token.md) — действуют 12 часов. 
* [API-ключи](../../iam/concepts/authorization/api-key.md) — можно выбрать любой срок действия.
* [Авторизованные ключи](../../iam/concepts/authorization/key.md) — не имеют срока действия.
* [Статические ключи доступа, совместимые с AWS API](../../iam/concepts/authorization/access-key.md) — не имеют срока действия.

Ключи без срока действия требуется ротировать самостоятельно — удалять и создавать новые. Дату создания можно проверить в свойствах ключа. Рекомендуется ротировать ключи как минимум раз в 90 дней, в соответствии со стандартами информационной безопасности, например, PCI DSS.

| ID требования | Критичность |
| --- | --- |
| IAM11 | Высокая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. Откройте консоль Yandex Cloud в вашем браузере.
  1. Перейдите в нужный каталог.
  1. В списке сервисов выберите **Identity and Access Management**.
  1. На панели слева выберите ![FaceRobot](../../_assets/console-icons/face-robot.svg) **Сервисные аккаунты**.
  1. Нажмите на нужный сервисный аккаунт и в разделе **Свойства ключей доступа** проверьте дату создания каждого ключа.
  1. Повторите действия в каждом из своих каталогов.
  1. Если даты создания ключей не старше 90 дней, то рекомендация выполняется. Если нет, то перейдите к п. <q>Инструкции и решения по выполнению</q>.

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый ID:

      ```bash
      yc organization-manager organization list
      ```

  1. Проверьте дату создания ключей:

      {% cut "**Bash**" %}

      [Статические ключи](../../iam/concepts/authorization/access-key.md): 

      ```bash
      export ORG_ID=<ID_организации>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do for SA in $(yc iam service-account list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id');
      do yc iam access-key list --service-account-id=$SA --format=json | jq -r '.[] | "key_id" + ":" + .id + "," + "sa_id" + ":" + .service_account_id + "," + "created_at" + ":" + .created_at '
      done;
      done;
      done
      ```

      [Авторизованные ключи](../../iam/concepts/authorization/key.md):

      ```bash
      export ORG_ID=<ID_организации>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do for SA in $(yc iam service-account list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id');
      do yc iam key list --service-account-id=$SA --format=json | jq -r '.[] | "key_id" + ":" + .id + "," + "sa_id" + ":" + .service_account_id + "," + "created_at" + ":" + .created_at '
      done;
      done;
      done
      ```

      [API-ключи](../../iam/concepts/authorization/api-key.md):

      ```bash
      export ORG_ID=<ID_организации>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do for SA in $(yc iam service-account list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id');
      do yc iam api-key list --service-account-id=$SA --format=json | jq -r '.[] | "key_id" + ":" + .id + "," + "sa_id" + ":" + .service_account_id + "," + "created_at" + ":" + .created_at '
      done;
      done;
      done
      ```

      {% endcut %}

      {% cut "**PowerShell**" %}

      ```powershell
      $ORG_ID = "<ID_организации>"

      if(!(Get-Module -Name Join-Object)) {
        # Force enable TLS12 in PowerShell session (important for Windows Server 2016 and earlier)
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Install-Module -Name Join-Object -Confirm:$false -Force
      }

      $SAList = (yc organization-manager users list --organization-id $ORG_ID --format=json | ConvertFrom-Json | where {$_.subject_claims.sub_type -eq "SERVICE_ACCOUNT"}).subject_claims

      $AllStaticKeys = @()
      $AllAuthKeys = @()
      $AllAPIKeys = @()

      foreach($SA in $SAList) {
        $StaticKeys = yc iam access-key list --service-account-id $SA.sub --format=json | ConvertFrom-Json

        if($StaticKeys) {
          $ExpiriedKeys = $StaticKeys | where {($(Get-Date) - $_.created_at).Days -gt 90} | Select @{n="StaticKeyID";e={$_.id}}, service_account_id, created_at, key_id, description, @{n="KeyStatus";e={"EXPIRIED"}}
          $ActualKeys = $StaticKeys | where {($(Get-Date) - $_.created_at).Days -le 90} | Select @{n="StaticKeyID";e={$_.id}}, service_account_id, created_at, key_id, description, @{n="KeyStatus";e={"VALID"}}

          if($ExpiriedKeys) {
            $AllStaticKeys += Join-Object -Left $($SAList | Where-Object {$_.sub -in $ExpiriedKeys.service_account_id}) -LeftJoinProperty sub -Right $ExpiriedKeys -RightJoinProperty service_account_id -Type OnlyIfInBoth | Select @{n="service_account_id";e={$_.sub}}, name, sub_type, StaticKeyID, created_at, key_id, description, KeyStatus
          }

          if($ActualKeys) {
            $AllStaticKeys += Join-Object -Left $($SAList | Where-Object {$_.sub -in $ActialKeys.service_account_id}) -LeftJoinProperty sub -Right $ActialKeys -RightJoinProperty service_account_id -Type OnlyIfInBoth | Select @{n="service_account_id";e={$_.sub}}, name, sub_type, StaticKeyID, created_at, key_id, description, KeyStatus
          }
        }

        $AuthKeys = yc iam key list --service-account-id $SA.sub --format=json | ConvertFrom-Json

        if($AuthKeys) {
          $ExpiriedKeys = $AuthKeys | where {($(Get-Date) - $_.created_at).Days -gt 90} | Select @{n="AuthKeyID";e={$_.id}}, service_account_id, created_at, @{n="KeyStatus";e={"EXPIRIED"}}, key_algorithm, last_used_at
          $ActualKeys = $AuthKeys | where {($(Get-Date) - $_.created_at).Days -le 90} | Select @{n="AuthKeyID";e={$_.id}}, service_account_id, created_at, @{n="KeyStatus";e={"VALID"}}, key_algorithm, last_used_at

          if($ExpiriedKeys) {
            $AllAuthKeys += Join-Object -Left $($SAList | Where-Object {$_.sub -in $ExpiriedKeys.service_account_id}) -LeftJoinProperty sub -Right $ExpiriedKeys -RightJoinProperty service_account_id -Type OnlyIfInBoth | Select @{n="service_account_id";e={$_.sub}}, name, sub_type, AuthKeyID, description, created_at, KeyStatus, key_algorithm, last_used_at
          }

          if($ActualKeys) {
            $AllAuthKeys += Join-Object -Left $($SAList | Where-Object {$_.sub -in $ActualKeys.service_account_id}) -LeftJoinProperty sub -Right $ActualKeys -RightJoinProperty service_account_id -Type OnlyIfInBoth | Select @{n="service_account_id";e={$_.sub}}, name, sub_type, AuthKeyID, description, created_at, KeyStatus, key_algorithm, last_used_at
          }
        }

        $APIKeys = yc iam api-key list --service-account-id $SA.sub --format=json | ConvertFrom-Json

        if($APIKeys) {
          $ExpiriedKeys = $APIKeys | where {($(Get-Date) - $_.created_at).Days -gt 90} | Select @{n="APIKeyID";e={$_.id}}, service_account_id, created_at, scope, expires_at, @{n="KeyStatus";e={"EXPIRIED"}}
          $ActualKeys = $APIKeys | where {($(Get-Date) - $_.created_at).Days -le 90} | Select @{n="APIKeyID";e={$_.id}}, service_account_id, created_at, scope, expires_at, @{n="KeyStatus";e={"VALID"}}

          if($ExpiriedKeys) {
            $AllAPIKeys += Join-Object -Left $($SAList | Where-Object {$_.sub -in $ExpiriedKeys.service_account_id}) -LeftJoinProperty sub -Right $ExpiriedKeys -RightJoinProperty service_account_id -Type OnlyIfInBoth | Select @{n="service_account_id";e={$_.sub}}, name, sub_type, APIKeyID, description, created_at, KeyStatus, scope, expires_at
          }

          if($ActualKeys) {
            $AllAPIKeys += Join-Object -Left $($SAList | Where-Object {$_.sub -in $ActualKeys.service_account_id}) -LeftJoinProperty sub -Right $ActualKeys -RightJoinProperty service_account_id -Type OnlyIfInBoth | Select @{n="service_account_id";e={$_.sub}}, name, sub_type, APIKeyID, description, created_at, KeyStatus, scope, expires_at
          }
        }
      }

      $AllStaticKeys
      $AllAuthKeys
      $AllAPIKeys
      ```

      Данный скрипт возвращает три массива объектов — со статическими, авторизованными и API-ключами, а также с автоматическим определением истекших ключей (более 90 дней).

      {% endcut %}

  1. Если в списке любого типа ключей отсутствуют ключи, у которых дата в поле `created_at` старше 90 дней, то рекомендация выполняется. Если нет, то перейдите к п. <q>Инструкции и решения по выполнению</q>.

{% endlist %}

**Инструкции и решения по выполнению:**

Для ротации ключей в зависимости от их типа воспользуйтесь [инструкцией](../../iam/operations/compromised-credentials.md#key-reissue).

#### 1.11 Для API-ключей сервисных аккаунтов заданы минимально необходимые области действия {#api-key-scopes}

Область действия — совокупность разрешенных сервисному аккаунту действий с ресурсами сервиса. В сервисе может быть больше одной области действия. API-ключ с заданными областями действия нельзя использовать в других сервисах или областях действия.

[Области действия](../../iam/concepts/authorization/api-key.md#scoped-api-keys) ограничивают применение [API-ключей](../../iam/concepts/authorization/api-key.md) в дополнение к собственным правам доступа сервисного аккаунта. Настройка ограничений области и срока действия позволяет снизить риск несанкционированного использования ключей. Задавайте для API-ключей только те области действия, которые действительно необходимы.

| ID требования | Критичность |
| --- | --- |
| IAM12 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, которому принадлежит сервисный аккаунт.
  1. В списке сервисов выберите **Identity and Access Management**.
  1. На панели слева выберите ![FaceRobot](../../_assets/console-icons/face-robot.svg) **Сервисные аккаунты** и выберите нужный сервисный аккаунт.
  1. В блоке **API-ключи** обратите внимание на поле **Область действия** в таблице с информацией о ваших API-ключах.
  1. Если для всех API-ключей заданы минимально необходимые области действия, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

- Проверка через CLI {#cli}

  Выполните команду, указав имя сервисного аккаунта, которому принадлежат ваши API-ключи:

  ```bash
  yc iam api-key list --service-account-name <имя_сервисного_аккаунта>
  ```

  Если в выводе команды в поле `SCOPES` для всех API-ключей заданы минимально необходимые области действия, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению:**

[Создайте](../../iam/operations/authentication/manage-api-keys.md#create-api-key) API-ключ с заданной областью действия.

#### 1.12 Токен для облачных функций и ВМ выдается через сервисный аккаунт {#func-token}

Для получения IAM-токена в ходе выполнения функции необходимо [назначить](../../functions/operations/function-sa.md) функции сервисный аккаунт. В этом случае функция получит IAM-токен с помощью встроенных механизмов Yandex Cloud, без необходимости передачи каких-либо секретов в функцию извне. Аналогично и [для ВМ](../../compute/operations/vm-info/get-info.md#inside-instance). Дополнительную информацию о получении IAM-токена в функции см. в разделе [Получение IAM-токена сервисного аккаунта с помощью функции](../../functions/operations/function-sa.md).

| ID требования | Критичность |
| --- | --- |
| IAM13 | Средняя |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Проанализируйте все ваши ВМ и облачные функции на предмет созданных вручную токенов сервисных аккаунтов. Правильно использовать токены путем назначения сервисного аккаунта на сущность и использовать токен аккаунта изнутри, через сервис метаданных.

{% endlist %}

#### 1.13 Используется имперсонация, где это возможно {#impersonation}

[Имперсонация](../../iam/operations/sa/impersonate-sa.md) позволяет пользователю выполнять действия от имени сервисного аккаунта и предоставляет возможность временно расширить права, не прибегая к генерации статических учетных данных. Может быть полезна в следующих сценариях: дежурства, локальная разработка, проверка прав доступа.

| ID требования | Критичность |
| --- | --- |
| IAM14 | Высокая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) на панели слева нажмите на имя нужного облака.
  1. Перейдите на вкладку **Права доступа** и проверьте наличие роли `iam.serviceAccounts.tokenCreator`.

{% endlist %}

**Инструкции и решения по выполнению:**

Если роль `iam.serviceAccounts.tokenCreator` отсутствует, то настройте имперсонацию для сервисных аккаунтов для обеспечения временного доступа к критичным данным по данной [инструкции](../../iam/operations/sa/impersonate-sa.md).


### Метаданные ВМ {#vm-metadata}

#### 1.14 В сервисе метаданных ВМ отсутствуют облачные ключи в открытом виде {#cloud-keys}

Не записывайте ключи сервисных аккаунтов и другие ключи в [метаданные виртуальной машины](../../compute/concepts/vm-metadata.md) напрямую. Используйте механизм [назначения сервисного аккаунта](../../compute/operations/vm-connect/auth-inside-vm.md) виртуальной машине и получения токена через сервис метаданных. Чувствительные данные могут находиться в любом поле метаданных, но самое распространенное — `user-data` (за счет использования в утилите cloud-init).

Чтобы получить метаданные виртуальной машины снаружи ВМ, выполните команду:

{% cut "**Bash**" %}

```bash
yc compute instance get \
  --id <идентификатор_виртуальной_машины> \
  --full \
  --format=json | jq -r '. | select(.metadata."user-data") | .metadata."user-data"'
```

{% endcut %}

{% cut "**PowerShell**" %}

```powershell
yc compute instance get `
  --id <идентификатор_виртуальной_машины> `
  --full `
  --format=json | ConvertFrom-Json
```

{% endcut %}

Ознакомьтесь со списком всех регулярных выражений для поиска секретов учетных данных облачных аккаунтов:

* **yandex_cloud_iam_cookie_v1** : c1\.[A-Z0-9a-z_-]+[=]{0,2}\.[A-Z0-9a-z_-]{86}[=]{0,2}
  Yandex.Cloud Session Cookie
* **yandex_cloud_iam_token_v1** : t1\.[A-Z0-9a-z_-]+[=]{0,2}\.[A-Z0-9a-z_-]{86}[=]{0,2}
  Yandex.Cloud IAM token
* **yandex_cloud_iam_api_key_v1** : AQVN[A-Za-z0-9_\-]{35,38}
  Yandex.Cloud API Keys (Speechkit, Vision, Translate)
* **yandex_passport_oauth_token** : y[0-6]_[-_A-Za-z0-9]{55} 
  Yandex Passport OAuth token
* **yandex_cloud_iam_access_secret** : YC[a-zA-Z0-9_\-]{38}
  Yandex.Cloud AWS API compatible Access Secret

| ID требования | Критичность |
| --- | --- |
| IAM15 | Высокая |

{% list tabs group=instructions %}

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый ID:

      ```bash
      yc organization-manager organization list
      ```

  1. В Yandex Cloud используются секреты разных типов, которые могут оказаться в метаданных или переменных окружения ВМ в явном виде. Для поиска кандидатов ВМ с секретами облака в метаданных, выполните следующий скрипт:

      {% cut "**Bash**" %}

      ```bash
      export ORG_ID=<ID_организации>
      CLOUDS=$(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id')

      for CLOUD_ID in $CLOUDS
        do
        FOLDERS=$(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id')
        for FOLDER_ID in $FOLDERS
        do
          VMIDS=$(yc compute instance list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id')

          if [[ -n "$VMIDS" ]]; then
            for VM_ID in $VMIDS
            do
              IAM_TOKEN=""
              IAM_COOKIE=""
              STATIC_KEY=""
              API_KEY=""
              OAUTH_TOKEN=""
              PRIVATE_KEY=""

              VMDATA=$(yc compute instance get --id $VM_ID --full --folder-id $FOLDER_ID --format=json)
              VM_META=$(echo $VMDATA | jq -r '. | select(.metadata."user-data") | .metadata."user-data"')

              if [[ -n $VM_META ]]; then

                # IAM Tokens
                IAM_TOKEN=$(echo $VMDATA | jq -r '. | select(.metadata."user-data")| .metadata."user-data" | match("t1\\.[A-Z0-9a-z_-]+[=]{0,2}\\.[A-Z0-9a-z_-]{86}[=]{0,2}") | .string')

                if [[ -n "$IAM_TOKEN" ]]; then
                  echo "------------"
                  echo "CLOUD_ID:" $CLOUD_ID
                  echo "FOLDER_ID:" $FOLDER_ID
                  echo "VM_ID: "$(echo $VMDATA | jq -r '.id')
                  echo "VM_NAME: "$(echo $VMDATA | jq -r '.name')
                  echo "METADATA_SECRET_ENTRY: $IAM_TOKEN"
                  echo "SECRET_TYPE: IAM-Token"
                  echo "------------"
                fi

                # IAM Cookies
                IAM_COOKIE=$(echo $VMDATA | jq -r '. | select(.metadata."user-data")| .metadata."user-data" | match("c1\\.[A-Z0-9a-z_-]+[=]{0,2}\\.[A-Z0-9a-z_-]{86}[=]{0,2}") | .string')

                if [[ -n $IAM_COOKIE ]]; then
                  echo "------------"
                  echo "CLOUD_ID: $CLOUD_ID"
                  echo "FOLDER_ID: $FOLDER_ID"
                  echo "VM_ID: "$(echo $VMDATA | jq -r '.id')
                  echo "VM_NAME: "$(echo $VMDATA | jq -r '.name')
                  echo "METADATA_SECRET_ENTRY: $IAM_COOKIE"
                  echo "SECRET_TYPE: IAM-Cookie"
                  echo "------------"
                fi

                # Static Keys
                STATIC_KEY=$(echo $VMDATA | jq -r '. | select(.metadata."user-data")| .metadata."user-data" | match("YC[a-zA-Z0-9_-]{38}") | .string')

                if [[ -n $STATIC_KEY ]]; then
                  echo "------------"
                  echo "CLOUD_ID:" $CLOUD_ID
                  echo "FOLDER_ID:" $FOLDER_ID
                  echo "VM_ID: "$(echo $VMDATA | jq -r '.id')
                  echo "VM_NAME: "$(echo $VMDATA | jq -r '.name')
                  echo "METADATA_SECRET_ENTRY: $STATIC_KEY"
                  echo "SECRET_TYPE: Static Key"
                  echo "------------"
                fi

                # API Keys
                API_KEY=$(echo $VMDATA | jq -r '. | select(.metadata."user-data")| .metadata."user-data" | match("AQVN[A-Za-z0-9_-]{35,38}") | .string')

                if [[ -n $API_KEY ]]; then
                  echo "------------"
                  echo "CLOUD_ID:" $CLOUD_ID
                  echo "FOLDER_ID:" $FOLDER_ID
                  echo "VM_ID: "$(echo $VMDATA | jq -r '.id')
                  echo "VM_NAME: "$(echo $VMDATA | jq -r '.name')
                  echo "METADATA_SECRET_ENTRY: $API_KEY"
                  echo "SECRET_TYPE: API Key"
                  echo "------------"
                fi

                # OAuth Tokens
                OAUTH_TOKEN=$(echo $VMDATA | jq -r '. | select(.metadata."user-data")| .metadata."user-data" | match("y[0-6]_[-_A-Za-z0-9]{55}") | .string')

                if [[ -n $OAUTH_TOKEN ]]; then
                  echo "------------"
                  echo "CLOUD_ID:" $CLOUD_ID
                  echo "FOLDER_ID:" $FOLDER_ID
                  echo "VM_ID: "$(echo $VMDATA | jq -r '.id')
                  echo "VM_NAME: "$(echo $VMDATA | jq -r '.name')
                  echo "METADATA_SECRET_ENTRY: $OAUTH_TOKEN"
                  echo "SECRET_TYPE: OAuth Token"
                  echo "------------"
                fi

                # Private keys
                PRIVATE_KEY=$(echo $VMDATA | jq -r '. | select(.metadata."user-data")| .metadata."user-data" | match("-----BEGIN PRIVATE KEY-----") | .string')

                if [[ -n $PRIVATE_KEY ]]; then
                  echo "------------"
                  echo "CLOUD_ID:" $CLOUD_ID
                  echo "FOLDER_ID:" $FOLDER_ID
                  echo "VM_ID: "$(echo $VMDATA | jq -r '.id')
                  echo "VM_NAME: "$(echo $VMDATA | jq -r '.name')
                  echo "METADATA_SECRET_ENTRY: $PRIVATE_KEY"
                  echo "SECRET_TYPE: Private Key"
                  echo "------------"
                fi
              fi
            done
          fi
        done
      done
      ```

      {% endcut %}


      {% cut "**PowerShell**" %}

      ```powershell
      $ORG_ID=<ID_организации>

      $Clouds = yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | ConvertFrom-Json | Select @{n="CloudID";e={$_.id}}, created_at, @{n="CloudName";e={$_.name}}, organization_id

      $MetadataSecrets = @()

      foreach ($Cloud in $Clouds) {
        $Folders = yc resource-manager folder list --cloud-id $Cloud.CloudID --format=json | ConvertFrom-Json

        foreach($Folder in $Folders) {
          $VMs = yc compute instance list --folder-id $Folder.id --format=json | ConvertFrom-Json

          foreach($VM in $VMs) {
            $VMData = yc compute instance get --id $VM.id --folder-id $Folder.id --full --format=json | ConvertFrom-Json

            $SecretScanner = @()
            if($VMData.metadata."user-data") {
              $VMData.metadata."user-data" | Out-File user-data.txt

              # Checking if IAM Cookie in user-data
              $SecretScanner += Get-Item -Path user-data.txt | Select-String -Pattern 'c1\.[a-zA-Z0-9_-]*\.[a-zA-Z0-9_-]*' | Select LineNumber, @{n="Entry";e={$_.Line}}, @{n="SecretType";e={"IAM Token"}}

              # Checking if IAM Token in user-data
              $SecretScanner += Get-Item -Path user-data.txt | Select-String -Pattern 't1\.[a-zA-Z0-9_-]*\.[a-zA-Z0-9_-]*' | Select LineNumber, @{n="Entry";e={$_.Line}}, @{n="SecretType";e={"IAM Cookie"}}

              # Checking if Static Key in user-data
              $SecretScanner += Get-Item -Path user-data.txt | Select-String -Pattern 'YC[a-zA-Z0-9_\\-]{38}'  -CaseSensitive | Select LineNumber, @{n="Entry";e={$_.Line}}, @{n="SecretType";e={"Static Key"}}

              # Checking if any API Key in user-data
              $SecretScanner += Get-Item -Path user-data.txt | Select-String -Pattern 'AQVN[a-zA-Z0-9_-]{35}' -CaseSensitive | Select LineNumber, @{n="Entry";e={$_.Line}}, @{n="SecretType";e={"API Key"}}

              # Checking if any private key in user-data
              $SecretScanner += Get-Item -Path user-data.txt | Select-String -Pattern "-----BEGIN PRIVATE KEY-----" -CaseSensitive | Select LineNumber, @{n="Entry";e={$_.Line}}, @{n="SecretType";e={"Private Key"}}

              # Checking if OAuth tokens
              $SecretScanner += Get-Item -Path user-data.txt | Select-String -Pattern 'y[0-6]_[a-zA-Z0-9_\\-]{58}' -CaseSensitive | Select LineNumber, @{n="Entry";e={$_.Line}}, @{n="SecretType";e={"Yandex OAuth Token"}}

              if($SecretScanner) {
                $MetadataSecrets += $SecretScanner | Select @{n="CloudID";e={$Cloud.CloudID}}, @{n="CloudName";e={$Cloud.CloudName}},@{n="FolderID";e={$Folder.id}},@{n="FolderName";e={$Folder.name}},@{n="VMID";e={$VMData.id}},@{n="VMName";e={$VMData.name}}, LineNumber, Entry, SecretType
              }
            }
          }
        }
      }

      $outNull = Remove-Item user-data.txt -Confirm:$false -Force

      $MetadataSecrets
      ```

      {% endcut %}

      Скрипт выполняет поиск всех секретов по всем ВМ в организации и возвращает вхождения строк с секретом в `user-data`, номер строки и тип секрета (`IAM Token`, `Static Key`, `API Key` или `Private Key`).

      {% cut "**Пример вывода**" %}

      ```text
      $MetadataSecrets
      CloudID    : b1g4bj142s8d********
      CloudName  : mycloud
      FolderID   : b1gd3nedooa0********
      FolderName : myfolder
      VMID       : fhmlfad6feul********
      VMName     : test
      LineNumber : 4
      Entry      : export token="t1.9eue****"
      SecretType : IAM Token

      CloudID    : b1g4bj142s8d********
      CloudName  : mycloud
      FolderID   : b1gd3nedooa0********
      FolderName : myfolder
      VMID       : fhmlfad6feul********
      VMName     : test
      LineNumber : 5
      Entry      : export token2="t1.9eue****"
      SecretType : IAM Token

      CloudID    : b1g4bj142s8d********
      CloudName  : mycloud
      FolderID   : b1gd3nedooa0********
      FolderName : myfolder
      VMID       : fhmlfad6feulm********
      VMName     : test
      LineNumber : 3
      Entry      : export key="YCMJ5_****"
      SecretType : Static Key

      CloudID    : b1g4bj142s8d********
      CloudName  : mycloud
      FolderID   : b1gd3nedooa0********
      FolderName : myfolder
      VMID       : fhmlfad6feul********
      VMName     : test
      LineNumber : 59
      Entry      : export a="AQVN2****"  
      SecretType : API Key

      CloudID    : b1g4bj142s8d********
      CloudName  : mycloud
      FolderID   : b1gd3nedooa0********
      FolderName : myfolder
      VMID       : fhmlfad6feul********
      VMName     : test
      LineNumber : 60
      Entry      : export b="AQVN2****" 
      SecretType : API Key

      CloudID    : b1g4bj142s8d********
      CloudName  : mycloud
      FolderID   : b1gd3nedooa0********
      FolderName : myfolder
      VMID       : fhmlfad6feul********
      VMName     : test
      LineNumber : 7
      Entry      : -----BEGIN PRIVATE KEY-----
      SecretType : Private Key
      ```

      {% endcut %}

  1. Если в списке отсутствуют строки, содержащие секреты, то рекомендация выполнена. Если нет, то перейдите к п. <q>Инструкции и решения по выполнению</q>.

{% endlist %}

**Инструкции и решения по выполнению:**

Удалите ключи из метаданных ВМ, у которых были найдены отклонения:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, которому принадлежит ВМ.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **Виртуальные машины**.
  1. В строке с нужной ВМ нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../_assets/console-icons/pencil.svg) **Редактировать**.
  1. Раскройте секцию **Метаданные** и удалите ключи, нажав ![image](../../_assets/console-icons/xmark.svg).
  1. Нажмите **Сохранить изменения**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для удаления метаданных:

      ```bash
      yc compute instance remove-metadata --help
      ```

  1. Удалите ключи:

      ```bash
      yc compute instance remove-metadata <идентификатор_ВМ> --keys <имя_SSH-ключа>
      ```

- API {#api}

  Чтобы удалить SSH-ключи из метаданных ВМ, воспользуйтесь методом REST API [updateMetadata](../../compute/api-ref/Instance/updateMetadata.md) для ресурса [Instance](../../compute/api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/UpdateMetadata](../../compute/api-ref/grpc/Instance/updateMetadata.md).

  В запросе передайте параметр `delete` с SSH-ключом.

  **Пример запроса для REST API**

  ```bash
  curl \
    --request POST \
    --header "Authorization: Bearer <IAM-токен>" \
    --data '{"delete":["<имя_SSH-ключа>"]}' \
    https://compute.api.cloud.yandex.net/compute/v1/instances/<идентификатор_ВМ>/updateMetadata
  ```

{% endlist %}

#### 1.15 На ВМ отключено получение токена через AWS IMDSv1 {#aws-token}

В облаке есть [сервис метаданных](../../compute/concepts/vm-metadata.md), предоставляющий сведения о работе виртуальных машин.

Изнутри виртуальной машины метаданные доступны в следующих форматах:

* Google Compute Engine (поддерживаются не все поля).
* Amazon EC2 (поддерживаются не все поля).

Формат Amazon EC2 Instance Metadata Service version 1 (IMDSv1) имеет ряд недостатков. Наиболее критичный из них — это риск компрометации токена сервисного аккаунта через сервис метаданных с помощью SSRF-атаки. Подробности в [официальном блоге AWS](https://aws.amazon.com/blogs/security/defense-in-depth-open-firewalls-reverse-proxies-ssrf-vulnerabilities-ec2-instance-metadata-service/). В связи с этим AWS выпустили вторую версию сервиса метаданных — IMDSv2.

В Yandex Cloud пока нет поддержки второй версии, поэтому строго рекомендуется технически отключать возможность получения токена сервисного аккаунта через Amazon EC2 сервис метаданных.

Сервис метаданных Google Compute Engine использует дополнительный заголовок для защиты от SSRF и повышения безопасности.

Отключить получение токена сервисного аккаунта через Amazon EC2 сервис метаданных можно с помощью параметра ВМ [aws_v1_http_token:DISABLED](../../compute/api-ref/grpc/Instance/create.md#yandex.cloud.compute.v1.MetadataOptions).

| ID требования | Критичность |
| --- | --- |
| IAM16 | Высокая |

{% list tabs group=instructions %}

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый ID:

      ```bash
      yc organization-manager organization list
      ```

  1. Выполните команду для поиска ВМ, у которых включено использование IMDSv1 для получения токена:

      ```bash
      export ORG_ID=<ID_организации>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do for VM_ID in $(yc compute instance list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); do yc compute instance get --id=$VM_ID --format=json | jq -r '. | select(.metadata_options.aws_v1_http_token=="ENABLED")' | jq -r '.id' 
      done;
      done;
      done
      ```

  1. Если в списке отсутствуют строки, то рекомендация выполнена. Если нет, то перейдите к п. <q>Инструкции и решения по выполнению</q>.

{% endlist %}

**Инструкции и решения по выполнению:**

В блоке metadata_options задайте параметру [aws_v1_http_token](../../compute/api-ref/grpc/Instance/create.md#yandex.cloud.compute.v1.MetadataOptions) значение `DISABLED` у найденных ВМ:

```bash
yc compute instance update <ID_виртуальной_машины> \
  --metadata-options aws-v1-http-token=DISABLED
```

### Привилегированные аккаунты {#privileged-accounts}

#### 1.16 Настроена двухфакторная аутентификация для привилегированных аккаунтов {#twofa}

Рекомендуется использовать двухфакторную аутентификацию (2FA) для доступа к облачной инфраструктуре, чтобы избежать рисков, связанных с компрометацией пользовательских учетных записей. Доступ в консоль Yandex Cloud может быть организован с помощью 2FA.

Чтобы подключить двухфакторную аутентификацию, обратитесь к поставщику удостоверений (identity provider) с поддержкой 2FA и настройте SAML-совместимую федерацию удостоверений. В Yandex Cloud нет своего IdP и задача идентификации пользователей решается с помощью внешних сервисов — Яндекс ID или корпоративных систем, интегрированных с помощью федерации удостоверений. Например, если вы используете IdP системы Active Directory или Keycloak, то настройте 2FA в данных системах. Необходимо настроить 2FA как минимум для привилегированных учетных записей облака.

Для аккаунта Яндекс ID настройте 2FA согласно [инструкции](https://yandex.ru/support/id/authorization/twofa.html).

| ID требования | Критичность |
| --- | --- |
| IAM17 | Высокая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. Откройте UI Яндекс ID в вашем браузере.
  1. Перейдите на вкладку [Безопасность](https://id.yandex.ru/security).
  1. Проверьте, что указан способ входа с помощью дополнительного ключа.
  1. Если способ входа с помощью ключа настроен, то рекомендация выполняется. Если нет, то перейдите к п. <q>Инструкции и решения по выполнению</q>.
  1. Если вы используете сторонние IdP, проверьте настройки по инструкциям.

{% endlist %}

**Инструкции и решения по выполнению:**

* [Двухфакторная аутентификация — Яндекс ID](https://yandex.ru/support/id/authorization/twofa.html).
* [KeyCloak — Creating other credentials](https://www.keycloak.org/docs/latest/server_admin/#creating-other-credentials).
* [Configure Additional Authentication Methods for AD FS](https://learn.microsoft.com/ru-ru/windows-server/identity/ad-fs/operations/configure-additional-authentication-methods-for-ad-fs).

#### 1.17 Привилегированные роли назначены только доверенным администраторам {#privileged-users}

К привилегированным пользователям Yandex Cloud относятся аккаунты со следующими ролями:

* `billing.accounts.owner`;
* `admin`, назначенная на платежный аккаунт;
* `organization-manager.organizations.owner`;
* `organization-manager.admin`;
* `resource-manager.clouds.owner`;
* `admin`, `editor`, назначенные на организацию;
* `admin`, `editor`, назначенные на облако;
* `admin`, `editor`, назначенные на каталог.

Роль `billing.accounts.owner` автоматически выдается при создании платежного аккаунта. Любой пользователь с ролью `billing.accounts.owner` может удалить эту роль у создателя платежного аккаунта и изменить владельца. Роль позволяет выполнять любые действия с платежным аккаунтом.

Роль `billing.accounts.owner` может быть назначена только аккаунту Яндекс ID. Аккаунт с ролью `billing.accounts.owner` используется при настройке способов оплаты и подключении облаков.

Безопасности этого аккаунта следует уделять повышенное внимание, поскольку он обладает значительными полномочиями и не может быть объединен с корпоративным аккаунтом.

Наиболее правильным подходом можно считать отказ от регулярного использования данного аккаунта:

* Используйте его только при первоначальной настройке и внесении изменений.
* На время активного использования данного аккаунта включите двухфакторную аутентификацию (2FA) в Яндекс ID.
* Затем, если вы не используете способ оплаты банковской картой (доступный только для данной роли), назначьте данному аккаунту сложный пароль (сгенерированный с помощью специализированного ПО), отключите 2FA и не используйте этот аккаунт без необходимости.
* После каждого использования меняйте пароль на сгенерированный заново.

Отключить 2FA рекомендуется только для этого аккаунта и в случае, если аккаунт не <q>закреплен</q> за конкретным сотрудником. Эта мера нужна, чтобы избежать привязки критически важного аккаунта к личному устройству.

Для управления платежным аккаунтом назначьте роль `admin` или `editor` на платежный аккаунт выделенному сотруднику организации с федеративным аккаунтом.

Для просмотра платежных данных назначьте роль `viewer` на платежный аккаунт выделенному сотруднику организации с федеративным аккаунтом.

Роль `organization-manager.organizations.owner` по умолчанию получает владелец организации — пользователь, который ее создал. Роль дает возможность назначать владельцев организации, а также пользоваться всеми полномочиями администратора.

Роль `resource-manager.clouds.owner` автоматически выдается при создании первого облака в организации. Пользователь с этой ролью может выполнять любые операции с облаком и ресурсами в нем, а также выдавать доступ к облаку другим пользователям: назначать роли и отзывать их.

Назначайте роль `resource-manager.clouds.owner` и `organization-manager.organizations.owner` одному или нескольким сотрудникам организации с федеративным аккаунтом. Аккаунту Яндекс ID, с которым создано облако, назначьте сложный пароль и используйте только в случае крайней необходимости, например, при поломке федерации.

Федеративный аккаунт с одной из привилегированных ролей, указанных выше, необходимо всесторонне защитить:

* Включите двухфакторную аутентификацию.
* Запретите аутентификацию с устройств, не управляемых организацией.
* Настройте мониторинг попыток входа и задайте пороги предупреждений.

Назначайте роли `admin` на облака, каталоги и платежные аккаунты федеративным аккаунтам. Минимизируйте количество аккаунтов с этими ролями и регулярно перепроверяйте потребность в этих ролях для тех аккаунтов, которым они назначены.

| ID требования | Критичность |
| --- | --- |
| IAM18 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  Проверка ролей на сервис Yandex Cloud Billing:

  1. Откройте консоль управления Yandex Cloud в вашем браузере.
  1. Перейдите в сервис [Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts).
  1. Проверьте кому назначены роли: `billing.accounts.owner`, `admin`.

  Проверка ролей на организацию:

  1. Откройте консоль управления Yandex Cloud в вашем браузере.
  1. Перейдите во вкладку **Все сервисы** → **Yandex Identity Hub** → **Пользователи**.
  1. Проверьте кому назначены роли: `admin`, `organization-manager.organizations.owner`, `organization-manager.admin`, `resource-manager.clouds.owner`.

  Проверка ролей на облако:

  1. Откройте консоль управления Yandex Cloud в вашем браузере.
  1. Перейдите в общее меню облака: нажмите на облако в исходном меню облака. Выберите вкладку **Права доступа**.
  1. Проверьте кому назначены роли: `admin`, `editor` , `resource-manager.clouds.owner`.

  Проверка ролей на каталоге:

  1. Откройте консоль управления Yandex Cloud в вашем браузере.
  1. Далее перейдите в каждый каталог каждого облака и по аналогии перейдите во вкладку **Права доступа**.
  1. Проверьте кому назначена роль `admin`.
  1. Если все привилегированные роли назначены доверенным администраторам, то рекомендация выполняется. Если нет, то перейдите к п. <q>Инструкции и решения по выполнению</q>.

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый ID:

      ```bash
      yc organization-manager organization list
      ```

  1. Найдите привилегированные права на уровне организации:

      {% cut "**Bash**" %}

      ```bash
      export ORG_ID=<ID_организации>
      yc organization-manager organization list-access-bindings
        --id=${ORG_ID} \
        --format=json | jq -r '.[] | select(.role_id=="admin" or .role_id=="editor" or .role_id=="organization-manager.organizations.owner" or .role_id=="organization-manager.admin" or .role_id=="resource-manager.clouds.owner" or role_id=="resource-manager.clouds.editor")'
      ```

      {% endcut %}

      {% cut "**PowerShell**" %}

      ```powershell
      $ORG_ID = "<ID_организации>"

      if(!(Get-Module -Name Join-Object)) {
        # Force enable TLS12 in PowerShell session (important for Windows Server 2016 and earlier)
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Install-Module -Name Join-Object -Confirm:$false -Force
      }

      $OrgUsers = yc organization-manager users list --organization-id $ORG_ID --format=json | ConvertFrom-Json
      $OrgGroups = yc organization-manager group list --organization-id $ORG_ID --format=json | ConvertFrom-Json

      $OrgBindings = yc organization-manager organization list-access-bindings --id=$ORG_ID --format=json | ConvertFrom-Json | where {$_.role_id -eq "admin"-or $_.role_id -eq "editor" -or $_.role_id -eq "organization-manager.organizations.owner" -or $_.role_id -eq "organization-manager.admin" -or $_.role_id -eq "resource-manager.clouds.owner" -or $_.role_id -eq "resource-manager.clouds.editor"} | select role_id -ExpandProperty subject

      $Result = @()
      $Result += Join-Object -Left $($OrgUsers.subject_claims | Where-Object { $_.sub -in $OrgBindings.id } ) -LeftJoinProperty sub -Right $OrgBindings -RightJoinProperty id -Type OnlyIfInBoth | Select sub, name, preferred_username, picture, email, sub_type, type, role_id 

      if($OrgGroups | Where-Object {$_.id -in $OrgBindings.id}) {
          $Result += Join-Object -Left $($OrgGroups | Where-Object {$_.id -in $OrgBindings.id}) -LeftJoinProperty id -Right $OrgBindings -RightJoinProperty id -Type OnlyIfInBoth | Select @{n="sub";e={$_.id}}, name, preferred_username, picture, email, sub_type, type, role_id 
      }
      $Result
      ```

      {% endcut %}

  1. Найдите привилегированные права на уровне облаков:

      {% cut "**Bash**" %}

      ```bash
      export ORG_ID=<ID_организации>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do yc resource-manager cloud list-access-bindings --id=$CLOUD_ID --format=json | jq -r '.[] | select(.role_id=="admin" or .role_id=="editor" or .role_id=="resource-manager.clouds.owner" or role_id=="resource-manager.clouds.editor")' && echo $CLOUD_ID
      done
      ```

      {% endcut %}

      {% cut "**PowerShell**" %}

      ```powershell
      $ORG_ID = "<ID_организации>"

      if(!(Get-Module -Name Join-Object)) {
        # Force enable TLS12 in PowerShell session (important for Windows Server 2016 and earlier)
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Install-Module -Name Join-Object -Confirm:$false -Force
      }

      $OrgUsers = yc organization-manager users list --organization-id $ORG_ID --format=json | ConvertFrom-Json
      $OrgGroups = yc organization-manager group list --organization-id $ORG_ID --format=json | ConvertFrom-Json

      $Clouds = yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | ConvertFrom-Json | Select @{n="CloudID";e={$_.id}}, created_at, @{n="CloudName";e={$_.name}}, organization_id

      $CloudBindings = @()
      foreach ($Cloud in $Clouds) {
        $CloudBindings += yc resource-manager cloud list-access-bindings --id $Cloud.CloudID --format=json | ConvertFrom-Json | where {$_.role_id -eq "admin" -or $_.role_id -eq "editor" -or $_.role_id -eq "resource-manager.clouds.owner" -or $_.role_id -eq "resource-manager.clouds.editor"} | select role_id -ExpandProperty subject | Select @{n="CloudID";e={$Cloud.CloudID}},  @{n="CloudName";e={$Cloud.CloudName}}, @{n="UserID";e={$_.id}}, type, role_id 
      }

      $Result = @()
      $Result += Join-Object -Left $($OrgUsers.subject_claims | Where-Object {$_.sub -in $CloudBindings.UserID}) -LeftJoinProperty sub -Right $CloudBindings -RightJoinProperty UserID -Type OnlyIfInBoth | Select CloudID, CloudName, sub, preferred_username, email, @{n="FedID";e={$_.federation.id}}, @{n="FedName";e={$_.federation.name}}, sub_type, type, role_id

      if($OrgGroups | Where-Object {$_.id -in $CloudBindings.UserID}) {
          $Result += Join-Object -Left $($OrgGroups | Where-Object {$_.id -in $CloudBindings.UserID}) -LeftJoinProperty id -Right $CloudBindings -RightJoinProperty UserID -Type OnlyIfInBoth | Select CloudID, CloudName, @{n="sub";e={$_.id}}, name, preferred_username, email, @{n="FedID";e={$_.federation.id}}, @{n="FedName";e={$_.federation.name}}, sub_type, type, role_id 
      }
      $Result
      ```

      {% endcut %}

  1. Выполните команду для поиска привилегированных прав на уровне всех каталогов в ваших облаках:

      {% cut "**Bash**" %}

      ```bash
      export ORG_ID=<ID_организации>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do yc resource-manager folder list-access-bindings --id=$FOLDER_ID --format=json | jq -r '.[] | select(.role_id=="admin" or .role_id=="editor")' && echo $FOLDER_ID
      done;
      done
      ```

      {% endcut %}

      {% cut "**PowerShell**" %}

      ```powershell
      $ORG_ID = "<ID_организации>"

      if(!(Get-Module -Name Join-Object)) {
        # Force enable TLS12 in PowerShell session (important for Windows Server 2016 and earlier)
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Install-Module -Name Join-Object -Confirm:$false -Force
      }

      $OrgUsers = yc organization-manager users list --organization-id $ORG_ID --format=json | ConvertFrom-Json
      $OrgGroups = yc organization-manager group list --organization-id $ORG_ID --format=json | ConvertFrom-Json
      $Clouds = yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | ConvertFrom-Json | Select @{n="CloudID";e={$_.id}}, created_at, @{n="CloudName";e={$_.name}}, organization_id

      $FolderBindings = @()

      foreach ($Cloud in $Clouds) {
        $Folders = yc resource-manager folder list --cloud-id $Cloud.CloudID --format=json | ConvertFrom-Json

        foreach($Folder in $Folders) {
          $FolderBindings += yc resource-manager folder list-access-bindings --id $Folder.id --format=json | ConvertFrom-Json | where {$_.role_id -eq "admin" -or $_.role_id -eq "editor"} | select role_id -ExpandProperty subject | Select @{n="CloudID";e={$Cloud.CloudID}},  @{n="CloudName";e={$Cloud.CloudName}}, @{n="FolderID";e={$Folder.id}}, @{n="FolderName";e={$Folder.name}}, @{n="FolderStatus";e={$Folder.status}}, @{n="UserID";e={$_.id}}, type, role_id 
        }
      }

      $Result = @()
      $Result += Join-Object -Left $($OrgUsers.subject_claims | Where-Object {$_.sub -in $FolderBindings.UserID}) -LeftJoinProperty sub -Right $FolderBindings -RightJoinProperty UserID -Type OnlyIfInBoth | Select CloudID, CloudName, FolderID, FolderName, FolderStatus, sub, name, email, sub_type, type, role_id

      if($OrgGroups | Where-Object {$_.id -in $FolderBindings.UserID}) {
          $Result += Join-Object -Left $($OrgGroups | Where-Object {$_.id -in $FolderBindings.UserID}) -LeftJoinProperty id -Right $FolderBindings -RightJoinProperty UserID -Type OnlyIfInBoth | Select CloudID, CloudName, FolderID, FolderName, FolderStatus, @{n="sub";e={$_.id}}, name, email, sub_type, type, role_id
      }

      $Result
      ```

      {% endcut %}

  1. Если все привилегированные роли назначены доверенным администраторам, то рекомендация выполняется. Если нет, то перейдите к п. <q>Инструкции и решения по выполнению</q>.

{% endlist %}

**Инструкции и решения по выполнению:**

Если обнаружены роли, которые назначены недоверенным администраторам, необходимо провести расследование и удалить лишние права.

### Локальные пользователи управляемых БД {#mdb-users} 

#### 1.18 Для локальных пользователей управляемых БД задан стойкий пароль {#mdb-auth}

Для работы с БД на прикладном уровне помимо сервисных IAM ролей создается отдельный локальный пользователь — владелец БД. В отношении него действует следующая парольная политика:

* пароль должен содержать цифры, буквы в верхнем регистре, буквы в нижнем регистре, специальные символы; 
* длина пароля — не менее 8 символов.

Также рекомендуется использовать сгенерированные пароли. В этом случае в сервисе [Yandex Lockbox](../../lockbox/index.md) будет создан [сгенерированный секрет](../../lockbox/concepts/secret.md#secret-type), значение которого будет являться паролем пользователя СУБД.

| ID требования | Критичность |
| --- | --- |
| IAM19 | Высокая |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Убедитесь, что пароль периодически ротируется в ручном режиме и соответствует парольным политикам вашей компании. Данный пароль хранится на стороне клиента и недоступен для просмотра в консоли управления, CLI и API.

{% endlist %}

### Доступ третьих лиц {#outstaff-access}

#### 1.19 Доступ для подрядных организаций и третьих лиц контролируется {#contractors}

Если вы предоставляете доступ к облакам внешним подрядным организациям, соблюдайте следующие меры безопасности:

* Назначайте права сотрудникам подрядных организаций с учетом принципа минимальных привилегий.
* По возможности создавайте отдельный аккаунт для сотрудников внешних организаций в вашем корпоративном IdP и назначайте ему необходимые политики.
* Предъявляйте требование по бережному обращению с секретами аккаунта.
* Перепроверяйте актуальность необходимости доступа внешних пользователей к вашей облачной инфраструктуре.
* Используйте роль [auditor](../../iam/roles-reference.md#auditor) без возможности доступа к данным везде, где это возможно.

| ID требования | Критичность |
| --- | --- |
| IAM20 | Высокая |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Проверьте все учетные записи в вашей организации и убедитесь, что вы знаете обо всех учетных записях подрядных организаций и третьих лиц и выполняете рекомендации выше.

{% endlist %}

### Ресурсная модель {#resource-framework}

#### 1.20 Используется корректная ресурсная модель {#resourses}

При разработке модели доступа для вашей инфраструктуры рекомендуется пользоваться принципом минимальных привилегий и принципом разделения ресурсов. Схематически ресурсную модель облака можно представить в виде вложенных друг в друга контейнеров: организация, облако, каталог.

[_Организация_](../../organization/concepts/organization.md) — корневой контейнер, содержащий информацию о пользователях, их ролях, а также некоторые сервисы (Yandex DataLens, Yandex DataSphere и т.д.) Роли уровня организации автоматически наследуется всеми низлежащими контейнерами. Поэтому рекомендуется выдавать роли на уровне организации только администраторам и пользователям сервисов уровня организации.

[_Облако_](../../resource-manager/concepts/resources-hierarchy.md#cloud) — контейнер под организацией, который содержит каталоги с сервисами. Облако логически объединяет несколько взаимосвязанных сред в его каталогах. Однако прямой связности между двумя облаками не предусмотрено. Роли, назначенные на уровне облака, наследуется всеми каталогами внутри него. Рекомендуется не выдавать слишком широкие привилегии на этом уровне.

[_Каталог_](../../resource-manager/concepts/resources-hierarchy.md#folder) — контейнер с ресурсами и сервисами. В рамках одного облака возможно организовывать сетевую связность между каталогами. Поэтому рекомендуется связанные сервисы и среды внутри инфраструктуры располагать в соседних каталогах.

При разработке модели доступа для вашей инфраструктуры рекомендуется использовать следующие подходы:

* Как минимум одна организация для компании (корневой контейнер, от которого роли пользователей наследуются на облака, каталоги и сервисы).
* Хорошей практикой является группировка ресурсов по проектам. Рекомендуется группировать ресурсы сервисов по назначению и помещать их в отдельные облака. Для наиболее строгой изоляции — в отдельные каталоги.
* Если над сервисами работают разные команды, имеет смысл разделить ресурсы этих команд в разные облака.
* Все критичные ресурсы помещайте в отдельные каталоги или облака. К критичным относятся в том числе ресурсы, которые связаны с обработкой платежных данных, персональных данных и данных, содержащих коммерческую тайну.
* Хорошая практика — не выдавать пользователям роли `.admin` на каталог с продуктовой средой. В этом случае рекомендуется использовать подход `GitOps` и управлять инфраструктурой каталога с помощью Terraform и GitLab.
* Группы ресурсов, которые требуют различного административного доступа например, DMZ, CDE, security, backoffice и т.д., поместите в разные каталоги или облака.
* При разработке приложений необходимо разделять тестовые и промышленные среды.
* Общие ресурсы (например, сеть и группы безопасности) поместите в отдельный каталог для разделяемых ресурсов (в случае разделения компонентов по каталогам).

| ID требования | Критичность |
| --- | --- |
| IAM21 | Высокая |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Проанализируйте вашу ресурсную модель и убедитесь, что рекомендации, указанные выше, выполняются.

{% endlist %}

#### 1.21 На ресурсах в организации отсутствует <q>публичный доступ</q> {#public-access}

В Yandex Cloud существует возможность предоставлять публичный доступ на ресурсы. Публичный доступ предоставляется путем назначения прав доступа для [публичных групп](../../iam/concepts/access-control/public-group.md) (`All authenticated users`, `All users`). 

Описание публичных групп:

* `All authenticated users` — все пользователи, прошедшие аутентификацию. Это все зарегистрированные пользователи или сервисные аккаунты Yandex Cloud: как из ваших облаков, так и из облаков других пользователей.
* `All users` — любой пользователь, аутентификация не требуется.

{% note warning %}

Сейчас `All users` поддерживается только в сервисах: Object Storage при управлении доступом с помощью ACL, Container Registry, Cloud Functions. В остальных сервисах назначение роли для группы `All users` эквивалентно назначению роли для `All authenticated users`.

{% endnote %}

Убедитесь, что к вашим ресурсам — облакам, каталогам, бакетам и т.д., не предоставлен публичный доступ для этих групп.

| ID требования | Критичность |
| --- | --- |
| IAM22 | Высокая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  Проверка ролей в облаке:

  1. Откройте консоль управления Yandex Cloud в вашем браузере.
  1. Далее перейдите в общее меню облака (нажать на облако в исходном меню облака). Выберите вкладку **Права доступа**.
  1. Проверьте, есть ли среди пользователей `All users` и `All authenticated users`.

  Проверка ролей в каталоге:

  1. Откройте консоль управления Yandex Cloud в вашем браузере.
  1. Перейдите в нужный каталог нужного облака и перейдите во вкладку **Права доступа**.
  1. Проверьте, есть ли среди пользователей `All users` и `All authenticated users`.
  1. Повторите действия для всех каталогов всех ваших облаков.

  Проверка ролей в Object Storage:

  1. Откройте консоль управления Yandex Cloud в вашем браузере.
  1. Перейдите в нужное облако и найдите сервис **Object Storage**.
  1. Нажмите на три точки напротив бакета и проверьте ACL бакета на наличие `allUsers`, `allAuthenticatedUsers`.
  1. Зайдите внутрь бакета и проверьте ACL на каждый объект бакета на наличие `allUsers`, `allAuthenticatedUsers`.
  1. Зайдите в глобальные настройки бакета и в разделе **Доступ на чтение объектов** проверьте, что параметр **Публичный** выключен.
  1. Повторите действия для всех бакетов и объектов во всех ваших облаках.

  Проверка ролей в Container Registry:

  1. Откройте консоль управления Yandex Cloud в вашем браузере.
  1. Далее перейдите в каждое облако и найдите сервис **Container Registry**.
  1. Перейдите в необходимый реестр и слева нажмите **Права доступа**.
  1. Проверьте, есть ли среди пользователей `All users` и `All authenticated users`.
  1. Повторите действия для всех ваших облаков.

  Проверка ролей в Cloud Functions:

  1. Откройте консоль управления Yandex Cloud в вашем браузере.
  1. Далее перейдите в каждое облако и найдите сервис **Cloud Functions**.
  1. Перейдите во все облачные функции и проверьте, что параметр **Публичный доступ** выключен.
  1. Если в каждом указанном ресурсе нет субъектов `All users` и `All authenticated users`, то рекомендация выполняется. Если есть, то перейдите к п. <q>Инструкции и решения по выполнению</q>.

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый ID:

      ```bash
      yc organization-manager organization list
      ```

  1. Выполните команду для поиска учетных записей с назначенными примитивными ролями на уровне организации:

      {% cut "**Bash**" %}

      ```bash
      export ORG_ID=<ID_организации>
      yc organization-manager organization list-access-bindings \
        --id=${ORG_ID} \
        --format=json | jq -r '.[] | select(.subject.id=="allAuthenticatedUsers" or .subject.id=="allUsers")'
      ```

      {% endcut %}

      {% cut "**PowerShell**" %}

      ```powershell
      $ORG_ID = "<ID_организации>"

      $OrgBindings = yc organization-manager organization list-access-bindings --id=$ORG_ID --format=json | ConvertFrom-Json | where {$_.subject.id -eq "allAuthenticatedUsers" -or $_.subject.id -eq "allUsers"} | select role_id -ExpandProperty subject

      $OrgBindings
      ```

      {% endcut %}

  1. Выполните команду для поиска прав доступа `allUsers`, `allAuthenticatedUsers` на уровне облаков:

      {% cut "**Bash**" %}

      ```bash
      export ORG_ID=<ID_организации>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do yc resource-manager cloud list-access-bindings --id=$CLOUD_ID --format=json | jq -r '.[] | select(.subject.id=="allAuthenticatedUsers" or .subject.id=="allUsers")' && echo $CLOUD_ID
      done
      ```

      {% endcut %}

      {% cut "**PowerShell**" %}

      ```powershell
      $ORG_ID = "<ID_организации>"

      $Clouds = yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | ConvertFrom-Json | Select @{n="CloudID";e={$_.id}}, created_at, @{n="CloudName";e={$_.name}}, organization_id

      $CloudBindings = @()
      foreach ($Cloud in $Clouds) {
        $CloudBindings += yc resource-manager cloud list-access-bindings --id $Cloud.CloudID --format=json | ConvertFrom-Json | where {$_.subject.id -eq "allAuthenticatedUsers" -or $_.subject.id -eq "allUsers"} | select role_id -ExpandProperty subject | Select @{n="CloudID";e={$Cloud.CloudID}},  @{n="CloudName";e={$Cloud.CloudName}}, @{n="PublicGroupID";e={$_.id}}, type, role_id
      }

      $CloudBindings
      ```

      {% endcut %}

  1. Выполните команду для поиска прав доступа `allUsers`, `allAuthenticatedUsers` на уровне каталогов:

      {% cut "**Bash**" %}

      ```bash
      export ORG_ID=<ID_организации>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do yc resource-manager folder list-access-bindings --id=$FOLDER_ID --format=json | jq -r '.[] | select(.subject.id=="allAuthenticatedUsers" or .subject.id=="allUsers")' && echo $FOLDER_ID
      done;
      done
      ```

      {% endcut %}

      {% cut "**PowerShell**" %}

      ```powershell
      $ORG_ID = "<ID_организации>"

      $Clouds = yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | ConvertFrom-Json | Select @{n="CloudID";e={$_.id}}, created_at, @{n="CloudName";e={$_.name}}, organization_id

      $FolderBindings = @()

      foreach ($Cloud in $Clouds) {
        $Folders = yc resource-manager folder list --cloud-id $Cloud.CloudID --format=json | ConvertFrom-Json

        foreach($Folder in $Folders) {
          $FolderBindings += yc resource-manager folder list-access-bindings --id $Folder.id --format=json | ConvertFrom-Json | where {$_.subject.id -eq "allAuthenticatedUsers" -or $_.subject.id -eq "allUsers"} | select role_id -ExpandProperty subject | Select @{n="CloudID";e={$Cloud.CloudID}},  @{n="CloudName";e={$Cloud.CloudName}}, @{n="FolderID";e={$Folder.id}}, @{n="FolderName";e={$Folder.name}}, @{n="FolderStatus";e={$Folder.status}}, @{n="PublicGroupID";e={$_.id}}, type, role_id 
        }
      }

      $FolderBindings
      ```

      {% endcut %}

  1. Выполните команду для поиска прав доступа `allUsers`, `allAuthenticatedUsers` на уровне Container Registry во всех каталогах:

      {% cut "**Bash**" %}

      ```bash
      export ORG_ID=<ID_организации>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do for CR in $(yc container registry list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id');
      do yc container registry list-access-bindings --id $CR --format=json | jq -r '.[] | select(.subject.id=="allAuthenticatedUsers" or .subject.id=="allUsers")' && echo $CR
      done;
      done;
      done
      ```

      {% endcut %}

      {% cut "**PowerShell**" %}

      ```powershell
      $ORG_ID = "<ID_организации>"

      $Clouds = yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | ConvertFrom-Json | Select @{n="CloudID";e={$_.id}}, created_at, @{n="CloudName";e={$_.name}}, organization_id

      $CRBindings = @()

      foreach ($Cloud in $Clouds) {
        $Folders = yc resource-manager folder list --cloud-id $Cloud.CloudID --format=json | ConvertFrom-Json

        foreach($Folder in $Folders) {

          $CRList = yc container registry list --folder-id=$Folder.id --format=json | ConvertFrom-Json

          foreach($CR in $CRList) {
              $CRBindings += yc container registry list-access-bindings --id $CR.id --folder-id $Folder.id --format=json | ConvertFrom-Json | where {$_.subject.id -eq "allAuthenticatedUsers" -or $_.subject.id -eq "allUsers"} | select role_id -ExpandProperty subject | Select @{n="CloudID";e={$Cloud.CloudID}},  @{n="CloudName";e={$Cloud.CloudName}}, @{n="FolderID";e={$Folder.id}}, @{n="FolderName";e={$Folder.name}}, @{n="FolderStatus";e={$Folder.status}}, @{n="PublicGroupID";e={$_.id}}, type, role_id 
          }
        }
      }

      $CRBindings
      ```

      {% endcut %}

  1. Выполните команду для поиска прав доступа `allUsers`, `allAuthenticatedUsers` на уровне Cloud Functions во всех каталогах:

      {% cut "**Bash**" %}

      ```bash
      export ORG_ID=<ID_организации>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do for FUN in $(yc serverless function list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); \
      do yc serverless function  list-access-bindings --id $FUN --format=json | jq -r '.[] | select(.subject.id=="allAuthenticatedUsers" or .subject.id=="allUsers")' && echo $FUN
      done;
      done;
      done
      ```

      {% endcut %}

      {% cut "**PowerShell**" %}

      ```powershell
      $ORG_ID = "<ID_организации>"

      $Clouds = yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | ConvertFrom-Json | Select @{n="CloudID";e={$_.id}}, created_at, @{n="CloudName";e={$_.name}}, organization_id

      $FunctionsBindings = @()

      foreach ($Cloud in $Clouds) {
        $Folders = yc resource-manager folder list --cloud-id $Cloud.CloudID --format=json | ConvertFrom-Json

        foreach($Folder in $Folders) {

          $FunctionsList = yc serverless function list --folder-id $Folder.id --format=json | ConvertFrom-Json

          foreach($Function in $FunctionsList) {
              $FunctionsBindings += yc serverless function  list-access-bindings --id $Function.id --folder-id $Folder.id --format=json | ConvertFrom-Json | where {$_.subject.id -eq "allAuthenticatedUsers" -or $_.subject.id -eq "allUsers"} | select role_id -ExpandProperty subject | Select @{n="CloudID";e={$Cloud.CloudID}},  @{n="CloudName";e={$Cloud.CloudName}}, @{n="FolderID";e={$Folder.id}}, @{n="FolderName";e={$Folder.name}}, @{n="FunctionID";e={$Function.id}}, @{n="FunctionName";e={$Function.name}}, @{n="FunctionStatus";e={$Function.status}}, @{n="PublicGroupID";e={$_.id}}, type, role_id 
          }
        }
      }

      $FunctionsBindings
      ```

      {% endcut %}

  1. Если в каждом указанном ресурсе отсутствуют субъекты: `allUsers`, `allAuthenticatedUsers` то рекомендация выполняется. Если нет, то перейдите к п. <q>Инструкции и решения по выполнению</q>.

{% endlist %}

**Инструкции и решения по выполнению:**

Если обнаружено наличие прав доступа у `All users`, `All authenticated users`, необходимо удалить данные права.

#### 1.22 Контактные данные ответственного за организацию актуальны {#org-contacts}

В Yandex Cloud при регистрации облака клиент указывает контактные данные. Например, электронная почта используется для оповещений, связанных с инцидентами, плановыми работами и т.д.

Например, если со стороны облака были обнаружены аномальные активности в организации клиента или облачные ключи IAM становятся доступными во внешних репозиториях GitHub, клиенту будет направлено оповещение. Эта возможность реализована с помощью участия Yandex Cloud в программе [Github Secret scanning partner program](https://docs.github.com/en/developers/overview/secret-scanning-partner-program), а также анализа секретов в поиске Яндекса. В случае компрометации ключей в публичном репозитории, удалите секрет из репозитория, его [истории](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/removing-sensitive-data-from-a-repository) и отзовите [ключи](../../iam/operations/compromised-credentials.md).

Убедитесь, что контактные данные актуальны и указанный почтовый ящик рассылает сообщения нескольким ответственным.

| ID требования | Критичность |
| --- | --- |
| IAM23 | Информационная |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. Откройте консоль управления Yandex Cloud в вашем браузере.
  1. Перейдите в сервис [Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts).
  1. Перейдите во вкладку **Данные аккаунта**.
  1. В самом низу будет кнопка **Редактировать данные в Яндекс Балансе**.
  1. Проверьте указанные контактные данные.
  1. Если указанные данные актуальны, то рекомендация выполняется. Если нет, то перейдите к п. <q>Инструкции и решения по выполнению</q>.

{% endlist %}

**Инструкции и решения по выполнению:**

Укажите актуальные контактные данные по [инструкции](../../billing/operations/change-data.md#change-address).

#### 1.23 На ресурсах используются метки {#labels}

Для отслеживания потоков данных и обозначения критичности ресурсов для управления привилегиями необходимо использование [меток](../../resource-manager/concepts/labels.md).
Например, для тегирования ресурсов, которые обрабатывают персональные данные в рамках Федерального закона Российской Федерации «О персональных данных» № 152-ФЗ нужно выбрать метку `152-fz:true` для:

* каталога;
* [бакета](../../storage/concepts/bucket.md) Yandex Object Storage;
* [секрета](../../lockbox/concepts/secret.md) Yandex Lockbox;
* кластеров управляемых баз данных.

| ID требования | Критичность |
| --- | --- |
| IAM24 | Информационная |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  В примере ниже показана проверка наличия метки к облачной сети [Yandex Virtual Private Cloud](../../vpc/index.md). Аналогично вы можете проверить наличие метки у другого ресурса.

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. Выберите сервис **Virtual Private Cloud**.
  1. Проверьте наличие меток.

{% endlist %}

**Инструкции и решения по выполнению:**

[Инструкция по управлению метками](../../resource-manager/operations/manage-labels.md).

### Уведомления и аудит {#notifications-and-audit}

#### 1.24 Уведомления безопасности Yandex Cloud включены {#security-notifications}

Для получения уведомлений о событиях в области безопасности, например, обнаруженных уязвимостях и их устранении, рекомендуется выбрать уведомления безопасности в настройках консоли управления.

| ID требования | Критичность |
| --- | --- |
| IAM25 | Высокая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) нажмите [**Настройки**](https://console.yandex.cloud/settings).
  1. Выберите раздел **Уведомления**.
  1. В настройках уведомлений включите опцию **Безопасность**.

{% endlist %}

**Инструкции и решения по выполнению:**

1. [Убедитесь](../../resource-manager/concepts/notify.md), что уведомления настроены.
1. Включите опцию **Безопасность** в настройках уведомлений консоли управления.

#### 1.25 Отслеживается дата последней аутентификации сервисного аккаунта и последнего использования ключей доступа в Yandex Identity and Access Management {#key-usage-control}

В [консоли управления](https://console.yandex.cloud) на странице с информацией о сервисном аккаунте отображаются дата и время его последней аутентификации. Эта информация позволяет отслеживать случаи несанкционированного использования сервисных аккаунтов.

Чтобы обеспечивать безопасность и контроль над доступом к ресурсам, отслеживать случаи несанкционированного использования ключей, а также удалять неиспользуемые ключи без риска нарушить работу сервисов Yandex Cloud, вы можете отслеживать даты последнего использования ключей доступа сервисных аккаунтов. Информация доступна на странице сервисного аккаунта в [консоли управления](https://console.yandex.cloud), а также в поле `last_used_at` при вызове методов управления ключами доступа через API.

Подробнее см. в разделе [Ключи сервисного аккаунта](../../iam/concepts/users/service-accounts.md#sa-key).

| ID требования | Критичность |
| --- | --- |
| IAM26 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, которому принадлежит сервисный аккаунт с ключами доступа.
  1. В списке сервисов выберите **Identity and Access Management**.
  1. На панели слева выберите ![FaceRobot](../../_assets/console-icons/face-robot.svg) **Сервисные аккаунты**.
  1. В открывшемся списке выберите нужный сервисный аккаунт.
  1. Данные о времени последнего использования ключа доступны в таблице с информацией о ключах в поле **Дата последнего использования**.

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый ID:

      ```bash
      yc organization-manager organization list
      ```

  1. Выполните команду для отображения дат последней аутентификации сервисных аккаунтов и последнего использования ключей доступа:

      {% cut "**Bash**" %}

      ```bash
      export ORG_ID=<ID_организации>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do for SA in $(yc iam service-account list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id');
      do yc iam key list --service-account-id=$SA --format=json | jq -r '.[] | "key_id" + ":" + .id + "," + "sa_id" + ":" + .service_account_id + "," + "created_at" + ":" + .created_at + "last_used_at" + ":" + .last_used_at' 
      done;
      done;
      done
      ```

      {% endcut %}

      {% cut "**PowerShell**" %}

      ```powershell
      $ORG_ID = "<ID_организации>"
      $SAList = (yc organization-manager users list --organization-id $ORG_ID --format=json | ConvertFrom-Json | where {$_.subject_claims.sub_type -eq "SERVICE_ACCOUNT"}).subject_claims

      $AllAuthKeys = @()

      foreach($SA in $SAList) {
        $AuthKeys = yc iam key list --service-account-id $SA.sub --format=json | ConvertFrom-Json

        if($AuthKeys) {
          $ExpiriedKeys = $AuthKeys | where {($(Get-Date) - $_.created_at).Days -gt 90} | Select @{n="AuthKeyID";e={$_.id}}, service_account_id, created_at, @{n="KeyStatus";e={"EXPIRIED"}}, key_algorithm, last_used_at
          $ActualKeys = $AuthKeys | where {($(Get-Date) - $_.created_at).Days -le 90} | Select @{n="AuthKeyID";e={$_.id}}, service_account_id, created_at, @{n="KeyStatus";e={"VALID"}}, key_algorithm, last_used_at

          if($ExpiriedKeys) {
            $AllAuthKeys += Join-Object -Left $($SAList | Where-Object {$_.sub -in $ExpiriedKeys.service_account_id}) -LeftJoinProperty sub -Right $ExpiriedKeys -RightJoinProperty service_account_id -Type OnlyIfInBoth | Select @{n="service_account_id";e={$_.sub}}, name, sub_type, AuthKeyID, description, created_at, KeyStatus, key_algorithm, last_used_at
          }

          if($ActualKeys) {
            $AllAuthKeys += Join-Object -Left $($SAList | Where-Object {$_.sub -in $ActualKeys.service_account_id}) -LeftJoinProperty sub -Right $ActualKeys -RightJoinProperty service_account_id -Type OnlyIfInBoth | Select @{n="service_account_id";e={$_.sub}}, name, sub_type, AuthKeyID, description, created_at, KeyStatus, key_algorithm, last_used_at
          }
        }
      }

      $AllAuthKeys
      ```

      {% endcut %}

{% endlist %}

#### 1.26 Регулярно проводится аудит прав доступа пользователей и сервисных аккаунтов с использованием Yandex Security Deck CIEM {#ciem-access-control}

В целях обеспечения безопасности данных и облачной инфраструктуры необходимо регулярно проводить аудит прав доступа, имеющихся у пользователей и сервисных аккаунтов.

[Модуль диагностики доступов](https://center.yandex.cloud/security/iam-diagnostics/) или CIEM (CIEM) — это инструмент, позволяющий централизованно просматривать полный список доступов [субъектов](../../iam/concepts/access-control/index.md#subject): пользователей, сервисных аккаунтов, [групп пользователей](../../organization/concepts/groups.md), [системных групп](../../iam/concepts/access-control/system-group.md) и [публичных групп](../../iam/concepts/access-control/public-group.md) к [ресурсам](../../iam/concepts/access-control/resources-with-access-control.md) организации. Этот инструмент также позволяет легко отзывать у субъектов лишние доступы.

Подробнее см. в разделе [Модуль диагностики доступов (CIEM)](../../security-deck/concepts/ciem.md).

| ID требования | Критичность |
| --- | --- |
| IAM27 | Информационная |

**Инструкции и решения по выполнению:**

[Просмотреть список доступов субъекта](../../security-deck/operations/ciem/view-permissions.md).
[Отозвать доступ у субъекта](../../security-deck/operations/ciem/revoke-permissions.md).

# Требования к сетевой безопасности

## 2. Сетевая безопасность {#network-security}


В этом разделе представлены рекомендации пользователям по настройкам безопасности в [Yandex Virtual Private Cloud](../../vpc/index.md).


Подробно о том, как настроить сетевую инфраструктуру, рассказывается в вебинаре [Как работает сеть в Yandex Cloud](https://www.youtube.com/watch?v=g3cZ0o50qH0).


Чтобы изолировать приложения друг от друга, поместите ресурсы в разные [группы безопасности](../../vpc/concepts/security-groups.md), а если требуется наиболее строгая изоляция — в разные [сети](../../vpc/concepts/network.md#network). Трафик внутри сети по умолчанию разрешен, а между сетями — нет. Трафик между сетями можно передавать только через [виртуальную машину](../../compute/concepts/vm.md) с двумя сетевыми интерфейсами в разных сетях, [VPN](../../glossary/vpn.md) или сервис [Yandex Cloud Interconnect](../../interconnect/index.md).

### Общее {#general}

#### 2.1 Для объектов облака используется межсетевой экран или группы безопасности {#firewall}

Встроенный механизм групп безопасности позволяет управлять доступом ВМ к ресурсам и группами безопасности Yandex Cloud или ресурсам в интернете. Группа безопасности — это набор правил для входящего и исходящего трафика, который можно назначить на сетевой интерфейс ВМ. Группы безопасности работают как stateful firewall, то есть отслеживают состояние сессий: если правило разрешает создать сессию, ответный трафик будет автоматически разрешен. Инструкцию по настройке групп безопасности см. в разделе [Создать группу безопасности](../../vpc/operations/security-group-create.md). Указать группу безопасности можно в настройках ВМ.

Группы безопасности могут использоваться для защиты:
* ВМ.
* [Управляемых баз данных](https://yandex.cloud/ru/services#data-platform).
* [Балансировщиков нагрузки](../../application-load-balancer/concepts/application-load-balancer.md) [Yandex Application Load Balancer](../../application-load-balancer/index.md).
* [Кластеров](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) [Yandex Managed Service for Kubernetes](../../managed-kubernetes/index.md).

Список доступных сервисов расширяется.

Вы можете управлять сетевым доступом без групп безопасности, например, с помощью отдельной ВМ — межсетевой экран на основе образа [NGFW](https://yandex.cloud/ru/marketplace/products/usergate/ngfw) из Yandex Cloud Marketplace, либо своего собственного образа. Использование NGFW может быть критично для тех клиентов, которым необходима следующая функциональность:
* Составление логов сетевых соединений.
* Потоковый анализ трафика на предмет зловредного контента.
* Обнаружение сетевых атак по сигнатурам.
* Другая функциональность классических NGFW-решений.

Убедитесь, что в ваших [облаках](../../resource-manager/concepts/resources-hierarchy.md#cloud) используется что-либо из списка:

* Группы безопасности на каждом объекте облака.
* Отдельная ВМ NGFW из Cloud Marketplace.
* Принцип [BYOI](https://en.wikipedia.org/wiki/Bring_your_own_operating_system), например: [собственный образ](../../compute/operations/image-create/upload.md) диска.

| ID требования | Критичность |
| --- | --- |
| NET1 | Высокая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  Проверка наличия групп безопасности на объектах:
  1. Откройте [консоль управления Yandex Cloud](https://console.yandex.cloud) в вашем браузере.
  1. Перейдите в каждое облако и в каждый [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) и последовательно открывайте все перечисленные ресурсы в пункте «Объекты, на которые возможно применить группы безопасности».
  1. В настройках объектов найдите параметр **Группа безопасности** и убедитесь, что назначена хотя бы одна группа безопасности.
  1. Если в параметрах каждого объекта, который поддерживает группы безопасности указана хотя бы одна группа, рекомендация выполняется. Если нет, перейдите к пункту «Инструкции и решения по выполнению».

  Проверка наличия NGFW вместо групп безопасности:
  1. Откройте консоль управления Yandex Cloud в вашем браузере.
  1. Перейдите в каждое облако и в каждый каталог и последовательно откройте все [диски](../../compute/concepts/vm.md) ВМ.
  1. В настройках дисков найдите параметр **Продукт Marketplace**.
  1. Если в параметрах **Продукт Marketplace** в диске указано одно из названий продуктов NGFW: Check Point CloudGuard IaaS — Firewall & Threat Prevention PAYG, UserGate NGFW, рекомендация выполняется. Если нет, перейдите к пункту «Инструкции и решения по выполнению».

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый `ID`:

     ```bash
     yc organization-manager organization list
     ```

  1. Выполните команду для поиска объектов облака без группы безопасности:

     ```bash
     export ORG_ID=<ID организации>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do for VM_ID in $(yc compute instance list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); do yc compute instance get --id=$VM_ID --format=json | jq -r '. | select(.network_interfaces[].security_group_ids | not)' | jq -r '.id'
     done;
     done;
     done
     ```

  1. Если выдается пустая строка, рекомендация выполняется. Если выдается результат с `ID` облачного ресурса, перейдите к пункту «Инструкции и решения по выполнению».

  Проверка наличия NGFW вместо группы безопасности:
  1. Выполните команду для поиска NGFW в облаке. По умолчанию команда ищет Checkpoint или Usergate. Если используете свой образ, укажите его.

     ```bash
     export ORG_ID=<ID организации>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id');
     do for DISK_ID in $(yc compute disk list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); do yc compute disk get --id=$DISK_ID --format=json | jq -r '. | select(.product_ids[0]=="f2ecl4ak62mjbl13qj5f" or .product_ids[0]=="f2eqc5sac8o5oic7m99k")' | jq -r '.id'
     done;
     done;
     done
     ```

  1. Если выдается `ID` ВМ с NGFW, рекомендация выполняется. Если выдается пустая строка, перейдите к пункту «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению:**
* Примените группы безопасности на все объекты, на которых группа отсутствует.
* Для применения группы безопасности с помощью Terraform используйте [настройку групп безопасности (dev/stage/prod) с помощью Terraform](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/network-sec/segmentation).
* Для использования NGFW [установите](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/network-sec/checkpoint-1VM) на ВМ межсетевой экран (NGFW): Check Point.
* [Инструкция](https://docs.google.com/document/d/1yYwHorzkwXwIUGeG3n_K6Zo-07BVYowZJL7q2bAgVR8/edit?usp=sharing) по использованию UserGate NGFW в облаке.
* NGFW в режиме [active-passive](https://github.com/yandex-cloud/yc-solution-library-for-security/blob/master/network-sec/checkpoint-2VM_active-active/README.md).

#### 2.2 В Virtual Private Cloud создана группа безопасности и не используется группа безопасности по умолчанию {#vpc-sg}

*Группа безопасности* (Security Group, SG) — это ресурс, который создается на уровне [облачной сети](../../vpc/concepts/network.md#network). После создания [группа безопасности](../../vpc/concepts/security-groups.md) может использоваться в [сервисах](../../vpc/concepts/security-groups.md#security-groups-apply) Yandex Cloud для разграничения сетевого доступа объекта, к которому она применяется.

*Группа безопасности по умолчанию* (Default Security Group, DSG) создается автоматически при создании [новой облачной сети](../../vpc/concepts/network.md#network). Группа безопасности по умолчанию обладает следующими свойствами:

* В новой сети будет разрешать весь сетевой трафик в обоих направлениях — исходящий (egress) и входящий (ingress).
* Действует для трафика, проходящего через все подсети в сети, где она создана.
* Работает лишь в том случае, если на объект еще явно не назначена группа безопасности.
* Ее невозможно удалить, она автоматически удаляется вместе с удалением сети.

Группа безопасности по умолчанию — это удобный, но небезопасный механизм, который автоматически разрешает весь сетевой трафик (входящий и исходящий) для объектов в вашей сети. Хотя это упрощает начальную настройку, такая открытость создает серьезные риски:

* Злоумышленники могут получить доступ к ресурсам через публичные интерфейсы.
* Неконтролируемый трафик повышает уязвимость к DDoS-атакам и сканированию портов.
* DSG активна только до тех пор, пока вы не назначите объекту другую группу безопасности.

Рекомендуем [создать](../../vpc/operations/security-group-create.md) собственную группу безопасности с [правилами](../../vpc/concepts/security-groups.md#security-groups-rules), которые явно разрешают только нужный трафик (например, `HTTP/HTTPS` для веб-серверов или `SSH` для администрирования), и назначить созданную группу на облачные [объекты](../../vpc/concepts/security-groups.md#security-groups-apply) ([виртуальные машины](../../compute/concepts/vm.md), [кластеры Kubernetes](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) и т.д.), чтобы переопределить DSG.

Это важно, потому что без ваших правил облачные ресурсы остаются открытыми для любых подключений из интернета, а собственные группы безопасности позволяют реализовать [принцип минимальных привилегий](../../iam/best-practices/using-iam-securely.md#restrict-access), снижая поверхность атак.

Группы безопасности можно комбинировать — на один объект можно назначить до пяти групп, что делает процесс разграничения доступа более гибким.

| ID требования | Критичность |
| --- | --- |
| NET2 | Высокая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. Откройте консоль Yandex Cloud в вашем браузере.
  1. Перейдите в каждое облако, далее в каждый каталог и в каждую Virtual Private Cloud.
  1. Перейдите в раздел **Группы безопасности**.
  1. Если для каждой сети Virtual Private Cloud обнаружена как минимум одна группа безопасности в дополнение к группе безопасности по умолчанию, рекомендация выполняется. Если нет, перейдите к пункту «Инструкции и решения по выполнению».

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый `ID`:

     ```bash
     yc organization-manager organization list
     ```

  1. Выполните команду для поиска каталогов без группы безопасности:

     ```bash
     export ORG_ID=<ID организации>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); \
     do echo "SG_ID: " && yc vpc security-group list --folder-id=$FOLDER_ID --format=json | jq -r '.[] | select(.id)' | jq -r '.id' && echo "FOLDER_ID: " $FOLDER_ID && echo "-----"
     done;
     done
     ```

  1. Если у каждого сочетания `SG_ID` напротив `FOLDER_ID`, в которой она находится, указаны `ID`, рекомендация выполняется. Если нет, перейдите к пункту «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению:**

Создайте группу безопасности в каждой Virtual Private Cloud с ограниченными правилами доступа, чтобы ее можно было назначать на облачные объекты.

#### 2.3 В группах безопасности отсутствует слишком широкое правило доступа {#access-rule}

В группе безопасности существует возможность открыть сетевой доступ для абсолютно всех IP-адресов интернета и также по всем диапазонам портов. Опасное правило выглядит следующим образом:
* Диапазон портов: 0-65535 или пусто.
* Протокол: любой или TCP/UDP.
* Источник: CIDR.
* CIDR блоки: 0.0.0.0/0 (доступ со всех адресов) или ::/0 (ipv6).

{% note warning %}

Если диапазон портов не указан, считается, что доступ предоставляется по всем портам (0-65535).

{% endnote %}

Открывать сетевой доступ необходимо только по тем портам, которые требуются для работы вашего приложения, и для тех адресов, с которых необходимо подключаться к вашим объектам.

| ID требования | Критичность |
| --- | --- |
| NET3 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. Откройте консоль Yandex Cloud в вашем браузере.
  1. Перейдите в каждое облако, далее в каждый каталог и в каждую Virtual Private Cloud.
  1. Перейдите в раздел **Группы безопасности**.
  1. Если не обнаружено ни одной группы безопасности, в которой есть правила сетевого доступа, разрешающие доступ по всем портам для всех адресов (интерпретация указана выше), рекомендация выполняется. Если нет, то перейдите к пункту «Инструкции и решения по выполнению».

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый `ID`:

     ```bash
     yc organization-manager organization list
     ```

  1. Найдите группы безопасности с опасным правилом доступа:

     ```bash
     export ORG_ID=<ID организации>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); \
     do echo "SG_ID: " && yc vpc security-group list --folder-id=$FOLDER_ID \
     --format=json | jq -r '.[] | select(.rules[].direction=="INGRESS" and .rules[].ports.to_port=="65535" and .rules[].cidr_blocks.v4_cidr_blocks[]=="0.0.0.0/0")' | jq -r '.id' \
     && echo "FOLDER_ID: " $FOLDER_ID && echo "-----"
     done;
     done
     ```

  1. Если `SG_ID` напротив `FOLDER_ID` указано пустое значение, рекомендация выполняется. Если вы видите не пустое `SG_ID`, перейдите к пункту «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению:**

Удалите опасное правило в каждой группе безопасности или отредактируйте, указав доверенные IP-адреса.

#### 2.4 Доступ по управляющим портам открыт только для доверенных IP-адресов {#trusted-ip}

Рекомендуется открывать доступ к вашей облачной инфраструктуре по управляющим портам только с доверенных IP-адресов. Убедитесь, что в ваших правилах доступа в рамках группы безопасности отсутствуют широкие правила доступа по управляющим портам:
* Диапазон портов: 22, 3389 или 21.
* Протокол: TCP.
* Источник: CIDR.
* CIDR блоки: 0.0.0.0/0 (доступ со всех адресов) или ::/0 (ipv6).

| ID требования | Критичность |
| --- | --- |
| NET4 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. Откройте консоль Yandex Cloud в вашем браузере.
  1. Перейдите в каждое облако, далее в каждый каталог и в каждую Virtual Private Cloud.
  1. Перейдите в раздел **Группы безопасности**.
  1. Если не обнаружено ни одной группы безопасности, в которой есть правила сетевого доступа, разрешающие доступ по управляющим портам для всех адресов (интерпретация указана выше), рекомендация выполняется. Если нет, перейдите к пункту «Инструкции и решения по выполнению».

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый `ID`:

     ```bash
     yc organization-manager organization list
     ```

  1. Выполните команду для поиска групп безопасности с опасным правилом доступа:

     ```bash
     export ORG_ID=<ID организации>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); \
     do echo "SG_ID: " && yc vpc security-group list --folder-id=$FOLDER_ID \
     --format=json | jq -r '.[] | select(.rules[].direction=="INGRESS" and (.rules[].ports.to_port=="22" or .rules[].ports.to_port=="3389" or .rules[].ports.to_port=="21") and .rules[].cidr_blocks.v4_cidr_blocks[]=="0.0.0.0/0")' | jq -r '.id' \
     && echo "FOLDER_ID: " $FOLDER_ID && echo "-----"
     done;
     done
     ```

  1. Если `SG_ID` напротив `FOLDER_ID` указано пустое значение, рекомендация выполняется. Если `SG_ID` не пустое, перейдите к пункту «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению:**

[Удалите](../../cli/cli-ref/vpc/cli-ref/security-group/index.md) опасное правило в каждой группе безопасности или укажите доверенные IP-адреса.

#### 2.5 Включена защита от DDoS-атак {#ddos-protection}

В Yandex Cloud существует базовая и расширенная защита от DDoS-атак, а также защита на прикладном уровне с помощью сервиса Yandex Smart Web Security. Необходимо убедиться, что у вас используется как минимум базовая защита.

* [Yandex Smart Web Security](../../smartwebsecurity/quickstart.md) — сервис для защиты от [DDoS-атак](../../glossary/ddos.md) и ботов на прикладном уровне L7 [сетевой модели OSI](https://ru.wikipedia.org/wiki/Сетевая_модель_OSI). Smart Web Security [подключается](../../smartwebsecurity/quickstart.md) к Yandex Application Load Balancer. Функциональность сервиса сводится к проверке HTTP-запросов к защищаемому ресурсу на соответствие [правилам](../../smartwebsecurity/concepts/rules.md), заданным в [профиле безопасности](../../smartwebsecurity/concepts/profiles.md). В зависимости от результатов проверки запросы пропускаются на защищаемый ресурс, блокируются или отправляются в сервис [Yandex SmartCaptcha](../../smartcaptcha/index.md) для дополнительной верификации.
* [Yandex DDoS Protection](../../vpc/ddos-protection/index.md) — это компонент сервиса Virtual Private Cloud для защиты облачных ресурсов от DDoS-атак. DDoS Protection предоставляется в партнерстве с Curator. Вы можете включать ее самостоятельно на внешний [IP-адрес](../../vpc/concepts/address.md) через инструменты управления облаком. Работает до L4 уровня модели OSI.
* [Расширенная](https://yandex.cloud/ru/services/ddos-protection) защита от DDoS-атак — работает на 3, 4 и 7 уровнях модели OSI. Вы также можете отслеживать показатели нагрузки, параметры атак и подключить Solidwall WAF в личном кабинете Curator. Чтобы включить расширенную защиту, обратитесь к вашему менеджеру или в техническую поддержку.

| ID требования | Критичность |
| --- | --- |
| NET5 | Высокая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  * Чтобы убедиться, что у вас используется защита от DDoS-атак на прикладном уровне:

      1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите проверить статус Smart Web Security.
      1. В списке сервисов выберите **Smart Web Security**.
      1. На панели слева выберите ![shield-check](../../_assets/console-icons/shield-check.svg) **Профили безопасности**.
      1. Убедитесь, что у вас есть созданные профили безопасности.
      1. Если профили безопасности есть, рекомендация выполняется. Если нет, перейдите к пункту «Инструкции и решения по выполнению».

  * Чтобы убедиться, что у вас используется базовая защита от DDoS-атак:

      1. В [консоли управления](https://console.yandex.cloud) откройте все созданные сети.
      1. Перейдите в раздел **IP-адреса**.
      1. Если у всех публичных адресов в столбце **Защита от DDoS-атак** установлено значение **Включена**, рекомендация выполняется. Если нет, перейдите к пункту «Инструкции и решения по выполнению».

- Ручная проверка {#manual}

  Чтобы убедиться, что у вас подключена расширенная защита от DDoS-атак, обратитесь к вашему персональному менеджеру. 

- Проверка через CLI {#cli}

  * Чтобы убедиться, что у вас используется защита от DDoS-атак на прикладном уровне, выполните команду:

      ```bash
      yc smartwebsecurity security-profile list
      ```

      Если команда вернет информацию об имеющихся профилях безопасности, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

  * Чтобы убедиться, что у вас используется базовая защита от DDoS-атак:

      1. Посмотрите доступные вам организации и зафиксируйте необходимый `ID`:

           ```bash
           yc organization-manager organization list
           ```

      1. Выполните команду для поиска IP-адресов без защиты от DDoS:

           ```bash
           export ORG_ID=<ID организации>
           for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
           do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); \
           do echo "Address_ID: " && yc vpc address list --folder-id=$FOLDER_ID \
           --format=json | jq -r '.[] | select(.external_ipv4_address.requirements.ddos_protection_provider=="qrator" | not)' | jq -r '.id' \
           && echo "FOLDER_ID: " $FOLDER_ID && echo "-----"
           done;
           done
           ```

      1. Если `Address_ID` напротив `FOLDER_ID` указано пустое значение, рекомендация выполняется. В противном случае перейдите к пункту «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению:**

* [Инструкция по созданию профиля безопасности Smart Web Security](../../smartwebsecurity/operations/profile-create.md).
* Вебинар [Защита от DDoS в Yandex Cloud](https://youtu.be/KWGbLQTth5U).
* Все [материалы](../../vpc/ddos-protection/index.md) по защите от DDoS в Yandex Cloud.

#### 2.6 Используется защищенный удаленный доступ {#secure-access}

Чтобы обеспечить удаленное подключение администраторов к облачным ресурсам, используйте одно из следующих решений:
* Site-to-site VPN между удаленной площадкой (например, вашим офисом) и облаком. В качестве шлюза для удаленного доступа используйте ВМ с функцией site-to-site VPN на основе [образа](https://yandex.cloud/ru/marketplace?categories=network) из Cloud Marketplace.

  **Варианты настройки**:
  * [Создание туннеля IPSec VPN с использованием демона strongSwan](../../tutorials/routing/ipsec/index.md).
  * [Создание site-to-site VPN-соединения с Yandex Cloud с помощью Terraform](https://github.com/yandex-cloud-examples/yc-site-to-site-vpn-with-ipsec-strongswan).
  * Client VPN между удаленными устройствами и Yandex Cloud. В качестве шлюза для удаленного доступа используйте ВМ с функцией client VPN на основе [образа](https://yandex.cloud/ru/marketplace?categories=network) из Cloud Marketplace.

  См. инструкцию в разделе [Создание VPN-соединения с помощью OpenVPN](../../tutorials/routing/openvpn.md). Возможно также использование сертифицированных СКЗИ.
* Приватное выделенное соединение между удаленной площадкой и Yandex Cloud c помощью сервиса Cloud Interconnect.

Для доступа в инфраструктуру по управляющим протоколам (например, SSH, RDP) рекомендуется создать бастионную ВМ. Для этого можно использовать бесплатное решение [Teleport](https://goteleport.com/). Доступ к бастионной ВМ или VPN-шлюзу из интернета должен быть ограничен.

Для дополнительного контроля действий администраторов рекомендуется использовать решения PAM (Privileged Access Management) с записью сессии администратора (например, Teleport). Для доступа по SSH и VPN рекомендуется отказаться от паролей и вместо этого использовать открытые ключи, X.509-сертификаты и SSH-сертификаты. При настройке SSH для ВМ рекомендуется использовать SSH-сертификаты, в том числе и для хостовой части SSH.

Для доступа к веб-сервисам, развернутым в облаке, рекомендуется использовать TLS версий 1.2 и выше.

| ID требования | Критичность |
| --- | --- |
| NET6 | Высокая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. Откройте консоль Yandex Cloud в вашем браузере.
  1. Откройте все созданные сети.
  1. Перейдите в раздел **Таблицы маршрутизации**.
  1. Если найдены маршруты в приватные сети удаленных площадок, которые направлены через ВМ с VPN шлюзом, рекомендация выполняется.
  1. Проверьте ВМ в каждом облаке на наличие VPN-шлюзов. Также проверьте у назначенных им групп безопасности открытые порты для VPN.

- Ручная проверка {#manual}

  Обратитесь к вашему персональному менеджеру и уточните, подключен ли у вас сервис Cloud Interconnect. Если подключен, проверьте, выполняется ли удаленный доступ.

{% endlist %}

#### 2.7 Для обеспечения удаленного доступа сотрудники используют Yandex Cloud Desktop {#use-cloud-desktop}

Yandex Cloud Desktop — сервис для управления виртуальной инфраструктурой [рабочих столов](../../cloud-desktop/concepts/desktops-and-groups.md).

С помощью сервиса вы можете:

* быстро создавать виртуальные рабочие места для новых сотрудников;
* безопасно подключать сотрудников, работающих удаленно, к корпоративной сети;
* предоставлять сотрудникам возможность работать с любого современного устройства, имеющего доступ в интернет, в том числе личного ([BYOD](https://ru.wikipedia.org/wiki/Bring_your_own_device));
* управлять вычислительными ресурсами рабочих столов;
* удаленно администрировать рабочие столы;
* создавать группы рабочих столов с одинаковыми вычислительными ресурсами и [облачной сетью](../../vpc/concepts/network.md).

| ID требования | Критичность |
| --- | --- |
| NET7 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы хотите проверить наличие [рабочих столов](../../cloud-desktop/concepts/desktops-and-groups.md).
  1. В списке сервисов выберите **Cloud Desktop**.
  1. На панели слева выберите ![image](../../_assets/console-icons/display.svg) **Рабочие столы**.
  1. Если в списке есть хотя бы один созданный рабочий стол, то рекомендация выполняется. В противном случае, переходите к п. «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению:**

1. [Создайте группу рабочих столов](../../cloud-desktop/operations/desktop-groups/create.md).
1. Если у вас есть специфичные требования к настройке операционной системы, вы можете использовать свой собственный образ ОС, воспользовавшись инструкцией [Создать образ на основе ВМ Linux Compute Cloud](../../cloud-desktop/operations/images/create-from-compute-linux.md), или [создать](../../cloud-desktop/operations/images/create-from-desktop.md) образ на основе существующего рабочего стола и переиспользовать его для группы.
1. После создания рабочей группы администратор может [создать](../../cloud-desktop/operations/desktops/create.md) нужное количество рабочих столов и самостоятельно назначить на них пользователей. Либо пользователи, входящие в группу рабочих столов, могут воспользоваться [витриной пользовательских рабочих столов](../../cloud-desktop/concepts/showcase.md) и получить рабочий стол самостоятельно.

#### 2.8 Для удаленного доступа к Cloud Desktop используется Безопасный Яндекс Браузер {#use-yandex-browser}

Сотрудникам, работающим удаленно через Cloud Desktop, для доступа к корпоративным ресурсам рекомендуется использовать [Безопасный Яндекс Браузер](https://browser.yandex.ru/corp). Это требование направлено на обеспечение безопасности данных, защиту от [фишинга](https://ru.wikipedia.org/wiki/Фишинг), вредоносных сайтов и утечек информации. Браузер предоставляет встроенные инструменты для шифрования трафика, блокировки опасных ресурсов и интеграции с корпоративными системами аутентификации.

| ID требования | Критичность |
| --- | --- |
| NET9 | Низкая |

#### 2.9 Исходящий доступ в интернет контролируется {#outgoing-access}

Возможные варианты организации исходящего доступа в интернет:
* [Публичный IP-адрес](../../vpc/concepts/address.md#public-addresses). Адрес назначается ВМ по принципу one-to-one NAT.
* [Egress NAT (NAT-шлюз)](../../vpc/operations/create-nat-gateway.md). Включает доступ в интернет для подсети через общий пул публичных адресов Yandex Cloud. Не рекомендуется использовать Egress NAT для критичных взаимодействий, так как IP-адрес NAT-шлюза может использоваться несколькими клиентами одновременно. Следует учитывать эту особенность при моделировании угроз для инфраструктуры.
* [NAT-инстанс](../../tutorials/routing/nat-instance/index.md). Функцию NAT выполняет отдельная ВМ. Для создания такой ВМ можно использовать образ [NAT-инстанс](https://yandex.cloud/ru/marketplace/products/yc/nat-instance-ubuntu-18-04-lts) из Cloud Marketplace.

**Сравнение способов доступа в интернет**:

| | Публичный IP-адрес | Egress NAT | NAT-инстанс |
| --- | --- | --- | --- |
| **Плюсы:** | | | |
| | * Не требует настройки<br>* Выделенный адрес для каждой ВМ | * Не требует настройки<br>* Работает только на исходящих соединениях | * Возможность фильтровать трафик на NAT-инстансе<br>* Возможность использовать собственный файрвол<br>* Экономия IP-адресов |
| **Минусы:** | | | |
| | * Выставлять ВМ напрямую в интернет может быть небезопасно<br>* Стоимость резервирования каждого адреса | * Общий пул IP-адресов<br>* Функция на стадии [Preview](../../overview/concepts/launch-stages.md), поэтому не рекомендуется для продуктовых сред | * Требуется настройка<br>* Стоимость использования ВМ (vCPU, RAM, диска) |

Вне зависимости от выбранного варианта организации исходящего доступа в интернет, ограничивайте трафик с помощью одного из механизмов, описанных выше. Для построения защищенной системы необходимо использовать статические IP-адреса, так как их можно внести в список исключений файрвола принимающей стороны.

| ID требования | Критичность |
| --- | --- |
| NET10 | Информационная |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. Откройте консоль Yandex Cloud в вашем браузере.
  1. Перейдите в нужный каталог.
  1. Перейдите в раздел **IP-адреса**.
  1. Если у всех публичных адресов в столбце **Защита от DDoS-атак** установлено значение **Включена**, рекомендация выполняется. В противном случае перейдите к пункту «Инструкции и решения по выполнению».

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый `ID`:

     ```bash
     yc organization-manager organization list
     ```

  1. Выполните команду для поиска всех ВМ с публичными адресами:

     ```bash
     export ORG_ID=<ID организации>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id');
     do echo "VM_ID: " && yc compute instance list --folder-id=$FOLDER_ID --format=json | jq -r '.[] | select(.network_interfaces[].primary_v4_address.one_to_one_nat.address)' | jq -r '.id' \
     && echo "FOLDER_ID: " $FOLDER_ID && echo "-----"
     done;
     done
     ```

  1. Если `VM_ID` напротив `FOLDER_ID` указано пустое значение, рекомендация выполняется. В противном случае перейдите к пункту «Инструкции и решения по выполнению».
  1. Выполните команду для поиска наличия Egress NAT (NAT-шлюз):

     ```bash
     export ORG_ID=<ID организации>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); \
     do echo "NAT_GW: " && yc vpc gateway list --folder-id=$FOLDER_ID --format=json | jq -r '.[] | select(.id)' | jq -r '.id' && echo "FOLDER_ID: " $FOLDER_ID && echo "-----"
     done;
     done
     ```

  1. Если `NAT_GW` напротив `FOLDER_ID` указано пустое значение, рекомендация выполняется. В противном случае перейдите к пункту «Инструкции и решения по выполнению».
  1. Выполните команду для поиска наличия NAT-инстанса:

     ```bash
     export ORG_ID=<ID организации>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id');
     do for DISK_ID in $(yc compute disk list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); do yc compute disk get --id=$DISK_ID --format=json | jq -r '. | select(.product_ids[0]=="fd8v7ru46kt3s4o5f0uo")' | jq -r '.id'
     done;
     done;
     done
     ```

  1. Если результатом является пустая строка, рекомендация выполняется. Если видите `ID` NAT-инстанса, перейдите к пункту «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению:**
* В случае наличия публичных адресов на ВМ убедитесь, что они необходимы. В противном случае удалите внешний IP-адрес в настройках ВМ.
* В случае наличия NAT-Gateway убедитесь, что он необходим. В противном случае удалите его.
* В случае наличия NAT-инстанс убедитесь, что он необходим. В противном случае удалите его.

#### 2.10 Запросы DNS не передаются в сторонние рекурсивные резолверы {#recursive-resolvers}

Для повышения отказоустойчивости часть трафика может передаваться в сторонние рекурсивные резолверы. Если необходимо избежать этого, обратитесь в [службу технической поддержки](../../support/overview.md).

| ID требования | Критичность |
| --- | --- |
| NET8 | Низкая |

# Требования к конфигурации виртуальной среды

## 3. Безопасная конфигурация виртуальной среды {#virtualenv-safe-config}


В данном разделе представлены рекомендации клиентам по настройкам безопасности в облачных сервисах Yandex Cloud, а также использованию дополнительных средств защиты данных в виртуальной среде.

### Общее {#general}

#### 3.1 Используется антивирусная защита {#antivirus}

Необходимо обеспечить защиту от вредоносного ПО в своей зоне ответственности. Возможно применение различных решений от наших партнеров в [Yandex Cloud Marketplace](https://yandex.cloud/ru/marketplace).
[Образы антивирусных решений](https://yandex.cloud/ru/marketplace/products/kaspersky/kaspersky-linux-hybrid-cloud-security-byol) доступны в Yandex Cloud Marketplace. Типы лицензий и другая необходимая информация доступны в описаниях продуктов.

| ID требования | Критичность |
| --- | --- |
| ENV38 | Средняя |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Необходимо проконтролировать наличие антивирусных решений в критичных системах.

{% endlist %}

**Инструкции и решения по выполнению**:

Установите антивирусное решение в соответствии с инструкциями поставщика.

#### 3.2 Использование серийной консоли контролируется либо отсутствует {#serial-console}

На виртуальных машинах доступ к серийной консоли по умолчанию отключен. Риски использования серийной консоли перечислены в разделе [Начало работы с серийной консолью](../../compute/operations/serial-console/index.md) документации Yandex Compute Cloud.

При работе с серийной консолью:

* Убедитесь, что критичные данные не попадают в вывод серийной консоли.
* При включенном доступе к серийной консоли по SSH убедитесь, что работа с учетными данными и пароль для локального входа в операционную систему соответствуют стандартам регуляторов. Например, в инфраструктуре для хранения данных платежных карт пароль должен соответствовать требованиям стандарта PCI DSS: содержать как буквы, так и цифры, иметь длину не менее 7 символов и меняться не реже чем каждые 90 дней.

{% note info %}

Согласно стандарту PCI DSS, доступ к виртуальной машине через серийную консоль считается «неконсольным» (non-console), и Yandex Cloud применяет для него шифрование TLS.

{% endnote %}

Не рекомендуется использовать доступ к серийной консоли без крайней необходимости.

| ID требования | Критичность |
| --- | --- |
| ENV1 | Высокая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В консоли управления выберите каталог, ВМ которого хотите проверить.
  1. В списке сервисов выберите **Compute Cloud**.
  1. Откройте настройки всех необходимых ВМ.
  1. В блоке **Доступ** найдите параметр **Дополнительно**.
  1. Опция **Доступ к серийной консоли** должна быть отключена.
  1. Если у всех ВМ опция отключена, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый ID:
    
     ```bash
     yc organization-manager organization list
     ```

  1. Найдите ВМ с включенным доступом к серийной консоли:

     ```bash
     export ORG_ID=<ID организации>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do for VM_ID in $(yc compute instance list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); do echo "VM_ID: " && yc compute instance get --id=$VM_ID --full --format=json | jq -r '. | select(.metadata."serial-port-enable"=="1")' | jq -r '.id' && echo "FOLDER_ID: " $FOLDER_ID && echo "-----"
     done;
     done;
     done
     ```

  1. Если VM_ID напротив FOLDER_ID указано пустое значение, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению**:

Если серийная консоль не должна быть использована на ВМ, отключите ее.

#### 3.3 Используется эталонный образ для развертывания ВМ {#standard-image}

При развертывании виртуальных машин рекомендуется:

* Подготовить образ виртуальной машины, настройки системы в котором соответствуют вашей политике информационной безопасности. Создать образ можно с помощью Packer, см. раздел [Начало работы с Packer](../../tutorials/infrastructure-management/packer-quickstart.md).
* Использовать этот образ для создания виртуальной машины или [группы виртуальных машин](../../compute/concepts/instance-groups/index.md).
* В информации о виртуальной машине убедиться, что для создания диска использовался именно этот образ.

| ID требования | Критичность |
| --- | --- |
| ENV2 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В консоли управления выберите каталог, ВМ которого хотите проверить.
  1. В списке сервисов выберите **Compute Cloud**.
  1. Перейдите на вкладку **Диски**.
  1. Откройте настройки всех дисков.
  1. В блоке **Источник** найдите параметр **Идентификатор**.
  1. Если во всех дисках отображается ID вашего эталонного образа, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый ID:

     ```bash
     yc organization-manager organization list
     ```

  1. Выполните команду для поиска дисков ВМ, которые не имеют ID вашего эталонного образа:

     ```bash
     export ORG_ID=<ID организации>
     export IMAGE_ID=<id вашего эталонного образа>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do for DISK_ID in $(yc compute disk list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); \
     do echo "DISK_ID: " && yc compute disk get --id=$DISK_ID \
     --format=json | jq -r --arg IMAGE_ID $IMAGE_ID '. | select(."source_image_id"==$IMAGE_ID | not)' | jq -r '.id' && echo "FOLDER_ID: " $FOLDER_ID && echo "-----"
     done;
     done;
     done
     ```

  1. Если DISK_ID напротив FOLDER_ID указано пустое значение, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению**:

1. Выясните, почему для данных дисков ВМ используется не эталонный образ.
1. Пересоздайте ВМ с необходимым образом.

#### 3.4 Инструмент Terraform используется в соответствии с лучшими практиками ИБ {#tf-using}

Terraform позволяет управлять облачной инфраструктурой с помощью файлов конфигураций. При изменении файлов Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить. Подробнее в разделе [Начало работы с Terraform](../../tutorials/infrastructure-management/terraform-quickstart.md).

В файлах конфигураций Terraform не рекомендуется указывать приватную информацию: пароли, секреты, персональные данные, данные платежных систем и др. Вместо этого необходимо использовать сервисы для хранения и использования в конфигурации секретов, например: [HashiCorp Vault](https://yandex.cloud/ru/marketplace/products/yc/vault-yckms) из Cloud Marketplace или [Lockbox](https://yandex.cloud/ru/services/lockbox) (для передачи секретов в целевой объект без использования Terraform).

Если все же требуется указать приватную информацию в конфигурации, необходимо принять меры безопасности:

* Указывать для приватной информации параметр [sensitive = true](https://www.terraform.io/docs/language/values/outputs.html#sensitive-suppressing-values-in-cli-output), чтобы отключить ее вывод в консоль при выполнении команд `terraform plan`, `terraform apply`.
* Использовать [terraformremotestate](https://www.terraform.io/docs/language/state/remote.html). Рекомендуется [загружать](../../tutorials/infrastructure-management/terraform-state-storage.md) состояние Terraform в Object Storage, а также [настроить](https://github.com/yandex-cloud-examples/yc-terraform-state) блокировку конфигурации с помощью Managed Service for YDB для предотвращения одновременного редактирования администраторами.
* Использовать [механизм передачи секретов в Terraform через env](https://www.terraform.io/docs/cli/config/environment-variables.html#tf_var_name) вместо plaintext либо использовать встроенную возможность KeyManagementService по [шифрованию данных в Terraform](../../kms/tutorials/terraform-secret.md) с помощью отдельного файла с приватными данными. [Подробнее о данной технике](https://blog.gruntwork.io/a-comprehensive-guide-to-managing-secrets-in-your-terraform-code-1d586955ace1#3073).

Об обеспечении безопасности Object Storage читайте ниже в подразделе [Object Storage](#objstorage).

{% note info %}

После развертывания конфигурации файл конфигурации с приватными данными можно удалить.

{% endnote %}

Проверяйте ваши Terraform-манифесты с помощью [Checkov](https://github.com/bridgecrewio/checkov) с поддержкой Yandex Cloud.

* [Пример: сканирование tf-файлов с помощью Checkov](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/terraform-sec/checkov-yc).
* [Пример: хранение состояния Terraform в Object Storage](https://github.com/yandex-cloud-examples/yc-terraform-state).

| ID требования | Критичность |
| --- | --- |
| ENV3 | Высокая |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Проведите точечный сбор данных об использовании лучших практик по безопасности Terraform.

{% endlist %}

#### 3.5 Выполняется контроль целостности {#integrity-control}

| ID требования | Критичность |
| --- | --- |
| ENV5 | Низкая |

##### 3.5.1 Контроль целостности файлов {#file-integrity-control}

Множество стандартов по ИБ требуют выполнения контроля целостности критичных файлов. Для этого можно использовать бесплатные host-based решения:

* [Wazuh](https://documentation.wazuh.com/current/learning-wazuh/detect-fs-changes.html)
* [Osquery](https://osquery.readthedocs.io/en/stable/deployment/file-integrity-monitoring/)

В маркетплейсе облака также доступны платные решения — например, [Kaspersky Security](https://yandex.cloud/ru/marketplace/products/kaspersky/kaspersky-linux-hybrid-cloud-security-byol).

| ID требования | Критичность |
| --- | --- |
| ENV5.1 | Средняя |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Проведите точечный сбор данных об использовании контроля целостности.

{% endlist %}

##### 3.5.2 Контроль целостности среды запуска ВМ {#vm-integrity-control}

В целях контроля среды запуска ВМ (например, доступ из ВМ к защищенному репозиторию только при запуске в облаке Yandex Cloud CLI) вы можете использовать механизм [Идентификационного документа](../../compute/concepts/metadata/identity-document.md). При создании ВМ формируется идентификационный документ (identity document), в котором хранятся сведения о самой ВМ: идентификаторы ВМ, продукта [Yandex Cloud Marketplace](https://yandex.cloud/ru/marketplace), образа диска и т.д. Такой документ подписывается сертификатом Yandex Cloud. Сам документ и его [подпись](../../compute/concepts/metadata/identity-document.md#signed-identity-documents) доступны процессам в ВМ через сервис метаданных, что позволяет процессам в виртуальной машине гарантированно идентифицировать среду запуска ВМ, образ диска и т.д. для ограничения доступа к контролируемым ресурсам.

| ID требования | Критичность |
| --- | --- |
| ENV5.2 | Низкая |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Убедитесь, что критические ВМ имеют подписанные идентификационные документы.

{% endlist %}

#### 3.6 Учтены принципы защиты от атак по побочным каналам (side-channel) {#side-channel-protection}

Для наилучшей защиты от атак по побочным каналам процессора (так называемым атакам side-channel на уровне CPU, например, Spectre или Meltdown) необходимо:

* Использовать полноядерные виртуальные машины, то есть виртуальные машины с долей ядра CPU в 100 процентов.
* Устанавливать обновления операционной системы и ядра, которые обеспечивают защиту от атак с использованием побочных каналов (например, [Kernel page-table isolation для Linux](https://en.wikipedia.org/wiki/Kernel_page-table_isolation), приложения, собранные с [Retpoline](https://en.wikipedia.org/wiki/Spectre_%28security_vulnerability%29)).

Для размещения нагрузок, наиболее критичных с точки зрения безопасности, рекомендуется использовать [выделенные хосты](../../compute/concepts/dedicated-host.md) (dedicated hosts).

[Подробнее](https://www.youtube.com/watch?v=VSP_cp6vDQQ&list=PL1x4ET76A10a9Jr6six11s0kRxeQ3fgom&index=17) о защите от side-channel-атак в облачных окружениях.

| ID требования | Критичность |
| --- | --- |
| ENV6 | Информационная |

#### 3.7 Сотрудники, работающие с Yandex Cloud, имеют сертификат Yandex Cloud Certified Security Specialist {#security-specialist-certificate}

Сертификационный экзамен Yandex Cloud Certified Security Specialist предназначен для оценки компетенций пользователей платформы Yandex Cloud, которые выполняют задачи по обеспечению информационной безопасности и защите облачных систем.

| ID требования | Критичность |
| --- | --- |
| ENV39 | Информационная |

**Инструкции и решения по выполнению**:

1. Перейдите на [описание проверяемых компетенций](https://yandex.cloud/ru/certification/security-specialist-competencies) экзамена на звание Yandex Cloud Certified Security Specialist.
1. Изучите [материалы](https://yandex.cloud/ru/certification/security-specialist-prerequisites), которые помогут пройти экзамен.
1. Заполните [форму](https://yandex.cloud/ru/certification#certification-security-form) для записи на прохождение экзамена.

### Yandex Object Storage {#objstorage}

#### 3.8 Отсутствует публичный доступ к бакету Object Storage {#bucket-access}

Рекомендуется назначать минимальные роли на бакет с помощью IAM и дополнять или детализировать их с помощью BucketPolicy (например, для ограничения доступа к бакету по IP-адресам, выдачи гранулярных прав на объекты и т.д.).

Проверка доступа к ресурсам Object Storage происходит на трех уровнях:

* [проверки сервиса IAM](../../iam/concepts/index.md);
* [политики доступа](../../storage/concepts/policy.md) (bucketpolicy);
* [списки управления доступом (ACL)](../../storage/concepts/acl.md).

**Порядок проверки**:

1. Если запрос прошел проверку IAM, к нему применяется проверка политики доступа.
1. Проверка правил политики доступа происходит в следующем порядке:

   1. Если запрос подошел хотя бы под одно из правил Deny, то доступ будет запрещен.
   1. Если запрос подошел хотя бы под одно из правил Allow, то доступ будет разрешен.
   1. Если запрос не подошел ни под одно из правил, то доступ будет запрещен.

1. Если запрос не прошел проверку IAM или политики доступа, то применяется проверка доступа через ACL объекта.

В сервисе IAM бакет наследует такие же права доступа, как у каталога и облака, в котором он находится. Подробнее об этом в разделе [Наследование прав доступа к бакету публичными группами Yandex Cloud](../../storage/concepts/acl.md#inheritance). Поэтому рекомендуется выдавать только минимально необходимые роли на определенные бакеты или объекты сервиса Object Storage.

Политики доступа используются для дополнительной защиты данных, например, для ограничения доступа к бакету по IP-адресам, выдачи гранулярных прав на объекты и т. д.

ACL позволяет предоставить доступ к объекту в обход проверок IAM и политик доступа. Рекомендуем установить строгие ACL на бакеты.

 [Пример безопасной конфигурации Object Storage: Terraform](https://github.com/yandex-cloud-examples/yc-s3-secure-bucket)

| ID требования | Критичность |
| --- | --- |
| ENV7 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В консоли управления выберите облако или каталог, бакеты которого вы хотите проверить.
  1. В списке сервисов выберите **Object Storage**.
  1. Нажмите на три точки напротив каждого бакета и проверьте ACL бакета на наличие `allUsers` и `allAuthenticatedUsers`.
  1. Зайдите внутрь бакета и проверьте ACL на каждый объект бакета на наличие `allUsers` и `allAuthenticatedUsers`.
  1. Проверьте, что в разделе **Доступ на чтение** объектов включен параметр **Публичный**. В противном случае перейдите к п. «Инструкции и решения по выполнению».

- Проверка через CLI {#cli}

  1. [Настройте](../../storage/tools/aws-cli.md) awscli на работу с облаком.
  1. Выполните команду для ACL бакета на наличие `allUsers`, `allAuthenticatedUsers`:

     ```bash
     aws --endpoint-url=https://storage.yandexcloud.net s3api get-bucket-acl  <имя вашего бакета>
     ```

{% endlist %}

**Инструкции и решения по выполнению**:

Если публичный доступ включен, [удалите](../../iam/operations/roles/revoke.md) его либо контролируйте (осознанно выдавайте для публичных данных).

#### 3.9 В Object Storage используются политики доступа (Bucket Policy) {#bucket-policy}

[Политики доступа](../../storage/concepts/policy.md) устанавливают права на действия с бакетами, объектами и группами объектов. Политика срабатывает, когда пользователь делает запрос к какому-либо ресурсу. В результате срабатывания политики запрос либо выполняется, либо отклоняется.

[Примеры](../../storage/concepts/policy.md#config-examples) Bucket Policy:

* Политика, которая разрешает скачивать объекты только из указанного диапазона IP-адресов.
* Политика, которая запрещает скачивать объекты с указанного IP-адреса.
* Политика дает разным пользователям полный доступ только к определенным папкам, каждому пользователю — к своей.
* Политика дает каждому пользователю и сервисному аккаунту полный доступ к папке с названием, равным идентификатору пользователя или сервисного аккаунта.

Рекомендуется убедиться, что в вашем бакете Object Storage используется как минимум одна политика.

| ID требования | Критичность |
| --- | --- |
| ENV8 | Высокая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В консоли управления выберите облако или каталог, политики доступа которых вы хотите проверить.
  1. В списке сервисов выберите Object Storage.
  1. Перейдите в раздел **Политика доступа**.
  1. Убедитесь, что как минимум одна политика включена. В противном случае перейдите к п. «Инструкции и решения по выполнению».

- Проверка через CLI {#cli}

  1. [Настройте](../../storage/tools/aws-cli.md) awscli на работу с облаком.
  1. Выполните команду для ACL бакета на проверку наличия `allUsers`, `allAuthenticatedUsers`:

     ```bash
     aws --endpoint-url=https://storage.yandexcloud.net s3api get-bucket-policy --bucket <имя вашего бакета>
     ```

{% endlist %}

**Инструкции и решения по выполнению**:

[Включите](../../storage/concepts/policy.md#config-examples) необходимую политику.

#### 3.10 В Object Storage включена функция «Блокировка версии объекта» (objectlock) {#object-lock}

При обработке в бакетах критичных данных необходимо обеспечить их защиту от удаления и резервирование версий. Это возможно сделать с помощью механизмов версионирования и управления жизненным циклом и блокировки версии объекта.

Версионирование бакета — это возможность хранить историю версий объекта. Каждая версия является полной копией объекта и занимает соответствующий объем в Object Storage. С помощью управления версиями вы можете защитить ваши данные как от непреднамеренных действий пользователя, так и от сбоев приложений.

В случае удаления или модификации объекта с включенным версионированием на самом деле создается новая версия объекта с новым id. В случае удаления объект становится недоступен для чтения, но его версия хранится и подлежит восстановлению.

Настройка версионирования описана в статье [Версионирование бакета](../../storage/concepts/versioning.md) документации Object Storage.

Настройка жизненного цикла описана в статьях [Жизненные циклы объектов в бакете](../../storage/concepts/lifecycles.md) и [Конфигурация жизненных циклов объектов в бакете](../../storage/s3/api-ref/lifecycles/xml-config.md) документации Object Storage.

Также для защиты версий объекта от удаления необходимо использовать [objectlock](../../storage/concepts/object-lock.md). Подробнее про типы блокировок и как их включить читайте в документации.

Срок хранения критичных данных в бакете определяется требованиями ИБ компании клиента и требованиями стандартов ИБ. Например, стандарт PCI DSS устанавливает, что аудитные логи должны храниться не менее одного года, и как минимум три месяца должны быть доступны онлайн.

| ID требования | Критичность |
| --- | --- |
| ENV9 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В консоли управления выберите облако или каталог, бакеты которых вы хотите проверить.
  1. В списке сервисов выберите **Object Storage**.
  1. Откройте настройки всех бакетов.
  1. Перейдите во вкладку **Версионирование** и убедитесь, что оно включено. В противном случае перейдите к п. «Инструкции и решения по выполнению».

- Проверка через CLI {#cli}

  1. [Настройте](../../storage/tools/aws-cli.md) awscli на работу с облаком.
  1. Выполните команду, чтобы проверить, что версионирование включено:

     ```bash
     aws --endpoint https://storage.yandexcloud.net \
     s3api get-bucket-versioning \
     --bucket <имя вашего бакета>
     ```

  1. Выполните команду, чтобы проверить, что версионирование включено:

     ```bash
     aws --endpoint-url=https://storage.yandexcloud.net/ \
     s3api get-object-lock-configuration \
     --bucket <имя вашего бакета>
     ```

{% endlist %}

**Инструкции и решения по выполнению**:

Если публичный доступ включен, удалите или контролируйте его (включая только по необходимости и согласованию).

#### 3.11 В Object Storage включен механизм логирования действий с бакетом {#bucket-logs}

При использовании сервиса Object Storage для хранения критичных данных необходимо включать логирование действий с бакетами. Подробнее в статье [Механизм логирования действий с бакетом](../../storage/concepts/server-logs.md) документации Object Storage.

При этом будут записываться именно логи data-plane c объектами: PUT, DELETE, GET, POST, OPTIONS, HEAD.

[Запись](../../audit-trails/concepts/events.md#objstorage) данных логов, кроме событий чтения объектов из бакета, можно запросить в Audit Trails. В сервисе [Monitoring](../../storage/metrics.md) с помощью метрики `traffic` можно увидеть объем исходящего трафика из бакета. В будущем все логи будут записываться в Audit Trails.

Дополнительно возможен анализ логов Object Storage при помощи DataLens. Подробнее в статье [Анализ логов Object Storage при помощи DataLens](../../tutorials/datalens/storage-logs-analysis.md).

| ID требования | Критичность |
| --- | --- |
| ENV10 | Низкая |

**Инструкции и решения по выполнению**:

Проверить включен ли механизм логирования можно только через Terraform/API согласно [инструкции](../../storage/operations/buckets/enable-logging.md).

#### 3.12 В Object Storage настроено управление кросс-доменными запросами (CORS) {#cors}

При необходимости [кросс-доменных запросов](../../glossary/cors.md) к объектам в бакетах клиенту необходимо настроить политику Cross-origin resource sharing (CORS) в соответствии с требованиями ИБ компании клиента. Подробнее в разделе [CORS-конфигурация бакетов](../../storage/s3/api-ref/cors/xml-config.md) документации Object Storage.

| ID требования | Критичность |
| --- | --- |
| ENV11 | Низкая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В консоли управления выберите облако или каталог, бакеты которых вы хотите проверить.
  1. В списке сервисов выберите **Object Storage**.
  1. Откройте настройки всех бакетов.
  1. Перейдите во вкладку **CORS** — конфигурация должна быть настроена. В противном случае перейдите к п. «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению**:

[Настройте](../../storage/s3/api-ref/cors/xml-config.md) CORS. 

#### 3.13 Для получения временных ключей доступа к Object Storage используется Yandex Security Token Service {#use-sts-for-storage-keys}

[Yandex Security Token Service](../../iam/concepts/authorization/sts.md) — компонент сервиса Yandex Identity and Access Management для получения _временных ключей доступа_, совместимых с [AWS S3 API](../../storage/s3/index.md).

Временные ключи доступа в качестве способа аутентификации поддерживаются только в сервисе [Yandex Object Storage](../../storage/index.md).

С помощью временных ключей вы можете гранулярно разграничить доступы в [бакеты](../../storage/concepts/bucket.md) для множества пользователей, используя для этого всего один [сервисный аккаунт](../../iam/concepts/users/service-accounts.md). Права доступа сервисного аккаунта должны включать в себя все разрешения, которые вы хотите предоставлять с помощью временных ключей.

Временный ключ доступа создается на основе [статического ключа](../../iam/concepts/authorization/access-key.md), но в отличие от него имеет ограниченные время жизни и права доступа. Права доступа и время жизни задаются для каждого временного ключа индивидуально. Максимальное время жизни ключа — 12 часов.

Права доступа для ключа задаются с помощью [политики доступа](../../storage/security/policy.md), описанной в формате JSON по [специальной схеме](../../storage/s3/api-ref/policy/scheme.md).

Временные ключи Security Token Service наследуют права доступа сервисного аккаунта, но ограничиваются политикой доступа. Если в политике доступа задать для временного ключа разрешения на выполнение операций, которые не разрешены для сервисного аккаунта, операции не будут выполнены.

| ID требования | Критичность |
| --- | --- |
| ENV12 | Низкая |

**Инструкции и решения по выполнению**:

[Создайте](../../iam/operations/sa/create-sts-key.md) временный ключ доступа с помощью Security Token Service.

#### 3.14 Для единичных случаев доступа к отдельным объектам в непубличных бакетах Object Storage генерируются подписанные URL {#use-presigned-urls}

В Object Storage реализовано несколько механизмов для управления доступом к ресурсам. Алгоритм взаимодействия этих механизмов см. в разделе [Обзор способов управления доступом в Object Storage](../../storage/security/overview.md).

С помощью подписанных URL произвольный пользователь интернета может выполнять в Object Storage различные операции, например:
* скачать объект;
* загрузить объект;
* создать бакет.

[Подписанный URL](../../storage/concepts/pre-signed-urls.md) — это URL, содержащий в своих параметрах данные для аутентификации запроса. Составить подписанный URL может пользователь, обладающий статическими ключами доступа.

Если произвольным пользователям, не авторизованным в [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud), требуется доступ к выборочным объектам в бакете, рекомендуем в таких случаях использовать подписанные URL, то есть следовать принципу минимальных привилегий и не открывать доступ ко всем объектам в бакете.

| ID требования | Критичность |
| --- | --- |
| ENV13 | Низкая |

**Инструкции и решения по выполнению**:

[Составьте](../../storage/concepts/pre-signed-urls.md#creating-presigned-url) и передайте нужному пользователю подписанный URL.

### Managed Services for Databases {#managed-databases}

#### 3.15 На управляемых базах данных назначена Группа безопасности {#db-security-group}

Рекомендуется запретить доступ из интернета к базам данных, которые содержат критичные данные, в частности данные PCI DSS или персональные данные. Настройте группы безопасности, чтобы разрешить подключение к СУБД только с определенных IP-адресов, см. инструкцию в разделе [Создать группу безопасности](../../vpc/operations/security-group-create.md). Указать группу безопасности можно в настройках кластера или при его создании, в блоке сетевых настроек.

| ID требования | Критичность |
| --- | --- |
| ENV14 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В консоли управления выберите облако или каталог, в которых вы хотите проверить базы данных.
  1. В списке сервисов выберите сервис(ы), где находятся управляемые базы данных.
  1. В настройках объектов найдите параметр **Группа безопасности** и убедитесь, что назначена хотя бы одна группа безопасности.
  1. Если в параметрах каждого объекта указана хотя бы одна группа безопасности, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

- Проверка через CLI {#cli}

  1. Выполните команду для поиска managed postgres без SG:

     ```bash
     export ORG_ID=<ID организации>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do for DB_ID in $(yc managed-postgresql cluster list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); do yc managed-postgresql cluster get --id=$DB_ID --format=json | jq -r '. | select(.security_group_ids | not)' | jq -r '.id' 
     done;
     done;
     done
     ```

  1. Если выдается пустая строка, то рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

- Проверка наличия SG на управляемых базах данных {#db-check}

  1. Выполните команду для поиска managed SQL без SG:

     ```bash
     export ORG_ID=<ID организации>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do for DB_ID in $(yc managed-mysql cluster list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); do yc managed-mysql cluster get --id=$DB_ID --format=json | jq -r '. | select(.security_group_ids | not)' | jq -r '.id' 
     done;
     done;
     done
     ```

  1. Если выдается пустая строка, то рекомендация выполняется. Если нет, перейдите к п. «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению**:

Если найдены базы данных без групп безопасности, назначьте их либо включите [функционал](../../vpc/concepts/security-groups.md#default-security-group.md) **Группа безопасности по умолчанию**.

#### 3.16 На управляемых базах данных не назначен публичный IP-адрес {#db-ip}

Назначение публичного IP-адреса на управляемую базу данных повышает риски ИБ. Рекомендуется не назначать внешний IP-адрес без крайней необходимости.

| ID требования | Критичность |
| --- | --- |
| ENV15 | Высокая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В консоли управления выберите облако или каталог, в которых вы хотите проверить базы данных.
  1. В списке сервисов выберите сервис(ы), где находятся управляемые базы данных.
  1. В настройках объектов перейдите во вкладку **Хосты**.
  1. Если в параметрах каждого объекта отключена опция **Публичный доступ**, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый ID:

     ```bash
     yc organization-manager organization list
     ```

  1. Выполните команду для поиска кластеров управляемых БД с публичным адресом:

     ```bash
     export ORG_ID=<ID организации>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do for DB_ID in $(yc managed-mysql cluster list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); do yc managed-mysql hosts list --cluster-id=$DB_ID --format=json | jq -r '.[] | select(.assign_public_ip)' | jq -r '.cluster_id' 
     done;
     done;
     done
     ```

  1. Если выдается пустая строка, рекомендация выполняется. Если нет, перейдите к п. «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению**:

Удалите публичный доступ, если он не требуется.

#### 3.17 Включена настройка защиты от удаления (deletion protection) {#deletion-protection}

В управляемых базах данных в Yandex Cloud существует возможность включения функции защиты от удаления. Защита от удаления управляет защитой кластера от непреднамеренного удаления пользователем. Включенная защита не помешает подключиться к кластеру вручную и удалить данные.

| ID требования | Критичность |
| --- | --- |
| ENV16 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В консоли управления выберите облако или каталог, в которых вы хотите проверить базы данных.
  1. В списке сервисов выберите сервис(ы), где находятся управляемые базы данных.
  1. В настройках объектов перейдите во вкладку **Дополнительные настройки**.
  1. Если в параметрах каждого объекта включена опция **Защита от удаления**, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый ID:

     ```bash
     yc organization-manager organization list
     ```

  1. Выполните команду для поиска кластеров управляемых БД без включенной защиты от удаления:

     ```bash
     export ORG_ID=<ID организации>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do for DB_ID in $(yc managed-mysql cluster list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); do yc managed-mysql cluster get --id=$DB_ID --format=json | jq -r '. | select(.deletion_protection | not)' | jq -r '.id' 
     done;
     done;
     done
     ```

  1. Если выдается пустая строка, то рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению**:

1. В консоли управления выберите облако или каталог, в которых хотите включить защиту от удаления.
1. В списке сервисов выберите сервис(ы), где находятся управляемые базы данных.
1. В настройках объектов перейдите во вкладку **Дополнительные настройки**.
1. В параметрах объекта включите опцию **Защита от удаления**.

#### 3.18 Выключена настройка доступа из DataLens без необходимости {#db-datalens-access}

Не следует без необходимости включать доступ к базам данных c критичными данными из консоли управления, [DataLens](../../datalens/index.md) и других сервисов. Доступ из DataLens может потребоваться для анализа и визуализации данных. Эти доступы осуществляются через служебную сеть Yandex Cloud, с аутентификацией и использованием шифрования TLS. Включить и отключить доступы из DataLens или других сервисов можно в настройках кластера или при его создании, в блоке дополнительных настроек.

| ID требования | Критичность |
| --- | --- |
| ENV17 | Высокая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В консоли управления выберите облако или каталог, в которых вы хотите проверить базы данных.
  1. В списке сервисов выберите сервис(ы), где находятся управляемые базы данных.
  1. В настройках объектов перейдите во вкладку **Дополнительные настройки**.
  1. Если в параметрах каждого объекта отключена опция **Доступ из DataLens**, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый ID:

     ```bash
     yc organization-manager organization list
     ```

  1. Найдите кластеры управляемых БД с включенным доступом из DataLens:

     ```bash
     export ORG_ID=<ID организации>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do for DB_ID in $(yc managed-mysql cluster list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); do yc managed-mysql cluster get --id=$DB_ID --format=json | jq -r '. | select(.config.access.data_lens)' | jq -r '.id' 
     done;
     done;
     done
     ```

  1. Если выдается пустая строка, то рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению**:

1. В консоли управления выберите облако или каталог, в которых вы хотите выключить доступ из DataLens.
1. В списке сервисов выберите сервис(ы), где находятся управляемые базы данных.
1. В настройках объектов перейдите во вкладку **Дополнительные настройки**.
1. В параметрах объекта отключите опцию **Доступ из DataLens**.

#### 3.19 На управляемых БД выключен доступ из консоли управления {#db-console-access}

Доступ к БД из консоли управления может потребоваться для отправки [SQL-запросов](../../managed-postgresql/operations/web-sql-query.md) в БД и визуализации структуры данных.

Рекомендуется включать такой доступ только в случае необходимости, т.к. он увеличивает риски ИБ. В штатном режиме используйте стандартное подключение к БД под пользователем БД.

| ID требования | Критичность |
| --- | --- |
| ENV18 | Низкая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В консоли управления выберите облако или каталог, в которых вы хотите проверить базы данных.
  1. В списке сервисов выберите сервис(ы), где находятся управляемые БД.
  1. В настройках объектов перейдите во вкладку **Дополнительные настройки**.
  1. Если в параметрах каждого объекта отключена опция **Доступ из консоли управления**, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый ID:

     ```bash
     yc organization-manager organization list
     ```

  1. Выполните команду для поиска кластеров управляемых БД c включенным доступом из консоли управления:

      {% cut "**Bash**" %}

      ```bash
      export ORG_ID=<ID_организации>

      # MySQL
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do yc managed-mysql cluster list --folder-id=$FOLDER_ID --format=json | jq -r '. | select(.config.access.web_sql)' | jq -r '.id' 
      done;
      done

      # PostgreSQL
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do yc managed-postgresql cluster list --folder-id=$FOLDER_ID --format=json | jq -r '. | select(.config.access.web_sql)' | jq -r '.id' 
      done;
      done

      # ClickHouse
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do yc managed-clickhouse cluster list --folder-id=$FOLDER_ID --format=json | jq -r '. | select(.config.access.web_sql)' | jq -r '.id' 
      done;
      done

      # Redis
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do yc managed-redis cluster list --folder-id=$FOLDER_ID --format=json | jq -r '. | select(.config.access.web_sql)' | jq -r '.id' 
      done;
      done

      # MongoDB
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do yc managed-mongodb cluster list --folder-id=$FOLDER_ID --format=json | jq -r '. | select(.config.access.web_sql)' | jq -r '.id' 
      done;
      done
      ```

      {% endcut %}

      {% cut "**PowerShell**" %}

      ```powershell
      $ORG_ID = "<ID_организации>"

      $Clouds = yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | ConvertFrom-Json | Select @{n="CloudID";e={$_.id}}, created_at, @{n="CloudName";e={$_.name}}, organization_id

      $MDBClusters = @()

      foreach ($Cloud in $Clouds) {
          $Folders = yc resource-manager folder list --cloud-id $Cloud.CloudID --format=json | ConvertFrom-Json

          foreach($Folder in $Folders) {
              # Getting Postgre
              $MDBName = "Managed PostgreSQL"
              $MDBClusters += yc managed-postgresql cluster list --folder-id $Folder.id --format=json | ConvertFrom-Json | where {$_.config.access.web_sql -eq $True} | Select @{n="CloudID";e={$Cloud.CloudID}}, @{n="CloudName";e={$Cloud.CloudName}}, @{n="FolderID";e={$Folder.id}}, @{n="FolderName";e={$Folder.name}}, @{n="MDB";e={$MDBName}}, @{n="ClusterID";e={$_.id}}, @{n="ClusterName";e={$_.name}}, @{n="ClusterEnv";e={$_.environment}}, @{n="ClusterStatus";e={$_.status}}, network_id, health, @{n="WebSQLAccess";e={$_.config.access.web_sql}}

              # Getting MySQL
              $MDBName = "Managed MySQL"
              $MDBClusters += yc managed-mysql cluster list --folder-id $Folder.id --format=json | ConvertFrom-Json | where {$_.config.access.web_sql -eq $True} | Select @{n="CloudID";e={$Cloud.CloudID}}, @{n="CloudName";e={$Cloud.CloudName}}, @{n="FolderID";e={$Folder.id}}, @{n="FolderName";e={$Folder.name}}, @{n="MDB";e={$MDBName}}, @{n="ClusterID";e={$_.id}}, @{n="ClusterName";e={$_.name}}, @{n="ClusterEnv";e={$_.environment}}, @{n="ClusterStatus";e={$_.status}}, network_id, health, @{n="WebSQLAccess";e={$_.config.access.web_sql}}

              # Getting ClickHouse
              $MDBName = "Managed ClickHouse"
              $MDBClusters += yc managed-clickhouse cluster list --folder-id $Folder.id --format=json | ConvertFrom-Json | where {$_.config.access.web_sql -eq $True} | Select @{n="CloudID";e={$Cloud.CloudID}}, @{n="CloudName";e={$Cloud.CloudName}}, @{n="FolderID";e={$Folder.id}}, @{n="FolderName";e={$Folder.name}}, @{n="MDB";e={$MDBName}}, @{n="ClusterID";e={$_.id}}, @{n="ClusterName";e={$_.name}}, @{n="ClusterEnv";e={$_.environment}}, @{n="ClusterStatus";e={$_.status}}, network_id, health, @{n="WebSQLAccess";e={$_.config.access.web_sql}} 

              # Getting Redis
              $MDBName = "Managed Redis"
              $MDBClusters += yc managed-redis cluster list --folder-id $Folder.id --format=json | ConvertFrom-Json | where {$_.config.access.web_sql -eq $True} | Select @{n="CloudID";e={$Cloud.CloudID}}, @{n="CloudName";e={$Cloud.CloudName}}, @{n="FolderID";e={$Folder.id}}, @{n="FolderName";e={$Folder.name}}, @{n="MDB";e={$MDBName}}, @{n="ClusterID";e={$_.id}}, @{n="ClusterName";e={$_.name}}, @{n="ClusterEnv";e={$_.environment}}, @{n="ClusterStatus";e={$_.status}}, network_id, health, @{n="WebSQLAccess";e={$_.config.access.web_sql}} 

              # Getting MongoDB
              $MDBName = "Managed MongoDB"
              $MDBClusters += yc managed-mongodb cluster list --folder-id $Folder.id --format=json | ConvertFrom-Json | where {$_.config.access.web_sql -eq $True} | Select @{n="CloudID";e={$Cloud.CloudID}}, @{n="CloudName";e={$Cloud.CloudName}}, @{n="FolderID";e={$Folder.id}}, @{n="FolderName";e={$Folder.name}}, @{n="MDB";e={$MDBName}}, @{n="ClusterID";e={$_.id}}, @{n="ClusterName";e={$_.name}}, @{n="ClusterEnv";e={$_.environment}}, @{n="ClusterStatus";e={$_.status}}, network_id, health, @{n="WebSQLAccess";e={$_.config.access.web_sql}} 
          }
      }

      $MDBClusters
      ```

      {% endcut %}

  1. Если выдается пустая строка, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению**:

1. В консоли управления выберите облако или каталог, в которых вы хотите выключить доступ из консоли.
1. В списке сервисов выберите сервис(ы), где находятся управляемые базы данных.
1. В настройках объектов перейдите во вкладку **Дополнительные настройки**.
1. В параметрах объекта выключите опцию **Доступ из консоли**.

### Yandex Cloud Functions {#functions}

#### 3.20 Serverless Containers/Cloud Functions использует внутреннюю сеть VPC {#vpc-functions}

По умолчанию функция запускается в изолированной IPv4-сети с включенным NAT-шлюзом. Поэтому из функции доступны только публичные IPv4-адреса. Возможности закрепить адрес нет.

Сетевое взаимодействие между двумя функциями, а также между функциями и пользовательскими ресурсами ограничено:

* Входящие соединения не поддерживаются. Например, нельзя обратиться по сети к внутренним компонентам функции, даже если известен IP-адрес ее экземпляра.
* Исходящие соединения поддерживаются по протоколам TCP, UDP и ICMP. Например, функция может получить доступ к виртуальной машине Yandex Compute Cloud или базе данных Yandex Managed Service for YDB в сети пользователя.
* Функция выполняется кросс-зонально: для запуска функции нельзя явным образом задать подсеть или выбрать зону доступности.

Если необходимо, в настройках функции можно указать облачную сеть. В этом случае:

* Функция будет выполняться в указанной облачной сети. 
* Во время выполнения функция получит IP-адрес в соответствующей подсети и доступ ко всем ресурсам сети.
* Функция будет иметь доступ не только в интернет, но и к пользовательским ресурсам, которые находятся в указанной сети, например, базам данных, виртуальным машинам и т.п. 
* Функция будет иметь IP-адрес в диапазоне `198.19.0.0/16` при доступе к пользовательским ресурсам.

Для функций, контейнеров и API-шлюзов, которые находятся в одном облаке, можно указать только одну сеть.

| ID требования | Критичность |
| --- | --- |
| ENV19 | Информационная |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В консоли управления выберите облако или каталог, в которых вы хотите проверить функции.
  1. В списке сервисов выберите Cloud Functions.
  1. Откройте все функции.
  1. В настройках объектов перейдите во вкладку **Редактирование версии функции**.
  1. Если в параметрах каждого объекта значение опции **Сеть — VPC**, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

- Проверка через CLI {#cli}

  1. Выполните команду для поиска всех облачных функций, для которых не заданы настройки сети в VPC:

     ```bash
     export ORG_ID=<ID организации>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do for VER in $(yc serverless function version list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); \
     do yc serverless function version get $VER --format=json | jq -r '. | select(.connectivity.network_id | not)' | jq -r '.id' 
     done;
     done;
     done
     ```

  1. Если выдается пустая строка, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению**:

1. Выберите облако или каталог, в которых хотите проверить функции, в консоли управления.
1. Выберите **Cloud Functions** в списке сервисов.
1. Откройте функцию.
1. Перейдите во вкладку **Редактирование версии функции** в настройках объектов.
1. Установите значение опции **Сеть — VPC**.

Дополнительную информацию об отслеживании версий функций см. в разделе [Резервное копирование в Cloud Functions](../../functions/concepts/backup.md).

#### 3.21 Для функций настроены разграничение прав доступа, управление секретами и переменными окружения, а также подключение к СУБД {#function-access-and-env}

Во всех случаях, когда явно не требуется использование публичных функций, рекомендуется использовать приватные функции. Подробнее о настройке доступа к функциям см. в разделе [Управление правами доступа к функции](../../functions/operations/function/function-public.md). Рекомендуется использовать приватные функции и назначать права на вызов функции конкретным пользователям облака.

[Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) — аккаунт, от имени которого программы или функции могут управлять ресурсами в Yandex Cloud. Если версия функции создана с сервисным аккаунтом, вы можете [получить](../../functions/operations/function-sa.md) для него IAM-токен из контекста вызова функции.

Сервисному аккаунту должны быть назначены [роли](../../iam/concepts/access-control/roles.md). Роль — это набор разрешений, который определяет допустимые операции с ресурсами облака. Роли, назначенные на каталог, облако или организацию, автоматически наследуются функцией. При этом они не отображаются в списке ролей, назначенных на нее.

Не храните секреты и чувствительные данные в коде функции и переменных окружения. Для хранения и ротации секретов используйте сервис [Yandex Lockbox](../../lockbox/index.md). Передать секрет Yandex Lockbox в функцию можно в переменной окружения.

Чтобы функция получила доступ к секрету, в ее параметрах нужно указать сервисный аккаунт, которому назначены роли:

* `lockbox.payloadViewer` [на секрет](../../lockbox/operations/secret-access.md);
* `kms.keys.encrypterDecrypter` [на ключ шифрования](../../kms/operations/key-access.md), если секрет создан с использованием ключа шифрования [Yandex Key Management Service](../../kms/index.md).

Секрет Yandex Lockbox, который передается в функцию, кешируется в сервисе Cloud Functions. После отзыва у сервисного аккаунта доступа к секрету, функция может продолжить хранить секрет до 5 минут.

При передаче секретов создается новая версия функции. В существующую версию функции передать секреты нельзя. 

Добавить дополнительные переменные окружения можно при создании версии функции. Максимальный объем переменных окружения, включая их имена, ограничен лимитом в 4 КБ.

Вычисление переменных окружения не осуществляется. Значения переменных окружения являются строковыми константами. Вычислить их можно только в коде функции. Получить переменные окружения можно с помощью стандартных средств языка программирования.

Обратиться из функции к хостам кластера БД можно только по [протоколу SSL](https://ru.wikipedia.org/wiki/SSL), с помощью [подключения к БД](../../functions/operations/database-connection.md#connect) или указав облачную сеть в настройках функции. Используйте сервисный аккаунт с назначенной ролью, а также активируйте доступ для функций на стороне СУБД.

| ID требования | Критичность |
| --- | --- |
| ENV20 | Средняя |

**Инструкции и решения по выполнению**:

* [Отключите](../../functions/operations/function/function-private.md) публичный доступ к функции.
* [Посмотрите](../../functions/operations/function/role-list.md) список ролей, назначенных на функцию.
* [Получите](../../functions/operations/function-sa.md) IAM-токен сервисного аккаунта с помощью функции.
* [Отзовите](../../functions/operations/function/role-revoke.md) роль, назначенную на функцию.
* [Подключитесь](../../functions/operations/database-connection.md) к базе данных из функции.

Дополнительную информацию о ролях и ресурсах, на которые можно назначить роли в Cloud Functions, см. в разделе [Управление доступом в Cloud Functions](../../functions/security/index.md).

#### 3.22 Учтены особенности синхронизации времени в Cloud Functions {#ntp-functions}

Сервис Cloud Functions не гарантирует синхронизацию времени перед выполнением или в процессе выполнения функциями запросов. Чтобы получить лог выполнения функции с точными метками времени на стороне Cloud Functions, используйте облачный сервис логирования. Подробнее о логировании функций см. в разделе [Логи функции](../../functions/concepts/logs.md).

| ID требования | Критичность |
| --- | --- |
| ENV22 | Информационная |

#### 3.23 Учтены особенности управления заголовками в Cloud Functions {#http-functions}

Если функция вызывается для обработки HTTP-запроса, то возвращаемый результат должен представлять собой JSON-документ, содержащий код ответа HTTP, заголовки ответа и содержимое ответа. Cloud Functions автоматически обработает этот JSON, и пользователь получит данные в виде стандартного HTTP-ответа. Клиенту необходимо самостоятельно управлять заголовками ответа в соответствии с требованиями регуляторов и модели угроз. Инструкцию по обработке HTTP-запроса см. в статье [Вызов функции в Cloud Functions](../../functions/concepts/function-invoke.md) документации Cloud Functions.

Вы можете запускать функцию с указанием строкового query-параметра `?integration=raw`. При использовании такой формы вызова функция не может анализировать и задавать HTTP-заголовки:

* Содержимое тела HTTPS-запроса передается первым аргументом (без преобразования в JSON-структуру).
* Содержимое тела HTTPS-ответа совпадает с ответом функции (без преобразования и проверки структуры), HTTP-статус ответа: `200`.

Запрос должен представлять собой JSON-структуру, которая содержит:

* `httpMethod` — HTTP-метод: `DELETE`, `GET`, `HEAD`, `OPTIONS`, `PATCH`, `POST` или `PUT`.
* `headers` — словарь строк, содержащий HTTP-заголовки запроса и их значения. Если один и тот же заголовок передан несколько раз, словарь содержит последнее переданное значение.
* `multiValueHeaders` — словарь, содержащий HTTP-заголовки запроса и списки с их значениями. Он содержит те же ключи, что и словарь `headers`, но, если какой-либо заголовок повторялся несколько раз, список для него будет содержать все переданные значения для данного заголовка. Если заголовок был передан всего один раз, он включается в этот словарь, и список для него будет содержать только одно значение.
* `queryStringParameters` — словарь, содержащий параметры запроса. Если один и тот же параметр указан несколько раз, словарь содержит последнее указанное значение.
* `multiValueQueryStringParameters` — словарь, содержащий для каждого параметра запроса список со всеми указанными значениями. Если один и тот же параметр указан несколько раз, словарь содержит все указанные значения.
* `requestContext` — контекст запроса.

Для целей отладки функции, можно использовать специальные запросы, которые возвращают JSON-структуру запроса и необходимый для отладки результат. Подробнее см. в разделе [отладка функции](../../functions/concepts/function-invoke.md#example).

| ID требования | Критичность |
| --- | --- |
| ENV23 | Информационная |

### Managed Service for YDB {#ydb-access}

#### 3.24 Учтены рекомендации по работе с конфиденциальными данными в YDB {#ydb-confidential-data}

Запрещается в качестве названий базы данных, таблиц, столбцов, директорий и т.д. использовать конфиденциальные данные. Запрещается отправлять критичные данные (например данные платежных карт) в Managed Service for YDB (как Dedicated, так и Serverless) в открытом виде. Перед отправкой данных их необходимо шифровать на уровне приложения, для чего можно воспользоваться сервисом KMS или любым другим способом, соответствующим стандарту регуляторов. Если срок хранения данных известен заранее, рекомендуется настроить функцию [Time To Live](https://ydb.tech/docs/ru//concepts/ttl).

| ID требования | Критичность |
| --- | --- |
| ENV24 | Высокая |

#### 3.25 Учтены рекомендации по защите от sql-инъекций YDB {#ydb-sql-injection}

При работе с базой данных для защиты от SQL-инъекций необходимо использовать [параметризованные подготовленные запросы](https://ydb.tech/docs/ru//reference/ydb-sdk/example/#param-queries). Если в приложении используется динамическая генерация шаблонов запросов, необходимо следить, чтобы недоверенный пользовательский ввод не попадал в шаблон запроса.

| ID требования | Критичность |
| --- | --- |
| ENV25 | Высокая |

#### 3.26 Публичный доступ отсутствует для YDB {#ydb-public}

При работе с базой данных в режиме Dedicated рекомендуется использовать ее внутри VPC и не открывать к ней доступ из интернета. В режиме Serverless база данных является доступной из интернета, что необходимо учитывать, в частности, при моделировании угроз при построении инфраструктуры. Подробнее о режимах работы см. в разделе [Режимы работы Serverless и Dedicated](../../ydb/concepts/serverless-and-dedicated.md) документации Managed Service for YDB.

При настройке доступа к БД следует использовать принцип минимальных привилегий.

| ID требования | Критичность |
| --- | --- |
| ENV26 | Высокая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В консоли управления выберите облако или каталог, в которых вы хотите проверить базу данных. 
  1. В списке сервисов выберите **Managed Service for YDB**.
  1. Откройте все базы данных.
  1. В настройках базы данных перейдите во вкладку **Сеть**.
  1. Если в параметрах каждого объекта отключена опция **Публичные IP-адреса**, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый ID:

     ```bash
     yc organization-manager organization list
     ```

  1. Выполните команду для поиска кластеров управляемых БД с публичным адресом:

     ```bash
     export ORG_ID=<ID организации>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do for DB_ID in $(yc managed-mysql cluster list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); do yc managed-mysql hosts list --cluster-id=$DB_ID --format=json | jq -r '.[] | select(.assign_public_ip)' | jq -r '.cluster_id' 
     done;
     done;
     done
     ```

  1. Если выдается пустая строка, то рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению**:

Удалите публичный доступ, если он не требуется.

#### 3.27 Учтены рекомендации по резервному копированию YDB {#ydb-backup}

При использовании механизма создания резервных [копий по требованию](../../ydb/pricing/serverless.md), необходимо убедиться, что данные резервной копии должным образом защищены.

При самостоятельном создании резервных копий в сервисе Object Storage необходимо следовать рекомендациям подраздела Object Storage выше — например, использовать встроенные возможности шифрования бакетов.

| ID требования | Критичность |
| --- | --- |
| ENV27 | Низкая |

### Yandex Container Registry {#container-registry}

#### 3.28 Настроен ACL по IP адресам для Yandex Container Registry {#acl-container-registry}

Доступ к вашему Container Registry рекомендуется ограничить до конкретных IP-адресов.

| ID требования | Критичность |
| --- | --- |
| ENV28 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В консоли управления выберите облако или каталог, в которых необходимо проверить реестр.
  1. В списке сервисов выберите **Container Registry**.
  1. В настройках конкретного реестра перейдите во вкладку **Доступ для IP-адресов**.
  1. Если в параметрах указаны конкретные адреса для доступа, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый ID:

     ```bash
     yc organization-manager organization list
     ```

  1. Выполните команду для поиска CR без фильтров по IP:

      {% cut "**Bash**" %}

      ```bash
      export ORG_ID=<ID_организации>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do for CR in $(yc container registry list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); do yc container registry list-ip-permissions --id=$CR --format=json | jq -r '.[] | select(.ip)' | jq -r '.action' && echo $CR "IF ACTION PULL/PUSH exist before CR then OK"
      done;
      done;
      done
      ```

      {% endcut %}

      {% cut "**PowerShell**" %}

      ```powershell
      $ORG_ID = "<ID_организации>"

      $Clouds = yc resource-manager cloud list --organization-id $ORG_ID --format=json | ConvertFrom-Json | Select @{n="CloudID";e={$_.id}}, created_at, @{n="CloudName";e={$_.name}}, organization_id

      $CRIPPermissions = @()

      foreach ($Cloud in $Clouds) {
        $Folders = yc resource-manager folder list --cloud-id $Cloud.CloudID --format=json | ConvertFrom-Json

        foreach($Folder in $Folders) {
          $CRList = yc container registry list --folder-id $Folder.id --format=json | ConvertFrom-Json

          if($CRList) {
            foreach($CR in $CRList) {
              $IPPermissions = yc container registry list-ip-permissions --id $CR.id --format=json | ConvertFrom-Json

              if($IPPermissions) {
                $CRIPPermissions += $CR | Select @{n="CloudID";e={$Cloud.CloudID}}, @{n="CloudName";e={$Cloud.CloudName}}, @{n="FolderID";e={$Folder.id}}, @{n="FolderName";e={$Folder.name}}, @{n="CRID";e={$_.id}}, @{n="CRName";e={$_.name}}, @{n="CRStatus";e={$_.status}},@{n="Lables";e={$_.labels}},@{n="IPPermissionsList";e={$IPPermissions}}
              }
            }
          }
        }
      }

      $CRIPPermissions
      ```

      {% endcut %}

  1. Если перед каждым ID registry выдается PULL/PUSH, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению**:

Задайте конкретные адреса для доступа к реестрам.

#### 3.29 Выполнены требования к защите приложений в Yandex Container Registry {#app-container-registry}

| ID требования | Критичность |
| --- | --- |
| ENV40 | Средняя |

##### 3.29.1. Docker-образы сканируются при загрузке в Yandex Container Registry {#upload--policy}

[Автоматическое сканирование](../../container-registry/operations/scanning-docker-image.md#automatically) Docker-образов при загрузке имеет решающее значение для раннего обнаружения и устранения уязвимостей, обеспечивая безопасное развертывание контейнеров. После завершения сканирования отчеты содержат краткое описание обнаруженных уязвимостей и проблем, помогая определять приоритеты и устранять риски безопасности в контейнерных приложениях.

| ID требования | Критичность |
| --- | --- |
| ENV41 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, которому принадлежит реестр с Docker-образами.
  1. Выберите реестр в сервисе **Container Registry**.
  1. Перейдите на вкладку **Сканер уязвимостей** и нажмите кнопку **Изменить настройки**.
  1. Убедитесь, что сканирование Docker-образов при загрузке включено.

{% endlist %}

**Инструкции и решения по выполнению:**

[Инструкция по сканированию Docker-образа при загрузке](../../container-registry/operations/scanning-docker-image.md#automatically).

**Инструкции и решения по выполнению**:

[Инструкция по сканированию Docker-образа при загрузке](../../container-registry/operations/scanning-docker-image.md#automatically).

##### 3.29.2 Выполняется периодическое сканирование Docker-образов, хранящихся в Container Registry {#periodic--scan}

Сканирование Docker-образов по расписанию представляет собой автоматизированный процесс проверки контейнерных образов на наличие уязвимостей и соответствие стандартам безопасности. Такое сканирование выполняется регулярно и автоматически, что обеспечивает консистентность проверки образов на наличие уязвимостей. Это позволяет поддерживать высокий уровень безопасности в долгосрочной перспективе. После завершения сканирования отчеты содержат краткое описание обнаруженных уязвимостей и проблем, помогая определять приоритеты и устранять риски безопасности в контейнерных приложениях.

Рекомендуем настроить расписание сканирования не реже, чем раз в неделю.

| ID требования | Критичность |
| --- | --- |
| ENV42 | Высокая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, которому принадлежит реестр с Docker-образами.
  1. Выберите реестр в сервисе **Container Registry**.
  1. Перейдите на вкладку **Сканер уязвимостей** и нажмите кнопку **Изменить настройки**.
  1. Убедитесь, что сканирование Docker-образов по расписанию включено и оно проходит не реже, чем раз в неделю.

{% endlist %}

**Инструкции и решения по выполнению:**

[Инструкция по сканированию Docker-образа по расписанию](../../container-registry/operations/scanning-docker-image.md#scheduled).

##### 3.29.3 Обеспечивается целостность артефактов {#pipeline-artifacts-cosign}

Подписание артефактов повышает безопасность, обеспечивая подлинность, целостность, доверие и соответствие требованиям в вашем программном обеспечении.

| ID требования | Критичность |
| --- | --- |
| ENV43 | Высокая |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Убедитесь, что выполняется подписание артефактов при сборке приложения.

{% endlist %}

**Инструкции и решения по выполнению:**

Артефакты в рамках пайплайна можно подписывать с помощью стороннего ПО [Cosign](https://github.com/sigstore/cosign) для подписи [артефактов](https://docs.sigstore.dev/signing/quickstart/), образов и [in-to-to аттестаций](https://github.com/in-toto/attestation/tree/main/spec/predicates), чтобы в дальнейшем загрузить их в Yandex Container Registry.

С помощью специальной сборки утилиты Cosign сохраняйте созданную [ключевую пару электронной подписи](../../kms/concepts/asymmetric-signature-key.md) в сервисе [Yandex Key Management Service](../../kms/quickstart/index.md), подписывайте файлы и артефакты закрытым ключом этой ключевой пары и проверяйте электронную подпись с помощью ее открытого ключа.

Подробнее см. в разделе [Подпись и проверка Docker-образов Container Registry в Yandex Managed Service for Kubernetes](../../container-registry/tutorials/sign-cr-with-cosign.md).

### Yandex Container Solution {#container-solution}

#### 3.30 Не используются привилегированные контейнеры в Yandex Container Solution {#vip-containers}

Не рекомендуется использовать привилегированные контейнеры для запуска нагрузок, обрабатывающих недоверенный пользовательский ввод. Привилегированные контейнеры следует использовать для администрирования виртуальной машины или других контейнеров.

| ID требования | Критичность |
| --- | --- |
| ENV44 | Высокая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В консоли управления выберите облако или каталог, в которых необходимо проверить ВМ.
  1. В списке сервисов выберите **Compute Cloud**.
  1. Зайдите в настройки конкретной ВМ c **ContainerOptimized Image**.
  1. В блоке **Настройки** Docker-контейнера найдите параметр **Привилегированный режим**.
  1. Если параметр отключен, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый ID:

     ```bash
     yc organization-manager organization list
     ```

  1. Выполните команду для поиска CR без фильтров по IP:

     ```bash
     export ORG_ID=<ID организации>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do for VM_ID in $(yc compute instance list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); \
     do yc compute instance get --id=$VM_ID --full --format=json | jq -r '. | select(.metadata."docker-container-declaration")| .metadata."docker-container-declaration" | match("privileged: true") | .string' && echo $VM_ID
     done;
     done;
     done
     ```

  1. Если перед каждым ID ВМ отсутствует `privileged: true`, то рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению**:

1. В консоли управления выберите облако или каталог, в которых нужно проверить ВМ.
1. В списке сервисов выберите **Compute Cloud**.
1. Зайдите в настройки конкретной ВМ c **ContainerOptimizedImage**.
1. В блоке Настройки Docker-контейнера отключите параметр **Привилегированный режим**.

#### 3.31 Срок действия сертификата Yandex Certificate Manager составляет как минимум 30 дней {#certificate-validity}

Сервис Yandex Certificate Manager позволяет управлять TLS-сертификатами для API-шлюзов сервиса API Gateway, а также для сайтов и бакетов в Object Storage. Сервис Application Load Balancer интегрирован с Certificate Manager для хранения и установки сертификатов. Рекомендуется использовать Certificate Manager для получения и автоматической ротации сертификатов.

При работе с TLS в приложении рекомендуется ограничивать список доверенных корневых сертификатов (root CA).

При использовании технологий certificatepinning следует учитывать, что сервис Let’sEncrypt выдает сертификаты со [сроком действия в 90 дней](https://letsencrypt.org/docs/faq/#what-is-the-lifetime-for-let-s-encrypt-certificates-for-how-long-are-they-valid).

Рекомендуется заблаговременно обновлять сертификат, если вы не используете [автоматическое обновление](../../certificate-manager/concepts/challenges.md#auto).

| ID требования | Критичность |
| --- | --- |
| ENV29 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В консоли управления выберите облако или каталог, в которых необходимо проверить ВМ.
  1. В списке сервисов выберите **Yandex Certificate Manager**.
  1. Зайдите в настройки каждого сертификата и найдите параметр **Дата окончания**.
  1. Если в параметре указано, что сертификат проживет еще как минимум 30 дней, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый ID:

     ```bash
     yc organization-manager organization list
     ```

  1. Найдите все сертификаты вашей организации с датой окончания:

     ```bash
     export ORG_ID=<ID организации>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do for CERT_ID in $(yc certificate-manager certificate list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); \
     do yc certificate-manager certificate get --id $CERT_ID --format=json | jq -r '. | "Date of the end " + .not_after + " --- Cert_ID " + .id'
     done;
     done;
     done
     ```

  1. Если срок действия сертификата истекает более чем через 30 дней, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению**:

Обновите сертификат либо настройте автоматическое обновление.

### Yandex Managed Service for GitLab {#git-lab-service}

#### 3.32 Выполняются рекомендации по настройке безопасности инстанса GitLab {#git-lab-secure}

Рекомендации представлены [здесь](../../managed-gitlab/concepts/security.md#secure-instance). 

| ID требования | Критичность |
| --- | --- |
| ENV30 | Средняя |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Необходимо проверить вручную.

{% endlist %}

#### 3.33 Выполнены требования к защите приложений в GitLab {#gl-app-container-registry}

| ID требования | Критичность |
| --- | --- |
| ENV45 | Средняя |

##### 3.33.1 Применяются защищенные шаблоны безопасного пайплайна {#pipeline-blocks}

При работе с Managed Service for GitLab убедитесь, что вы применяете встроенные механизмы безопасности GitLab для защиты вашего пайплайна. Доступны следующие [варианты использования](../../managed-gitlab/concepts/security.md#security-pipeline-usage) пайплайна в ваших проектах:

* Создание пайплайна в отдельном проекте и подключение его к другим проектам с помощью [функции `include`](https://docs.gitlab.com/ee/ci/yaml/includes.html). Доступно для всех типов лицензий.
* Использование [механизма `Compliance framework and pipeline`](https://docs.gitlab.com/ee/user/project/settings/index.html#compliance-frameworks), который будет выполняться в любом проекте группы. Механизм доступен для типа лицензии `Ultimate`.
* Копирование секции пайплайна в файлы `.gitlab-ci.yml` ваших проектов.

| ID требования | Критичность |
| --- | --- |
| ENV46 | Информационная |

##### 3.33.2 Настроены правила ревью кода {#setup-code-review}

[Yandex Managed Service for GitLab](../../managed-gitlab/index.md) позволяет гибко настраивать обязательные [правила ревью кода](../../managed-gitlab/concepts/approval-rules.md), прежде чем этот код может быть добавлен в целевую [ветку проекта](../../glossary/vcs.md#branch). Функциональность является альтернативой встроенному в GitLab Enterprise Edition инструменту [Approval Rules](https://docs.gitlab.com/ee/user/project/merge_requests/approvals/rules.html) и доступна вне зависимости от [версии](https://about.gitlab.com/pricing) GitLab.

Если в [инстансе GitLab](../../managed-gitlab/concepts/index.md#instance) включены правила ревью кода, Managed Service for GitLab анализирует подтверждения от ревьюеров на соответствие заданным правилам. Если подтверждений недостаточно, в мерж-реквесте создается техническая дискуссия, блокирующая его интеграцию в целевую ветку. При изменении мерж-реквеста в дискуссии создается или обновляется комментарий с текущим статусом соответствия правилам. Когда все необходимые подтверждения получены, дискуссия закрывается.

Если закрыть техническую дискуссию вручную, она будет создана заново. В случае интеграции мерж-реквеста в обход заданных правил пользователи с ролью `Maintainer` и выше получат уведомление на электронную почту о нарушении установленного процесса ревью кода.

| ID требования | Критичность |
| --- | --- |
| ENV47 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором расположен инстанс GitLab.
  1. В списке сервисов выберите **Managed Service for&nbsp;GitLab**.
  1. Выберите нужный инстанс и в правом верхнем углу страницы нажмите **Редактировать**.
  1. Убедитесь, что в поле **Правила ревью кода** выбрана настроенная [конфигурация](../../managed-gitlab/concepts/approval-rules.md#packages) правил ревью кода.

{% endlist %}

**Инструкции и решения по выполнению**:

[Активация правил ревью кода в инстансе GitLab](../../managed-gitlab/operations/approval-rules.md#enable).

#### 3.34 Используются рекомендации по безопасности Yandex Managed Service for Kubernetes {#k8s-security}

Вы можете ознакомиться с рекомендациями в разделе [Требования к безопасности Kubernetes](kubernetes-security.md).

| ID требования | Критичность |
| --- | --- |
| ENV32 | Средняя |

#### 3.35 Для подключения к виртуальной машине или узлу Kubernetes используется OS Login {#os-login-onto-hosts}

[OS Login](../../organization/concepts/os-login.md) — это удобный способ управления подключениями к [виртуальным машинам](../../compute/concepts/vm.md) и узлам [кластеров](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) Yandex Managed Service for Kubernetes по SSH через [CLI](../../cli/quickstart.md) или через стандартный SSH-клиент c SSH-сертификатом или SSH-ключом, предварительно добавленным в профиль OS Login пользователя организации или [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) в Yandex Identity Hub.

OS Login связывает учетную запись пользователя виртуальной машины или узла Kubernetes с учетной записью пользователя организации или сервисного аккаунта. Чтобы управлять доступом к виртуальным машинам и узлам Kubernetes, на уровне организации [включите](../../organization/operations/os-login-access.md) опцию, разрешающую доступ по OS Login, а затем [активируйте](../../compute/operations/vm-connect/enable-os-login.md) доступ по OS Login отдельно на каждой виртуальной машине или узле Kubernetes.

Так можно легко управлять доступом к виртуальным машинам и узлам Kubernetes, назначая пользователю или сервисному аккаунту необходимые роли. Если у пользователя или сервисного аккаунта отозвать роли, он потеряет доступ ко всем виртуальным машинам и узлам Kubernetes, для которых включен доступ по OS Login.

| ID требования | Критичность |
| --- | --- |
| ENV33 | Низкая |

**Инструкции и решения по выполнению**:

* [Включить доступ по OS Login на уровне организации](../../organization/operations/os-login-access.md).
* [Настроить доступ по OS Login на существующей виртуальной машине](../../compute/operations/vm-connect/enable-os-login.md).
* [Подключиться к виртуальной машине по OS Login](../../compute/operations/vm-connect/os-login.md).
* [Подключиться к узлу Kubernetes по OS Login](../../managed-kubernetes/operations/node-connect-oslogin.md).

#### 3.36 Выполняется сканирование уязвимостей на уровне облачных IP-адресов {#ip-level}

Рекомендуем клиентам самостоятельно выполнять сканирование хостов на наличие уязвимостей. Облачные ресурсы поддерживают возможность установки собственных виртуальных образов сканеров уязвимостей либо программных агентов на хостах. Для сканирования существует множество как платных, так и бесплатных решений.

Сетевые сканеры выполняют сканирование хостов, доступных по сети. Как правило, в сетевых сканерах возможна настройка аутентификации. 

Примеры бесплатных сетевых сканеров:
- [Nmap](https://nmap.org/)
- [OpenVAS](https://www.openvas.org/)
- [OWASP ZAP](https://www.zaproxy.org/)

Пример бесплатного сканера, который работает в виде агента на хостах: [Wazuh](https://documentation.wazuh.com/current/user-manual/capabilities/vulnerability-detection/how_it_works.html). Wazuh может также использоваться в качестве системы обнаружения вторжений (host-based intrusion detection system — IDS).

Вы также можете воспользоваться [решением](https://yandex.cloud/ru/marketplace/products/scanfactory/scanfactory-saas) из Cloud Marketplace.

| ID требования | Критичность |
| --- | --- |
| ENV34 | Средняя |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Выполните проверку вручную.

{% endlist %}

#### 3.37 Внешние сканирования безопасности выполняются по правилам Yandex Cloud {#external-security-scans}

Клиенты, размещающие в Yandex Cloud собственное программное обеспечение, могут проводить для размещенного ПО внешние сканирования безопасности, в том числе тесты на проникновение. Вы можете проводить сканирование самостоятельно либо с привлечением подрядчиков. Подробнее в разделе [Правила проведения внешних сканирований безопасности](../compliance/pentest.md).

| ID требования | Критичность |
| --- | --- |
| ENV35 | Информационная |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Выполните проверку вручную.

{% endlist %}

#### 3.38 Выстроен процесс обновлений безопасности {#security-updates}

Клиент должен самостоятельно выполнять обновления безопасности в своей [зоне ответственности](../respons.md). Возможно применение различных автоматизированных инструментов для централизованных автоматических обновлений ОС и ПО.

Yandex Cloud публикует [бюллетени безопасности](../security-bulletins/index.md), чтобы оповещать клиентов о новых найденных уязвимостях и обновлениях безопасности.

| ID требования | Критичность |
| --- | --- |
| ENV36 | Средняя |

### Резервное копирование {#backup}

#### 3.39 Используется Cloud Backup или механизм snapshot по расписанию {#snapshot}

Убедитесь, что в вашей организации все виртуальные машины резервируются с помощью:
* снимков по расписанию;
* сервиса Cloud Backup.

| ID требования | Критичность |
| --- | --- |
| ENV37 | Высокая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В консоли управления выберите облако или каталог, в которых необходимо проверить ВМ.
  1. В списке сервисов выберите Compute Cloud.
  1. Убедитесь, что на ВМ настроена политика снимков по расписанию.
  1. В списке сервисов выберите Cloud Backup.
  1. Убедитесь, что он включен.

{% endlist %}


### Yandex API Gateway {#api-gateway}

API-шлюз — это интерфейс взаимодействия с сервисами внутри Yandex Cloud или в интернете. Шлюз задается декларативно при помощи спецификации по стандарту [OpenAPI 3.0](https://www.openapis.org/what-is-openapi).


#### 3.40 Настроено управление доступом в API Gateway {#api-gateway-access-managment}

Пользователь Yandex Cloud может выполнять только те операции над ресурсами, которые разрешены назначенными ему [ролями](../../iam/concepts/access-control/roles.md). Пока у пользователя нет никаких ролей, почти все операции ему запрещены.

Все операции в Yandex Cloud проверяются в сервисе [Yandex Identity and Access Management](../../iam/index.md). Если у субъекта нет необходимых разрешений, сервис вернет ошибку.

Убедитесь, что пользователь Yandex Cloud имеет доступ к ресурсам сервиса API Gateway ([API-шлюза](../../api-gateway/concepts/index.md)). Для этого у него должны быть нужные роли. Назначать роли на API-шлюз могут пользователи, у которых есть роль `api-gateway.admin` или одна из следующих ролей:

* `admin`;
* `resource-manager.admin`;
* `organization-manager.admin`;
* `resource-manager.clouds.owner`;
* `organization-manager.organizations.owner`.

| ID требования | Критичность |
| --- | --- |
| ENV48 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В консоли управления выберите облако и каталог, в которых необходимо проверить доступ к API-шлюзу.
  1. Перейдите на вкладку **Права доступа**.
  1. Убедитесь, что пользователям назначены нужные роли для доступа к шлюзу.

{% endlist %}

Роль на API-шлюз можно назначить также через Yandex Cloud [CLI](../../cli/cli-ref/serverless/cli-ref/api-gateway/add-access-binding.md) или [API](../../api-gateway/api-ref/apigateway/authentication.md).

Подробнее о том какие роли действуют в сервисе API Gateway см. в разделе [Какие роли действуют в сервисе](../../api-gateway/security/index.md#roles-list).


#### 3.41 Настроено сетевое взаимодействие в API Gateway {#networking}

По умолчанию API-шлюз находится в изолированной IPv4-сети с включенным [NAT-шлюзом](../../vpc/concepts/gateways.md). Поэтому из него доступны только публичные IPv4-адреса.

Чтобы шлюз имел доступ не только в интернет, но и к пользовательским ресурсам, [укажите](../../api-gateway/operations/api-gw-network-add.md) в настройках API-шлюза [облачную сеть](../../vpc/concepts/network.md#network) в которой находятся эти ресурсы.

Облачная сеть должна соответствовать следующим условиям:
* Имеет [подсети](../../vpc/concepts/network.md#subnet) во всех [зонах доступности](../../overview/concepts/geo-scope.md).
* Есть хотя бы один ресурс, IP-адрес которого находится в указанной облачной сети.

{% note info %}

Если сеть не соответствует условиям выше, сервис не гарантирует ее работу.

{% endnote %}

Если пользователь укажет сеть в настройках API-шлюза, в каждой зоне доступности создастся служебная подсеть с адресами из диапазона `198.19.0.0/16`. API-шлюз получит IP-адрес из соответствующей подсети и доступ ко всем ресурсам сети.

| ID требования | Критичность |
| --- | --- |
| ENV49 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В консоли управления выберите каталог, в котором находится API-шлюз.
  1. В списке сервисов выберите **API Gateway**.
  1. Выберите в списке нужный API-шлюз.
  1. Убедитесь, что в разделе **Обзор** указана облачная сеть.

{% endlist %}

**Инструкции и решения по выполнению**:

Если API-шлюзу не требуется доступ к ресурсам из указанной облачной сети, удалите ее из настроек шлюза. Подробнее см. в статье [Изменить API-шлюз](../../api-gateway/operations/api-gw-update.md).

#### 3.42 Учтены рекомендации по использованию своих доменов {#using-own-domain}

Сервис API Gateway интегрирован с системой управления доменами сервиса Certificate Manager.

Если вы используете в сервисе API Gateway свои домены с подтвержденными правами при обращении к API:

* Регулярно [проверяйте актуальность](../../certificate-manager/operations/managed/cert-update.md) TLS-сертификата, привязанного к домену.
* Используйте для работы [протокол TLS](../../storage/concepts/tls.md) версии 1.2 или выше.
* Используйте [дополнительные механизмы защиты](../../api-gateway/concepts/extensions/index.md): системы обнаружения вторжений и защиты от DDoS-атак.

| ID требования | Критичность |
| --- | --- |
| ENV50 | Информационная |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Выполните проверку вручную версии протокола TLS и актуальность сертификата TLS-соединения.

{% endlist %}

Подробнее о доменах читайте в разделе [Интеграция системы управления доменами с сервисами Yandex Cloud](../../certificate-manager/concepts/domains/services.md).

#### 3.43 Учтены рекомендации по использованию протокола WebSocket {#websocket}

Для организации асинхронного двунаправленного взаимодействия между клиентами и API-шлюзом сервис API Gateway поддерживает протокол [WebSocket](https://ru.wikipedia.org/wiki/WebSocket). Чтобы подключиться к API-шлюзу по протоколу WebSocket, можно использовать служебный домен, выделяемый при создании API-шлюза, или любой другой, добавленный к API-шлюзу.

Управлять веб-сокетами можно с помощью [API](../../api-gateway/api-ref/websocket/authentication.md), который позволяет получить информацию о соединении, отправить данные на клиентскую сторону и закрыть соединение.

Рекомендуется подключаться к API-шлюзу по протоколу WebSocket используя:
* [Протокол TLS](../../storage/concepts/tls.md) версии 1.2 или выше, регулярно [проверяя актуальность](../../certificate-manager/operations/managed/cert-update.md) сертификата TLS-соединения.
* [Механизмы аутентификации и авторизации](#authorization), предусмотренные спецификацией OpenAPI 3.0.
* [Расширения спецификации API-шлюза](../../api-gateway/concepts/extensions/index.md), с помощью которых вы можете усилить безопасность виртуальной среды.

| ID требования | Критичность |
| --- | --- |
| ENV51 | Информационная |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В консоли управления выберите каталог, в котором находится API-шлюз.
  1. В списке сервисов выберите **API Gateway**.
  1. Выберите в списке нужный API-шлюз.
  1. Настройте интеграции в OpenAPI-спецификации, используя операции: `x-yc-apigateway-websocket-message`, `x-yc-apigateway-websocket-connect` или `x-yc-apigateway-websocket-disconnect`.

{% endlist %}

Подробнее см. в статье [Работа с API-шлюзом по протоколу WebSocket](../../api-gateway/tutorials/api-gw-websocket.md).

#### 3.44 Настроено взаимодействие API-шлюза с сервисами {yandex-cloud} {#inter-cloud-services}

Убедитесь, что в сервисе API Gateway спецификация дополнена расширениями, усиливающими безопасность.

| ID требования | Критичность |
| --- | --- |
| ENV52 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В консоли управления выберите каталог, в котором находится API-шлюз.
  1. В списке сервисов выберите **API Gateway**.
  1. Выберите в списке нужный API-шлюз.
  1. В блоке **Спецификация** использован стандарт OpenAPI 3.0.

{% endlist %}

#### 3.45 Безопасность API-шлюза усилена расширениями {#inter-cloud-services}

В расширении `x-yc-apigateway:smartWebSecurity` использованы правила [профиля безопасности Yandex Smart Web Security](../../smartwebsecurity/concepts/profiles.md) с условиями для применения определенных действий к HTTP-запросам, приходящим к защищаемому ресурсу:
* [Базовые правила](../../smartwebsecurity/concepts/rules.md#base-rules) блокируют нежелательный трафик.
* Правило [Smart Protection](../../smartwebsecurity/concepts/rules.md#smart-protection-rules) для всего трафика дает наиболее полную и прозрачную защиту.
* [Advanced Rate Limiter](../../smartwebsecurity/concepts/arl.md) устанавливает ограничения на количество запросов, снижая нагрузку на веб-приложения и защищает бэкенд от исчерпания ресурсов.
* Профиль [WAF](../../smartwebsecurity/concepts/waf.md) анализирует входящие HTTP-запросы к веб-приложению по предварительно настроенным правилам, защищая от DoS/DDoS-атак.

| ID требования | Критичность |
| --- | --- |
| ENV53 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В консоли управления выберите каталог, в котором находится API-шлюз.
  1. В списке сервисов выберите **API Gateway**.
  1. Выберите в списке нужный API-шлюз.
  1. Убедитесь, что в блоке **Спецификация** использовано расширение `x-yc-apigateway:smartWebSecurity`, которое защищает API-шлюз и с ним ваше приложение, функцию или контейнер от DDoS-атак, на основе правил профиля безопасности Yandex Smart Web Security.

{% endlist %}

#### 3.46 Настроена авторизация в API-шлюзе {#authorization}

Рекомендуется использовать стандартные механизмы аутентификации и авторизации API Gateway, предусмотренные спецификацией OpenAPI 3.0. На данный момент доступна авторизация с помощью функции и с помощью JWT.

* [Авторизация с помощью функции Cloud Functions](../../api-gateway/concepts/extensions/function-authorizer.md). Для авторизации HTTP-запроса API Gateway вызывает `x-yc-apigateway-authorizer:function` расширение, в настоящее время поддержаны три типа: `HTTP Basic`, `HTTP Bearer` и `API Key`.
* [Авторизация с помощью JWT](../../api-gateway/concepts/extensions/jwt-authorizer.md). Для авторизации HTTP-запроса API Gateway валидирует токен, а также проверяет его подпись при помощи публичных ключей: поддержаны адрес, место, поля, тело, время, режим кеширования и время хранения кеша.

| ID требования | Критичность |
| --- | --- |
| ENV54 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В консоли управления выберите каталог, в котором находится API-шлюз.
  1. В списке сервисов выберите **API Gateway**.
  1. Выберите в списке нужный API-шлюз.
  1. Убедитесь, что в блоке **Спецификация** настроены расширения `x-yc-apigateway-authorizer:jwt` или `x-yc-apigateway-authorizer:function`.

{% endlist %}

#### 3.47 Использован контекст авторизации {#auth-context}

Рекомендуется использовать [контекст авторизации](../../api-gateway/concepts/extensions/function-authorizer.md#context) в [запросе](../../functions/concepts/function-invoke.md#request) внутри поля `requestContext.authorizer`. Это позволит сохранить целостность данных и предотвратить несанкционированный доступ.

| ID требования | Критичность |
| --- | --- |
| ENV55 | Средняя |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Убедитесь, что в настройках спецификации API-шлюза при использовании расширения `x-yc-apigateway-authorizer:function` настроен контекст авторизации.

{% endlist %}

#### 3.48 Использовано логирование сервиса {#api-logs}

Рекомендуется включать механизм логирования при создании API-шлюза. Подробнее см. в статье [Записать логи в журнал выполнения в API Gateway](../../api-gateway/operations/api-gw-logs-write.md).

| ID требования | Критичность |
| --- | --- |
| ENV56 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В консоли управления выберите каталог, в котором находится API-шлюз.
  1. В списке сервисов выберите **API Gateway**.
  1. Выберите в списке нужный API-шлюз.
  1. Убедитесь, что в блоке **Логирование** включена **Запись логов**, а также настроены назначение и уровень логирования шлюза.

{% endlist %}

 Для анализа работы API-шлюза используйте аудитные логи, которые передаются в сервис [Yandex Audit Trails](../../../api-gateway/at-ref/).

# Требования к шифрованию данных и управлению ключами и секретами

## 4. Шифрование данных и управление ключами {#data-encryption-and-key-management}


Yandex Cloud предоставляет встроенные функции шифрования при использовании ряда сервисов. В зоне ответственности клиента находится включение шифрования в этих сервисах, а также самостоятельная реализация шифрования в других компонентах обработки критичных данных. Для шифрования данных и управления ключами шифрования предназначен сервис [Key Management Service](../../kms/index.md) (KMS).

API сервисов Yandex Cloud поддерживают наборы алгоритмов (cipher suits) и версии протокола TLS, отвечающие требованиям стандарта PCI DSS и другим стандартам.

### Шифрование в состоянии покоя (at rest) {#at-rest}

По умолчанию все пользовательские данные в состоянии покоя (at rest) зашифрованы на уровне Yandex Cloud. Шифрование на уровне Yandex Cloud является реализацией одной из лучших практик по защите данных пользователей и выполняется на ключах Yandex Cloud.

Если ваша корпоративная политика информационной безопасности предъявляет требования к длине ключа или частоте [ротации ключей](../../kms/operations/key.md#rotate), вы можете шифровать данные собственными ключами. Для этого можно использовать сервис KMS и его интеграцию с другими сервисами Yandex Cloud, либо реализовать шифрование на уровне Data plane полностью самостоятельно.

Yandex Cloud предоставляет функции шифрования в состоянии покоя (at rest) для следующих сервисов:
* Compute Cloud (шифрование дисков ВМ);
* Object Storage (шифрование бакетов);
* Managed Service for Kubernetes (шифрование секретов).

#### 4.1 Включено шифрование дисков в Yandex Compute Cloud {#compute-encryption}

| ID требования | Критичность |
| --- | --- |
| CRYPT17 | Высокая |

**Поиск зашифрованных дисков ВМ:**

{% list tabs group=instructions %}

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый ID:

     ```bash
     yc organization-manager organization list
     ```

  1. Выполните команду для поиска зашифрованных дисков:

      {% cut "**Bash**" %}

      ```bash
      export ORG_ID=<ID_организации>
      CLOUDS=$(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id')

      echo "Encrypted disks:"
      for CLOUD_ID in $CLOUDS
        do
        FOLDERS=$(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id')
        for FOLDER_ID in $FOLDERS
        do
          DISKS=$(yc compute disk list --folder-id $FOLDER_ID --format=json | jq -r '.[] | select(.kms_key.key_id)' | jq -r '.id')

          if [[ -n "$DISKS" ]]; then
            for DISK in $DISKS
            do
              DISKDATA=$(yc compute disk get --id $DISK --folder-id $FOLDER_ID --format=json)
              VM_ID=$(echo $DISKDATA| jq -r '.instance_ids[]')

              VMDATA=""

              if [[ -n "$VM_ID" ]]; then
                VMDATA=$(yc compute instance get --id $VM_ID --folder-id $FOLDER_ID --format=json)
              fi

              echo "------------"
              echo "CLOUD_ID:" $CLOUD_ID
              echo "FOLDER_ID:" $FOLDER_ID
              echo "DISK_ID: "$(echo $DISKDATA | jq -r '.id')
              echo "DISK_NAME: "$(echo $DISKDATA | jq -r '.name')
              echo "DISK_TYPE: "$(echo $DISKDATA | jq -r '.type_id')
              echo "DISK_ZONE: "$(echo $DISKDATA | jq -r '.zone_id')
              echo "DISK_SIZE: "$(echo $DISKDATA | jq -r '.size')
              echo "DISK_KEY: "$(echo $DISKDATA | jq -r '.kms_key')

              if [[ -n "$VMDATA" ]]; then
                echo "VM_ID: "$(echo $VMDATA | jq -r '.id')
                echo "VM_NAME: "$(echo $VMDATA | jq -r '.name')
                echo "VM_STATUS: "$(echo $VMDATA | jq -r '.status')
              fi
              echo "------------"
            done
          fi
        done
      done
      ```

      {% endcut %}

      {% cut "**PowerShell**" %}

      ```powershell
      $ORG_ID = "<ID_организации>"

      $Clouds = yc resource-manager cloud list --organization-id=$ORG_ID --format=json | ConvertFrom-Json | Select @{n="CloudID";e={$_.id}}, created_at, @{n="CloudName";e={$_.name}}, organization_id

      $EncryptedVMs = @()
      $VMDisks = @()

      foreach ($Cloud in $Clouds) {
        $Folders = yc resource-manager folder list --cloud-id $Cloud.CloudID --format=json | ConvertFrom-Json

        foreach($Folder in $Folders) {
          $FolderDiskList = yc compute disk list --folder-id $Folder.id --format=json | ConvertFrom-Json | where{$_.kms_key}

          foreach($Disk in $FolderDiskList) {
            $VMData = $null

            if($Disk.instance_ids) {
              $VMData = yc compute instance get --id $Disk.instance_ids --folder-id $Folder.id --format=json | ConvertFrom-Json
            }

            $EncryptedVMs += $Disk | Select @{n="CloudID";e={$Cloud.CloudID}}, @{n="CloudName";e={$Cloud.CloudName}}, @{n="FolderID";e={$Folder.id}}, @{n="FolderName";e={$Folder.name}}, @{n="DiskID";e={$_.id}}, @{n="DiskName";e={$_.name}}, @{n="DiskType";e={$_.type_id}}, zone_id, @{n="DiskSize";e={$_.size/1GB}}, kms_key, @{n="VMID";e={$VMData.id}}, @{n="VMName";e={$VMData.name}}, @{n="VMStatus";e={$VMData.status}}
          }
        }
      }

      $EncryptedVMs
      ```

      {% endcut %}

{% endlist %}

Проверьте список возвращенных зашифрованных дисков. Если список соответствует вашей модели угроз, то дополнительных действий не требуется. Если какие-либо диски отсутствуют в списке, то выполните следующие действия:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится диск.
  1. В списке сервисов выберите **Compute Cloud**.
  1. На панели слева выберите ![image](../../_assets/console-icons/hard-drive.svg) **Диски** и найдете в списке диск, который требуется зашифровать.

      Если диск присоединен к ВМ и ВМ включена, рекомендуется выключить ее.
  1. [Создайте](../../compute/operations/disk-control/create-snapshot.md) снимок диска.
  1. Создайте из полученного снимка новый зашифрованный диск:

      1. Нажмите кнопку **Создать диск**.
      1. В открывшейся форме:
          1. В поле **Имя** задайте имя диска.
          1. В поле **Зона доступности** укажите нужную [зону доступности](../../overview/concepts/geo-scope.md).
          1. В поле **Наполнение** выберите `Снимок` и выберите созданный ранее снимок.
          1. В поле **Тип** задайте необходимый [тип диска](../../compute/concepts/disk.md#disks-types).
          1. В блоке **Шифрование** включите опцию **Зашифрованный диск** и выберите или создайте [ключ шифрования](../../kms/concepts/key.md) KMS.
          1. Нажмите кнопку **Создать диск**.
  1. После создания зашифрованного диска присоедините его к нужной ВМ вместо незашифрованного.

{% endlist %}

#### 4.2 В Yandex Object Storage включено шифрование данных at rest с ключом KMS {#storage-kms}

Для защиты критичных данных в Yandex Object Storage рекомендуется использовать шифрование бакета на стороне сервера с помощью ключей Yandex Key Management Service (server-side encryption). Такое шифрование защищает от случайной или намеренной публикации содержимого бакета в интернете. Подробнее см. в разделе [Шифрование](../../storage/concepts/encryption.md) документации Object Storage.

| ID требования | Критичность |
| --- | --- |
| CRYPT1 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В консоли управления выберите облако или каталог, в которых необходимо проверить бакеты.
  1. В списке сервисов выберите **Object Storage**.
  1. Перейдите в настройки бакета.
  1. Перейдите на вкладку **Шифрование**.
  1. Убедитесь, что шифрование включено и указан KMS ключ шифрования.
  1. Если шифрование включено, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

- Проверка через CLI {#cli}

  1. [Настройте](../../storage/tools/aws-cli.md) AWS CLI на работу с облаком.
  1. Выполните команду, чтобы проверить, что шифрование включено:

     ```bash
     aws --endpoint-url=https://storage.yandexcloud.net/ \
     s3api get-bucket-encryption \
     --bucket <имя бакета>
     ```

  1. Если шифрование включено, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению:**

Настройте шифрование бакета согласно [инструкции](../../storage/operations/buckets/encrypt.md).

### Шифрование в состоянии передачи (in transit) {#in-transit}

В большинстве случаев соединение с сервисами Yandex Cloud возможно только с использованием HTTPS. Однако в некоторых сценариях data plane доступ к сервисам может быть осуществлен и по HTTP, без шифрования соединения на прикладном уровне. Во всех таких сценариях у пользователя есть возможность выбрать в настройках сервиса, какой протокол использовать при data plane-операциях: HTTP или HTTPS, а в случае выбора HTTPS указать собственный TLS-сертификат.

{% note info %}

Убедитесь, что используете для работы (или соединения) с API сервисов Yandex Cloud протокол TLS версии 1.2 и выше, так как более ранние версии подвержены уязвимостям.

Например, использование gRPC-интерфейсов Yandex Cloud гарантирует работу по TLS 1.2 и выше, так как протокол HTTP/2, на основе которого работает gRPC, устанавливает TLS 1.2 в качестве минимальной поддерживаемой версии протокола TLS.

Поддержка устаревших протоколов TLS в сервисах Yandex Cloud [будет постепенно прекращена](../security-bulletins/index.md).

{% endnote %}

Yandex Cloud предоставляет возможность использования собственных TLS-сертификатов для следующих сервисов:
* Object Storage;
* Application Load Balancer;
* API Gateway;
* Cloud CDN.

#### 4.3 В Yandex Object Storage включено HTTPS для хостинга статического сайта {#storage-https}

[Object Storage](../../storage/index.md) поддерживает безопасное подключение по протоколу HTTPS. Вы можете загрузить собственный сертификат безопасности, если к сайту в Object Storage требуется доступ по протоколу HTTPS. Также доступна интеграция с сервисом [Certificate Manager](../../certificate-manager/index.md). См. инструкции в документации Object Storage:
* [Настройка HTTPS](../../storage/operations/hosting/certificate.md)
* [Бакет](../../storage/concepts/bucket.md)

При работе с сервисом [Object Storage](../../storage/index.md) необходимо убедиться, что в клиенте отключена поддержка протоколов TLS ниже версии 1.2. При помощи политики (bucket policy) [`aws:securetransport`](../../storage/s3/api-ref/policy/conditions.md) необходимо проверить, что для бакета настроен запрет на работу без протокола TLS.

| ID требования | Критичность |
| --- | --- |
| CRYPT2 | Высокая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) в списке сервисов выберите **Object Storage** и перейдите в нужный бакет.
  1. На панели слева выберите ![image](../../_assets/console-icons/persons-lock.svg) **Безопасность**.
  1. Выберите вкладку **HTTPS**.
  1. Убедитесь, что доступ по протоколу HTTPS включен и указан TLS-сертификат.
  1. Если доступ по HTTPS включен, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

- Проверка через CLI {#cli}

  Выполните команду, указав имя нужного бакета:

  ```bash
  yc storage bucket get-https <имя_бакета>
  ```

  Если в поле `certificate_id` команда вернула идентификатор сертификата, значит доступ по протоколу HTTPS включен и рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению:**

[Включите](../../storage/operations/hosting/certificate.md) доступ по HTTPS, если бакет используется для хостинга статического сайта.

#### 4.4 В Yandex Application Load Balancer используется HTTPS {#alb-https}

Сервис [Application Load Balancer](../../application-load-balancer/index.md) поддерживает HTTPS-обработчик с загрузкой [сертификата](../../certificate-manager/concepts/imported-certificate.md) из Certificate Manager. См. [описание настройки обработчика](../../application-load-balancer/concepts/application-load-balancer.md#listener) в документации Yandex Application Load Balancer.

| ID требования | Критичность |
| --- | --- |
| CRYPT3 | Высокая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}
 
  1. В консоли управления выберите облако или каталог, в которых необходимо проверить балансировщики.
  1. В списке сервисов выберите **Application Load Balancer**.
  1. Перейдите в настройки балансировщика.
  1. Убедитесь, что у обработчика указан протокол **HTTPS**.
  1. Если указан HTTPS, рекомендация выполняется. Если нет, перейдите к п. «Инструкции и решения по выполнению».

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый ID:

     ```bash
     yc organization-manager organization list
     ```

  1. Выполните команду для вывода списка всех балансировщиков без https:

      {% cut "**Bash**" %}

      ```bash
      export ORG_ID=<ID_организации>
      CLOUDS=$(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id')
      for CLOUD_ID in $CLOUDS
      do
        FOLDERS=$(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id')
        for FOLDER_ID in $FOLDERS
        do
          yc application-load-balancer load-balancer list --folder-id $FOLDER_ID --format=json | jq -r '.[] | select(.listeners[0].tls | not)' | jq -r '.'
        done
      done
      ```

      {% endcut %}

      {% cut "**PowerShell**" %}

      ```powershell
      $ORG_ID = "<ID_организации>"

      $Clouds = yc resource-manager cloud list --organization-id $ORG_ID --format=json | ConvertFrom-Json | Select @{n="CloudID";e={$_.id}}, created_at, @{n="CloudName";e={$_.name}}, organization_id

      $ALBWithoutTLS = @()

      foreach ($Cloud in $Clouds) {
        $Folders = yc resource-manager folder list --cloud-id $Cloud.CloudID --format=json | ConvertFrom-Json

        foreach($Folder in $Folders) {
          $ALBWithoutTLS += yc application-load-balancer load-balancer list --folder-id $Folder.id --format=json | ConvertFrom-Json | where{!$_.listeners.tls}
        }
      }

      $ALBWithoutTLS
      ```

      {% endcut %}

  1. Если выведен пустой список, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению:**

Включите HTTPS обработчик согласно [инструкции](../../application-load-balancer/tutorials/tls-termination/index.md).

#### 4.5 В Yandex API Gateway используется HTTPS и собственный домен {#api-gateway-https}

[API Gateway](../../api-gateway/index.md) обеспечивает безопасное подключение по протоколу HTTPS. Вы можете привязать собственный домен и загрузить собственный сертификат безопасности для доступа к вашему [API-шлюзу](../../api-gateway/concepts/index.md) по протоколу HTTPS.

| ID требования | Критичность |
| --- | --- |
| CRYPT4 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В консоли управления выберите облако или каталог, в которых необходимо проверить шлюзы.
  1. В списке сервисов выберите **API Gateway → Настройки шлюза → Домены**.
  1. Убедитесь, что домен и сертификат подключены.
  1. Если домен и сертификат активны, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый ID:

     ```bash
     yc organization-manager organization list
     ```

  1. Выполните команду для вывода списка всех api gateway без подключенных доменов и сертификатов:

     ```bash
     export ORG_ID=<ID организации>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do for APIGW in $(yc serverless api-gateway list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); \
     do yc serverless api-gateway get --id $APIGW --format json | jq -r '. | select(.attached_domains[0].certificate_id | not)' | jq -r '.id'
     done;
     done;
     done
     ```

  1. Если выведен пустой список, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению:**

1. В консоли управления выберите облако или каталог, в которых необходимо подключить домены и сертификаты.
1. В списке сервисов выберите **API Gateway → Настройки шлюза → Домены**.
1. Подключите домены и сертификаты.

#### 4.6 В Yandex Cloud CDN используется HTTPS и собственный SSL-сертификат {#cdn-https}

[Cloud CDN](../../cdn/index.md) поддерживает безопасное подключение по протоколу HTTPS к источникам. Также вы можете загрузить собственный сертификат безопасности для доступа к вашему [CDN-ресурсу](../../cdn/concepts/resource.md) по протоколу HTTPS.

| ID требования | Критичность |
| --- | --- |
| CRYPT5 | Низкая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В консоли управления выберите облако или каталог, в которых необходимо проверить ресурсы.
  1. В списке сервисов выберите **Cloud CDN**.
  1. Перейдите в настройки ресурса, на вкладку **Дополнительно**.
  1. Убедитесь, что в поле **Протокол для источников** указан протокол **HTTPS**.
  1. Убедитесь, что в поле **Сертификат** указан собственный сертификат либо **Let’s encrypt**.
  1. Если указан HTTPS и собственный сертификат, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый ID:

     ```bash
     yc organization-manager organization list
     ```

  1. Выполните команду для вывода списка всех ресурсов без подключенных сертификатов и HTTPS до источников:

     ```bash
     export ORG_ID=<ID организации>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do for CDN in $(yc cdn resource list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); \
     do yc cdn resource get --id $CDN --format json | jq -r '. | select(.origin_protocol=="HTTPS" and .ssl_certificate.type=="CM" | not)' | jq -r '.id' 
     done;
     done;
     done
     ```

  1. Если выведен пустой список, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению:**

[Подключите](../../cdn/operations/resources/configure-basics.md) сертификат и HTTPS согласно инструкции.

### Самостоятельное шифрование {#self-encryption}

**При использовании сервисов, которые не имеют встроенных функций шифрования, шифрование критичных данных является ответственностью клиента.**

#### 4.7 Используется шифрование данных на уровне приложения {#self-data-app}

Для шифрования данных на уровне приложения (client-side encryption) перед их отправкой в бакет Yandex Object Storage вы можете использовать следующие подходы:
* Интеграция Object Storage с сервисом Key Management Service для шифрования данных на уровне приложения (client-side encryption). Подробнее смотрите в разделе «Рекомендуемые криптографические библиотеки».
* Шифрование данных на уровне приложения перед отправкой их в Object Storage с помощью сторонних библиотек. При использовании сторонних библиотек и собственных способов управления ключами следует убедиться, что схема работы, используемые алгоритмы и длины ключей соответствуют требованиям регуляторов.

Для шифрования данных на уровне приложения (client-side encryption) рекомендуется использовать следующие библиотеки:
* AWS Encryption SDK и его [интеграцию с KMS](../../kms/tutorials/encrypt/aws-encryption-sdk.md);
* Google Tink и ее [интеграцию с KMS](../../kms/tutorials/encrypt/google-tink.md);
* [SDK Yandex Cloud](../../kms/tutorials/encrypt/sdk.md) вместе с любой другой криптографической библиотекой, совместимой с PCI DSS или другими стандартами, применяемыми в вашей компании.

Сравнение библиотек представлено в разделе [Какой способ шифрования выбрать](../../kms/tutorials/encrypt/index.md) документации KMS.

| ID требования | Критичность |
| --- | --- |
| CRYPT7 | Высокая |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Убедитесь, что данные хранятся в зашифрованном виде.

{% endlist %}

#### 4.8 Используется шифрование дисков и снимков виртуальных машин {#managed-vm-kms}

По умолчанию все данные на дисках Yandex Compute Cloud шифруются на уровне базы данных хранилища с помощью системного ключа. Это позволяет защитить данные от компрометации в случае физической кражи дисков из дата-центров Yandex Cloud. 

Рекомендуем также использовать шифрование дисков и [снимков дисков](../../compute/concepts/snapshot.md) с помощью пользовательских [симметричных ключей](../../kms/concepts/key.md) Yandex Key Management Service. Такой подход позволяет:
* Защищаться от потенциальных угроз нарушения изоляции и компрометации данных на уровне виртуальной инфраструктуры.
* Контролировать шифрование и жизненный цикл ключей KMS, а также управлять ими. Подробнее см. в разделе [Управление ключами](../../kms/operations/key.md).
* Повысить уровень контроля доступа к данным на диске за счет необходимости прав на ключ KMS. Подробнее см. в разделе [Настройка прав доступа к симметричному ключу шифрования](../../kms/operations/key-access.md).
* Отслеживать операции шифрования и расшифрования вашим ключом KMS с помощью сервиса Yandex Audit Trails. Подробнее см. в разделе [Аудит использования ключей](../../kms/concepts/index.md#keys-audit).

Вы можете зашифровать диски следующих типов:
* Сетевой SSD-диск (`network-ssd`).
* Сетевой HDD-диск (`network-hdd`).
* Нереплицируемый SSD-диск (`network-ssd-nonreplicated`).
* Сверхбыстрое сетевое хранилище с тремя репликами (SSD) (`network-ssd-io-m3`).

| ID требования | Критичность |
| --- | --- |
| CRYPT8 | Средняя |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  При [создании диска](../../compute/operations/disk-create/empty.md) убедитесь, что включена опция **Зашифрованный диск**.

{% endlist %}

**Инструкции и решения по выполнению:**

[Зашифруйте](../../compute/operations/disk-control/disk-encrypt.md) диск виртуальной машины Yandex Compute Cloud.

### Управление ключами {#keys}

Для шифрования данных и управления ключами рекомендуется использовать [Key Management Service](../../kms/tutorials/encrypt/sdk.md). KMS предназначен для защиты данных в инфраструктуре Yandex Cloud, а также подходит для шифрования и расшифровки любых ваших данных.

KMS использует схему шифрования AES-GCM. Вы можете выбрать длину ключа: 128, 192 или 256 — и настроить период ротации ключей в зависимости от своих потребностей.

#### 4.9 Ключи Key Management Service хранятся в аппаратном модуле безопасности (HSM) {#keys-hsm}

В продакшн-среде рекомендуется использовать отдельные ключи, все крипто-операции с которыми будут выполняться только внутри специализированного аппаратного устройства. Подробнее см. статью [Аппаратный модуль безопасности (HSM)](../../kms/concepts/hsm.md).

Чтобы использовать HSM, при создании ключа выберите тип алгоритма AES-256 HSM. Все операции с этим ключом будут выполняться внутри HSM, дополнительные действия не требуются.

Рекомендуется использовать HSM для ключей KMS, это увеличивает уровень безопасности.

| ID требования | Критичность |
| --- | --- |
| CRYPT9 | Информационная |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В консоли управления выберите облако или каталог, в которых необходимо проверить ключи.
  1. В списке сервисов выберите **Key Management Service**.
  1. Перейдите на вкладку **Ключи**.
  1. Убедитесь, что в поле **Алгоритм шифрования** указан **AES-256 HSM**.
  1. Если указан AES-256 HSM, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый ID:

     ```bash
     yc organization-manager organization list
     ```

  1. Выполните команду для вывода списка всех ключей KMS организации и их алгоритмов шифрования:

     ```bash
     export ORG_ID=<ID организации>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do yc kms symmetric-key list --folder-id=$FOLDER_ID --format json | jq -r '.[] | "KEY_ID " + .id + "FOLDER_ID " + .folder_id + "ALGORITM_ID " + .default_algorithm' 
     done;
     done
     ```

  1. Если алгоритм шифрования содержит AES-256 HSM, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению:**

[Установите](../../kms/operations/symmetric-encryption.md) алгоритм шифрования для ключей KMS «AES-256 HSM».

#### 4.10 Права на управление ключами в KMS выданы контролируемым пользователям {#keys-controlled-users}

Для доступа к сервису KMS необходимо использовать [IAM-токен](../../iam/concepts/authorization/iam-token.md).

В случае автоматизации работы с KMS рекомендуется создать [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) и выполнять команды и скрипты от его имени. Если вы используете виртуальные машины, получите IAM-токен для сервисного аккаунта через механизм [назначения сервисного аккаунта](../../compute/operations/vm-connect/auth-inside-vm.md) виртуальной машине. Другие способы получения IAM-токена для сервисного аккаунта приведены в статье [Получение IAM-токена для сервисного аккаунта](../../iam/operations/iam-token/create-for-sa.md) документации IAM.

Рекомендуется выдавать пользователям и сервисным аккаунтам гранулярные доступы на конкретные ключи сервиса KMS. Подробнее см. статью [Управление доступом в Key Management Service](../../kms/security/index.md) документации KMS.

Подробнее о мерах безопасности при управлении доступом читайте в статье [Аутентификация и управление доступом](authentication.md).

Для того чтобы проверить права доступа к ключу KMS, необходимо проверить, у кого есть права:
* на организацию, облако, каталоги с правами: `admin`, `editor`, `kms.admin`, `kms.editor`, `kms.keys.encrypterDecrypter`;
* на ключи: `kms.keys.encrypterDecrypter` и `kms.editor`.

| ID требования | Критичность |
| --- | --- |
| CRYPT10 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}
 
  1. В консоли управления выберите облако или каталог, в которых необходимо проверить права на ключ.
  1. Перейдите на вкладку **Права доступа**.
  1. Убедитесь, что роли `admin`, `editor`, `kms.admin`, `kms.editor`, `kms.keys.encrypterDecrypter` имеют только контролируемые пользователи.
  1. Проверить права доступа к самим ключам возможно только через CLI.

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый ID:

     ```bash
     yc organization-manager organization list
     ```

  1. Выполните команду для поиска учетных записей на уровне организации:

     ```bash
     export ORG_ID=<ID организации>
     yc organization-manager organization list-access-bindings --id=${ORG_ID} --format=json | jq -r '.[] | select(.role_id=="admin" or .role_id=="editor" or .role_id=="kms.admin" or .role_id=="kms.editor" or .role_id=="kms.keys.encrypterDecrypter")'
     ```

  1. Если в списке отсутствуют учетные записи, рекомендация выполнена. В противном случае перейдите к п. «Инструкции и решения по выполнению».

  1. Найдите учетные записи с назначенными ролями на уровне облаков:

     ```bash
     export ORG_ID=<ID организации>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do yc resource-manager cloud list-access-bindings --id=$CLOUD_ID --format=json | jq -r '.[] | select(.role_id=="admin" or .role_id=="editor" or .role_id=="kms.admin" or .role_id=="kms.editor" or .role_id=="kms.keys.encrypterDecrypter")'
     done
     ```

  1. Если в списке отсутствуют учетные записи, рекомендация выполнена. В противном случае перейдите к п. «Инструкции и решения по выполнению».

  1. Выполните команду для поиска учетных записей с назначенными примитивными ролями на уровне всех каталогов в ваших облаках:

     ```bash
     export ORG_ID=<ID организации>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); \
     do yc resource-manager folder list-access-bindings --id=$FOLDER_ID --format=json | jq -r '.[] | select(.role_id=="admin" or .role_id=="editor" or .role_id=="kms.admin" or .role_id=="kms.editor" or .role_id=="kms.keys.encrypterDecrypter")' && echo $FOLDER_ID
     done;
     done
     ```

  1. Если в списке отсутствуют учетные записи, рекомендация выполнена. В противном случае перейдите к п. «Инструкции и решения по выполнению».

  1. Найдите учетные записи с назначенными ролями на уровне ключей:

     ```bash
     export ORG_ID=<ID организации>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do for KEY in $(yc kms symmetric-key list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); \
     do yc kms symmetric-key list-access-bindings --id $KEY --format json 
     done;
     done;
     done
     ```

{% endlist %}

**Инструкции и решения по выполнению:**

Проконтролируйте, кому предоставлен доступ к ключам KMS.

#### 4.11 Для KMS ключей включена ротация {#keys-rotation}

Для повышения безопасности инфраструктуры рекомендуется разделить ключи шифрования на две группы:
* Ключи для сервисов, которые обрабатывают критичные данные, но не хранят их. Например, Message Queue, Cloud Functions.
* Ключи для сервисов, которые хранят критичные данные. Например, Managed Services for Databases.

Для первой группы рекомендуется настроить автоматическую ротацию с периодом ротации больше, чем срок обработки данных в этих сервисах. По истечении периода ротации старые версии должны быть удалены. При автоматической ротации и удалении старых версий ключей ранее обработанные данные не могут быть восстановлены и расшифрованы.

Для сервисов хранения данных рекомендуется использовать либо ручные процедуры ротации, либо автоматическую ротацию ключей в зависимости от внутренних процедур обработки критичных данных.

Безопасным значением для AES-GCM является шифрование 4 294 967 296 (= 2<sup>32</sup>) блоков. После достижения этого количества шифрованных блоков необходимо создать новую версию ключа шифрования данных. Подробнее про режим работы AES-GCM см. в [материалах NIST](https://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication800-38d.pdf).

{% note info %}

Удаление какой-либо версии ключа равносильно уничтожению всех данных, зашифрованных с ее помощью. Ключ можно защитить от удаления с помощью установки параметра deletionProtection, однако этот параметр не защищает от удаления отдельных версий.	 

{% endnote %}

Подробнее о ротации ключей см. в разделе [Версия ключа](../../kms/concepts/version.md) документации KMS.

| ID требования | Критичность |
| --- | --- |
| CRYPT11 | Высокая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В консоли управления выберите облако или каталог, в которых необходимо проверить ключи.
  1. В списке сервисов выберите **Key Management Service**.
  1. Перейдите в настройки ключа.
  1. Найдите параметр **Период ротации**.
  1. Если в параметре указано любое значение, отличное от **Нет ротации**, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый ID:

     ```bash
     yc organization-manager organization list
     ```

  1. Выполните команду для вывода списка всех ключей KMS организации и их алгоритмов шифрования:

     ```bash
     export ORG_ID=<ID организации>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do yc kms symmetric-key list --folder-id=$FOLDER_ID --format=json | jq -r '.[] | select(.rotation_period | not)' | jq -r '.id' 
     done;
     done
     ```

  1. Если выведен пустой список, то рекомендация выполняется. Если нет, перейдите к п. «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению:**

Установите период ротации для ключей.

#### 4.12 Для ключей KMS включена защита от удаления {#keys-deletion-protection}

Удаление KMS ключа приводит к гарантированному удалению данных, поэтому необходимо защищать ключи от непреднамеренного удаления. В KMS существует соответствующая функция.

| ID требования | Критичность |
| --- | --- |
| CRYPT12 | Высокая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В консоли управления выберите облако или каталог, в которых необходимо проверить ключи.
  1. В списке сервисов выберите **Key Management Service**.
  1. Перейдите в настройки ключа.
  1. Найдите параметр **Защита от удаления**.
  1. Если в параметре указано **Да**, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый ID:

     ```bash
     yc organization-manager organization list
     ```

  1. Выполните команду для вывода списка всех ключей KMS без защиты от удаления:

     ```bash
     export ORG_ID=<ID организации>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do yc kms symmetric-key list --folder-id=$FOLDER_ID --format=json | jq -r '.[] | select(.deletion_protection | not)' | jq -r '.id' 
     done;
     done
     ```

  1. Если выведен пустой список, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению:**

Установите защиту от удаления.

### Управление секретами {#secrets}

Критичные данные и секреты для доступа к данным (токены аутентификации, API-ключи, ключи шифрования и т. п.) не следует использовать в открытом виде в коде, в названиях и описаниях объектов облака, в метаданных виртуальных машин и т. д. Вместо этого используйте сервисы для хранения секретов, такие как Lockbox или HashiCorp Vault.

#### 4.13 В организации используется Yandex Lockbox для безопасного хранения секретов {#secrets-lockbox}

Критичные данные и секреты для доступа к данным (токены аутентификации, API-ключи, ключи шифрования и т. п.) не следует использовать в открытом виде в коде, в названиях и описаниях объектов облака, в метаданных виртуальных машин и т. д. Вместо этого используйте сервисы для хранения секретов, такие как Lockbox.

Сервис Lockbox обеспечивает безопасное хранение секретов только в зашифрованном виде. Шифрование выполняется с помощью KMS. Для разграничения доступа к секретам используйте сервисные роли.

Инструкции по работе с сервисом см. в [документации](../../lockbox/index.md) Lockbox.

{% note info %}

При работе в Terraform рекомендуем [заполнять](../../terraform/resources/lockbox_secret_version.md) содержимое секрета скриптом. В таком случае содержимое не останется в файле `.tfstate`.

{% endnote %}

| ID требования | Критичность |
| --- | --- |
| CRYPT13 | Высокая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В консоли управления выберите облако или каталог, в которых необходимо проверить секреты.
  1. В списке сервисов выберите **Lockbox**.
  1. Убедитесь, что используется как минимум один секрет Lockbox.
  1. Если используется Lockbox, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый ID:

     ```bash
     yc organization-manager organization list
     ```

  1. Выполните команду для поиска как минимум одного секрета Lockbox:
 
     ```bash
     export ORG_ID=<ID организации>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do yc lockbox secret list --folder-id=$FOLDER_ID --format=json 
     done;
     done
     ```

  1. Если выведен пустой список, рекомендация выполняется. Если нет, перейдите к п. «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению:**

Храните секреты в Lockbox.

#### 4.14 Для Serverless Containers и Cloud Functions используются секреты Lockbox {#secrets-serverless-functions}

При работе с Serverless Containers или Cloud Functions часто возникает необходимость использовать секрет (токен, пароль и т.д.).

Если указать секретную информацию в переменных окружения, она может быть доступна для просмотра любому пользователю облака с правами на просмотр и использование функции и влечет за собой риски ИБ.

Рекомендуется использовать для этих целей интеграцию Serverless с Lockbox. Вы можете указать конкретный секрет из сервиса Yandex Lockbox и сервисный аккаунт с правами на данный секрет для использования его в функции или контейнере. 

Рекомендуется убедиться, что секреты используются именно таким образом. 

| ID требования | Критичность |
| --- | --- |
| CRYPT14 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В консоли управления выберите облако или каталог, в которых необходимо проверить функции.
  1. В списке сервисов выберите **Cloud Functions**.
  1. Перейдите в настройки функции, на вкладку **Редактор**.
  1. Найдите параметр **Секреты Lockbox**.
  1. Если в параметрах каждого объекта указано **Секреты Lockbox** или отсутствуют env с секретными данными, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

- Проверка через CLI {#cli}

  1. Выполните команду для поиска всех облачных функций, которые не используют секреты Lockbox и убедитесь, что в данных функциях не используются секретные данные в env:

     ```bash
     export ORG_ID=<ID организации>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do for VER in $(yc serverless function version list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); \
     do yc serverless function version get $VER --format=json | jq -r '. | select(.secrets | not)' | jq -r '.id' 
     done;
     done;
     done
     ```

  1. Если выведен пустой список, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению:**

Удалите секретные данные из env и воспользуйтесь функционалом интеграции с Lockbox:
* [Передать секреты Yandex Lockbox в контейнер](../../serverless-containers/operations/lockbox-secret-transmit.md).
* [Передать секреты Yandex Lockbox в функцию](../../functions/operations/function/lockbox-secret-transmit.md).

#### 4.15 При работе Container Optimized Image используется шифрование секретов {#secrets-coi}

KMS предоставляет возможность шифрования секретов, используемых в конфигурации Terraform, в частности, для передачи секретов на виртуальную машину в зашифрованном виде. См. инструкцию в разделе [Шифрование секретов в HashiCorp Terraform](../../kms/tutorials/terraform-secret.md) документации KMS. Передача секретов через переменные окружения в открытом виде небезопасна, поскольку они отображаются в свойствах ВМ.

| ID требования | Критичность |
| --- | --- |
| CRYPT15 | Высокая |

**Инструкции и решения по выполнению:**

[Шифрование секретов в Terraform для передачи на ВМ с Container Optimized Image](https://github.com/yandex-cloud-examples/yc-encrypt-coi-secrets).

Другие рекомендации по безопасному использованию Terraform см. в статье [Безопасная конфигурация: Terraform](virtualenv-safe-config.md#tf-using).

#### 4.16 Администратор облака имеет инструкцию по действиям в случае компрометации секретов его облака {#secrets-scanning}

В Yandex Cloud по умолчанию для всех включен [Secret Scanning Service](../operations/search-secrets.md).
Источники для обнаружения облачных структурированных секретов в открытом доступе:

* [Партнерская программа поиска секретов Yandex Cloud](../operations/search-secrets.md#leak-detection-affiliate-program).
* [GitHub Secret scanning partner program](../operations/search-secrets.md#github-secret-scanning).
* [GitLab Secret Detection](../operations/search-secrets.md#gitlab-secret-detection).
* [Поисковый индекс Яндекс](../operations/search-secrets.md#secret-is-leaked).
* [Helm-чарты в Yandex Cloud Marketplace](../operations/search-secrets.md#helm-charts).

Список облачных секретов для обнаружения:

* [API-ключи](../../iam/concepts/authorization/api-key.md).
* [IAM Cookies](../../iam/concepts/authorization/cookie.md).
* [IAM-токены](../../iam/concepts/authorization/iam-token.md).
* [Статические ключи доступа](../../iam/concepts/authorization/access-key.md).
* [OAuth-токен](../../iam/concepts/authorization/oauth-token.md).
* [Серверные ключи SmartCaptcha](../../smartcaptcha/concepts/keys.md).
* [Refresh-токены](../../iam/concepts/authorization/refresh-token.md).
* [Секреты OIDC-приложений](../../organization/concepts/applications.md#oidc-secret).

Сервис автоматически уведомляет клиента о найденном секрете, который относится к его инфраструктуре:

* по электронной почте;
* с помощью [событий](../../audit-trails/concepts/events.md) Yandex Audit Trails.

| ID требования | Критичность |
| --- | --- |
| CRYPT16 | Информационная |

**Инструкции и решения по выполнению:**

Убедитесь, что:

* [Контактные данные ответственного за организацию актуальны](authentication.md#org-contacts).
* [Включен сервис Yandex Audit Trails на уровне организации](audit-logs.md#audit-trails).
* Администратор ознакомлен с [инструкцией](../operations/search-secrets.md#secret-is-leaked) по действиям при компрометации секретов.

# Требования к сбору, мониторингу и анализу аудитных логов

## 5. Сбор, мониторинг и анализ аудитных логов {#audit--logs}


Аудитные логи (журналы аудита) — это записи обо всех событиях в системе, включая доступ к ней и выполненные операции. Сбор и проверка аудитных логов позволяют контролировать соблюдение установленных процедур и стандартов безопасности и выявить изъяны в механизмах безопасности.

События в аудитных логах относятся к различным уровням:
* [уровень Yandex Cloud](#audit-trails) — события, происходящие с ресурсами Yandex Cloud;
* [уровень ОС](#os-level);
* [уровень приложений](#app-level);
* [уровень сети](#network-level) (Flow Logs).

{% note info %}

О событиях Kubernetes читайте в разделе [Сбор, мониторинг и анализ аудитных логов в Yandex Managed Service for Kubernetes](../domains/kubernetes.md#collection-monitoring-analysis-audit-logs).

{% endnote %}

### Общее {#general}

#### 5.1 Включен сервис Yandex Audit Trails на уровне организации {#audit-trails}

Основным инструментом сбора логов уровня Yandex Cloud является сервис [Yandex Audit Trails](../../audit-trails/concepts/index.md). Сервис позволяет собирать аудитные логи о происходящих с ресурсами Yandex Cloud событиях и загружать эти логи в бакет Yandex Object Storage или лог-группу Cloud Logging для дальнейшего анализа или экспорта. См. [инструкцию](../../audit-trails/quickstart.md), как запустить сбор логов.

Аудитные логи Audit Trails могут содержать два разных типа событий: [события уровня конфигурации](../../audit-trails/concepts/events.md) и [события уровня сервисов](../../audit-trails/concepts/events-data-plane.md).

К [событиям уровня конфигурации](../../audit-trails/concepts/format.md) относятся действия, связанные с конфигурированием ресурсов Yandex Cloud, такие как создание, изменение или удаление компонентов инфраструктуры, пользователей или политик. К [событиям уровня сервисов](../../audit-trails/concepts/format-data-plane.md) относятся изменения и действия, которые происходят с данными и ресурсами внутри сервисов Yandex Cloud. По умолчанию Audit Trails не регистрирует события уровня сервисов. [Включать](../../audit-trails/quickstart.md#the-trail-creation) сбор аудитных логов уровня сервисов нужно отдельно для каждого из поддерживаемых сервисов.

Подробнее см. в разделе [Сравнение логов событий уровня конфигурации и уровня сервисов](../../audit-trails/concepts/control-plane-vs-data-plane.md).

 Для сбора метрик, анализа некоторых событий уровня Yandex Cloud и настройки оповещений рекомендуется использовать сервис [Yandex Monitoring](../../monitoring/index.md).  С его помощью возможно отслеживать, например, резкое возрастание нагрузки на Compute Cloud, RPS сервиса Application Load Balancer, значительные изменения в статистике событий сервиса Identity and Access Management.

Кроме того, Monitoring можно применять для мониторинга работоспособности самого сервиса Audit Trails и мониторинга событий безопасности. Выгрузка метрик в SIEM-систему возможна через [API](../../glossary/rest-api.md), см. [инструкцию](../../monitoring/operations/metric/get.md).

[Решение: Мониторинг Audit Trails и событий безопасности с помощью Monitoring](https://github.com/yandex-cloud-examples/yc-audit-trails-monitoring)

Аудитные логи возможно экспортировать в лог-группу [Cloud Logging](../../logging/index.md) или Data Streams и в SIEM-систему клиента для анализа информации о событиях и инцидентах.

Список важных событий уровня Yandex Cloud для поиска в аудитных логах:

[Решение: поиск важных событий безопасности в аудитных логах](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/_use_cases_and_searches)

Yandex Audit Trails возможно включить на уровне каталога, облака и организации. Рекомендуется включать Yandex Audit Trails на уровне всей организации — это позволит централизованно собирать аудитные логи, например, в отдельное облако безопасности.

| ID требования | Критичность |
| --- | --- |
| AUDIT1 | Высокая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В консоли управления выберите облако или каталог, в которых необходимо проверить функции.
  1. В списке сервисов выберите Yandex Audit Trails.
  1. Убедитесь, что в параметре Фильтр находится значение Организация.
  1. Дополнительно убедитесь, что назначение логов: bucket Yandex Object Storage, лог-группа [Cloud Logging](../../logging/index.md), Data Streams в рабочем состоянии и логи доступны для дальнейшего анализа.

{% endlist %}

#### 5.2 События Yandex Audit Trails экспортируются в SIEM-системы {#events}

Решения для экспорта аудитных логов Yandex Cloud подготовлены для следующих SIEM-систем:


* ArcSight — [Сбор, мониторинг и анализ аудитных логов во SIEM ArcSight](https://github.com/yandex-cloud-examples/yc-export-auditlogs-to-arcsight)

* Splunk — [Сбор, мониторинг и анализ аудитных логов в SIEM Splunk](https://github.com/yandex-cloud-examples/yc-export-auditlogs-to-splunk)

* MaxPatrol SIEM — [Сбор, мониторинг и анализ аудитных логов в MaxPatrol SIEM](../../audit-trails/tutorials/maxpatrol/index.md)

* Wazuh — [Сбор, мониторинг и анализ аудитных логов в Wazuh](https://github.com/yandex-cloud-examples/yc-export-auditlogs-to-wazuh/blob/main/README.md)

* KUMA — [Сбор, мониторинг и анализ аудитных логов в KUMA](../../tutorials/security/audit-trails-events-to-kuma/index.md)

Вы можете подробнее ознакомиться с MaxPatrol в [разделе](../../audit-trails/tutorials/maxpatrol/index.md).

Для настройки экспорта в любые SIEM подходят утилиты [GeeseFS](../../storage/tools/geesefs.md) или [s3fs](../../storage/tools/s3fs.md). Они позволяют смонтировать бакет Yandex Object Storage как локальный диск виртуальной машины. Далее на ВМ необходимо установить коннектор для SIEM и настроить вычитывание JSON-файлов из бакета. Либо утилиты совместимые с AWS Kinesis datastreams в случае, если вы направляете аудитные логи в Yandex Data Streams.


Вы также можете анализировать аудитные логи вручную, если у вас отсутствует SIEM-система, с помощью [поиска](../../audit-trails/tutorials/search-events-audit-logs/index.md) событий Yandex Cloud в Yandex Query, Cloud Logging или Object Storage.


| ID требования | Критичность |
| --- | --- |
| AUDIT2 | Информационная |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Убедитесь, что аудитные логи из Yandex Audit Trails экспортируются для анализа в SIEM-систему либо анализируются в облаке одним из способов.

{% endlist %}

#### 5.3 Настроено реагирование на события Yandex Audit Trails {#reaction}

Вы можете реагировать на события Yandex Audit Trails средствами вашей SIEM-системы либо вручную. Либо вы можете использовать автоматическое реагирование.

C помощью Yandex Cloud Functions можно настроить оповещения о событиях Audit Trails, а так же автоматическое реагирование на вредоносные действия, например  удаление опасных правил или прав доступа.

[Решение: уведомления и реагирование на события ИБ Audit Trails с помощью IAM / Cloud Functions + Telegram](https://github.com/yandex-cloud-examples/yc-audit-trails-automatic-response)

| ID требования | Критичность |
| --- | --- |
| AUDIT3 | Средняя |

#### 5.4 Выполнен hardering бакета Object Storage, где хранятся аудитные логи Yandex Audit Trails {#hardering}

Убедитесь, что в случае записи аудитных логов Yandex Audit Trails в bucket Yandex Object Storage сам бакет настроен в соответствии с лучшими практиками безопасности:

* [Отсутствует публичный доступ к бакету Yandex Object Storage](virtualenv-safe-config.md#bucket-access).
* [В Yandex Object Storage используются политики доступа (Bucket Policy)](virtualenv-safe-config.md#bucket-policy).
* [В Yandex Object Storage включена функция **Блокировка версии объекта** (object lock)](virtualenv-safe-config.md#object-lock).
* [В Yandex Object Storage включен механизм логирования действий с бакетом](virtualenv-safe-config.md#bucket-logs).
* [В Yandex Object Storage включено шифрование данных at rest с помощью ключа KMS](encryption.md#storage-kms).

Вы можете воспользоваться решением для настройки безопасного бакета Yandex Object Storage с помощью Terraform.

| ID требования | Критичность |
| --- | --- |
| AUDIT4 | Средняя |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Выполните проверку вручную.

{% endlist %}

#### 5.5 Выполняется сбор аудитных логов с уровня ОС {#os-level}

При использовании облачных сервисов по модели [IaaS](https://yandex.cloud/ru/blog/posts/2022/01/iaas) и использовании групп узлов Kubernetes клиент отвечает за безопасность ОС и выполняет сбор событий уровня ОС самостоятельно. Для сбора стандартных событий, которые генерирует ОС, и их экспорта в SIEM-систему клиента существуют бесплатные инструменты, такие как:
  * [Osquery](https://osquery.io/);
  * [Filebeat (ELK)](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-system.html);
  * [Wazuh](https://documentation.wazuh.com/current/getting-started/use_cases/log_analysis.html).

Дополнительные опции генерации событий возможно реализовать с помощью утилиты Auditd для Linux, Sysmon для Windows.

Системные метрики Linux (процессор, память, диск) можно собирать с помощью компонента [Unified Agent](../../monitoring/concepts/data-collection/unified-agent/index.md) сервиса Monitoring.

Также события ОС возможно экспортировать в Cloud Logging с  помощью [плагина Fluent bit](https://github.com/yandex-cloud/fluent-bit-plugin-yandex) либо в Data Streams.

Для описания событий, которые нужно искать в логах, рекомендуем использовать формат [Sigma](https://github.com/SigmaHQ/sigma), поддерживаемый популярными SIEM-системами. Репозиторий Sigma содержит [библиотеку событий](https://github.com/SigmaHQ/sigma/tree/master/rules), описанных в этом формате.

Чтобы получать точную хронологию событий уровня ОС и приложений, настройте синхронизацию часов по [инструкции](../../compute/tutorials/ntp.md).

Дополнительно рекомендуется повысить уровень логирования внутри виртуальных машин как минимум до [`VERBOSE`](https://en.wikipedia.org/wiki/Verbose_mode).

| ID требования | Критичность |
| --- | --- |
| AUDIT5 | Высокая |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Выполните проверку вручную.

{% endlist %}

#### 5.6 Выполняется сбор аудитных логов с уровня приложений {#app-level}

Сбор событий уровня приложений, развернутых на ресурсах Compute Cloud, клиент может выполнять самостоятельно. Например, записывать логи приложения в файл и передавать их в SIEM-систему с помощью инструментов, перечисленных в подразделе выше.

Включите сбор аудитных логов в используемых неуправляемых СУБД:

* Включите протоколирование всех действий аутентификации (успешных и неудачных).
* Активируйте логирование операций изменения данных (`INSERT`, `UPDATE`, `DELETE`).
* Настройте регистрацию операций изменения схемы (`ALTER`, `CREATE`, `DROP`).
* Фиксируйте изменения разрешений и привилегий.
* Настройте события для отслеживания запросов.

| ID требования | Критичность |
| --- | --- |
| AUDIT6 | Средняя |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Выполните проверку вручную.

{% endlist %}

#### 5.7 Выполняется сбор логов с уровня сети {#network-level}

Запись событий о сетевом трафике VPC (Flow Logs) на текущий момент может выполняться только средствами клиента. Для сбора и передачи событий могут использоваться решения из Yandex Cloud Marketplace (например, [NGFW](https://yandex.cloud/ru/marketplace?tab=software&search=NGFW), [IDS/IPS](https://yandex.cloud/ru/marketplace?tab=software&search=IDS%2FIPS), [сетевые продукты](https://yandex.cloud/ru/marketplace?categories=network)) либо бесплатное ПО. Также сбор логов уровня сети возможно выполнять с помощью различных агентов — HIDS и др.

| ID требования | Критичность |
| --- | --- |
| AUDIT7 | Средняя |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Выполните проверку вручную.

{% endlist %}

#### 5.8 Отслеживаются события уровня сервисов {#data-plane-events}

[Аудитный лог событий уровня сервисов](../../audit-trails/concepts/format-data-plane.md) — это запись о событиях, которые произошли с ресурсами Yandex Cloud, в форме JSON-объекта. Благодаря отслеживанию событий уровня сервисов вам будет проще собирать дополнительные события с облачных сервисов, что позволит эффективнее реагировать на инциденты безопасности в облаках. Кроме того, отслеживание событий уровня сервисов поможет обеспечить соответствие вашей облачной инфраструктуры нормативным правовым актам и отраслевым стандартам. Например, вы можете отслеживать получение сотрудниками доступа к конфиденциальным данным, хранящимся в [бакетах](../../storage/concepts/bucket.md).

Включать сбор аудитных логов уровня сервисов нужно отдельно для каждого из [поддерживаемых сервисов](../../audit-trails/concepts/control-plane-vs-data-plane.md#data-plane-events).

Рекомендуется включать **все события** для сервисов [Yandex Identity and Access Management](../../audit-trails/concepts/events-data-plane.md#iam) и [Yandex Cloud DNS](../../audit-trails/concepts/events-data-plane.md#dns), а также **все события** для следующих сервисов, если эти сервисы используются:

* [Yandex Certificate Manager](../../audit-trails/concepts/events-data-plane.md#certificate-manager)
* [Yandex Compute Cloud](../../audit-trails/concepts/events-data-plane.md#compute)
* [Yandex Key Management Service](../../audit-trails/concepts/events-data-plane.md#kms)
* [Yandex Lockbox](../../audit-trails/concepts/events-data-plane.md#lockbox)
* [Yandex Managed Service for ClickHouse®](../../audit-trails/concepts/events-data-plane.md#mch)
* [Yandex Managed Service for Kubernetes](../../audit-trails/concepts/events-data-plane.md#managed-service-for-kubernetes)
* [Yandex StoreDoc](../../audit-trails/concepts/events-data-plane.md#mmg)
* [Yandex Managed Service for MySQL®](../../audit-trails/concepts/events-data-plane.md#mmy)
* [Yandex Managed Service for PostgreSQL](../../audit-trails/concepts/events-data-plane.md#mpg)
* [Yandex Managed Service for Valkey™](../../audit-trails/concepts/events-data-plane.md#mrd)
* [Yandex Object Storage](../../audit-trails/concepts/events-data-plane.md#objstorage)
* [Yandex Smart Web Security](../../audit-trails/concepts/events-data-plane.md#sws)
* [Yandex WebSQL](../../audit-trails/concepts/events-data-plane.md#websql)

| ID требования | Критичность |
| --- | --- |
| AUDIT8 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором расположен [трейл](../../audit-trails/concepts/trail.md).
  1. В списке сервисов выберите **Audit Trails**.
  1. Выберите нужный трейл.
  1. Убедитесь, что на странице с информацией о трейле в блоке **Сбор событий с уровня сервисов** указаны все сервисы, для которых вы хотите собирать логи уровня сервисов, и для каждого указанного сервиса задана нужная [область сбора](../../audit-trails/concepts/trail.md#collecting-area) аудитных логов.

      Список поддерживаемых сервисов см. в [Справочник событий уровня сервисов](../../audit-trails/concepts/events-data-plane.md).

{% endlist %}

#### 5.9 Включен модуль Security Deck Access Transparency для проверки действий, произведенных сотрудниками Yandex Cloud с инфраструктурой {#access-transparency-enabled}

Все действия сотрудников Yandex Cloud фиксируются и контролируются с помощью [бастионных хостов](../../tutorials/routing/bastion.md), на которых записываются операции с ресурсами, обрабатывающими пользовательские данные.

Модуль [Access Transparency](../../security-deck/concepts/access-transparency.md) позволяет проверить, для каких целей сотрудники провайдера получили доступ к инфраструктуре. Например, для выполнения дополнительной диагностики IT‑систем инженерами службы поддержки или обновления ПО. [ML‑модели](../../glossary/ml-models.md) анализируют эти действия. YandexGPT, встроенный в Access Transparency, создает сводки о событиях доступа для повышения прозрачности. Подозрительные сессии автоматически передаются на рассмотрение команде безопасности Yandex Cloud.

| ID требования | Критичность |
| --- | --- |
| AUDIT9 | Низкая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. Перейдите в сервис [Yandex Security Deck](https://center.yandex.cloud/security/).
  1. На панели слева выберите ![CloudCheck](../../_assets/console-icons/cloud-check.svg) **Access Transparency**.
  1. Если вы видите предложение о подключении модуля Access Transparency, то этот модуль у вас еще не активирован: перейдите к п. <q>Инструкции и решения по выполнению</q>.

{% endlist %}

**Инструкции и решения по выполнению:**

Нажмите кнопку **Подключить**, чтобы активировать модуль `Access Transparency`.


# Требования к защите приложений

## 6. Защита приложений {#app-security}

### Защита от роботной активности {#protecting-recommendations}

#### 6.1 Используется Yandex SmartCaptcha {#use-smartcaptcha}

Для снижения рисков, связанных с автоматизированными атаками на приложения, рекомендуем использовать сервис [Yandex SmartCaptcha](https://yandex.cloud/ru/services/smartcaptcha). Сервис проверяет запросы пользователей своими ML-алгоритмами и показывает задание только тем пользователям, запросы которых посчитал подозрительными. При этом на странице необязательно размещать кнопку **Я не робот**.

| ID требования | Критичность |
| --- | --- |
| APPSEC1 | Информационная |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. Выберите сервис **Yandex SmartCaptcha**.
  1. Убедитесь, что [создана](../../smartcaptcha/operations/create-captcha.md) хотя бы одна капча для вашего приложения.

{% endlist %}

**Инструкции и решения по выполнению:**

[Инструкция по созданию капчи в Yandex SmartCaptcha](../../smartcaptcha/operations/create-captcha.md).

### Построение безопасного пайплайна {#pipeline-recommendations}

Yandex Cloud позволяет клиентам выстроить соответствие разрабатываемого ПО по всем уровням [Supply-chain Levels for Software Artifacts (SLSA)](https://slsa.dev/), при соблюдении инструкций в данном разделе. При использовании [Yandex Managed Service for GitLab](../../managed-gitlab/index.md), клиент автоматически достигает [соответствия до 2 уровня SLSA включительно](https://about.gitlab.com/blog/2022/11/30/achieve-slsa-level-2-compliance-with-gitlab/).

#### 6.2 При создании реестра в Yandex Container Registry по умолчанию оставляйте безопасные настройки реестра {#keep-safe-cr-settings}

При создании нового [реестра](../../container-registry/concepts/registry.md) набор опций по умолчанию помогает соответствовать стандарту безопасности Yandex Cloud:

* автоматически выполняется сканирование Docker-образов при их загрузке в реестр;
* регулярно выполняется повторное сканирование Docker-образов в реестре: каждые 7 дней с возможностью выбрать в настройках ежедневное сканирование.

| ID требования | Критичность |
| --- | --- |
| APPSEC14 | Средняя |

**Инструкции и решения по выполнению:**

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором будет создан реестр.
  1. В списке сервисов выберите **Container Registry**.
  1. Нажмите кнопку **Создать реестр**.
  1. В поле **Имя** введите имя реестра. Требования к имени:
      
      * длина — от 3 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.
  1. В блоке **Автоматическое сканирование**:

      * Оставьте включенной опцию **Сканировать Docker-образы при загрузке**, чтобы сканировать Docker-образы при загрузке в репозиторий.
      * Оставьте включенной опцию **Сканировать все Docker-образы в реестре**, при необходимости настройте периодичность сканирования.

  1. Нажмите кнопку **Создать реестр**.

- CLI {#cli}

  Выполните команду, чтобы создать реестр с безопасными настройками сканирования образов по умолчанию:

  ```bash
  yc container registry create \
    --name <имя_реестра> \
    --secure
  ```

{% endlist %}

#### 6.3 Docker-образы сканируются при загрузке в Container Registry {#upload-policy}

[Автоматическое сканирование](../../container-registry/operations/scanning-docker-image.md#automatically) Docker-образов при загрузке имеет решающее значение для раннего обнаружения и устранения уязвимостей, обеспечивая безопасное развертывание контейнеров. После завершения сканирования отчеты содержат краткое описание обнаруженных уязвимостей и проблем, помогая определять приоритеты и устранять риски безопасности в контейнерных приложениях.

| ID требования | Критичность |
| --- | --- |
| APPSEC2 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, которому принадлежит реестр с Docker-образами.
  1. Выберите реестр в сервисе **Container Registry**.
  1. Перейдите на вкладку **Сканер уязвимостей** и нажмите кнопку **Изменить настройки**.
  1. Убедитесь, что сканирование Docker-образов при загрузке включено.

{% endlist %}

**Инструкции и решения по выполнению:**

[Инструкция по сканированию Docker-образа при загрузке](../../container-registry/operations/scanning-docker-image.md#automatically).

#### 6.4 Выполняется периодическое сканирование Docker-образов, хранящихся в Container Registry {#periodic-scan}

Сканирование Docker-образов по расписанию представляет собой автоматизированный процесс проверки контейнерных образов на наличие уязвимостей и соответствие стандартам безопасности. Такое сканирование выполняется регулярно и автоматически, что обеспечивает консистентность проверки образов на наличие уязвимостей. Это позволяет поддерживать высокий уровень безопасности в долгосрочной перспективе. После завершения сканирования отчеты содержат краткое описание обнаруженных уязвимостей и проблем, помогая определять приоритеты и устранять риски безопасности в контейнерных приложениях.

Рекомендуем настроить расписание сканирования не реже, чем раз в неделю.

| ID требования | Критичность |
| --- | --- |
| APPSEC3 | Высокая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, которому принадлежит реестр с Docker-образами.
  1. Выберите реестр в сервисе **Container Registry**.
  1. Перейдите на вкладку **Сканер уязвимостей** и нажмите кнопку **Изменить настройки**.
  1. Убедитесь, что сканирование Docker-образов по расписанию включено и оно проходит не реже, чем раз в неделю.

{% endlist %}

**Инструкции и решения по выполнению:**

[Инструкция по сканированию Docker-образа по расписанию](../../container-registry/operations/scanning-docker-image.md#scheduled).

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

При использовании Managed Service for GitLab процесс применения аттестаций становится проще, потому что сервис имеет функцию генерации [provenance attestation](https://about.gitlab.com/releases/2022/06/22/gitlab-15-1-released/#slsa-2-attestation-included-for-build-artifacts). SBOM может быть сгенерирован с использованием стороннего ПО [syft](https://github.com/anchore/syft).

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

Подписание артефактов повышает безопасность, обеспечивая подлинность, целостность, доверие и соответствие требованиям в вашем программном обеспечении.

| ID требования | Критичность |
| --- | --- |
| APPSEC6 | Высокая |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Убедитесь, что выполняется подписание артефактов при сборке приложения.

{% endlist %}

**Инструкции и решения по выполнению:**

Артефакты в рамках пайплайна можно подписывать с помощью стороннего ПО [Cosign](https://github.com/sigstore/cosign) для подписи [артефактов](https://docs.sigstore.dev/signing/quickstart/), образов и [in-to-to аттестаций](https://github.com/in-toto/attestation/tree/main/spec/predicates), чтобы в дальнейшем загрузить их в Yandex Container Registry.

С помощью специальной сборки утилиты Cosign сохраняйте созданную [ключевую пару электронной подписи](../../kms/concepts/asymmetric-signature-key.md) в сервисе [Yandex Key Management Service](../../kms/quickstart/index.md), подписывайте файлы и артефакты закрытым ключом этой ключевой пары и проверяйте электронную подпись с помощью ее открытого ключа.

Подробнее см. в разделе [Подпись и проверка Docker-образов Container Registry в Yandex Managed Service for Kubernetes](../../container-registry/tutorials/sign-cr-with-cosign.md).

#### 6.8 Выполняется проверка подлинности артефактов при развертывании {#artifacts-checked}

Чтобы обеспечить надежность, безопасность и совместимость приложений в [Managed Service for Kubernetes](../../managed-kubernetes/index.md), сервисе для автоматического масштабирования и развертывания приложений, необходимо свести к минимуму риск возникновения проблем, уязвимостей и сбоев во время развертывания и выполнения. Для этого используется [подпись и проверка подписи](../../container-registry/tutorials/sign-cr-with-cosign.md) в Managed Service for Kubernetes с помощью Cosign и [Kyverno](../../managed-kubernetes/operations/applications/kyverno.md).

| ID требования | Критичность |
| --- | --- |
| APPSEC7 | Средняя |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Убедитесь, что выполняется проверка подлинности артефактов при сборке приложения.

{% endlist %}

**Инструкции и решения по выполнению:**

[Инструкция по настройке подписи артефактов](../../container-registry/tutorials/sign-cr-with-cosign.md).

#### 6.9 Применяются защищенные шаблоны безопасного пайплайна {#pipeline-blocks}

При работе с Managed Service for GitLab убедитесь, что вы применяете встроенные механизмы безопасности GitLab для защиты вашего пайплайна. Доступны следующие [варианты использования](../../managed-gitlab/concepts/security.md#security-pipeline-usage) пайплайна в ваших проектах:

* Создание пайплайна в отдельном проекте и подключение его к другим проектам с помощью [функции `include`](https://docs.gitlab.com/ee/ci/yaml/includes.html). Доступно для всех типов лицензий.
* Использование [механизма `Compliance framework and pipeline`](https://docs.gitlab.com/ee/user/project/settings/index.html#compliance-frameworks), который будет выполняться в любом проекте группы. Механизм доступен для типа лицензии `Ultimate`.
* Копирование секции пайплайна в файлы `.gitlab-ci.yml` ваших проектов.

| ID требования | Критичность |
| --- | --- |
| APPSEC8 | Информационная |

#### 6.10 Используется профиль безопасности Yandex Smart Web Security {#use-sws}

[Yandex Smart Web Security](../../smartwebsecurity/quickstart.md) — сервис для защиты от [DDoS, web-атак](../../glossary/ddos.md) и ботов на прикладном уровне L7 [сетевой модели OSI](https://ru.wikipedia.org/wiki/Сетевая_модель_OSI). Smart Web Security [подключается](../../smartwebsecurity/quickstart.md) к Yandex Application Load Balancer.

Функциональность сервиса сводится к проверке HTTP-запросов к защищаемому ресурсу на соответствие [правилам](../../smartwebsecurity/concepts/rules.md), заданным в [профиле безопасности](../../smartwebsecurity/concepts/profiles.md). В зависимости от результатов проверки запросы пропускаются на защищаемый ресурс, блокируются или отправляются в сервис [Yandex SmartCaptcha](../../smartcaptcha/index.md) для дополнительной верификации.

| ID требования | Критичность |
| --- | --- |
| APPSEC9 | Высокая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите проверить статус Smart Web Security.
  1. В списке сервисов выберите **Smart Web Security**.
  1. На панели слева выберите ![shield-check](../../_assets/console-icons/shield-check.svg) **Профили безопасности**.
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

[Создание профиля безопасности и подключение его к виртуальному хосту L7-балансировщика](../../smartwebsecurity/quickstart.md).

#### 6.11 Используется Web Application Firewall {#use-waf}

Для снижения рисков, связанных с веб-атаками, рекомендуем использовать Yandex Smart Web Security [Web Application Firewall (WAF)](../../glossary/waf.md). Web Application Firewall анализирует входящие HTTP-запросы к веб-приложению по предварительно настроенным правилам. На основе результатов анализа к HTTP-запросам применяются определенные [действия](../../smartwebsecurity/concepts/rules.md#rule-action).

Вы можете управлять межсетевым экраном веб-приложений с помощью [профиля WAF](../../smartwebsecurity/concepts/waf.md), который подключается к [профилю безопасности](../../smartwebsecurity/concepts/profiles.md) Smart Web Security в виде отдельного [правила](../../smartwebsecurity/concepts/rules.md).

| ID требования | Критичность |
| --- | --- |
| APPSEC10 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором необходимо проверить наличие правила WAF в профиле безопасности.
  1. В списке сервисов выберите **Smart Web Security**.
  1. Убедитесь, что у вас в профиле безопасности есть правило безопасности с типом **Web Application Firewall**.

{% endlist %}

**Инструкции и решения по выполнению:**

[Создание профиля WAF и подключение его к профилю безопасности Smart Web Security](../../smartwebsecurity/quickstart.md#waf).

#### 6.12 Используется Advanced Rate Limiter {#use-arl}

[Advanced Rate Limiter (ARL)](../../smartwebsecurity/concepts/arl.md) — модуль Yandex Smart Web Security для контроля и ограничения нагрузки на веб-приложения. Модуль позволяет установить лимит на количество HTTP-запросов за определенный промежуток времени. Все запросы сверх лимита будут блокироваться. Можно установить как единый лимит на весь трафик, так и настраивать отдельные лимиты для сегментирования запросов по определенным параметрам. Запросы для лимитов можно считать по одному или объединять в группы по заданному признаку.

Профиль ARL необходимо подключить к [профилю безопасности](../../smartwebsecurity/concepts/profiles.md) Smart Web Security.

| ID требования | Критичность |
| --- | --- |
| APPSEC11 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором необходимо проверить наличие профилей ARL.
  1. В списке сервисов выберите **Smart Web Security**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/arl.svg) **Профили ARL** и убедитесь, что у вас есть профили ARL, подключенные к профилю безопасности.

{% endlist %}

**Инструкции и решения по выполнению:**

[Создание профиля ARL и подключение его к профилю безопасности Smart Web Security](../../smartwebsecurity/quickstart.md#arl).

#### 6.13 Настроены правила ревью кода {#setup-code-review}

[Yandex Managed Service for GitLab](../../managed-gitlab/index.md) позволяет гибко настраивать обязательные [правила ревью кода](../../managed-gitlab/concepts/approval-rules.md), прежде чем этот код может быть добавлен в целевую [ветку проекта](../../glossary/vcs.md#branch). Функциональность является альтернативой встроенному в GitLab Enterprise Edition инструменту [Approval Rules](https://docs.gitlab.com/ee/user/project/merge_requests/approvals/rules.html) и доступна вне зависимости от [версии](https://about.gitlab.com/pricing) GitLab.

Если в [инстансе GitLab](../../managed-gitlab/concepts/index.md#instance) включены правила ревью кода, Managed Service for GitLab анализирует подтверждения от ревьюеров на соответствие заданным правилам. Если подтверждений недостаточно, в мерж-реквесте создается техническая дискуссия, блокирующая его интеграцию в целевую ветку. При изменении мерж-реквеста в дискуссии создается или обновляется комментарий с текущим статусом соответствия правилам. Когда все необходимые подтверждения получены, дискуссия закрывается.

Если закрыть техническую дискуссию вручную, она будет создана заново. В случае интеграции мерж-реквеста в обход заданных правил пользователи с ролью `Maintainer` и выше получат уведомление на электронную почту о нарушении установленного процесса ревью кода.

| ID требования | Критичность |
| --- | --- |
| APPSEC12 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором расположен инстанс GitLab.
  1. В списке сервисов выберите **Managed Service for&nbsp;GitLab**.
  1. Выберите нужный инстанс и в правом верхнем углу страницы нажмите **Редактировать**.
  1. Убедитесь, что в поле **Правила ревью кода** выбрана настроенная [конфигурация](../../managed-gitlab/concepts/approval-rules.md#packages) правил ревью кода.

{% endlist %}

**Инструкции и решения по выполнению:**

[Активация правил ревью кода в инстансе GitLab](../../managed-gitlab/operations/approval-rules.md#enable).

#### 6.14 Доверенные и нежелательные IP-адреса группируются в списки {#app-sws-lists}

В [Yandex Smart Web Security](../../smartwebsecurity/index.md) есть возможность сформировать собственные наборы IP-адресов — [пользовательские списки](../../smartwebsecurity/concepts/lists.md#user-rules). Списки можно добавлять в качестве [условий](../../smartwebsecurity/concepts/conditions.md) в [правила](../../smartwebsecurity/concepts/rules.md), чтобы пропустить, заблокировать или направить в [SmartCaptcha](../../smartcaptcha/index.md) часть трафика на этапе проверки IP-адреса.

| ID требования | Критичность |
| --- | --- |
| APPSEC13 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. Откройте консоль Yandex Cloud в вашем браузере.
  1. Перейдите в нужный каталог.
  1. В списке сервисов выберите **Smart Web Security**.
  1. Перейдите в раздел **Списки**.
  1. Убедитесь, что у вас есть созданные списки.
  1. Если списки есть, рекомендация выполняется. Если нет, перейдите к пункту «Инструкции и решения по выполнению».

- Ручная проверка {#manual}

  Чтобы убедиться, что у вас есть списки в Smart Web Security, обратитесь к вашему персональному менеджеру.

{% endlist %}

**Инструкции и решения по выполнению:**

Используйте черные и белые списки IP-адресов для фильтрации трафика. Подробнее см. в разделе [Управление списками адресов](../../smartwebsecurity/operations/list-create.md).


# Требования к безопасности Kubernetes

## 7. Безопасность Kubernetes {#kubernetes-security}


[Yandex Managed Service for Kubernetes](../../managed-kubernetes/index.md) предоставляет окружение для работы с [контейнеризованными приложениями](../../glossary/containerization.md) в инфраструктуре Yandex Cloud. Вы можете разворачивать, масштабировать и управлять приложениями в контейнерах с помощью Kubernetes.

Все действия внутри узла Kubernetes являются ответственностью пользователя. Пользователь несет ответственность за безопасность узлов и их корректную настройку в соответствии с требованиями PCI DSS и других стандартов безопасности.

За безопасность API Kubernetes отвечает Yandex Cloud.

Пользователь отвечает за правильный выбор настроек безопасности Managed Service for Kubernetes, в том числе выбор [канала](../../managed-kubernetes/concepts/release-channels-and-updates.md) и расписания обновлений.

### Общее {#general}

#### 7.1 Ограничено использование критичных данных {#not-use-critical-data}

При работе с сервисом Managed Service for Kubernetes для выполнения требований PCI DSS и других стандартов безопасности запрещается:

* Использовать критичные данные в именах и описаниях кластеров, групп узлов, пространств имен, сервисов, подов.
* Использовать критичные данные в [метках узлов Kubernetes](../../managed-kubernetes/concepts/index.md#node-labels) и [метках ресурсов сервисов Yandex Cloud](../../resource-manager/concepts/labels.md).
* Указывать критичные данные в манифестах подов.
* Указывать критичные данные в etcd в открытом виде.
* Записывать критичные данные в логи Managed Service for Kubernetes.

| ID требования | Критичность |
| --- | --- |
| K8S1 | Высокая |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  * Убедитесь, что в именах и описаниях кластеров, групп узлов, пространств имен, сервисов, подов нет критичных данных.
  * Проверьте конфигурационные файлы на предмет критичных данных.

- Проверка в консоли управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором расположен инстанс Managed Service for Kubernetes.
  1. В списке сервисов выберите **Managed Service for&nbsp;Kubernetes**.
  1. Убедитесь, что в [метках узлов Kubernetes](../../managed-kubernetes/concepts/index.md#node-labels) и [метках ресурсов сервисов Yandex Cloud](../../resource-manager/concepts/labels.md) нет критичных данных.

{% endlist %}

**Инструкции и решения по выполнению:**

Вручную исправьте названия или наполнения для манифестов и других конфигурационных файлов, если в них используются критичные данные.

#### 7.2 Ресурсы изолированы друг от друга {#maximum-isolation}

Придерживайтесь максимальной изоляции между ресурсами везде, где это возможно:

* Под каждый «большой» проект используется отдельная организация.
* Под каждую команду разработки используется отдельное облако.
* Под каждый сервис используется отдельный кластер Kubernetes в отдельном каталоге.
* Под каждый [микросервис](https://yandex.cloud/ru/blog/posts/2022/03/microservice-architecture) используется отдельное пространство имен.
* У облаков должны отсутствовать разделяемые ресурсы, у участников облаков должен быть доступ только к своему облаку.

Возможны и менее строгие схемы изоляции, например:

* Проекты развернуты в разных облаках.
* Команды разработки используют отдельные каталоги.
* Сервис представлен отдельным кластером Kubernetes.
* Микросервисы используют разные пространства имен.

| ID требования | Критичность |
| --- | --- |
| K8S2 | Высокая |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Проверьте, что обеспечена максимальная изоляция между ресурсами везде, где это возможно.

{% endlist %}

#### 7.3 Нет доступа к API Kubernetes и группам узлов из недоверенных сетей {#api-security}

Не рекомендуется открывать доступ к API Kubernetes и группам узлов из недоверенных сетей, в том числе из интернета. В случае необходимости используйте средства межсетевого экранирования, в частности [группы безопасности](../../vpc/concepts/security-groups.md).

| ID требования | Критичность |
| --- | --- |
| K8S3 | Средняя |

**Инструкции и решения по выполнению:**

* [Инструкция по созданию кластера без доступа в интернет](../../managed-kubernetes/tutorials/k8s-cluster-with-no-internet.md).
* [Инструкция по настройке групп безопасности](../../managed-kubernetes/operations/connect/security-groups.md).
* Используйте инструменты для настройки network policy с помощью плагинов [Calico](../../managed-kubernetes/concepts/network-policy.md#calico) (базовый) или [Cilium CNI](../../managed-kubernetes/concepts/network-policy.md#cilium) (продвинутый) в Yandex Cloud, используя `default deny` правила для входящего и исходящего трафика по умолчанию и разрешать только необходимый трафик.
* Выделите отдельный кластер Kubernetes для конечных точек, которые взаимодействуют с интернетом, либо отдельные группы узлов (с помощью механизмов: [Taints and Tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/#:~:text=Node%20affinity%20is%20a%20property,onto%20nodes%20with%20matching%20taints) + [Node affinity](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/)). Таким образом, выделяется DMZ, и в случае компрометации узлов из интернета поверхность атаки ограничится.
* Чтобы организовать входящий сетевой доступ к рабочим нагрузкам по протоколу HTTP/HTTPS используйте ресурс [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/). Существует как минимум 2 варианта Ingress-контроллера, которые можно использовать в Yandex Cloud:

  * [NGINX Ingress Controller](../../managed-kubernetes/tutorials/ingress-cert-manager.md).
  * [Application Load Balancer Ingress-контроллера](../../application-load-balancer/tools/k8s-ingress-controller/index.md).

#### 7.4 В Managed Service for Kubernetes настроены аутентификация и управление доступом {#kubernetes-auth}

Для работы кластера Kubernetes необходимы два сервисных аккаунта: [сервисный аккаунт кластера и сервисный аккаунт группы узлов](../../managed-kubernetes/security/index.md#sa-annotation). Управление доступом учетных записей IAM к ресурсам Managed Service for Kubernetes выполняется на следующих уровнях:

* Сервисные роли Managed Service for Kubernetes (доступ к Yandex Cloud API): позволяют управлять кластерами и группами узлов (например, создать кластер, создать/редактировать/удалить группу узлов и т.д.).
* Сервисные роли для доступа к Kubernetes API: позволяют управлять ресурсами кластера через Kubernetes API (например, стандартные действия с Kubernetes: создание, удаление, просмотр пространств имен, работа с подами, deployments, создание ролей и т.д.). Доступны только базовые глобальные роли на уровне всего кластера: `k8s.cluster-api.cluster-admin`, `k8s.cluster-api.editor` и `k8s.cluster-api.viewer`.
* Примитивные роли: глобальные примитивные роли IAM, которые содержат в себе сервисные роли (например, примитивная роль admin содержит в себе и сервисную административную роль и административную роль для доступа к Kubernetes API).
* Стандартные роли Kubernetes: внутри самого кластера Kubernetes доступно создание ролей и кластерных ролей средствами Kubernetes. Таким образом можно управлять доступом учетных записей IAM на уровне пространства имен. Для назначения IAM ролей на уровне пространства имен возможно вручную создавать объекты RoleBinding в необходимом пространстве имен, указывая в поле «subjects name» идентификатор IAM пользователя облака.

| ID требования | Критичность |
| --- | --- |
| K8S4 | Высокая |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Проверьте, что рекомендации, указанные выше, выполняются.

{% endlist %}

#### 7.5 В Managed Service for Kubernetes используется безопасная конфигурация {#kubernetes-safe-config}

В Managed Service for Kubernetes пользователь управляет всеми настройками групп узлов, настройками [мастера](../../managed-kubernetes/concepts/index.md#master) — только частично. Пользователь отвечает за безопасность всего кластера.

Для безопасной конфигурации Kubernetes, включая конфигурацию узлов, существует стандарт [CIS Kubernetes Benchmark](https://www.cisecurity.org/benchmark/kubernetes). В Yandex Cloud группы узлов Kubernetes по умолчанию разворачиваются с конфигурацией, которая соответствует стандарту CIS Kubernetes Benchmark.

| ID требования | Критичность |
| --- | --- |
| K8S5 | Средняя |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  * С помощью инструмента [kube-bench](https://github.com/aquasecurity/kube-bench) проверьте конфигурацию группы узлов по стандарту CIS Kubernetes Benchmark. Инструмент официально поддерживает группы узлов Yandex Cloud.
  * [Starboard Operator](https://blog.aquasec.com/automate-kubernetes-compliance) — это бесплатный инструмент, который позволяет автоматизировать сканирование образов на уязвимости и проверку конфигурации на соответствие CIS Kubernetes Benchmark. Starboard Operator поддерживает интеграцию с kube-bench и используется для его автоматического запуска.

{% endlist %}

#### 7.6 Шифрование данных и управление секретами Managed Service for Kubernetes выполняются в формате ESO as a Service {#data-encryption}

Шифрование секретов на уровне Kubernetes etcd необходимо выполнять встроенным [механизмом сервиса Yandex Cloud](../../managed-kubernetes/concepts/encryption.md).

Работу с Kubernetes secrets рекомендуется выполнять с помощью решений класса SecretManager. В Yandex Cloud таким решением является сервис [Yandex Lockbox](../../lockbox/index.md).

Интеграция Yandex Lockbox с Kubernetes выполнена с помощью открытого проекта [External Secrets](https://external-secrets.io/latest/). Решение доступно в Cloud Marketplace в базовом упрощенном сценарии — [External Secrets Operator с поддержкой Yandex Lockbox](https://yandex.cloud/ru/marketplace/products/yc/external-secrets).

Рекомендуемый наиболее безопасный вариант шифрования секретов — ESO as a Service (External Secrets Operator as a service). При использовании ESO глобальный администратор имеет доступ к пространству имен с установленным ESO, а администраторы отдельных пространств имен создают себе объекты [SecretStore](https://external-secrets.io/latest/api/secretstore/) (в которых указывают IAM авторизованные ключи доступа к своим секретам Lockbox). В случае компрометации данного объекта SecretStore скомпрометирован будет только авторизованный ключ одного пространства имен, а не всех как в случае, например, схемы Shared ClusterSecretStore.

| ID требования | Критичность |
| --- | --- |
| K8S6 | Средняя |

**Инструкции и решения по выполнению:**

* [Инструкция по работе с External Secrets и Yandex Lockbox из описания проекта](https://external-secrets.io/latest/provider/yandex-lockbox/).
* [Инструкция по работе с External Secrets и Yandex Lockbox из документации Yandex Cloud](../../lockbox/tutorials/kubernetes-lockbox-secrets.md).

#### 7.7 Docker-образы хранятся в реестре Container Registry с настроенным периодическим сканированием образов {#docker-images-periodic-scan}

Для эффективного обеспечения безопасности рекомендуется использовать [Container Registry](../../container-registry/index.md) для хранения Docker-образов, которые разворачиваются в Managed Service for Kubernetes. Это позволит оперативно реагировать на появление новых уязвимостей в образах с помощью встроенного переодического сканирования на уязвимости.

Сканирование на уязвимости должно проводиться не реже одного раза в неделю. Это поможет своевременно обнаруживать и устранять уязвимости в образах, что существенно снизит риски несанкционированного доступа к вашим ресурсам и повысит уровень безопасности вашей инфраструктуры.

Использование Container Registry для хранения образов также обеспечит централизованное управление версиями образов, что упростит процесс обновления и управления безопасностью.

| ID требования | Критичность |
| --- | --- |
| K8S7 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, которому принадлежит реестр с Docker-образами.
  1. Выберите реестр в сервисе **Container Registry**.
  1. Перейдите на вкладку **Сканер уязвимостей** и нажмите кнопку **Изменить настройки**.
  1. Убедитесь, что сканирование Docker-образов по расписанию включено и оно проходит не реже, чем раз в неделю.

{% endlist %}

**Инструкции и решения по выполнению:**

* [Инструкция по сканированию Docker-образа по расписанию](../../container-registry/operations/scanning-docker-image.md#scheduled).

#### 7.8 Используется одна из трех последних версий Kubernetes и ведется мониторинг обновлений {#version-update}

Для Kubernetes доступно как автоматическое, так и ручное обновление [кластера](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) и [группы узлов](../../managed-kubernetes/concepts/index.md#node-group). Вы можете в любое время запросить обновление кластера Kubernetes или его узлов вручную до последней поддерживаемой [версии](../../managed-kubernetes/concepts/release-channels-and-updates.md). Ручные обновления обходят любые настроенные окна обслуживания и исключения обслуживания. Kubernetes регулярно выпускает обновления. Для соответствия стандартам ИБ:

* выберите подходящий канал обновления и настройте автоматическое применение обновлений, либо применяйте обновления вручную сразу после публикации в выбранном канале;
* проверьте, что настройки обновлений соответствуют стандартам ИБ;
* используйте одну из трех последних версий Kubernetes, так как любые обновления, в том числе обновления безопасности, выпускаются только для них.

| ID требования | Критичность |
| --- | --- |
| K8S8 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  Чтобы узнать список доступных версий для кластера Kubernetes:
  1. Перейдите на страницу [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) и выберите сервис **Managed Service for&nbsp;Kubernetes**.
  1. Нажмите на имя нужного кластера Kubernetes.
  1. Нажмите кнопку **Редактировать** в правом верхнем углу.
  1. Получите список доступных версий в поле **Версия Kubernetes** блока **Конфигурация мастера**.

  Чтобы узнать список доступных версий для группы узлов Kubernetes:
  1. Перейдите на страницу каталога и выберите сервис **Managed Service for&nbsp;Kubernetes**.
  1. Нажмите на имя нужного кластера Kubernetes и перейдите на вкладку **Управление узлами**.
  1. Выберите нужную группу узлов Kubernetes в списке и нажмите кнопку **Редактировать** в правом верхнем углу.
  1. Получите список доступных версий в поле **Версия Kubernetes**.

- Проверка через CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы получить список доступных версий, выполните команду:

  ```bash
  yc managed-kubernetes list-versions
  ```

- Проверка через API {#api}

  Чтобы получить список доступных версий, воспользуйтесь методом [list](../../managed-kubernetes/managed-kubernetes/api-ref/Version/list.md).

{% endlist %}

**Инструкции и решения по выполнению:**

* [Инструкция как обновить кластер автоматически](../../managed-kubernetes/operations/update-kubernetes.md#cluster-upgrade).
* [Инструкция как обновить кластер вручную](../../managed-kubernetes/operations/update-kubernetes.md#cluster-manual-upgrade).

#### 7.9 Настроено резервное копирование {#backup}

Для обеспечения непрерывности работы и защиты данных рекомендуется использовать резервное копирование в Managed Service for Kubernetes, поскольку оно позволяет быстро восстановить работу сервиса без потери данных и времени на восстановление после сбоя или аварии. Данные в [кластерах Kubernetes](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) надежно хранятся и реплицируются в инфраструктуре Yandex Cloud. Однако в любой момент вы можете сделать резервные копии данных из [групп узлов](../../managed-kubernetes/concepts/index.md#node-group) кластеров Kubernetes и хранить их в [Yandex Object Storage](../../storage/index.md) или другом хранилище.

| ID требования | Критичность |
| --- | --- |
| K8S9 | Высокая |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Проверьте наличие резервных копий данных из групп узлов кластеров Kubernetes.

{% endlist %}

**Инструкции и решения по выполнению:**

Вы можете создавать резервные копии данных из групп узлов кластера Kubernetes с помощью инструмента [Velero](https://velero.io/). Этот инструмент поддерживает работу с [дисками](../../compute/concepts/disk.md) Yandex Cloud с помощью CSI-драйвера Kubernetes, и позволяет создавать моментальные [снимки дисков томов](../../compute/concepts/snapshot.md).

При работе с Velero, установленным вручную, вы можете использовать [nfs](https://kubernetes.io/docs/concepts/storage/volumes/#nfs), [emptyDir](https://kubernetes.io/docs/concepts/storage/volumes/#emptydir), [локальный](https://kubernetes.io/docs/concepts/storage/volumes/#local) или любой другой тип тома, в котором нет встроенной поддержки моментальных снимков. Чтобы использовать такой тип тома, задействуйте [плагин restic](https://velero.io/docs/v1.8/restic/) при установке Velero. Velero, установленный из [Cloud Marketplace](https://yandex.cloud/ru/marketplace/products/yc/velero-yc-csi), плагин restic не включает.

* [Инструкция по резервному копированию кластера Kubernetes в Object Storage](../../managed-kubernetes/tutorials/kubernetes-backup.md#backup).

#### 7.10 Используются чек-листы для безопасного создания и использования Docker-образа {#check-list}

Практики безопасного создания и использования Docker-образа необходимы для защиты от потенциальных уязвимостей, вредоносных программ и несанкционированного доступа к данным. Они помогают обеспечить целостность образа, его соответствие стандартам безопасности и предотвратить возможные угрозы при его использовании в инфраструктуре. Используйте данные чеклисты для выполнения требований по безопасному созданию образов:

* [Dockerfile best practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/).
* [Kubernetes Security Checklist and Requirements](https://github.com/Vinum-Security/kubernetes-security-checklist/blob/main/README.md).

Контролировать Dockerfile в процессе [CI/CD](https://yandex.cloud/ru/blog/posts/2022/10/ci-cd) можно с помощью утилиты [Conftest](https://www.conftest.dev/).

При проверке минимальных образов или образов distroless (distroless images), в которых отсутствует shell, рекомендуется использовать [ephemeral cointainers](https://kubernetes.io/docs/concepts/workloads/pods/ephemeral-containers/).

| ID требования | Критичность |
| --- | --- |
| K8S10 | Информационная |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Проверьте наличие чеклистов для выполнения требований по безопасному созданию образов.

{% endlist %}

#### 7.11 Используется политика безопасности Kubernetes {#security-standards}

Требования [Pod Security Standards от Kubernetes](https://kubernetes.io/docs/concepts/security/pod-security-standards/) позволяют предотвращать угрозы, связанные с объектами Kubernetes, такие как несанкционированный доступ к конфиденциальным данным или выполнение вредоносного кода.

Эти требования помогают обеспечить безопасность и надежность работы приложений в кластере Kubernetes. Для их реализации можно использовать встроенный инструмент Kubernetes [Pod Security Admission Controller](https://kubernetes.io/docs/setup/best-practices/enforcing-pod-security-standards/) или открытое программное обеспечение, например, [OPA Gatekeeper](https://github.com/open-policy-agent/gatekeeper) или [Kyverno](https://yandex.cloud/ru/marketplace/products/yc/kyverno).

| ID требования | Критичность |
| --- | --- |
| K8S11 | Средняя |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Проверьте выполнение требований Pod Security Standards от Kubernetes.

{% endlist %}

**Инструкции и решения по выполнению:**

* Для контроля соответствия требованиям Pod Security Standarts также можно использовать следующие инструменты в рамках [CI/CD](https://yandex.cloud/ru/blog/posts/2022/10/ci-cd):

  * [Kyverno CLI](https://kyverno.io/docs/kyverno-cli/)
  * The gator CLI

* Инструмент [Kubesec](https://kubesec.io/).

#### 7.12 Настроен сбор аудитных логов для расследований инцидентов {#audit-logs}

События, доступные пользователю в рамках сервиса Managed Service for Kubernetes, можно разделить на следующие уровни:

* события Kubernetes API (Kubernetes Audit logging);
* события узлов Kubernetes;
* события подов Kubernetes;
* метрики Kubernetes;
* Flow logs Kubernetes.

Подробнее о настройке сбора событий аудита на разных уровнях см. в разделе [Сбор, мониторинг и анализ аудитных логов Managed Service for Kubernetes](../domains/kubernetes.md#collection-monitoring-analysis-audit-logs).

Managed Service for Kubernetes предоставляет возможность проводить аудит текущей ролевой модели в сервисе. Для этого в [консоли управления](https://console.yandex.cloud) откройте страницу кластера Kubernetes и перейдите на вкладку **Управление доступом**.

Также можно использовать:

* [KubiScan](https://github.com/cyberark/KubiScan).
* [Krane](https://github.com/appvia/krane).
* [Аудитные логи](../../managed-kubernetes/at-ref.md) Yandex Audit Trails.

| ID требования | Критичность |
| --- | --- |
| K8S12 | Высокая |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Убедитесь, что выполняется сбор аудитных логов.

{% endlist %}

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._