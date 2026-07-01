# Рекомендации по использованию правил ревью кода в Yandex Managed Service for GitLab

Managed Service for GitLab позволяет гибко настраивать обязательные _правила ревью кода_, прежде чем код может быть добавлен в целевую [ветку проекта](../../glossary/vcs.md#branch). Функциональность является альтернативой встроенному в GitLab Enterprise Edition инструменту [Approval Rules](https://docs.gitlab.com/ee/user/project/merge_requests/approvals/rules.html) и доступна вне зависимости от [версии](https://about.gitlab.com/pricing) GitLab.

Конфигурация правил ревью в Managed Service for GitLab настраиваются только в виде кода (Configuration as Code) в файлах `APPROVALRULES` и (опционально) `CODEOWNERS`.

Подробнее читайте на странице [Правила ревью кода в Yandex Managed Service for GitLab](approval-rules.md).

{% note warning %}

За использование правил ревью кода в Managed Service for GitLab взимается плата в зависимости от используемой [конфигурации](approval-rules.md#packages). Подробнее читайте на странице [{#T}](../../managed-gitlab/pricing.md).

{% endnote %}

В разделе приведены примеры файлов `APPROVALRULES` и (опционально) `CODEOWNERS` для следующих типовых сценариев:
* [Пример настройки правил для ревью от конкретных пользователей](#role-based-review)
* [Пример настройки правил для двухэтапного ревью](#two-stage-review)
* [Пример настройки правил для ревью изменений в CI/CD](#cicd-review)

Помимо правил ревью кода в репозитории может быть настроена [защита веток](https://docs.gitlab.com/user/project/repository/branches/protected/). Это два параллельных механизма, поэтому выполнения правил ревью кода может быть недостаточно для слияния мерж-реквеста с целевой веткой. Для упрощения считается, что приведенные в примерах ветки не являются основными в репозитории, например `main`, и защищены только от прямых внесений изменений (direct push).

Правила ревью кода начинают действовать после того, как изменения в файлах `APPROVALRULES` и (опционально) `CODEOWNERS` будут влиты в [основную ветку](https://docs.gitlab.com/ee/user/project/repository/branches/default.html) репозитория. Переносить эти изменения в остальные ветки не нужно.

{% note warning %}

По умолчанию основная ветка репозитория [защищена](https://docs.gitlab.com/user/project/repository/branches/protected/) от изменений по схеме [Fully protected](https://docs.gitlab.com/user/project/repository/branches/default/#protect-initial-default-branches). Вносить в нее изменения могут только пользователи с [ролью](https://docs.gitlab.com/user/permissions/#roles) `Maintainer`.

{% endnote %}

У пользователей, выполняющих ревью мерж-реквестов, должна быть минимальная роль `Reporter` в проекте GitLab, в большинстве случаев используется более привилегированная роль `Developer`.

## Предварительные действия {#preparations}

1. Если у вас еще нет инстанса GitLab, [создайте и активируйте](../operations/instance/instance-create.md) его.
1. Если у вас еще не сконфигурированы правила ревью кода в инстансе и проекте GitLab, [настройте](../operations/approval-rules.md) их.

    {% note info %}

    Минимальная [конфигурация](approval-rules.md#packages) для функциональности правил ревью кода указана в каждом примере.

    {% endnote %}

1. Создайте пользователей и [группы](https://docs.gitlab.com/user/group/) согласно примерам ниже.
1. Создайте файлы `APPROVALRULES` и (опционально) `CODEOWNERS` в основной ветке репозитория согласно примерам ниже.

## Пример настройки правил для ревью от конкретных пользователей {#role-based-review}

#|
|| **Минимальная [конфигурация](approval-rules.md#packages)** | **Комментарий** ||
|| Базовая | 
* Используется одно правило на проект.
* Правило действует на одну ветку.
* Не используется Code Ownership. ||
|#

В примере представлен сценарий для обязательных проверок мерж-реквестов специалистами по информационной безопасности. Для слияния с веткой `release` требуется одобрение мерж-реквеста от одного из пользователей с `username`: `security-expert1` или `security-expert2`.

Сценарий также подходит для других простых случаев, когда вы хотите защитить одну ветку и назначать конкретных согласующих.

Содержимое файла `APPROVALRULES`:

```yaml
# Правила ревью
ApprovalRules:
  # Произвольное название правила
  - SecurityReview:
      # Список пользователей (username), которые могут одобрить мерж-реквест
      approvers:
        - "security-expert1"
        - "security-expert2"
      # Требуемое количество одобрений
      count: 1
# Группы веток, к которым применяются правила
BranchGroups:
  # Произвольное название группы веток
  - Release:
      # Список веток, к которым применяются правила
      branches:
        - release
      # Применяемые правила
      rules:
        - SecurityReview
```

В результате при создании мерж-реквеста в ветку `release` в поле **Reviewer** автоматически назначается один из указанных пользователей, а сам мерж-реквест блокируется до того, как будет одобрен.

{% note tip %}

Вместо блока `approvers` с конкретными пользователями вы можете использовать блок `groups` для указания [группы](https://docs.gitlab.com/user/group/) пользователей.

{% cut "Пример" %}

```yaml
ApprovalRules:
  - SecurityReview:
      groups:
        - "soc"
        - "secops"
      count: 1
...
```

{% endcut %}

В таком случае согласующим в мерж-реквест будет автоматически добавляться один из пользователей, состоящий в одной из этих групп.

Одновременное использование блоков `approvers` и `groups` в одном правиле избыточно.

{% endnote %}

## Пример настройки правил для двухэтапного ревью {#two-stage-review}

#|
|| **Минимальная [конфигурация](approval-rules.md#packages)** | **Комментарий** ||
|| Продвинутая | 
* Используется несколько правил на проект.
* Разные правила для разных веток.
* Не используется Code Ownership. ||
|#

В примере представлен сценарий для обязательных проверок мерж-реквестов в два этапа:
1. Для слияния с веткой `stage` требуется одно одобрение от разработчика из [группы](https://docs.gitlab.com/user/group/) `devs` — код проверяется на корректность, стиль, тесты и архитектуру.
1. Для слияния с веткой `release` требуются два одобрения: от разработчика из группы `devs` и от технического лида из группы `tech-leads`, который оценивает соответствие бизнес-целям и стандартам команды.

Соответственно подразумевается, что сначала изменения попадают из основной ветки, в которой ведется разработка, например `dev`, на стейджинг (ветка `stage`) и тестируются там, а уже после этого — в релиз (ветка `release`).

Вы также можете адаптировать сценарий для случаев, когда для слияния мерж-реквестов в разные ветки требуются разные правила ревью.

Содержимое файла `APPROVALRULES`:

```yaml
# Правила ревью
ApprovalRules:
  # Произвольное название правила
  - TechnicalReview:
      # Список групп, участники которых могут одобрить мерж-реквест
      groups:
        - devs
      # Требуемое количество одобрений
      count: 1
  - LeadApproval:
      groups:
        - tech-leads
      count: 1
# Группы веток, к которым применяются правила
BranchGroups:
  # Произвольное название группы веток
  - Stage:
      # Список веток, к которым применяются правила
      branches:
        - stage
      # Применяемые правила
      rules:
        - TechnicalReview
  - Release:
      branches:
        - release
      rules:
        - TechnicalReview
        - LeadApproval
```

В результате при создании мерж-реквеста в ветку `stage` в поле **Reviewer** автоматически назначается один из участников группы `devs`, а сам мерж-реквест блокируется до того, как будет одобрен. После мержа изменения тестируются на стейджинге.

Далее разработчик создает мерж-реквест из ветки `stage` в ветку `release`. В поле **Reviewer** автоматически назначаются один из участников группы `devs` и один из участников группы `tech-leads`, а сам мерж-реквест также блокируется до того, как получит оба одобрения.

{% note tip %}

Вместо блока `groups` с [группами](https://docs.gitlab.com/user/group/) пользователей вы можете использовать блок `approvers` для указания конкретных пользователей.

{% cut "Пример" %}

```yaml
ApprovalRules:
  - TechnicalReview:
      approvers:
        - "dev1"
        - "dev2"
      count: 1
...
```

{% endcut %}

В таком случае согласующим в мерж-реквест будет автоматически добавляться один из указанных пользователей.

Одновременное использование блоков `approvers` и `groups` в одном правиле избыточно.

{% endnote %}

## Пример настройки правил для ревью изменений в CI/CD {#cicd-review}

#|
|| **Минимальная [конфигурация](approval-rules.md#packages)** | **Комментарий** ||
|| Стандартная | 
* Используется одно правило на проект.
* Правило действует на одну ветку.
* Используется Code Ownership. ||
|#

В примере представлен сценарий для обязательных проверок мерж-реквестов DevOps-инженерами, только если была затронута конфигурация CI/CD. Если в мерж-реквесте были изменены файл `.gitlab-ci.yml` или файлы с расширением `.yml` в директории `ci/`, то для слияния с веткой `release` требуется одобрение от одного из участников [группы](https://docs.gitlab.com/user/group/) `devops-team`.

Сценарий также подходит для других случаев, когда вы хотите разграничить область ревью в разных директориях или файлах репозитория для разных команд или пользователей.

Фильтрация по путям не поддерживается в `APPROVALRULES`, поэтому используйте совместно с правилами ревью механизм [Code Ownership](../operations/approval-rules.md#code-ownership).

Содержимое файла `CODEOWNERS`:

```text
# <Пути_к_файлам_или_паттерны_фильтрации> @<ответственная_группа>
.gitlab-ci.yml @devops-team
ci/*.yml @devops-team
```

Содержимое файла `APPROVALRULES`:

```yaml
# Группы веток, к которым применяются правила
BranchGroups:
  # Произвольное название группы веток
  - Release:
      # Список веток, к которым применяются правила
      branches:
        - release
      # Применяемые правила
      rules:
        - CODE_OWNERS
```

В результате при создании мерж-реквеста в ветку `release`, затрагивающего файлы `.gitlab-ci.yml` или `ci/*.yml`, в поле **Reviewer** автоматически назначается один из участников группы `devops-team`, а сам мерж-реквест блокируется до того, как будет одобрен.

{% note tip %}

Рекомендуется применять правила Code Ownership точечно — только для веток, куда попадают финальные изменения. Однако вы также можете применить их ко всем веткам.

{% cut "Пример" %}

```yaml
BranchGroups:
  - All:
      branches:
        - "*"
      rules:
        - CODE_OWNERS
```

{% endcut %}

{% endnote %}

#### Полезные ссылки {#see-also}

* [Правила ревью кода в Yandex Managed Service for GitLab](approval-rules.md)
* [Настройка правил ревью кода в Yandex Managed Service for GitLab](../operations/approval-rules.md)
* [Создание и активация инстанса Yandex Managed Service for GitLab](../operations/instance/instance-create.md)

#### Документация GitLab {#gl-docs}

* [Merge request approval rules](https://docs.gitlab.com/ee/user/project/merge_requests/approvals/rules.html)
* [Syntax of CODEOWNERS file](https://docs.gitlab.com/user/project/codeowners/reference/)
* [Protected branches](https://docs.gitlab.com/user/project/repository/branches/protected/)
* [Default branch](https://docs.gitlab.com/ee/user/project/repository/branches/default.html)
* [Roles and permissions](https://docs.gitlab.com/user/permissions/)
* [Groups](https://docs.gitlab.com/user/group/)