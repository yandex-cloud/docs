# Скачать Docker-образ из реестра

Для скачивания [Docker-образа](../../concepts/docker-image.md) необходимо знать в каком репозитории он хранится, а также его тег или хеш.

{% list tabs %}

- CLI

  1. Выберите необходимый вам Docker-образ. Для этого [получите список Docker-образов в реестре](docker-image-list.md#docker-image-list).
  1. Скачайте Docker-образ из реестра:

     * Используя **тег**:

       ```
       docker pull {{ registry }}/crpd50616s9a2t7gr8mi/ubuntu:hello
       ```

       Результат:

       ```
       hello: Pulling from crpd50616s9a2t7gr8mi/ubuntu
       84ed7d2f608f: Already exists
       be2bf1c4a48d: Already exists
       a5bdc6303093: Already exists
       e9055237d68d: Already exists
       Digest: sha256:035ac8e1bd9c49871a2fd76ccb3c4b0f84e7eee775919ccd345337ec7b49f80d
       Status: Downloaded newer image for {{ registry }}/crpd50616s9a2t7gr8mi/ubuntu:hello
       ```

     * Используя **хеш**:

       ```
       docker pull {{ registry }}/crpd50616s9a2t7gr8mi/ubuntu@sha256:035ac8e1bd9c49871a2fd76
       ```

       Результат:

       ```
       ccb3c4b0f84e7eee775919ccd345337ec7b49f80d
       sha256:035ac8e1bd9c49871a2fd76ccb3c4b0f84e7eee775919ccd345337ec7b49f80d: Pulling from crpd50616s9a2t7gr8mi/ubuntu
       84ed7d2f608f: Already exists
       be2bf1c4a48d: Already exists
       a5bdc6303093: Already exists
       e9055237d68d: Already exists
       Digest: sha256:035ac8e1bd9c49871a2fd76ccb3c4b0f84e7eee775919ccd345337ec7b49f80d
       Status: Downloaded newer image for {{ registry }}/crpd50616s9a2t7gr8mi/ubuntu@sha256:035ac8e1bd9c49871a2fd76ccb3c4b0f84e7eee775919ccd345337ec7b49f80d
       ```

       Обратите внимание, что в данном случае Docker-образ будет скачан без тега. В поле `TAG` будет указано `<none>`.
  1. Проверьте, что Docker-образ действительно скачан:

     ```
     docker image list
     ```

     Результат:

     ```
     REPOSITORY                                  TAG     IMAGE ID      CREATED       SIZE
     {{ registry }}/crpd50616s9a2t7gr8mi/ubuntu  <none>  50ff4b0e5783  24 hours ago  86.7MB
     ubuntu                                      latest  1d9c17228a9e  2 weeks ago   86.7MB
     ```

{% endlist %}