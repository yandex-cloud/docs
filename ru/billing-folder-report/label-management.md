# Управление метками

Пользовательские метки представляют собой пару `<имя метки>=<значение метки>`. Вы можете проставить ресурсам метки, чтобы в файле с [детализацией расходов](get-folder-report.md#format) появился столбец `label.user_labels.<имя метки>`. Каждому ресурсу может быть присвоено несколько меток. 

Например, если все виртуальные машины относятся к двум проектам, вы можете добавить каждой ВМ метку `project=1` или `project=2`. После этого в детализации появится столбец `label.user_labels.project` с соответствующими значениями.

## Добавить метку {#add-label}

{% list tabs %}

- CLI

    {% include [cli-install](../_includes/cli-install.md) %}
    
    Добавьте метку ресурсу сервиса:
    
    ```
    yc <имя сервиса> <тип ресурса> add-labels <имя или идентификатор ресурса> \
      --labels <имя метки>=<значение метки>
    ```

{% endlist %}

## Изменить метку {#update-label}

{% list tabs %}

- CLI

    {% include [cli-install](../_includes/cli-install.md) %}
    
    {% note warning %}
    
    Существующий набор `labels` полностью перезаписывается набором, переданным в запросе.
    
    {% endnote %}
    
    Измените метку ресурса сервиса:
    
    ```
    yc <имя сервиса> <тип ресурса> update <имя или идентификатор ресурса> \
      --labels <имя метки>=<значение метки>
    ```

{% endlist %}

## Удалить метку {#remove-label}

{% list tabs %}

- CLI

    {% include [cli-install](../_includes/cli-install.md) %}
    
    Удалите метку ресурса сервиса:

    ```
    yc <имя сервиса> <тип ресурса> remove-labels <имя или идентификатор ресурса> \
      --labels <имя метки>
    ```
  
{% endlist %}

## Примеры управления метками {#examples}

### Добавить метку

Добавить метку виртуальной машине:

```
yc compute instance add-labels cl123g4dridnn5cna6df-yduv --labels project=test
```
Результат:

```
done (5s)
id: fhm1pr2bu3p45s6ildh7
folder_id: b1g23ga45mev6cljderg
created_at: "2020-08-07T11:29:18Z"
name: cl123g4dridnn5cna6df-yduv
labels:
  project: test
zone_id: {{ region-id }}-a
...
```

### Изменить метку

Измените метку кластера {{ k8s }}:

```
yc managed-kubernetes cluster update k8s-gpu --labels new_lable=test_label
```

Результат:

```
done (1m36s)
id: cat1hknor2345e6d7rr8
folder_id: b1g23ga45mev6cljderg
created_at: "2020-08-07T11:15:59Z"
name: cluster
labels:
  new_lable: test_label
status: RUNNING
...
```

### Удалить метку

Удалите метку кластера {{ mmy-short-name }}:

```
yc managed-mysql cluster remove-labels mysql123 --labels my_lable
```

Результат:

```
id: c1qmjaatlurm2bcoi34i
folder_id: b1g23ga45mev6cljderg
created_at: "2020-08-20T11:53:20.015543Z"
name: mysql123
environment: PRODUCTION
...
```