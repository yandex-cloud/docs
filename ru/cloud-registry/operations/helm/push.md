# Загрузить Helm-чарт в реестр

Вы можете загрузить [Helm-чарт](https://helm.sh/docs/topics/charts/) в [реестр](../../concepts/registry.md) {{ cloud-registry-name }}. В {{ cloud-registry-name }} Helm-чарты хранятся как [Docker-образы](../../concepts/docker-image.md).

{% note info %}

Если вы используете Helm версии ниже 3.7.1, при обновлении до более новой версии повторно загрузите чарты в реестр {{ cloud-registry-name }}.

{% endnote %}

Чтобы загрузить Helm-чарт:

{% list tabs group=instructions %}

- CLI {#cli}

  1. [Установите](https://helm.sh/ru/docs/intro/install/) клиент Helm версии 3.8.0 или выше.

     {% note info %}

     При установке Helm переменные окружения не обновляются автоматически. Чтобы выполнять команды `helm`, запускайте их в директории установки или вручную добавьте Helm в переменные окружения.

     {% endnote %}

  1. Если вы используете версию Helm ниже 3.8.0, включите поддержку [Open Container Initiative](https://opencontainers.org/) в клиенте Helm:

     ```bash
     export HELM_EXPERIMENTAL_OCI=1
     ```

  
  1. Аутентифицируйте свой клиент Helm в реестре {{ cloud-registry-name }} одним из способов.
     * С помощью OAuth-токена:
       1. Если у вас еще нет OAuth-токена, получите его по [ссылке]({{ link-cloud-oauth }}).
       1. Выполните команду:

          ```bash
          helm registry login {{ cloud-registry }} -u oauth
          Password: <OAuth-токен>
          ```

     * С помощью IAM-токена:
       1. [Получите IAM-токен](../../../iam/operations/iam-token/create.md).
       1. Выполните команду:

          ```bash
          helm registry login {{ cloud-registry }} -u iam
          Password: <IAM-токен>
          ```

     Результат:

     ```text
     Login succeeded
     ```


  1. Создайте Helm-чарт:
  
     ```bash
     helm create <имя_Helm-чарта>
     ```

     Имя должно соответствовать требованиям:

     {% include [name-format](../../../_includes/name-format.md) %}

     Результат:

     ```text
     Creating <имя_Helm-чарта>
     ```

  1. Соберите Helm-чарт для загрузки:

     ```bash
     helm package <имя_Helm-чарта>/. --version <версия_Helm-чарта>
     ```

     Результат:

     ```text
     Successfully packaged chart and saved it to: <путь>/<имя_Helm-чарта>-<версия>.tgz
     ```

  1. Загрузите Helm-чарт в {{ cloud-registry-name }}:

     ```bash
     helm push <имя_Helm-чарта>-<версия>.tgz oci://{{ cloud-registry }}/<идентификатор_реестра>
     ```

     Результат:

     ```text
     Pushed: {{ cloud-registry }}/crp3h07fgv9b********/<имя_Helm-чарта>:<версия>
     Digest: <SHA256...>
     ```

{% endlist %}

## Примеры {#examples}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Создайте Helm-чарт:

     ```bash
     helm create my-chart
     ```

     Результат:

     ```text
     Creating my-chart
     ```

  1. Соберите Helm-чарт для загрузки:

     ```bash
     helm package my-chart/. --version 3.11.2
     ```

     Результат:

     ```text
     Successfully packaged chart and saved it to: C:/my-chart-3.11.2.tgz
     ```

  1. Загрузите Helm-чарт в {{ cloud-registry-name }}:

     ```bash
     helm push my-chart-3.11.2.tgz oci://{{ cloud-registry}}/<идентификатор_реестра>
     ```

     Результат:

     ```text
     Pushed: {{ cloud-registry }}/crp3h07fgv9b********/my-chart:3.11.2
     Digest: sha256:dc44a4e8b686b043b8a88f77ef9dcb998116fab422e8c892a2370da0********
     ```

{% endlist %}