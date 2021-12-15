# Загрузить Helm-чарт в реестр

Вы можете загружать чарты [Helm Chart](https://helm.sh/docs/topics/charts/) в репозитории {{ container-registry-name }}. В {{ container-registry-name }} Helm-чарты хранятся так же, как и обычные [Docker-образы](../../concepts/docker-image.md).

Чтобы загрузить Helm-чарт:

{% list tabs %}

- CLI

  1. [Установите]{% if lang == "ru" %}(https://helm.sh/ru/docs/intro/install/){% endif %}{% if lang == "en" %}(https://helm.sh/docs/intro/install/){% endif %} клиент Helm версии 3.

  1. Включите поддержку [Open Container Initiative](https://opencontainers.org/) в клиенте Helm:

     ```bash
     export HELM_EXPERIMENTAL_OCI=1
     ```

  1. Аутентифицируйте свой клиент Helm в реестре {{ container-registry-name }} одним из способов.

     * С помощью OAuth-токена:

       1. Если у вас еще нет OAuth-токена, получите его по [ссылке]({{ link-cloud-oauth }}).

       1. Выполните команду:

          ```bash
          helm registry login cr.yandex -u oauth
          Password: <OAuth-токен>
          ```

     * С помощью IAM-токена:

       1. [Получите IAM-токен](../../../iam/operations/iam-token/create.md).

       1. Выполните команду:

          ```bash
          helm registry login cr.yandex -u iam
          Password: <IAM-токен>
          ```

     Результат выполнения любой команды:

     ```bash
     Login succeeded
     ```

  1. Сохраните Helm-чарт локально:

     ```bash
     helm package . cr.yandex/<ID реестра>/<имя Helm-чарта>:<версия>
     ```

     Результат выполнения команды:

     ```bash
     ref:     cr.yandex/<ID реестра>/<имя Helm-чарта>:<версия>
     digest:  f3c306aa678756aec30ef11a9483e45d1d0c1e5bab921fe86e8716957203239c
     size:    4.7 KiB
     name:    <имя Helm-чарта>
     version: 5
     <version>: saved
     ```

  1. Загрузите Helm-чарт в {{ container-registry-name }}:

     ```bash
     helm push cr.yandex/<ID реестра>/<имя Helm-чарта>:<версия>
     ```

     Результат выполнения команды:

     ```bash
     The push refers to repository [cr.yandex/<ID реестра>/<имя Helm-чарта>]
     ref:     cr.yandex/<ID реестра>/<имя Helm-чарта>:<версия>
     digest:  f3c306aa678756aec30ef11a9483e45d1d0c1e5bab921fe86e8716957203239c
     size:    4.7 KiB
     name:    <имя Helm-чарта>
     version: 5
     <version>: pushed to remote (1 layer, 4.7 KiB total)
     ```

{% endlist %}
