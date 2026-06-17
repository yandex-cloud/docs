# Поля и аннотации ресурса IngressClass

Ресурс `IngressClass` — это класс ресурсов [Ingress](ingress.md), который позволяет использовать одновременно несколько Ingress-контроллеров, например Application Load Balancer и NGINX. Каждый ресурс `IngressClass` относится к отдельному Ingress-контроллеру. В результате можно маршрутизировать трафик через ресурсы `Ingress` разных контроллеров в рамках одного приложения в одном кластере Managed Service for Kubernetes.

{% note tip %}

Вместо ALB Ingress-контроллера и Gateway API рекомендуется использовать новый контроллер [Yandex Cloud Gwin](gwin-index.md).

{% endnote %}

Если вы используете несколько Ingress-контроллеров, в каждом ресурсе `Ingress` укажите, к какому контроллеру ресурс относится. Для этого задайте название `IngressClass` соответствующего контроллера в поле [spec.ingressClassName](ingress.md#spec).

`IngressClass` — стандартный ресурс Kubernetes. Ниже описаны поля и аннотации ресурса. Подробнее о применении и конфигурации ресурса `IngressClass` читайте в [документации Kubernetes](https://kubernetes.io/docs/concepts/services-networking/ingress/#ingress-class). На GitHub есть [пример](https://github.com/yandex-cloud-examples/yc-mk8s-with-ingress-class), как настроить ресурсы `Ingress` и маршрутизировать трафик с помощью нескольких Ingress-контроллеров.

## IngressClass {#ingress-class}

```yaml
apiVersion: networking.k8s.io/v1
kind: IngressClass
metadata: <ObjectMeta>
spec:
  controller: <string>
```

#|
|| **Поле**          | **Значение или тип**   | **Описание**                    ||
|| `apiVersion`      | `networking.k8s.io/v1` | **Обязательное**.

Версия API Kubernetes. ||
|| `kind`            | `IngressClass`         | Тип ресурса.                    ||
|| `metadata`        | `ObjectMeta`           | **Обязательное**.

[Метаданные ресурса](#metadata). ||
|| `spec`            | `IngressClassSpec`     | **Обязательное**.

Спецификация ресурса. ||
|| `spec.controller` | `string`               | **Обязательное**.

Имя Ingress-контроллера, к которому относится ресурс `IngressClass`. Возможные значения:

* `ingress.alb.yc.io/yc-alb-ingress-controller` — контроллер Application Load Balancer;
* `k8s.io/ingress-nginx` — контроллер NGINX. ||
|#

{% cut "Пример" %}

```yaml
apiVersion: networking.k8s.io/v1
kind: IngressClass
metadata:
  labels:
    app.kubernetes.io/component: controller
  name: alb
  annotations:
    ingressclass.kubernetes.io/is-default-class: "true"
spec:
  controller: ingress.alb.yc.io/yc-alb-ingress-controller
```

{% endcut %}

## ObjectMeta {#metadata}

```yaml
name: <string>
labels:
  <string>: <string>
annotations:
  ingressclass.kubernetes.io/is-default-class: "<bool>"
```

#|
|| **Поле**      | **Значение или тип** | **Описание** ||
|| `name`        | `string`             | **Обязательное**.

Имя ресурса. Подробнее о формате смотрите в [документации Kubernetes](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).

Имя также указывается в поле [spec.ingressClassName](ingress.md#spec) в ресурсе `Ingress`. ||
|| `labels`      | `map[string]string`  | Kubernetes-метки для управления объектами Kubernetes и мониторинга этих объектов.

[Рекомендуемое значение](https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels/): `app.kubernetes.io/component: controller`. ||
|| `annotations` | `map[string]string`  | Аннотации ресурса.

Доступная аннотация: `ingressclass.kubernetes.io/is-default-class`. Тип данных аннотации — `bool`. Определяет, используется ли ресурс `IngressClass` по умолчанию. Если аннотация принимает значение `"true"`, то `IngressClass` автоматически применяется к ресурсам `Ingress`, в которых не указан `IngressClass`. ||
|#