# Обновить Ingress-контроллер {{ alb-name }} для {{ managed-k8s-name }}

Версии [ALB Ingress Controller](/marketplace/products/yc/alb-ingress-controller) 0.2.0 и позднее не совместимы с версиями 0.1.x. Из-за этого возникают ограничения, связанные с [группами бэкендов](../../../application-load-balancer/tools/k8s-ingress-controller/principles.md).

Один из способов создать группу бэкендов — указать [правила](../../../application-load-balancer/k8s-ref/ingress.md#rule) в ресурсе `Ingress`. В версиях ALB Ingress Controller до 0.2.0 каждая группа бэкендов соответствует связке параметров `host`, `http.paths.path` и `http.paths.pathType`. В версиях 0.2.0 и позднее группа бэкендов соответствует параметру `backend.service` в ресурсе `Ingress`. В этом параметре указывается [сервис {{ k8s }}](../../../managed-kubernetes/concepts/service.md). Подробнее о значении параметров и конфигурации ресурса `Ingress` см. в [документации {{ k8s }}](https://kubernetes.io/docs/concepts/services-networking/ingress/).

Если вы обновляете ALB Ingress Controller с версии 0.1.x до версии 0.2.0 или позднее, проверьте, применимы ли следующие случаи к вашим группам ресурсов `Ingress` (группы формируются по значению аннотации `ingress.alb.yc.io/group-name` в ресурсах `Ingress`):

* В конфигурациях встречаются одинаковые значения параметров `host`, `http.paths.path` и `http.paths.pathType`, при этом указаны разные сервисы {{ k8s }} в параметрах `backend.service.name`. В этом случае пересоздайте группы бэкендов с помощью объектов [HttpBackendGroup](../../../managed-kubernetes/tutorials/alb-ingress-controller.md#create-ingress-and-apps).

* На несколько связок параметров `host`, `http.paths.path` и `http.paths.pathType` приходится один сервис {{ k8s }}. В этом случае проверьте, различаются ли настройки бэкендов в параметре `backend`. Например, одна группа ресурсов `Ingress` может устанавливать соединения по протоколу gRPC, а другая — по протоколу HTTP.

   Если настройки бэкендов не различаются, менять конфигурацию не нужно. Если различаются, выполните следующие действия:

   1. Для каждой группы ресурсов `Ingress` создайте отдельный файл с конфигурацией объекта `Service`. В объекте укажите:

      * Его название — для каждого сервиса используйте разные названия.
      * Название объекта `Deployment` — для каждого сервиса это название должно быть одинаковым, так как ранее использовался только один сервис {{ k8s }}.
      * Настройки бэкендов, которыми различаются группы ресурсов `Ingress`.

      {% cut "Пример конфигурационного файла" %}

      ```yaml
      apiVersion: v1
      kind: Service
      metadata:
        name: alb-demo-service-1 # Укажите разные названия для каждого сервиса.
      spec:
        selector:
          app: alb-demo-app # Укажите один Deployment для каждого сервиса.
        type: NodePort
        ports:
          ... # Укажите настройки, которыми отличаются группы ресурсов Ingress.
      ```

      {% endcut %}

   1. Примените полученные конфигурации:

      ```bash
      kubectl apply -f <названия_конфигурационных_файлов>
      ```

   1. Измените названия сервисов {{ k8s }} в ресурсах `Ingress`. В параметре `backend.service.name` укажите название сервиса в соответствии с той группой, в которой находится ресурс `Ingress`.
   1. Примените конфигурации измененных ресурсов `Ingress`:

      ```bash
      kubectl apply -f <названия_файлов_с_ресурсами_Ingress>
      ```

{% note info %}

Если нет возможности изменить конфигурацию ресурсов `Ingress`, не обновляйте ALB Ingress Controller. Иначе возникнут коллизии.

{% endnote %}
