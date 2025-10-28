# Требования к аутентификации и управлению доступом

## 1. Аутентификация и управление доступом {#authentication}


В {{ yandex-cloud }} управление идентификацией, аутентификацией и контролем доступа выполняется сервисами [{{ iam-full-name }} ({{ iam-short-name }})](../../../iam/) и [{{ org-full-name }}](../../../organization/).

Платформа работает с тремя категориями учетных записей:

* [аккаунты на Яндексе](../../../iam/concepts/users/accounts.md#passport) — учетные записи в системе Яндекс ID, в том числе аккаунты в {{ yandex-360 }};
* [федеративные аккаунты](../../../iam/concepts/#saml-federation) — учетные записи в корпоративной [SAML-совместимой федерации удостоверений](../../../organization/concepts/add-federation.md), например Active Directory;
* [сервисные аккаунты](../../../iam/concepts/#sa) — учетные записи, от имени которых программы могут управлять ресурсами.

Аккаунты Яндекс ID и федеративные аккаунты аутентифицируются в собственных системах. {{ yandex-cloud }} не имеет доступа к паролям этих пользователей и аутентифицирует только сервисные аккаунты с помощью сервиса {{ iam-short-name }}. Для аккаунтов Яндекс ID и {{ yandex-360 }} рекомендуем настроить двухфакторную аутентификацию (2FA) согласно [инструкции](https://yandex.ru/support/id/authorization/twofa.html).

Доступ пользователей к ресурсам облака регулируется с помощью [ролей](../../../iam/concepts/access-control/roles.md). Сервисы {{ yandex-cloud }} могут предлагать разный уровень гранулярности назначения прав: в одних случаях роль можно назначить непосредственно на сам ресурс в сервисе, в других случаях права назначаются только на уровне каталога или облака, в котором размещен ресурс сервиса.

Таким образом, в инфраструктуре {{ yandex-cloud }} взаимодействуют различные категории ресурсов, ролей и пользователей. Контроль доступа к ресурсам выполняется сервисом {{ iam-short-name }}. Сервис {{ iam-short-name }} контролирует каждый запрос, чтобы все операции над ресурсами выполнялась только пользователями с необходимыми правами.

{% note info %}

При использовании {{ yandex-cloud }} совместно с сервисами {{ yandex-360 }} выполните [рекомендации по безопасности]({{ link-yandex }}/support/yandex-360/business/admin/ru/security/security-recommendations) {{ yandex-360 }}: укажите в Яндекс ID данные для восстановления доступа к аккаунту и привяжите актуальный номер телефона для восстановления и получения уведомлений, а также [настройте]({{ link-yandex }}/support/yandex-360/business/admin/ru/admin-audit-log) аудитные логи.

{% endnote %}

### Федерации удостоверений {#federations}

#### 1.1 Настроена федерация удостоверений (Single Sign-On, SSO) {#saml-federation}

[{{ org-full-name }}](../../../organization/) — это единый сервис для управления составом организации, настройки интеграции с каталогом сотрудников и разграничения доступов пользователей к облачным ресурсам организации.

Для централизованного управления учетными данными используйте [SAML-совместимые федерации удостоверений](../../../organization/concepts/add-federation.md). С помощью федераций удостоверений компания может настроить Single Sign-On аутентификацию в {{ yandex-cloud }} через свой сервер IdP. При таком подходе сотрудники имеют возможность использовать свои корпоративные аккаунты, на которые распространяются политики безопасности компании, такие как:

* отзыв и блокирование аккаунтов;
* парольные политики;
* ограничение количества неуспешных попыток входа;
* блокирование сеанса доступа после установленного времени бездействия;
* двухфакторная аутентификация.

{% note tip %}

Используйте федеративные аккаунты вместо аккаунтов Яндекс ID, где это возможно. Помните, что для управления федерацией существует отдельная роль `organization-manager.federations.admin`.

{% endnote %}

Чтобы все запросы аутентификации от {{ yandex-cloud }} содержали цифровую подпись, включите опцию **Подписывать запросы аутентификации**. Для завершения настройки потребуется скачать и установить сертификат {{ yandex-cloud }}. Скачать сертификат можно в поле **Подписывать запросы аутентификации** сразу после сохранения федерации.

| ID требования | Критичность |
| --- | --- |
| IAM1 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. Откройте консоль {{ yandex-cloud }} в вашем браузере.
  1. Перейдите во вкладку **Все сервисы** → **{{ org-full-name }}** → **Федерации**.
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

* [Инструкция по настройке SAML федерации удостоверений](../../../organization/concepts/add-federation.md#federation-usage).
* [Инструкция по настройке SAML федерации с KeyCloak](https://www.youtube.com/watch?v=m-oe7V9PvC4).

##### 1.1.1 Настроено сопоставление групп пользователей в федерации удостоверений {#group-mapping}

Для организаций, в которых много участников, одинаковые права доступа к ресурсам {{ yandex-cloud }} могут потребоваться сразу нескольким пользователям. В этом случае роли и доступы эффективнее выдавать не персонально, а для группы.

Если вы используете группы пользователей в вашем поставщике удостоверений или собираетесь это сделать, [настройте сопоставление групп](../../../organization/operations/federation-group-mapping.md) пользователей между поставщиком удостоверений и {{ org-name }}. Пользователи в группах поставщика удостоверений будут иметь права доступа к ресурсам {{ yandex-cloud }} из сопоставленных групп в {{ org-name }}.

| ID требования | Критичность |
| --- | --- |
| IAM2 | Средняя |

#### 1.2 Учетные записи Яндекс ID используются только в исключительных случаях {#yandex-id-accounts}

Наиболее правильный с точки зрения безопасности подход к управлению учетными записями — это использование федерации удостоверений (подробнее в рекомендации № 1.1). В связи с этим необходимо стремиться к тому, чтобы в списке пользователей вашей организации находились только федеративные пользователи (пользователи c атрибутом <q>FEDERATION ID</q>) и минимум учетных записей с Яндекс ID. Список допустимых исключений:

* Учетная запись с правами `billing.accounts.owner` (технически на текущий момент данную роль может иметь только учетная запись Яндекс ID).
* Учетная запись с правами `organization-manager.organizations.owner` и `{{ roles-cloud-owner }}`, если вы используете ее только для аварийного применения, например, когда сломалась настройка федерации. При необходимости можно [удалить](../../../security/operations/account-deletion.md) привилегированный [аккаунт на Яндексе](../../../iam/concepts/users/accounts.md#passport) с ролью `organization-manager.organizations.owner` из организации.
* Внешние учетные записи, например, контрагентов или подрядчиков, которые по каким-либо причинам вы не можете завести в вашей IdP.

| ID требования | Критичность |
| --- | --- |
| IAM3 | Высокая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. Откройте консоль {{ yandex-cloud }} в вашем браузере.
  1. Перейдите во вкладку **Все сервисы** → **{{ org-full-name }}** → **Пользователи**.
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

В настройках [федерации удостоверений](../../../organization/concepts/add-federation.md) необходимо убедиться, что значение параметра **Время жизни cookie** меньше либо равно 6 часов. Это необходимо, чтобы минимизировать риск компрометации рабочих станций пользователей облака.

| ID требования | Критичность |
| --- | --- |
| IAM4 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. Откройте консоль управления {{ yandex-cloud }} в вашем браузере.
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
      do yc organization-manager federation saml get --id bpfdshe1skaqcjp6uc50 --format=json | jq -r '. | select(.cookie_max_age>"21600s")'
      done
      ```

  1. Если выдается пустая строка, то рекомендация выполняется. Если выдается результат с настройкой текущей федерации, где параметр `cookie_max_age` > 21600s, то перейдите к п. <q>Инструкции и решения по выполнению</q>.

{% endlist %}

**Инструкции и решения по выполнению:**

Задайте значение параметра **Время жизни cookie** равным 6 часам (21600 секундам) или меньше.

### Особенности управления доступом {#access-control}

#### 1.4 Только необходимые администраторы управляют членством в {{ iam-short-name }}-группах {#iam-admins}

Для управления доступом к ресурсам удобно использовать [группы пользователей](../../../organization/operations/create-group.md). Необходимо контролировать права доступа к самой группе как к ресурсу. Пользователь с правами доступа к группе может управлять членством других пользователей. Случаи, в которых пользователь получает такие права:

* Пользователю назначена роль `organization-manager.groups.memberAdmin` на организацию.
* Пользователю назначена роль `organization-manager.groups.memberAdmin` на конкретную группу как на ресурс.
* Пользователю назначена роль `organization-manager.organizations.owner` или `{{ roles-admin }}` или другая привилегированная роль на всю организацию.
* Пользователю назначена роль `{{ roles-admin }}` или `{{ roles-editor }}` на конкретную группу как на ресурс (нерекомендованный сценарий).

| ID требования | Критичность |
| --- | --- |
| IAM5 | Высокая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. Откройте консоль {{ yandex-cloud }} в вашем браузере.
  1. Перейдите во вкладку **Все сервисы** → **{{ org-full-name }}** → **Группы** → **Выберите нужную группу** → **Права доступа к группе**.
  1. Нажмите тумблер **Наследуемые роли**.
  1. Если в списке отсутствуют учетные записи, которые не должны иметь прав управления членством в группе, то рекомендация выполнена. Если нет, то перейдите к п. <q>Инструкции и решения по выполнению</q>.

{% endlist %}

**Инструкции и решения по выполнению:**

Удалите права на доступ к группе у учетных записей, которым это не требуется.

#### 1.5 Используются сервисные роли вместо примитивных: {{ roles-admin }}, {{ roles-editor }}, {{ roles-viewer }}, {{ roles-auditor }} {#min-privileges}

[Принцип минимальных привилегий](../../../iam/best-practices/using-iam-securely.md#restrict-access) требует назначать минимально необходимые для работы роли. Не рекомендуется использовать примитивные роли `{{ roles-admin }}`, `{{ roles-editor }}`, `{{ roles-viewer }}` и `{{ roles-auditor }}`, действующие во всех сервисах, так как это противоречит принципу минимальных привилегий. Для более избирательного управления доступом и реализации принципа минимальных привилегий используйте сервисные роли, которые содержат разрешения только для определенного типа ресурсов в указанном сервисе. Со списком всех сервисных ролей можно ознакомиться в [справочнике ролей {{ yandex-cloud }}](../../../iam/roles-reference.md).

Используйте роль [{{ roles-auditor }}](../../../iam/roles-reference.md#auditor) без возможности доступа к данным везде, где это возможно.

| ID требования | Критичность |
| --- | --- |
| IAM6 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. Откройте консоль {{ yandex-cloud }} в вашем браузере.
  1. Перейдите во вкладку **Все сервисы** → **{{ org-full-name }}** → **Пользователи**.
  1. Если у всех учетных записей в колонке **Права доступа** отсутствуют примитивные роли `{{ roles-admin }}`, `{{ roles-editor }}` и `{{ roles-viewer }}`, то рекомендация выполняется. Если нет, то перейдите к п. <q>Инструкции и решения по выполнению</q>.
  1. Далее перейдите в общее меню облака (нажать на облако в исходном меню облака). Выберите вкладку **Права доступа**.
  1. Если у всех учетных записей в колонке **Роли** отсутствуют примитивные роли `{{ roles-admin }}`, `{{ roles-editor }}` и `{{ roles-viewer }}`, то рекомендация выполняется. Если нет, то перейдите к п. <q>Инструкции и решения по выполнению</q>.
  1. Далее перейдите в каждый каталог каждого облака и по аналогии перейдите во вкладку **Права доступа**.
  1. Если у всех учетных записей в колонке роли отсутствуют примитивные роли `{{ roles-admin }}`, `{{ roles-editor }}` и `{{ roles-viewer }}`, то рекомендация выполняется. Если нет, то перейдите к п. <q>Инструкции и решения по выполнению</q>.
 
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

Проанализируйте найденные учетные записи с назначенными примитивными ролями `{{ roles-admin }}`, `{{ roles-editor }}` и `{{ roles-viewer }}` и замените их на [сервисные гранулярные роли](../../../iam/roles-reference.md) в соответствии с вашей матрицей ролей.

Чтобы просмотреть полный список доступов субъекта, воспользуйтесь [инструкцией](../../../security-deck/operations/ciem/view-permissions.md).

#### 1.6 Используется роль {{ roles-auditor }} для исключения доступа к данным пользователей {#roles-auditor}

Для пользователей, которые не нуждаются в доступе к данным (таких как внешние подрядчики или аудиторы), необходимо назначить роль `{{ roles-auditor }}`.
Роль `{{ roles-auditor }}` это роль с минимальными привилегиями и без доступа к данным сервисов. Она дает разрешение на чтение конфигурации и метаданных сервисов.
Роль `{{ roles-auditor }}` позволяет выполнять следующие операции:

* Просмотр информации о ресурсе.
* Просмотр метаданных ресурса.
* Просмотр списка операций с ресурсом.

Использование роли `{{ roles-auditor }}` по умолчанию позволяет более избирательно управлять доступом и реализовывать принцип минимальных привилегий.

| ID требования | Критичность |
| --- | --- |
| IAM7 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. Перейдите на вкладку **Права доступа**.
  1. Нажмите кнопку **Назначить роли**.
  1. В окне **Настройка прав доступа** нажмите кнопку **Выбрать пользователя**.
  1. Выберите пользователя из списка или воспользуйтесь поиском по пользователям.
  1. Нажмите кнопку **Добавить роль**.
  1. Выберите роль `{{ roles-auditor }}` в каталоге.
  1. Нажмите кнопку **Сохранить**.

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый ID:

     ```bash
     yc organization-manager organization list
     ```

  1. Выполните команду для поиска учетных записей с ролью `{{ roles-auditor }}` на уровне организации:

     ```bash
     export ORG_ID=<ID_организации>
     yc organization-manager organization list-access-bindings \
     --id=${ORG_ID} \
     --format=json | jq -r '.[] | select(.role_id=="auditor")'
     ```

     Если в списке отсутствуют учетные записи, то перейдите к п. <q>Инструкции и решения по выполнению</q>.

  1. Выполните команду для поиска учетных записей с ролью `{{ roles-auditor }}` на уровне облаков:

     ```bash
     export ORG_ID=<ID_организации>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do yc resource-manager cloud list-access-bindings --id=$CLOUD_ID --format=json | jq -r '.[] | select(.role_id=="auditor")'
     done
     ```

     Если в списке отсутствуют учетные записи, то перейдите к п. <q>Инструкции и решения по выполнению</q>.

  1. Выполните команду для поиска учетных записей с ролью `{{ roles-auditor }}` на уровне всех каталогов в ваших облаках:

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

1. [Назначьте](../../../iam/operations/roles/grant.md) роль `{{ roles-auditor }}` пользователям, которые не нуждаются в доступе к данным.
1. Удалите избыточные права аккаунта с помощью сервиса {{ iam-short-name }}.

### Сервисные аккаунты {#service-accounts}

#### 1.7 Облачные сущности с сервисными аккаунтами учтены и ограничены {#sa}

[Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) — аккаунт, от имени которого программы могут управлять ресурсами в {{ yandex-cloud }}. Сервисный аккаунт служит для выполнения запросов от имени приложения.

* Не используйте вместо сервисных аккаунтов аккаунты сотрудников. Например, если сотрудник уволится или сменит подразделение, его аккаунт потеряет права, что может привести к сбою приложения.
* Не записывайте ключи сервисных аккаунтов напрямую в код приложения, конфигурационные файлы или переменные окружения.

**При использовании сервисных аккаунтов**:

* Применяйте механизм [назначения сервисного аккаунта](../../../compute/operations/vm-connect/auth-inside-vm.md) виртуальной машине и получения токена через сервис метаданных.
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

  1. Откройте консоль {{ yandex-cloud }} в вашем браузере.
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

Следуйте принципу минимальных привилегий и [назначайте сервисному аккаунту](../../../iam/operations/roles/grant.md) только те роли, которые необходимы для функционирования приложения.

| ID требования | Критичность |
| --- | --- |
| IAM9 | Высокая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. Откройте консоль {{ yandex-cloud }} в вашем браузере.
  1. Перейдите в нужный каталог.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. На панели слева выберите ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
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

* [Посмотрите](../../../security-deck/operations/ciem/view-permissions.md) полный список доступов сервисного аккаунта с помощью сервиса {{ sd-full-name }}.
* [Отзовите](../../../security-deck/operations/ciem/revoke-permissions.md) избыточные доступы у сервисного аккаунта с помощью сервиса {{ sd-name }}.
* [Удалите](../../../iam/operations/roles/revoke.md) избыточные права у сервисного аккаунта с помощью сервиса {{ iam-short-name }}.

#### 1.9 Только доверенные администраторы имеют доступ к сервисным аккаунтам {#sa-admins}

Существует возможность назначать права на использование сервисного аккаунта от имени другого пользователя или сервисного аккаунта.
Следуйте принципу минимальных привилегий при выдаче доступа к сервисному аккаунту как к ресурсу: при наличии у пользователя прав на сервисный аккаунт, у него также появляется доступ и ко всем его правам. [Назначайте](../../../iam/operations/sa/set-access-bindings.md) роли на использование и управление сервисными аккаунтами минимальному кругу пользователей.
Каждый сервисный аккаунт с расширенными правами нужно размещать как ресурс в отдельном каталоге. Это необходимо для того, чтобы случайно не выдать пользователю права на такой сервисный аккаунт вместе с правами на каталог с компонентом сервиса.

| ID требования | Критичность |
| --- | --- |
| IAM10 | Высокая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. Откройте консоль {{ yandex-cloud }} в вашем браузере.
  1. Перейдите в нужный каталог.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. На панели слева выберите ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
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

[Удалите](../../../iam/operations/roles/revoke.md) избыточные права сервисного аккаунта с помощью сервиса {{ iam-short-name }}.

#### 1.10 Выполняется периодическая ротация ключей сервисных аккаунтов {#sa-key-rotation}

В {{ yandex-cloud }} поддерживаются следующие ключи доступа, которые могут быть созданы для сервисных аккаунтов:

* [IAM-токены](../../../iam/concepts/authorization/iam-token.md) — действуют 12 часов. 
* [API-ключи](../../../iam/concepts/authorization/api-key.md) — можно выбрать любой срок действия.
* [Авторизованные ключи](../../../iam/concepts/authorization/key.md) — не имеют срока действия.
* [Статические ключи доступа, совместимые с AWS API](../../../iam/concepts/authorization/access-key.md) — не имеют срока действия.

Ключи без срока действия требуется ротировать самостоятельно — удалять и создавать новые. Дату создания можно проверить в свойствах ключа. Рекомендуется ротировать ключи как минимум раз в 90 дней, в соответствии со стандартами информационной безопасности, например, PCI DSS.

| ID требования | Критичность |
| --- | --- |
| IAM11 | Высокая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. Откройте консоль {{ yandex-cloud }} в вашем браузере.
  1. Перейдите в нужный каталог.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. На панели слева выберите ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
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

      [Статические ключи](../../../iam/concepts/authorization/access-key.md): 

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

      [Авторизованные ключи](../../../iam/concepts/authorization/key.md):

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

      [API-ключи](../../../iam/concepts/authorization/api-key.md):

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

Для ротации ключей в зависимости от их типа воспользуйтесь [инструкцией](../../../iam/operations/compromised-credentials.md#key-reissue).

#### 1.11 Для API-ключей сервисных аккаунтов заданы минимально необходимые области действия {#api-key-scopes}

{% include [scoped-api-keys](../../../_includes/iam/scoped-api-keys.md) %}

[Области действия](../../../iam/concepts/authorization/api-key.md#scoped-api-keys) ограничивают применение [API-ключей](../../../iam/concepts/authorization/api-key.md) в дополнение к собственным правам доступа сервисного аккаунта. Настройка ограничений области и срока действия позволяет снизить риск несанкционированного использования ключей. Задавайте для API-ключей только те области действия, которые действительно необходимы.

| ID требования | Критичность |
| --- | --- |
| IAM12 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, которому принадлежит сервисный аккаунт.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. На панели слева выберите ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}** и выберите нужный сервисный аккаунт.
  1. В блоке **{{ ui-key.yacloud.iam.folder.service-account.overview.section_api_keys }}** обратите внимание на поле **{{ ui-key.yacloud.iam.folder.service-account.overview.column_key_scope }}** в таблице с информацией о ваших API-ключах.
  1. Если для всех API-ключей заданы минимально необходимые области действия, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

- Проверка через CLI {#cli}

  Выполните команду, указав имя сервисного аккаунта, которому принадлежат ваши API-ключи:

  ```bash
  yc iam api-key list --service-account-name <имя_сервисного_аккаунта>
  ```

  Если в выводе команды в поле `SCOPES` для всех API-ключей заданы минимально необходимые области действия, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению:**

[Создайте](../../../iam/operations/authentication/manage-api-keys.md#create-api-key) API-ключ с заданной областью действия.

#### 1.12 Токен для облачных функций и ВМ выдается через сервисный аккаунт {#func-token}

Для получения IAM-токена в ходе выполнения функции необходимо [назначить](../../../functions/operations/function-sa.md) функции сервисный аккаунт. В этом случае функция получит {{ iam-short-name }}-токен с помощью встроенных механизмов {{ yandex-cloud }}, без необходимости передачи каких-либо секретов в функцию извне. Аналогично и [для ВМ](../../../compute/operations/vm-info/get-info.md#inside-instance). Дополнительную информацию о получении IAM-токена в функции см. в разделе [{#T}](../../../functions/operations/function-sa.md).

| ID требования | Критичность |
| --- | --- |
| IAM13 | Средняя |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Проанализируйте все ваши ВМ и облачные функции на предмет созданных вручную токенов сервисных аккаунтов. Правильно использовать токены путем назначения сервисного аккаунта на сущность и использовать токен аккаунта изнутри, через сервис метаданных.

{% endlist %}

#### 1.13 Используется имперсонация, где это возможно {#impersonation}

[Имперсонация](../../../iam/operations/sa/impersonate-sa.md) позволяет пользователю выполнять действия от имени сервисного аккаунта и предоставляет возможность временно расширить права, не прибегая к генерации статических учетных данных. Может быть полезна в следующих сценариях: дежурства, локальная разработка, проверка прав доступа.

| ID требования | Критичность |
| --- | --- |
| IAM14 | Высокая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В [консоли управления]({{ link-console-main }}) на панели слева нажмите на имя нужного облака.
  1. Перейдите на вкладку **Права доступа** и проверьте наличие роли `{{ roles-iam-sa-tokencreator }}`.

{% endlist %}

**Инструкции и решения по выполнению:**

Если роль `{{ roles-iam-sa-tokencreator }}` отсутствует, то настройте имперсонацию для сервисных аккаунтов для обеспечения временного доступа к критичным данным по данной [инструкции](../../../iam/operations/sa/impersonate-sa.md).


### Метаданные ВМ {#vm-metadata}

#### 1.14 В сервисе метаданных ВМ отсутствуют облачные ключи в открытом виде {#cloud-keys}

Не записывайте ключи сервисных аккаунтов и другие ключи в [метаданные виртуальной машины](../../../compute/concepts/vm-metadata.md) напрямую. Используйте механизм [назначения сервисного аккаунта](../../../compute/operations/vm-connect/auth-inside-vm.md) виртуальной машине и получения токена через сервис метаданных. Чувствительные данные могут находиться в любом поле метаданных, но самое распространенное — `user-data` (за счет использования в утилите cloud-init).

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

  1. В {{ yandex-cloud }} используются секреты разных типов, которые могут оказаться в метаданных или переменных окружения ВМ в явном виде. Для поиска кандидатов ВМ с секретами облака в метаданных, выполните следующий скрипт:

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

{% include [delete-keys-from-metadata](../../../_includes/compute/delete-keys-from-metadata.md) %}

#### 1.15 На ВМ отключено получение токена через AWS IMDSv1 {#aws-token}

В облаке есть [сервис метаданных](../../../compute/concepts/vm-metadata.md), предоставляющий сведения о работе виртуальных машин.

Изнутри виртуальной машины метаданные доступны в следующих форматах:

* Google Compute Engine (поддерживаются не все поля).
* Amazon EC2 (поддерживаются не все поля).

Формат Amazon EC2 Instance Metadata Service version 1 (IMDSv1) имеет ряд недостатков. Наиболее критичный из них — это риск компрометации токена сервисного аккаунта через сервис метаданных с помощью SSRF-атаки. Подробности в [официальном блоге AWS](https://aws.amazon.com/blogs/security/defense-in-depth-open-firewalls-reverse-proxies-ssrf-vulnerabilities-ec2-instance-metadata-service/). В связи с этим AWS выпустили вторую версию сервиса метаданных — IMDSv2.

В {{ yandex-cloud }} пока нет поддержки второй версии, поэтому строго рекомендуется технически отключать возможность получения токена сервисного аккаунта через Amazon EC2 сервис метаданных.

Сервис метаданных Google Compute Engine использует дополнительный заголовок для защиты от SSRF и повышения безопасности.

Отключить получение токена сервисного аккаунта через Amazon EC2 сервис метаданных можно с помощью параметра ВМ [aws_v1_http_token:DISABLED](../../../compute/api-ref/grpc/Instance/create.md#yandex.cloud.compute.v1.MetadataOptions).

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

В блоке metadata_options задайте параметру [aws_v1_http_token](../../../compute/api-ref/grpc/Instance/create.md#yandex.cloud.compute.v1.MetadataOptions) значение `DISABLED` у найденных ВМ:

```bash
yc compute instance update <ID_виртуальной_машины> \
  --metadata-options aws-v1-http-token=DISABLED
```

### Привилегированные аккаунты {#privileged-accounts}

#### 1.16 Настроена двухфакторная аутентификация для привилегированных аккаунтов {#twofa}

Рекомендуется использовать двухфакторную аутентификацию (2FA) для доступа к облачной инфраструктуре, чтобы избежать рисков, связанных с компрометацией пользовательских учетных записей. Доступ в консоль {{ yandex-cloud }} может быть организован с помощью 2FA.

Чтобы подключить двухфакторную аутентификацию, обратитесь к поставщику удостоверений (identity provider) с поддержкой 2FA и настройте SAML-совместимую федерацию удостоверений. В {{ yandex-cloud }} нет своего IdP и задача идентификации пользователей решается с помощью внешних сервисов — Яндекс ID или корпоративных систем, интегрированных с помощью федерации удостоверений. Например, если вы используете IdP системы Active Directory или Keycloak, то настройте 2FA в данных системах. Необходимо настроить 2FA как минимум для привилегированных учетных записей облака.

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

К привилегированным пользователям {{ yandex-cloud }} относятся аккаунты со следующими ролями:

* `billing.accounts.owner`;
* `{{ roles-admin }}`, назначенная на платежный аккаунт;
* `organization-manager.organizations.owner`;
* `organization-manager.admin`;
* `{{ roles-cloud-owner }}`;
* `{{ roles-admin }}`, `{{ roles-editor }}`, назначенные на организацию;
* `{{ roles-admin }}`, `{{ roles-editor }}`, назначенные на облако;
* `{{ roles-admin }}`, `{{ roles-editor }}`, назначенные на каталог.

Роль `billing.accounts.owner` автоматически выдается при создании платежного аккаунта. Любой пользователь с ролью `billing.accounts.owner` может удалить эту роль у создателя платежного аккаунта и изменить владельца. Роль позволяет выполнять любые действия с платежным аккаунтом.

Роль `billing.accounts.owner` может быть назначена только аккаунту Яндекс ID. Аккаунт с ролью `billing.accounts.owner` используется при настройке способов оплаты и подключении облаков.

Безопасности этого аккаунта следует уделять повышенное внимание, поскольку он обладает значительными полномочиями и не может быть объединен с корпоративным аккаунтом.

Наиболее правильным подходом можно считать отказ от регулярного использования данного аккаунта:

* Используйте его только при первоначальной настройке и внесении изменений.
* На время активного использования данного аккаунта включите двухфакторную аутентификацию (2FA) в Яндекс ID.
* Затем, если вы не используете способ оплаты банковской картой (доступный только для данной роли), назначьте данному аккаунту сложный пароль (сгенерированный с помощью специализированного ПО), отключите 2FA и не используйте этот аккаунт без необходимости.
* После каждого использования меняйте пароль на сгенерированный заново.

Отключить 2FA рекомендуется только для этого аккаунта и в случае, если аккаунт не <q>закреплен</q> за конкретным сотрудником. Эта мера нужна, чтобы избежать привязки критически важного аккаунта к личному устройству.

Для управления платежным аккаунтом назначьте роль `{{ roles-admin }}` или `{{ roles-editor }}` на платежный аккаунт выделенному сотруднику организации с федеративным аккаунтом.

Для просмотра платежных данных назначьте роль `{{ roles-viewer }}` на платежный аккаунт выделенному сотруднику организации с федеративным аккаунтом.

Роль `organization-manager.organizations.owner` по умолчанию получает владелец организации — пользователь, который ее создал. Роль дает возможность назначать владельцев организации, а также пользоваться всеми полномочиями администратора.

Роль `{{ roles-cloud-owner }}` автоматически выдается при создании первого облака в организации. Пользователь с этой ролью может выполнять любые операции с облаком и ресурсами в нем, а также выдавать доступ к облаку другим пользователям: назначать роли и отзывать их.

Назначайте роль `{{ roles-cloud-owner }}` и `organization-manager.organizations.owner` одному или нескольким сотрудникам организации с федеративным аккаунтом. Аккаунту Яндекс ID, с которым создано облако, назначьте сложный пароль и используйте только в случае крайней необходимости, например, при поломке федерации.

Федеративный аккаунт с одной из привилегированных ролей, указанных выше, необходимо всесторонне защитить:

* Включите двухфакторную аутентификацию.
* Запретите аутентификацию с устройств, не управляемых организацией.
* Настройте мониторинг попыток входа и задайте пороги предупреждений.

Назначайте роли `{{ roles-admin }}` на облака, каталоги и платежные аккаунты федеративным аккаунтам. Минимизируйте количество аккаунтов с этими ролями и регулярно перепроверяйте потребность в этих ролях для тех аккаунтов, которым они назначены.

| ID требования | Критичность |
| --- | --- |
| IAM18 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  Проверка ролей на сервис {{ billing-name }}:

  1. Откройте консоль управления {{ yandex-cloud }} в вашем браузере.
  1. Перейдите в сервис [{{ billing-name }}]({{ link-console-billing }}).
  1. Проверьте кому назначены роли: `billing.accounts.owner`, `{{ roles-admin }}`.

  Проверка ролей на организацию:

  1. Откройте консоль управления {{ yandex-cloud }} в вашем браузере.
  1. Перейдите во вкладку **Все сервисы** → **{{ org-full-name }}** → **Пользователи**.
  1. Проверьте кому назначены роли: `{{ roles-admin }}`, `organization-manager.organizations.owner`, `organization-manager.admin`, `{{ roles-cloud-owner }}`.

  Проверка ролей на облако:

  1. Откройте консоль управления {{ yandex-cloud }} в вашем браузере.
  1. Перейдите в общее меню облака: нажмите на облако в исходном меню облака. Выберите вкладку **Права доступа**.
  1. Проверьте кому назначены роли: `{{ roles-admin }}`, `{{ roles-editor }}` , `{{ roles-cloud-owner }}`.

  Проверка ролей на каталоге:

  1. Откройте консоль управления {{ yandex-cloud }} в вашем браузере.
  1. Далее перейдите в каждый каталог каждого облака и по аналогии перейдите во вкладку **Права доступа**.
  1. Проверьте кому назначена роль `{{ roles-admin }}`.
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

Для работы с БД на прикладном уровне помимо сервисных {{ iam-short-name }} ролей создается отдельный локальный пользователь — владелец БД. В отношении него действует следующая парольная политика:

* пароль должен содержать цифры, буквы в верхнем регистре, буквы в нижнем регистре, специальные символы; 
* длина пароля — не менее 8 символов.

Также рекомендуется использовать сгенерированные пароли. В этом случае в сервисе [{{ lockbox-full-name }}](../../../lockbox/index.yaml) будет создан [сгенерированный секрет](../../../lockbox/concepts/secret.md#secret-type), значение которого будет являться паролем пользователя СУБД.

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
* Используйте роль [{{ roles-auditor }}](../../../iam/roles-reference.md#auditor) без возможности доступа к данным везде, где это возможно.

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

[_Организация_](../../../organization/concepts/organization.md) — корневой контейнер, содержащий информацию о пользователях, их ролях, а также некоторые сервисы ({{ datalens-full-name }}, {{ ml-platform-full-name }} и т.д.) Роли уровня организации автоматически наследуется всеми низлежащими контейнерами. Поэтому рекомендуется выдавать роли на уровне организации только администраторам и пользователям сервисов уровня организации.

[_Облако_](../../../resource-manager/concepts/resources-hierarchy.md#cloud) — контейнер под организацией, который содержит каталоги с сервисами. Облако логически объединяет несколько взаимосвязанных сред в его каталогах. Однако прямой связности между двумя облаками не предусмотрено. Роли, назначенные на уровне облака, наследуется всеми каталогами внутри него. Рекомендуется не выдавать слишком широкие привилегии на этом уровне.

[_Каталог_](../../../resource-manager/concepts/resources-hierarchy.md#folder) — контейнер с ресурсами и сервисами. В рамках одного облака возможно организовывать сетевую связность между каталогами. Поэтому рекомендуется связанные сервисы и среды внутри инфраструктуры располагать в соседних каталогах.

При разработке модели доступа для вашей инфраструктуры рекомендуется использовать следующие подходы:

* Как минимум одна организация для компании (корневой контейнер, от которого роли пользователей наследуются на облака, каталоги и сервисы).
* Хорошей практикой является группировка ресурсов по проектам. Рекомендуется группировать ресурсы сервисов по назначению и помещать их в отдельные облака. Для наиболее строгой изоляции — в отдельные каталоги.
* Если над сервисами работают разные команды, имеет смысл разделить ресурсы этих команд в разные облака.
* Все критичные ресурсы помещайте в отдельные каталоги или облака. К критичным относятся в том числе ресурсы, которые связаны с обработкой платежных данных, персональных данных и данных, содержащих коммерческую тайну.
* Хорошая практика — не выдавать пользователям роли `.admin` на каталог с продуктовой средой. В этом случае рекомендуется использовать подход `GitOps` и управлять инфраструктурой каталога с помощью {{ TF }} и {{ GL }}.
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

В {{ yandex-cloud }} существует возможность предоставлять публичный доступ на ресурсы. Публичный доступ предоставляется путем назначения прав доступа для [публичных групп](../../../iam/concepts/access-control/public-group.md) (`All authenticated users`, `All users`). 

Описание публичных групп:

* `All authenticated users` — все пользователи, прошедшие аутентификацию. Это все зарегистрированные пользователи или сервисные аккаунты {{ yandex-cloud }}: как из ваших облаков, так и из облаков других пользователей.
* `All users` — любой пользователь, аутентификация не требуется.

{% note warning %}

Сейчас `All users` поддерживается только в сервисах: {{ objstorage-short-name }} при управлении доступом с помощью ACL, {{ container-registry-name }}, {{ sf-name }}. В остальных сервисах назначение роли для группы `All users` эквивалентно назначению роли для `All authenticated users`.

{% endnote %}

Убедитесь, что к вашим ресурсам — облакам, каталогам, бакетам и т.д., не предоставлен публичный доступ для этих групп.

| ID требования | Критичность |
| --- | --- |
| IAM22 | Высокая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  Проверка ролей в облаке:

  1. Откройте консоль управления {{ yandex-cloud }} в вашем браузере.
  1. Далее перейдите в общее меню облака (нажать на облако в исходном меню облака). Выберите вкладку **Права доступа**.
  1. Проверьте, есть ли среди пользователей `All users` и `All authenticated users`.

  Проверка ролей в каталоге:

  1. Откройте консоль управления {{ yandex-cloud }} в вашем браузере.
  1. Перейдите в нужный каталог нужного облака и перейдите во вкладку **Права доступа**.
  1. Проверьте, есть ли среди пользователей `All users` и `All authenticated users`.
  1. Повторите действия для всех каталогов всех ваших облаков.

  Проверка ролей в {{ objstorage-short-name }}:

  1. Откройте консоль управления {{ yandex-cloud }} в вашем браузере.
  1. Перейдите в нужное облако и найдите сервис **{{ objstorage-short-name }}**.
  1. Нажмите на три точки напротив бакета и проверьте ACL бакета на наличие `allUsers`, `allAuthenticatedUsers`.
  1. Зайдите внутрь бакета и проверьте ACL на каждый объект бакета на наличие `allUsers`, `allAuthenticatedUsers`.
  1. Зайдите в глобальные настройки бакета и в разделе **Доступ на чтение объектов** проверьте, что параметр **Публичный** выключен.
  1. Повторите действия для всех бакетов и объектов во всех ваших облаках.

  Проверка ролей в {{ container-registry-name }}:

  1. Откройте консоль управления {{ yandex-cloud }} в вашем браузере.
  1. Далее перейдите в каждое облако и найдите сервис **{{ container-registry-name }}**.
  1. Перейдите в необходимый реестр и слева нажмите **Права доступа**.
  1. Проверьте, есть ли среди пользователей `All users` и `All authenticated users`.
  1. Повторите действия для всех ваших облаков.

  Проверка ролей в {{ sf-name }}:

  1. Откройте консоль управления {{ yandex-cloud }} в вашем браузере.
  1. Далее перейдите в каждое облако и найдите сервис **{{ sf-name }}**.
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

  1. Выполните команду для поиска прав доступа `allUsers`, `allAuthenticatedUsers` на уровне {{ container-registry-name }} во всех каталогах:

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

  1. Выполните команду для поиска прав доступа `allUsers`, `allAuthenticatedUsers` на уровне {{ sf-name }} во всех каталогах:

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

В {{ yandex-cloud }} при регистрации облака клиент указывает контактные данные. Например, электронная почта используется для оповещений, связанных с инцидентами, плановыми работами и т.д.

Например, если со стороны облака были обнаружены аномальные активности в организации клиента или облачные ключи {{ iam-short-name }} становятся доступными во внешних репозиториях GitHub, клиенту будет направлено оповещение. Эта возможность реализована с помощью участия {{ yandex-cloud }} в программе [Github Secret scanning partner program](https://docs.github.com/en/developers/overview/secret-scanning-partner-program), а также анализа секретов в поиске Яндекса. В случае компрометации ключей в публичном репозитории, удалите секрет из репозитория, его [истории](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/removing-sensitive-data-from-a-repository) и отзовите [ключи](../../../iam/operations/compromised-credentials.md).

Убедитесь, что контактные данные актуальны и указанный почтовый ящик рассылает сообщения нескольким ответственным.

| ID требования | Критичность |
| --- | --- |
| IAM23 | Информационная |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. Откройте консоль управления {{ yandex-cloud }} в вашем браузере.
  1. Перейдите в сервис [{{ billing-name }}]({{ link-console-billing }}).
  1. Перейдите во вкладку **Данные аккаунта**.
  1. В самом низу будет кнопка **Редактировать данные в Яндекс Балансе**.
  1. Проверьте указанные контактные данные.
  1. Если указанные данные актуальны, то рекомендация выполняется. Если нет, то перейдите к п. <q>Инструкции и решения по выполнению</q>.

{% endlist %}

**Инструкции и решения по выполнению:**

Укажите актуальные контактные данные по [инструкции](../../../billing/operations/change-data.md#change-address).

#### 1.23 На ресурсах используются метки {#labels}

Для отслеживания потоков данных и обозначения критичности ресурсов для управления привилегиями необходимо использование [меток](../../../resource-manager/concepts/labels.md).
Например, для тегирования ресурсов, которые обрабатывают персональные данные в рамках Федерального закона Российской Федерации «О персональных данных» № 152-ФЗ нужно выбрать метку `152-fz:true` для:

* каталога;
* [бакета](../../../storage/concepts/bucket.md) {{ objstorage-full-name }};
* [секрета](../../../lockbox/concepts/secret.md) {{ lockbox-full-name }};
* кластеров управляемых баз данных.

{% list tabs group=instructions %}

| ID требования | Критичность |
| --- | --- |
| IAM24 | Информационная |

- Проверка в консоли управления {#console}

  В примере ниже показана проверка наличия метки к облачной сети [{{ vpc-full-name }}](../../../vpc/). Аналогично вы можете проверить наличие метки у другого ресурса.

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Проверьте наличие меток.

{% endlist %}

**Инструкции и решения по выполнению:**

[Инструкция по управлению метками](../../../resource-manager/operations/manage-labels.md).

### Уведомления и аудит {#notifications-and-audit}

#### 1.24 Уведомления безопасности {{ yandex-cloud }} включены {#security-notifications}

Для получения уведомлений о событиях в области безопасности, например, обнаруженных уязвимостях и их устранении, рекомендуется выбрать уведомления безопасности в настройках консоли управления.

| ID требования | Критичность |
| --- | --- |
| IAM25 | Высокая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В [консоли управления]({{ link-console-main }}) нажмите [**Настройки**]({{ link-console-settings }}).
  1. Выберите раздел **Уведомления**.
  1. В настройках уведомлений включите опцию **Безопасность**.

{% endlist %}

**Инструкции и решения по выполнению:**

1. [Убедитесь](../../../resource-manager/concepts/notify.md), что уведомления настроены.
1. Включите опцию **Безопасность** в настройках уведомлений консоли управления.

#### 1.25 Отслеживается дата последней аутентификации сервисного аккаунта и последнего использования ключей доступа в {{ iam-full-name }} {#key-usage-control}

{% include [sa-last-used-data](../../iam/sa-last-used-data.md) %}

{% include [key-has-last-used-data](../../iam/key-has-last-used-data.md) %}

Подробнее см. в разделе [{#T}](../../../iam/concepts/users/service-accounts.md#sa-key).

| ID требования | Критичность |
| --- | --- |
| IAM26 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, которому принадлежит сервисный аккаунт с ключами доступа.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. На панели слева выберите ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
  1. В открывшемся списке выберите нужный сервисный аккаунт.
  1. Данные о времени последнего использования ключа доступны в таблице с информацией о ключах в поле **{{ ui-key.yacloud.iam.folder.service-account.overview.column_key_last-used-at }}**.

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

#### 1.26 Регулярно проводится аудит прав доступа пользователей и сервисных аккаунтов с использованием {{ sd-full-name }} {{ ciem-name }} {#ciem-access-control}

В целях обеспечения безопасности данных и облачной инфраструктуры необходимо регулярно проводить аудит прав доступа, имеющихся у пользователей и сервисных аккаунтов.

[Модуль диагностики доступов]({{ link-sd-main }}iam-diagnostics/) или {{ ciem-name }} (Cloud Infrastructure Entitlement Management) — это инструмент, позволяющий централизованно просматривать полный список доступов [субъектов](../../../iam/concepts/access-control/index.md#subject): пользователей, сервисных аккаунтов, [групп пользователей](../../../organization/concepts/groups.md), [системных групп](../../../iam/concepts/access-control/system-group.md) и [публичных групп](../../../iam/concepts/access-control/public-group.md) к [ресурсам](../../../iam/concepts/access-control/resources-with-access-control.md) организации. Этот инструмент также позволяет легко отзывать у субъектов лишние доступы.

Подробнее см. в разделе [{#T}](../../../security-deck/concepts/ciem.md).

| ID требования | Критичность |
| --- | --- |
| IAM27 | Информационная |

**Инструкции и решения по выполнению:**

[{#T}](../../../security-deck/operations/ciem/view-permissions.md).
[{#T}](../../../security-deck/operations/ciem/revoke-permissions.md).