# Загрузить Helm-чарт в реестр

Вы можете загружать чарты [Helm Chart](https://helm.sh/docs/topics/charts/) в репозитории {{ container-registry-name }}. В {{ container-registry-name }} Helm-чарты хранятся так же, как и обычные [Docker-образы](../../concepts/docker-image.md).

{% note info %}

Если вы используете Helm версии ниже 3.7.1, при обновлении до более новой версии повторно загрузите чарты в репозиторий {{ container-registry-name }}.

{% endnote %}

Чтобы загрузить Helm-чарт:

{% list tabs %}

- CLI

  1. [Установите](https://helm.sh/ru/docs/intro/install/) клиент Helm версии 3.7.1 или выше.
  1. Включите поддержку [Open Container Initiative](https://opencontainers.org/) в клиенте Helm:

     ```bash
     export HELM_EXPERIMENTAL_OCI=1
     ```

  {% if product == "yandex-cloud" %}

  1. Аутентифицируйте свой клиент Helm в реестре {{ container-registry-name }} одним из способов.
     * С помощью OAuth-токена:
       1. Если у вас еще нет OAuth-токена, получите его по [ссылке]({{ link-cloud-oauth }}).
       1. Выполните команду:

          ```bash
          helm registry login {{ registry }} -u oauth
          Password: <OAuth-токен>
          ```

     * С помощью IAM-токена:
       1. [Получите IAM-токен](../../../iam/operations/iam-token/create.md).
       1. Выполните команду:

          ```bash
          helm registry login {{ registry }} -u iam
          Password: <IAM-токен>
          ```

     Результат:

     ```bash
     Login succeeded
     ```

  {% endif %}

  {% if product == "cloud-il" %}

  1. Аутентифицируйте свой клиент Helm в реестре {{ container-registry-name }} c помощью IAM-токена:
     1. [Получите IAM-токен](../../../iam/operations/iam-token/create-for-federation.md).
     1. Выполните команду:

        ```bash
        helm registry login {{ registry }} -u iam
        Password: <IAM-токен>
        ```

        Результат:

        ```bash
        Login succeeded
        ```

  {% endif %}

  1. Сохраните Helm-чарт локально:

     ```bash
     helm package . --version <версия Helm-чарта>
     ```

     Результат:

     ```bash
     Successfully packaged chart and saved it to: /<путь>/<имя Helm-чарта>-<версия>.tgz
     ```

  1. Загрузите Helm-чарт в {{ container-registry-name }}:

     ```bash
     helm push <имя Helm-чарта>-<версия>.tgz oci://{{ registry }}/<ID реестра>
     ```

     Результат:

     ```bash
     Pushed: {{ registry }}/<ID реестра>/<имя Helm-чарта>:<версия>
     Digest: <SHA256...>
     ```

{% endlist %}