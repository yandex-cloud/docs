[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Stackland](../../index.md) > [Сборник рецептов администратора Stackland](../index.md) > Запуск команды разработки в инсталляцию > Настройка квот

# Настройка квот

Этот рецепт покажет, как контролировать использование CPU, памяти и других ресурсов на уровне проекта.

Вы узнаете:

* как работают квоты в Stackland;

* как настроить квоту на уровне проекта через ресурс `Project`;

* как проверить использование квот;

* что делать при превышении квот.

## Как работают квоты в Stackland {#how-quotas-work}

В Stackland квоты настраиваются на **уровне проекта** через ресурс `Project`. Квота ограничивает **суммарное** потребление ресурсов всеми пространствами имен, входящими в проект.

### Поддерживаемые типы квот {#quota-types}

#|
|| **Ресурс** | **Описание** ||
|| `requests.cpu` | Суммарный запрос CPU для всех подов во всех пространствах имен проекта ||
|| `requests.memory` | Суммарный запрос памяти для всех подов ||
|| `limits.cpu` | Суммарный лимит CPU для всех подов ||
|| `limits.memory` | Суммарный лимит памяти для всех подов ||
|| `requests.storage` | Суммарный объем хранилища для всех PVC ||
|| `count/pods` | Максимальное количество подов в проекте ||
|| `count/persistentvolumeclaims` | Максимальное количество PVC в проекте ||
|| `secrets` | Максимальное количество секретов в проекте ||
|| `requests.nvidia.com/gpu` | Суммарное количество GPU для всех подов ||
|| `storage.stackland.yandex.cloud/buckets-count` | Максимальное количество бакетов Object Storage, которое можно создать ||
|| `storage.stackland.yandex.cloud/volume-size` | Максимальный суммарный объем данных, который можно хранить во всех бакетах Object Storage ||
|#

## Создание квоты на уровне проекта {#create-project-quota}

{% note info %}

Квоты для проекта можно задавать как через CLI, так и через консоль управления.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В консоли управления перейдите на страницу **Проекты**.

  1. Нажмите на **···** (три точки) напротив проекта `team-alpha`. Если вы не создавали этот проект, обратитесь к рецепту [Подготовка проекта и пространств имен команды](02-project-and-namespaces.md).

      ![Отображение проекта в консоли управления](../../_assets/cookbooks/dev-team-onboarding/04-02-console-project-view.png)

  1. Выберите **Редактировать**.

  1. В блоке **Квоты** укажите тип ресурса и значения квоты. Для примера используйте значения:

      * `limits.cpu` — 4

      * `limits.memory` — 4 Gi

      * `pods` — 1

      * `requests.cpu` — 2

      * `requests.memory` — 2 Gi

      * `secrets` — 1

  1. Нажмите **Сохранить**.

  ![Страница редактирования проекта в консоли управления](../../_assets/cookbooks/dev-team-onboarding/04-03-console-edit-project.png)

