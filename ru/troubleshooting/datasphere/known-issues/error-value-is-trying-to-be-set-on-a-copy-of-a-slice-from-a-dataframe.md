# Устранение ошибки `A value is trying to be set on a copy of a slice from a DataFrame`


## Описание проблемы {#issue-description}

При запуске кода в ячейке появляется предупреждение: 
```
SettingWithCopyWarning:
A value is trying to be set on a copy of a slice from a DataFrame.
Try using .loc[row_indexer,col_indexer] = value instead

See the caveats in the documentation: https://pandas.pydata.org/pandas-docs/stable/user_guide/indexing.html#returning-a-view-versus-a-copy
...
```

## Решение {#issue-resolution}

Такое сообщение может быть связано с тем, что в коде встречается «цепное назначение». Это сочетание цепочки и назначения в одном шаге. Чтобы избежать этого, рекомендуем использовать синтаксис `.loc[row_indexer,col_indexer]`, например:

```python
df2 = df.loc[:, ['A']]
```

Подробнее можно прочитать в [официальной документации pandas](https://pandas.pydata.org/pandas-docs/stable/user_guide/indexing.html#returning-a-view-versus-a-copy).
