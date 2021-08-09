---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---
# Скачать Helm-чарт в реестр

Вы можете скачать чарты [Helm Chart](https://helm.sh/docs/topics/charts/) в репозитории {{ container-registry-name }}. В {{ container-registry-name }} Helm-чарты хранятся так же, как и обычные [Docker-образы](../../concepts/docker-image.md).

{% list tabs %}

- CLI

  Чтобы скачать Helm-чарт, выполните команду:

  ```bash
  helm chart pull cr.yandex/<ID реестра>/<имя Helm-чарта>:<версия>
  ```

  Результат выполнения команды:

  ```bash
  <version>: Pulling from cr.yandex/<ID реестра>/<имя Helm-чарта>
  ref:     cr.yandex/<ID реестра>/<имя Helm-чарта>:<версия>
  digest:  f3c306aa678756aec30ef11a9483e45d1d0c1e5bab921fe86e8716957203239c
  size:    4.7 KiB
  name:    <имя Helm-чарта>
  version: 5
  Status: Downloaded newer chart for cr.yandex/<ID реестра>/<имя Helm-чарта>:<версия>
  ```

{% endlist %}