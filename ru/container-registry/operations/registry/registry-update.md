# Изменить реестр

Узнайте, как изменить: 
* [Имя реестра](#update-name)
* [Метку реестра](#update-label)

[!INCLUDE [cli-install](../../../_includes/cli-install.md)]

Для обращения к [реестру](../../concepts/registry.md) используйте его идентификатор или имя. Как узнать идентификатор или имя реестра, 
читайте в разделе [Получить информацию об имеющихся реестрах](registry-list.md).


## Изменить имя реестра {#update-name}

---
 
**[!TAB CLI]**

Измените имя реестра: 

* Используя параметр `id`:
   
    ```
    $ yc container registry update --id crp3qleutgksvd1prhvb --new-name my-reg
    id: crp3qleutgksvd1prhvb
    folder_id: b1g88tflru0ek1omtsu0
    name: my-reg
    status: ACTIVE
    created_at: "2019-01-15T14:39:48.154Z"
    ```

* Используя параметр `name`:
    
    ```
    $ yc container registry update --name my-reg --new-name new-reg
    id: crp3qleutgksvd1prhvb
    folder_id: b1g88tflru0ek1omtsu0
    name: new-reg
    status: ACTIVE
    created_at: "2019-01-15T14:39:48.154Z"
    ```

**[!TAB API]**

Чтобы изменить имя реестра, воспользуйтесь методом [update](../../api-ref/Registry/update.md) для ресурса [Registry](../../api-ref/Registry/).

---


## Изменить метку реестра {#update-label}

---

**[!TAB CLI]**

Измените метку реестра (не путайте с тегами Docker-образа): 

* Используя параметр `id`:
    
    ```
    $ yc container registry update --id crp3qleutgksvd1prhvb --labels my_label=fav_label
    id: crp3qleutgksvd1prhvb
    folder_id: b1g88tflru0ek1omtsu0
    name: new-reg
    status: ACTIVE
    created_at: "2019-01-15T14:39:48.154Z"
    labels:
      my_label: fav_label
    ```
    
* Используя параметр `name`:
    
    ```
    $ yc container registry update --name new-reg --labels new_label=test_label
    id: crp3qleutgksvd1prhvb
    folder_id: b1g88tflru0ek1omtsu0
    name: new-reg
    status: ACTIVE
    created_at: "2019-01-15T14:39:48.154Z"
    labels:
      new_label: test_label
    ```

**[!TAB API]**

Чтобы изменить метку реестра, воспользуйтесь методом [update](../../api-ref/Registry/update.md) для ресурса [Registry](../../api-ref/Registry/).

---