- CLI {#cli}

  **Шаг 1. Добавьте квоты в проект**

  1. Отредактируйте ресурс `Project`:

      ```bash
      kubectl edit project team-alpha
      ```

  1. Добавьте секцию `spec.quotas`, если она отсутствует:

      ```yaml
      apiVersion: stackland.yandex.cloud/v1alpha1
      kind: Project
      metadata:
        name: team-alpha
      spec:
        description: "Проект команды Alpha"
        quotas:
          requests.cpu: "2"
          limits.cpu: "4"
          requests.memory: "2Gi"
          limits.memory: "4Gi"
          secrets: "1"
          pods: "1"
      ```

  **Шаг 2. Проверьте применение квот**

  Для проверки квот воспользуйтесь командой `describe`:

  ```bash
  kubectl describe project team-alpha
  ```

  В выводе вы увидите заданные ранее квоты:

  ```plaintext
  ...
  Spec:
    Description:   Проект команды Alpha
    Display Name:  Team Alpha
    Quotas:
      limits.cpu:       4
      limits.memory:    4Gi
      Pods:             1
      requests.cpu:     2
      requests.memory:  2Gi
      Secrets:          1
  ...
  ```

{% endlist %}

## Проверка использования квот {#check-quota-usage}

Создайте объекты в кластере, чтобы увидеть, как меняется использование ресурсов в квотах.

### Шаг 1. Проверьте текущее использование квот {#check-current-usage}

Перед созданием нагрузки посмотрите текущее состояние:

```bash
kubectl describe project team-alpha | grep -A 20 Usage
```

Если ранее вы не создавали ресурсов в пространстве имен, то увидите **нулевое использование** всех ресурсов.

### Шаг 2. Создайте под с запросом ресурсов {#create-pod}

Создайте файл `test-pod.yaml`:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: test-pod-1
  namespace: team-alpha-dev
spec:
  containers:
  - name: nginx
    image: nginx:latest
    resources:
      requests:
        cpu: "500m"
        memory: "256Mi"
      limits:
        cpu: "1000m"
        memory: "512Mi"
```

Примените манифест:

```bash
kubectl apply -f test-pod.yaml
```

### Шаг 3. Проверьте изменение использования квот {#check-usage-change}

Использование квот можно посмотреть с помощью `describe`:

```bash
kubectl describe project team-alpha | grep -A 20 Usage
```

Теперь в `status.usage` должны появиться значения:

```plaintext
  Usage:
    count/persistentvolumeclaims:  0
    count/pods:                    1
    limits.cpu:                    1
    limits.ephemeral-storage:      0
    limits.memory:                 512Mi
    requests.cpu:                  500m
    requests.ephemeral-storage:    0
    requests.memory:               256Mi
    requests.storage:              0
    Secrets:                       0
```

Также расход квот можно посмотреть в консоли управления — в разделе **Основное** в соответствующем проекте.

![Отображение используемых квот на странице проекта в консоли управления](../../_assets/cookbooks/dev-team-onboarding/04-04-console-quota-usage.png)

### Шаг 4. Создайте второй под с превышением квот {#exceed-quota}

Создайте второй под с превышением квот по CPU, но уже в другом пространстве имен — `team-alpha-dev`.

Создайте файл `test-pod-2.yaml`:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: test-pod-2
  namespace: team-alpha-dev
spec:
  containers:
  - name: nginx
    image: nginx:latest
    resources:
      requests:
        cpu: "2000m"
        memory: "256Mi"
      limits:
        cpu: "3000m"
        memory: "512Mi"
```

```bash
kubectl apply -f test-pod-2.yaml
```

При создании вы получите ошибку, которая сообщит, лимит какой квоты исчерпан и насколько:

```plaintext
Error from server (Forbidden): error when creating "test-pod-2.yaml": admission webhook "validate-v1-pod-quota.stackland.yandex.cloud" denied the request: quota exceeded: requests.cpu (requested: 2, available: 1500m, limit: 2)
```

Текст ошибки указывает, что вы достигли предела по квоте `requests.cpu` и что запрашивается 2 CPU (или `2000m`), а доступно только `1500m` при максимальной квоте в 2 CPU (`2000m`). Доступно `1500m`, поскольку на создание `test-pod-1` вы потратили `500m` из квоты (`2000m`).

## Что делать при достижении лимита {#quota-exceeded}

Когда лимит квоты достигнут, новые ресурсы создать нельзя. Дальше расскажем о способах решения этой проблемы.

{% note info %}

Речь пойдет о квотах на CPU и память.

{% endnote %}

* **Оптимизация.** Уменьшите requests и limits в манифестах приложений, если это возможно.

* **Удаление ресурсов.** Удалите ресурсы, которые не используются.

* **HPA.** Включите HPA (Horizontal Pod Autoscaler) для автоматического масштабирования. Сервисы, которые не испытывают значительной нагрузки, будут развернуты в меньшем количестве экземпляров, что освободит ресурсы для других рабочих нагрузок.

* **Увеличение квот**, если это возможно.

* **Перераспределение ресурсов.** По возможности перенесите рабочие нагрузки в другие проекты.

## Итоги {#summary}

Вы настроили квоты для проекта `team-alpha`. Что важно запомнить:

* Квота на уровне проекта ограничивает суммарное потребление ресурсов всеми пространствами имен проекта.

* Проверить использование квот можно через `describe` или консоль управления.

* При попытке создать ресурс с превышением квоты вы получите ошибку `quota exceeded`.

* В случае превышения квот попробуйте уменьшить requests и limits в манифестах приложений, удалить неиспользуемые ресурсы, включить HPA, перераспределить ресурсы или увеличить квоты.