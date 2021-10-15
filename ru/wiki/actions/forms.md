# Формы из {{ forms-full-name }}

Блок `forms` позволяет вставлять на страницу форму, которая создана в сервисе [{{ forms-full-name }}]{% if audience == "external" %}({{ link-forms-b2b }}){% else %}({{ link-forms-int }}){% endif %}.

О том, как создать форму, читайте в [документации {{ forms-name }}](../../forms/).

## Вызов блока {#forms-call}

```
{{forms id="id формы"}}
```  
Как получить код для вставки формы, читайте в [документации {{ forms-full-name }}](../../forms/publish#xvx_g2c_tbb).