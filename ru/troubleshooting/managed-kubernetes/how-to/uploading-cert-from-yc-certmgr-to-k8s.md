# Использование сертификатов из {{ certificate-manager-name }} в балансировщиках нагрузки или в {{ managed-k8s-name }}


## Описание сценария {#case-description}

* Необходимо использовать сертификат, выпущенный в {{ certificate-manager-name }} для веб-приложения, запущенного в кластере {{ managed-k8s-name }}.
* Необходимо получить сертификат, выпущенный в {{ certificate-manager-name }} для его загрузки в {{ managed-k8s-name }}.

## Решение {#case-resolution}

Сертификаты, выпущенные в {{ certificate-manager-name }}, не подгружаются автоматически в приложения, запущенные в кластерах {{ managed-k8s-name }}, а также внутри {{ alb-name }} и {{ network-load-balancer-name }}.

Однократно получить файл с цепочкой сертификатов в формате PEM вы можете с помощью команды:
`yc certificate-manager certificate content --id <CERTIFICATE_ID> --chain CERT_FILE_NAME_HERE.PEM`

Однако такой вариант не предусматривает автоматического обновления сертификата в веб-приложении при перевыпуске сертификата. Если сертификат требуется автоматически перевыпускать и загружать в ваше приложение, следует воспользоваться сценарием, описывающим установку Ingress-контроллера NGINX с сертификатом из Yandex Certificate Manager.

Описание сценария и последовательность действий вы можете найти [в материале по этой ссылке](https://cloud.yandex.ru/docs/certificate-manager/tutorials/nginx-ingress-certificate-manager).

## Если ничего не получилось {#if-issue-still-persists}

Если вышеописанные действия не помогли решить задачу, [создайте запрос в техническую поддержку]({{ link-console-support }}).
При создании запроса укажите следующую информацию:

1. Идентификатор сертификата в {{ certificate-manager-name }}.
2. Идентификатор кластера {{ managed-k8s-name }}, {{ alb-name }} или {{ network-load-balancer-name }}..
3. Описание желаемого результата.
