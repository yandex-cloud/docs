# Как настроить статический IP-адрес


## Описание сценария {#case-description}

Необходимо настроить статический IP-адрес для функции или Serverless.

## Решение {#case-resolution}

Возможности привязать к облачной функции статический IP-адрес пока не предусмотрено. Функция каждый раз может выполняться на ресурсах с разными адресами и закрепить за ней конкретный не получится.

В качестве альтернативного решения вы можете воспользоваться сервисом Compute Cloud. В нем потребуется создать виртуальную машину со статическим IP-адресом, установить среду выполнения для используемого вами языка программирования и запускать выполнение кода функции на ней. Подробнее пишем [здесь](https://cloud.yandex.ru/docs/compute/operations/vm-create/create-linux-vm) и [здесь](https://cloud.yandex.ru/docs/vpc/operations/get-static-ip).

{% note info %}

Вы также можете использовать API-шлюз для вызова функции через собственный домен. 

Подробнее в нашей документации: 
- [Привязка домена к шлюзу](https://cloud.yandex.ru/docs/api-gateway/operations/api-gw-domains);
- [Вызов функции через шлюз](https://cloud.yandex.ru/docs/api-gateway/concepts/extensions/cloud-functions);
- [Вызов контейнера через шлюз](https://cloud.yandex.ru/docs/api-gateway/concepts/extensions/containers).

{% endnote %}