# Устранение ошибки `KernelNotResponding: The kernel died unexpectedly`


## Описание проблемы {#issue-description}

При работе с CSV-файлами возникает ошибка:
```
KernelNotResponding: The kernel died unexpectedly
```

## Решение {#issue-resolution}

Попробуйте прочитать первые несколько десятков строк из CSV-файла. Используйте [`pandas.read_csv`](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.read_csv.html) с указанием дополнительного параметра `nrows` для того, чтобы указать необходимое количество строк в формате `nrows`. Также вы можете считывать из CSV-файла только нужные колонки: `index_col` или `names`.

После загрузки фрагмента отпечаток (*footprint*) в оперативной памяти [можно задать так](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.memory_usage.html): `df.memory_usage(deep=True).sum()`. Это позволит определить необходимую конфигурацию ноды.

Информация об объеме оперативной памяти на каждой конфигурации есть в нашей [документации](../../../datasphere/concepts/configurations.md).

{% note info %}

Доступ к конфигурациям начиная с g1.1 для {{ ml-platform-name }} открывается после [перехода на платное потребление и пополнения лицевого счета на сумму от 500 рублей](../../../datasphere/concepts/limits.md).

После перехода на платное потребление для оплаты ресурсов в первую очередь будут использоваться активные гранты. Средства с лицевого счета начнут списываться только после того, как [средства гранта будут потрачены или истечет срок его действия](../../../billing/payment/billing-cycle-individual.md).

{% endnote %}