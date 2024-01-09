# Подключение к интерфейсам компонентов

Вы можете подключиться к интерфейсам компонентов {{ dataproc-name }} либо с помощью [UI Proxy](#ui-proxy), либо с помощью [промежуточной виртуальной машины](#routing). Подробнее см. в разделе [{#T}](../concepts/interfaces.md).

## UI Proxy {#ui-proxy}

{% note warning %}

Для использования UI Proxy может потребоваться дополнительная [настройка групп безопасности](connect.md#configuring-security-groups) (функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md)).

{% endnote %}

### Включить веб-интерфейсы компонентов {#ui-proxy-enable}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
    1. Выберите кластер и нажмите кнопку ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_configuration }}** включите опцию **{{ ui-key.yacloud.mdb.forms.config_field_ui_proxy }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы включить доступ к веб-интерфейсам компонентов кластера, задайте значение `true` для параметра `--ui-proxy`:

    ```bash
    {{ yc-dp }} cluster update <имя_или_идентификатор_кластера> \
       --ui-proxy=true
    ```

    Идентификатор и имя кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list).

- API {#api}

    Воспользуйтесь методом [update](../api-ref/Cluster/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list).
    * Значение `true` в параметре `uiProxy`.
    * Список изменяемых полей конфигурации кластера в параметре `updateMask` (в данном случае — `uiProxy`).

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

### Получить список URL для подключения {#ui-proxy-list}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
    1. Нажмите на имя нужного кластера.
    1. Ссылки для подключения к веб-интерфейсам компонентов находятся в блоке **{{ ui-key.yacloud.mdb.cluster.overview.section_ui-proxy }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить список URL для подключения к веб-интерфейсам компонентов кластера {{ dataproc-name }}, выполните команду:

    ```bash
    {{ yc-dp }} cluster list-ui-links <имя_или_идентификатор_кластера>
    ```

    Идентификатор и имя кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list).

- API {#api}

    Воспользуйтесь методом API [listUILinks](../api-ref/Cluster/listUILinks.md) и передайте в запросе идентификатор кластера в параметре `clusterId`.

    Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list).

{% endlist %}

## Перенаправление портов {#routing}

Чтобы получить доступ к сетевому интерфейсу компонента из интернета, [создайте](../../compute/operations/vm-create/create-linux-vm.md) промежуточную виртуальную машину в сервисе {{compute-full-name}}.

Требования к промежуточной ВМ:

* Наличие публичного IP-адреса.
* Размещение в одной сети с нужным кластером {{ dataproc-name }}.
* [Настройки групп безопасности](../concepts/network.md#security-groups) должны разрешать обмен трафиком с кластером через порты соответствующих компонентов.

Пошаговые инструкции по настройке групп безопасности для перенаправления портов приведены в разделе [{#T}](connect.md#configuring-security-groups).

Чтобы соединиться с нужным портом хоста {{ dataproc-name }}, выполните команду:


```bash
ssh -A \
    -J <публичный_IP-адрес_ВМ> \
    -L <номер_порта>:<FQDN_хоста_Data_Proc>:<номер_порта> <имя_пользователя>@<FQDN_хоста_Data_Proc>
```



Где:

* `-A` — включает перенаправление соединения от агента аутентификации с промежуточной ВМ (jump host) на целевой хост кластера {{ dataproc-name }}.
* `-J` — подключение к целевому хосту через промежуточную ВМ. Устанавливает SSH-соединение с промежуточной ВМ, которая будет перенаправлять пакеты к целевому хосту в кластере {{ dataproc-name }}.
* `-L` — перенаправление локального порта на хост кластера {{ dataproc-name }}.

    
    Для подключения к хостам кластера с [версией образа](../concepts/environment.md) 1.x используйте имя пользователя `root`, для версии 2.x — `ubuntu`.


Найти FQDN хоста {{ dataproc-name }} можно на странице кластера {{ dataproc-name }}, на вкладке **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}**, в столбце **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}**.

Номера портов для компонентов {{ dataproc-name }} приведены в разделе [Интерфейсы и порты компонентов](../concepts/interfaces.md#port-numbers).
