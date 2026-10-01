[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for GitLab](../index.md) > Вопросы и ответы

# Общие вопросы про Managed Service for GitLab

* [В чем преимущества Managed Service for GitLab перед пользовательской инсталляцией GitLab Community Edition?](#advantages)

* [Как перенести данные из GitLab в Managed Service for GitLab?](#migration)

* [Как обновить ПО на инстансе Managed Service for GitLab?](#update-gitlab)

* [Можно ли интегрировать провайдеров аутентификации для GitLab?](#auth-provider)

* [Можно ли использовать Яндекс ID или Яндекс 360 для аутентификации?](#auth-yandex-id)

* [Есть ли интеграция GitLab с Яндекс Трекер?](#tracker-integration)

* [Почему не получается отправить изменения в репозиторий Managed Service for GitLab?](#push)

* [Что делать, если при выполнении `git push` возникает ошибка HTTP 413?](#413-error)

* [Что делать, если при открытии инстанса возникает ошибка HTTP 500 или HTTP 502?](#500-error)

* [Как я могу очистить логи пайплайнов, чтобы освободить место на диске?](#pipeline-cleanup)

* [Где я могу отслеживать использование дискового пространства?](#disk-space)

* [Как настроить алерт, который срабатывает при заполнении определенного процента дискового пространства?](#alert-for-disk-space)

* [Почему резервные копии не создаются?](#backup-failed)

* [Можно ли после создания инстанса изменить его тип или размер диска?](#change-type-size)

* [Что делать, если не удается подключиться к системному хуку на `localhost`?](#system-hooks-localhost)

* [Что делать, если при работе воркера возникает ошибка `EOF fatal`?](#eof-fatal-error)

* [Что делать, если SSL-сертификат просрочен?](#ssl-certificate-expired)

#### В чем преимущества Managed Service for GitLab перед пользовательской инсталляцией GitLab Community Edition? {#advantages}

Основное преимущество Managed Service for GitLab заключается в том, что он позволяет сократить затраты на установку и администрирование GitLab. Кроме того, в Managed Service for GitLab добавлена функциональность, которой нет в [Community Edition](https://about.gitlab.com/install/ce-or-ee/) (например, правила ревью кода). Подробнее читайте в разделе [Преимущества сервиса перед пользовательской инсталляцией GitLab](../concepts/managed-gitlab-vs-custom-installation.md).

#### Как перенести данные из GitLab в Managed Service for GitLab? {#migration}

Вы можете перенести данные из пользовательской инсталляции GitLab в сервис Managed Service for GitLab. О том, как это сделать, читайте в [инструкции](../operations/instance/migration.md). Перед началом работы ознакомьтесь с [порядком предоставления услуги](../concepts/migration.md).

Проекты из GitLab.com можно перенести с помощью [самостоятельного экспорта и импорта](../operations/instance/migration.md#self-migration). 

#### Как обновить ПО на инстансе Managed Service for GitLab? {#update-gitlab}

ПО GitLab на инстансах Managed Service for GitLab обновляется автоматически по мере адаптации новых версий к среде Yandex Cloud. Самостоятельно обновить версию ПО нельзя.

Если обновление необходимо раньше, обратитесь в [техническую поддержку](https://center.yandex.cloud/support). В запросе укажите:

* идентификатор инстанса;
* требуемую версию GitLab;
* желаемые дату и время обновления;
* причину обновления.

{% note alert %}

Во время операции обновления ПО инстанс Managed Service for GitLab и данные на нем будут недоступны.

{% endnote %}

#### Можно ли интегрировать провайдеров аутентификации для GitLab? {#auth-provider}

Да, для этого [настройте OmniAuth](../operations/omniauth.md).

#### Можно ли использовать Яндекс ID или Яндекс 360 для аутентификации? {#auth-yandex-id}

Да, для этого в OmniAuth [добавьте провайдер](../operations/omniauth.md#add-provider) с типом `Yandex ID` и укажите его [параметры](../operations/omniauth.md#yandex-id).

#### Есть ли интеграция GitLab с Яндекс Трекер? {#tracker-integration}

Да, настройки интеграции описаны в разделе [Интеграция с Яндекс Трекер](https://yandex.ru/support/tracker/ru/user/gitlab).

#### Почему не получается отправить изменения в репозиторий Managed Service for GitLab? {#push}

Тексты ошибок:

```text
You are not allowed to push code to this project.
```

```text
You are not allowed to push code to protected branches on this project.
```

Чтобы отправлять изменения в репозиторий Managed Service for GitLab, [назначьте](https://docs.gitlab.com/ee/user/project/members/#add-users-to-a-project) пользователю необходимую роль в проекте. Для отправки:

* В защищенные ветки (например `master`) — `Maintainer` или `Owner`.
* В незащищенные — `Developer`, `Maintainer` или `Owner`.

Пользователи с ролями `Guest` и `Reporter` отправлять изменения не могут.

Подробнее о ролях в [документации GitLab](https://docs.gitlab.com/ee/user/permissions.html).

#### Что делать, если при выполнении `git push` возникает ошибка HTTP 413? {#413-error}

При отправке изменений по HTTP или HTTPS может возникнуть ошибка:

```text
error: RPC failed;
HTTP 413 curl 22
The requested URL returned error: 413
```

Размер данных, отправляемых одной командой `git push` по HTTP или HTTPS, ограничен 250 МБ. Изменить настройки Nginx для отдельного инстанса нельзя.

Отправьте изменения по SSH или разделите их на несколько отправок. Настройка доступа по SSH описана в разделе [Как начать работать с Managed Service for GitLab](../quickstart.md).

#### Что делать, если при открытии инстанса возникает ошибка HTTP 500 или HTTP 502? {#500-error}

Дисковое пространство инстанса может быть переполнено. Вы можете самостоятельно [увеличить дисковое пространство инстанса](../operations/instance/instance-update.md).

Также используйте инструкцию [Очистка переполненного дискового пространства инстанса](../operations/instance/clean-up-disk-space.md).

Чтобы отслеживать заполнение диска, [настройте мониторинг и алерты](../operations/instance/monitoring.md#monitoring-integration). Место на диске могут занимать образы контейнеров и артефакты сборки. Для их регулярного удаления [настройте политики очистки](../operations/instance/clean-up-disk-space.md#set-cleanup-policy).

#### Как я могу очистить логи пайплайнов, чтобы освободить место на диске? {#pipeline-cleanup}

Удалить логи отдельно нельзя. Однако это можно сделать [удалив неактуальные пайплайны](../operations/instance/clean-up-disk-space.md#pipeline-cleanup).

#### Где я могу отслеживать использование дискового пространства? {#disk-space}

Отслеживать использование дискового пространства можно:

* в консоли управления с помощью инструментов [мониторинга состояния инстанса](../operations/instance/monitoring.md#view-graphs);
* в сервисе [Yandex Monitoring](../../monitoring/concepts/index.md) с возможностью [настроить алерты](../operations/instance/monitoring.md#monitoring-integration) по заданным метрикам.

#### Как настроить алерт, который срабатывает при заполнении определенного процента дискового пространства? {#alert-for-disk-space}

С помощью инструкции [Настройка алертов в Monitoring для Managed Service for GitLab](../operations/instance/monitoring.md#monitoring-integration).

#### Почему резервные копии не создаются? {#backup-failed}

Если создание [резервных копий](../concepts/backup.md) завершается ошибкой (статус `Failed`), [настройте отдельную группу безопасности](../operations/configure-security-group.md) и привяжите ее к инстансу GitLab.

#### Можно ли после создания инстанса изменить его тип или размер диска? {#change-type-size}

Да, можно изменить тип инстанса на более производительный, а также увеличить размер его диска. Уменьшить размер диска, а также перейти на менее производительный тип инстанса нельзя. Подробнее в разделе [Изменение настроек инстанса](../operations/instance/instance-update.md).

#### Что делать, если не удается подключиться к системному хуку на localhost? {#system-hooks-localhost}

Если не удается подключиться к системному хуку, используйте IP-адрес `127.0.0.1` вместо `localhost`:

1. В параметрах системного хука (**Admin area** → **System Hooks**) измените значение **URL** на `http://127.0.0.1:24080/default`.
1. В настройках GitLab, разрешающих отправлять сообщения в локальную сеть (**Admin area** → **Settings** → **Network** → **Expand outbound requests**, поле ввода для CIDR), добавьте `http://127.0.0.1:24080` в список IP-адресов и доменных имен.

#### Что делать, если при работе воркера возникает ошибка EOF fatal? {#eof-fatal-error}

Полный текст ошибки:

```text
EOF fatal: early EOF fatal: fetch-pack: invalid index-pack output
```

Ошибку можно исправить только на раннере, который вручную развернут на ВМ. Для этого примените следующие настройки:

```bash
sysctl -w net.core.rmem_max=26214400
sysctl -w net.core.rmem_default=6250000
sysctl -w net.core.wmem_max=26214400
sysctl -w net.core.wmem_default=6250000
sysctl -w net.ipv4.tcp_rmem='4096 6250000 26214400'
sysctl -w net.ipv4.tcp_wmem='4096 6250000 26214400'
```

#### Что делать, если SSL-сертификат просрочен? {#ssl-certificate-expired}

Обычно SSL-сертификат на инстансах Managed Service for GitLab перевыпускается автоматически. Если этого не произошло, [перезапустите](../operations/instance/instance-stop.md) инстанс.

Если перезапуск не решил проблему, обратитесь в [техническую поддержку](https://center.yandex.cloud/support).