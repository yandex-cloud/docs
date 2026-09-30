#### В чем преимущества {{ mgl-name }} перед пользовательской инсталляцией {{ GL }} Community Edition? {#advantages}

Основное преимущество {{ mgl-name }} заключается в том, что он позволяет сократить затраты на установку и администрирование {{ GL }}. Кроме того, в {{ mgl-name }} добавлена функциональность, которой нет в [Community Edition](https://about.gitlab.com/install/ce-or-ee/) (например, правила ревью кода). Подробнее читайте в разделе [Преимущества сервиса перед пользовательской инсталляцией {{ GL }}](../../managed-gitlab/concepts/managed-gitlab-vs-custom-installation.md).

#### Как перенести данные из {{ GL }} в {{ mgl-name }}? {#migration}

Вы можете перенести данные из пользовательской инсталляции {{ GL }} в сервис {{ mgl-name }}. О том, как это сделать, читайте в [инструкции](../../managed-gitlab/operations/instance/migration.md). Перед началом работы ознакомьтесь с [порядком предоставления услуги](../../managed-gitlab/concepts/migration.md).

Проекты из {{ GL }}.com можно перенести с помощью [самостоятельного экспорта и импорта](../../managed-gitlab/operations/instance/migration.md#self-migration). 

#### Как обновить ПО на инстансе {{ mgl-name }}? {#update-gitlab}

ПО {{ GL }} на инстансах {{ mgl-name }} обновляется автоматически по мере адаптации новых версий к среде {{ yandex-cloud }}. Самостоятельно обновить версию ПО нельзя.

Если обновление необходимо раньше, обратитесь в [техническую поддержку]({{ link-console-support }}). В запросе укажите:

* идентификатор инстанса;
* требуемую версию {{ GL }};
* желаемые дату и время обновления;
* причину обновления.

{% note alert %}

Во время операции обновления ПО инстанс {{ mgl-name }} и данные на нем будут недоступны.

{% endnote %}

#### Можно ли интегрировать провайдеров аутентификации для {{ GL }}? {#auth-provider}

Да, для этого [настройте OmniAuth](../../managed-gitlab/operations/omniauth.md).

#### Можно ли использовать Яндекс ID или Яндекс 360 для аутентификации? {#auth-yandex-id}

Да, для этого в OmniAuth [добавьте провайдер](../../managed-gitlab/operations/omniauth.md#add-provider) с типом `Yandex ID` и укажите его [параметры](../../managed-gitlab/operations/omniauth.md#yandex-id).

#### Есть ли интеграция {{ GL }} с {{ tracker-full-name }}? {#tracker-integration}

Да, настройки интеграции описаны в разделе [Интеграция с {{ tracker-full-name }}](https://yandex.ru/support/tracker/ru/user/gitlab).

#### Почему не получается отправить изменения в репозиторий {{ mgl-name }}? {#push}

Тексты ошибок:

```text
You are not allowed to push code to this project.
```

```text
You are not allowed to push code to protected branches on this project.
```

Чтобы отправлять изменения в репозиторий {{ mgl-name }}, [назначьте]({{ gl.docs }}/ee/user/project/members/#add-users-to-a-project) пользователю необходимую роль в проекте. Для отправки:

* В защищенные ветки (например `master`) — `Maintainer` или `Owner`.
* В незащищенные — `Developer`, `Maintainer` или `Owner`.

Пользователи с ролями `Guest` и `Reporter` отправлять изменения не могут.

Подробнее о ролях в [документации {{ GL }}]({{ gl.docs }}/ee/user/permissions.html).

#### Что делать, если при выполнении `git push` возникает ошибка HTTP 413? {#413-error}

При отправке изменений по HTTP или HTTPS может возникнуть ошибка:

```text
error: RPC failed;
HTTP 413 curl 22
The requested URL returned error: 413
```

Размер данных, отправляемых одной командой `git push` по HTTP или HTTPS, ограничен 250 МБ. Изменить настройки Nginx для отдельного инстанса нельзя.

Отправьте изменения по SSH или разделите их на несколько отправок. Настройка доступа по SSH описана в разделе [{#T}](../../managed-gitlab/quickstart.md).

#### Что делать, если при открытии инстанса возникает ошибка HTTP 500 или HTTP 502? {#500-error}

Дисковое пространство инстанса может быть переполнено. Вы можете самостоятельно [увеличить дисковое пространство инстанса](../../managed-gitlab/operations/instance/instance-update.md).

Также используйте инструкцию [{#T}](../../managed-gitlab/operations/instance/clean-up-disk-space.md).

Чтобы отслеживать заполнение диска, [настройте мониторинг и алерты](../../managed-gitlab/operations/instance/monitoring.md#monitoring-integration). Место на диске могут занимать образы контейнеров и артефакты сборки. Для их регулярного удаления [настройте политики очистки](../../managed-gitlab/operations/instance/clean-up-disk-space.md#set-cleanup-policy).

#### Как я могу очистить логи пайплайнов, чтобы освободить место на диске? {#pipeline-cleanup}

Удалить логи отдельно нельзя. Однако это можно сделать [удалив неактуальные пайплайны](../../managed-gitlab/operations/instance/clean-up-disk-space.md#pipeline-cleanup).

#### Где я могу отслеживать использование дискового пространства? {#disk-space}

Отслеживать использование дискового пространства можно:

* в консоли управления с помощью инструментов [мониторинга состояния инстанса](../../managed-gitlab/operations/instance/monitoring.md#view-graphs);
* в сервисе [{{ monitoring-full-name }}](../../monitoring/concepts/index.md) с возможностью [настроить алерты](../../managed-gitlab/operations/instance/monitoring.md#monitoring-integration) по заданным метрикам.

#### Как настроить алерт, который срабатывает при заполнении определенного процента дискового пространства? {#alert-for-disk-space}

С помощью инструкции [Настройка алертов в {{ monitoring-name }} для {{ mgl-name }}](../../managed-gitlab/operations/instance/monitoring.md#monitoring-integration).

#### Почему резервные копии не создаются? {#backup-failed}

Если создание [резервных копий](../../managed-gitlab/concepts/backup.md) завершается ошибкой (статус `Failed`), [настройте отдельную группу безопасности](../../managed-gitlab/operations/configure-security-group.md) и привяжите ее к инстансу {{ GL }}.

#### Можно ли после создания инстанса изменить его тип или размер диска? {#change-type-size}

Да, можно изменить тип инстанса на более производительный, а также увеличить размер его диска. Уменьшить размер диска, а также перейти на менее производительный тип инстанса нельзя. Подробнее в разделе [{#T}](../../managed-gitlab/operations/instance/instance-update.md).

#### Что делать, если не удается подключиться к системному хуку на localhost? {#system-hooks-localhost}

Если не удается подключиться к системному хуку, используйте IP-адрес `127.0.0.1` вместо `localhost`:

1. В параметрах системного хука (**Admin area** → **System Hooks**) измените значение **URL** на `http://127.0.0.1:24080/default`.
1. В настройках {{ GL }}, разрешающих отправлять сообщения в локальную сеть (**Admin area** → **Settings** → **Network** → **Expand outbound requests**, поле ввода для CIDR), добавьте `http://127.0.0.1:24080` в список IP-адресов и доменных имен.

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

Обычно SSL-сертификат на инстансах {{ mgl-name }} перевыпускается автоматически. Если этого не произошло, [перезапустите](../../managed-gitlab/operations/instance/instance-stop.md) инстанс.

Если перезапуск не решил проблему, обратитесь в [техническую поддержку]({{ link-console-support }}).
