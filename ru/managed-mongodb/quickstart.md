# Как начать работать с {{ mmg-name }}

Чтобы начать работу с сервисом:
1. [Создайте кластер](#cluster-create).
1. [Подключитесь к БД](#connect).

{% if audience == "internal" %}

Для внутреннего сервиса MDB развернут [веб-интерфейс]({{ console-link }}), где кластер БД можно накликать. Подробнее про [квоты]({{ link-console-quotas }}) и соответствие ABC-сервисов облакам и каталогам читайте в разделе [{#T}](../mdb/access.md).

{% include [Internal access](../_includes/mdb/internal-access.md) %}

## Настройка CLI {#cli-setup}

Если вы планируете использовать CLI, установите и настройте его согласно [инструкции](../cli/quickstart.md).

Если все сделано правильно, должен заработать запрос списка кластеров:

```bash
{{ yc-mdb-mg }} cluster list
```

{% else %}

## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.

1. Если у вас еще нет каталога, создайте его:

   {% include [create-folder](../_includes/create-folder.md) %}

1. Подключаться к кластерам БД можно как изнутри, так и извне {{ yandex-cloud }}:

   * Чтобы подключиться изнутри {{ yandex-cloud }}, создайте виртуальную машину в той же облачной сети, что и кластер БД (на основе [Linux](../compute/quickstart/quick-create-linux.md){% if product == "cloud-il" %} или [Windows](../compute/quickstart/quick-create-windows.md){% endif %}).

   * Чтобы подключиться к кластеру из интернета, запросите публичный доступ к хостам при создании кластера.

   {% note info %}

   Следующий шаг предполагает, что подключение к кластеру производится с ВМ на основе [Linux](../compute/quickstart/quick-create-linux.md).

   {% endnote %}

1. [Подключитесь](../compute/operations/vm-connect/ssh.md) к ВМ по {% if lang == "ru" and audience != "internal" %}[SSH](../glossary/ssh-keygen.md){% else %}SSH{% endif %}.

1. Установите {{ MG }} Shell:

   ```bash
   cd ~/ && \
   wget https://repo.mongodb.org/apt/ubuntu/dists/focal/mongodb-org/4.4/multiverse/binary-amd64/mongodb-org-shell_4.4.1_amd64.deb && \
   sudo dpkg -i mongodb-org-shell_4.4.1_amd64.deb
   ```

{% endif %}

## Создайте кластер {#cluster-create}

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер БД.
1. Выберите сервис **{{ mmg-name }}**.
1. Нажмите кнопку **Создать кластер**.
1. Задайте параметры кластера и нажмите кнопку **Создать кластер**. Процесс подробно рассмотрен в разделе [{#T}](operations/cluster-create.md).
1. Дождитесь, когда кластер будет готов к работе: его статус на панели {{ mmg-short-name }} сменится на **Running**, а состояние — на **Alive**. Это может занять некоторое время.

## Подключитесь к БД {#connect}

{% if audience != "internal" %}

1. Если вы используете группы безопасности для облачной сети, [настройте их](operations/connect/index.md#configuring-security-groups) так, чтобы был разрешен весь необходимый трафик между кластером и хостом, с которого выполняется подключение.

   {% include [preview-pp.md](../_includes/preview-pp.md) %}

    {% include [security-groups-note-services](../_includes/vpc/security-groups-note-services.md) %}
 
{% endif %}

1. Получите SSL-сертификат:

   {% include [install-certificate](../_includes/mdb/mmg/install-certificate.md) %}

1. Подключитесь к кластеру с помощью {{ MG }} CLI:

   {% include [default-connstring-old](../_includes/mdb/mmg/default-connstring-old.md) %}

## Что дальше {#whats-next}

* Изучите [концепции сервиса](concepts/index.md).
* Узнайте подробнее о [создании кластера](operations/cluster-create.md) и [подключении к БД](operations/connect/index.md).
* Ознакомьтесь с [вопросами и ответами](qa/general.md).
