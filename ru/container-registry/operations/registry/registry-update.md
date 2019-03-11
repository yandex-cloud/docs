# Изменить реестр

Узнайте, как изменить: 
- [Имя реестра](#update-name)
- [Метку реестра](#update-label)

Для обращения к [реестру](../../concepts/registry.md) используйте его идентификатор или имя. Как узнать идентификатор или имя реестра, 
читайте в разделе [Получить информацию об имеющихся реестрах](registry-list.md).


## Изменить имя реестра {#update-name}

---
 
**[!TAB CLI]**

[!INCLUDE [cli-install](../../../_includes/cli-install.md)]

Измените имя реестра: 

```
$ yc container registry update my-reg --new-name new-reg
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

[!INCLUDE [cli-install](../../../_includes/cli-install.md)]

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

**[!TAB API]**

Чтобы изменить метку реестра, воспользуйтесь методом [update](../../api-ref/Registry/update.md) для ресурса [Registry](../../api-ref/Registry/).

---
