### Версия {{ ES }} не поддерживается {#elastic-version}

Трансфер завершается ошибкой:

```text
failed to execute elasticsearch activate hook: failed to dump source indexes info: unable to get source indexes 
list: failed to fetch schema, index deals : failed to amend schema based on sample data: failed to unmarshal sample 
document, index: deals, err: json: cannot unmarshal number into Go struct field searchResults.hits.total of type 
elastic.total
```

Ошибка возникает, если вы используете версию {{ ES }} ниже 7.x — такие версии не поддерживаются.

**Решение**: обновите {{ ES }} до версии 7.x или выше.

