---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---
# Изменить реестр

Узнайте, как изменить:
- [Имя реестра](#update-name)
- [Метку реестра](#update-label)

Для обращения к [реестру](../../concepts/registry.md) используйте его идентификатор или имя. Как узнать идентификатор или имя реестра,
читайте в разделе [Получить информацию об имеющихся реестрах](registry-list.md).


## Изменить имя реестра {#update-name}

{% list tabs %}
- Консоль управления
  
  Чтобы изменить имя [реестра](../../concepts/registry.md):
  1. Откройте раздел **Container Registry** в каталоге, где требуется изменить реестр.
  1. Нажмите значок ![image](../../../_assets/vertical-ellipsis.svg) в строке реестра, который требуется изменить.
  1. В открывшемся меню нажмите кнопку **Изменить**.
  1. В открывшемся окне укажите нужное имя реестра.
  1. Нажмите кнопку **Изменить**.
  
  
- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  Измените имя реестра:
  
  ```
  $ yc container registry update my-reg --new-name new-reg
  id: crp3qleutgksvd1prhvb
  folder_id: b1g88tflru0ek1omtsu0
  name: new-reg
  status: ACTIVE
  created_at: "2019-01-15T14:39:48.154Z"
  ```
  
- API
  
  Чтобы изменить имя реестра, воспользуйтесь методом [update](../../api-ref/Registry/update.md) для ресурса [Registry](../../api-ref/Registry/).
  
{% endlist %}


## Изменить метку реестра {#update-label}

{% list tabs %}

- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  Измените метку реестра (не путайте с тегами Docker-образа):
  
  ```
  $ yc container registry update new-reg --labels new_label=test_label
  id: crp3qleutgksvd1prhvb
  folder_id: b1g88tflru0ek1omtsu0
  name: new-reg
  status: ACTIVE
  created_at: "2019-01-15T14:39:48.154Z"
  labels:
    new_label: test_label
  ```
  
- API
  
  Чтобы изменить метку реестра, воспользуйтесь методом [update](../../api-ref/Registry/update.md) для ресурса [Registry](../../api-ref/Registry/).
  
{% endlist %}
