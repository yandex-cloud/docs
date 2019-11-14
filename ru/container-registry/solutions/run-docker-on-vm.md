# Запуск Docker-образа на виртуальной машине

В данном примере описаны шаги, необходимые для запуска Docker-образа на виртуальной машине с использованием реестра.
Если у вас еще нет виртуальной машины, вы можете [создать ее](../../compute/quickstart/index.md).

1. Добавьте переменные для удобства работы:
        
    * Адрес вашей виртуальной машины в переменную `${INSTANCE_ID}`:
        
        ```
        $ export INSTANCE_ID=ef3ni90g6qblknkph60v
        ```

    * Ваш OAuth-токен в переменную `${OAUTH}`:
        
        ```
        $ export OAUTH=AQAAAAAV6O...
        ```
    
    * Ваш IAM-токен в переменную `${IAM}`:
        
        ```
        $ export IAM=CggaATEVAg...
        ```

    * ID реестра из [примера](../quickstart/index.md) в переменную `${REGISTRY_ID}`:
        
        ```
        $ export REGISTRY_ID=crpc9qeoft236r8tfalm
        ```
1. Соберите Docker-образ Ubuntu из [примера](../operations/docker-image/docker-image-create.md):
    
    ```
    $ docker build . \
    -t cr.yandex/${REGISTRY_ID}/ubuntu:hello
    ```
1. Аутентифицируйтесь в реестре от своего имени:
    
    ```
    $ docker login \
    --username oauth \
    --password ${OAUTH} \
    cr.yandex
    ```
1. Загрузите собранный Docker-образ в Yandex Cloud Registry:
    
    ```
    $ docker push \
    cr.yandex/${REGISTRY_ID}/ubuntu:hello
    ```
1. Зайдите по SSH на виртуальную машину и пройдите аутентификацию от имени сервисного аккаунта, привязанного к этой машине:
    
    ```
    $ ssh ${INSTANCE_ID} docker login \
    --username iam \
    --password ${IAM} \
    cr.yandex
    ```
1. Скачайте Docker-образ на виртуальную машину:

    ```
    $ ssh ${INSTANCE_ID} \
    docker pull cr.yandex/${REGISTRY_ID}/ubuntu:hello
    ```
1. Запустите Docker-образ на виртуальной машине:

    ```
    $ ssh ${INSTANCE_ID} \
    docker run cr.yandex/${REGISTRY_ID}/ubuntu:hello
    ```
