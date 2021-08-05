---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---
# Примитивные типы данных

{% note info %}

Термины «простые» и «примитивные» типы данных используются как синонимы.

{% endnote %}

{% include [datatypes](../../../_includes/datatypes_primitive_number.md) %}

{% include [datatypes](../../../_includes/datatypes_primitive_string.md) %}

{% include [datatypes](../../../_includes/datatypes_primitive_datetime.md) %}

## Приведение примитивных типов данных {%cast} {#converting-primitive-data-types-cast}

### Явное приведение {%explicit_cast} {#explicit-cast}

Явное приведение при помощи [CAST](../syntax/expressions.md#cast):

<table class="docutils">
	<thead>
		<tr>
			<th></th>
			<th align="center"><strong>Bool</strong></th>
			<th align="center"><strong>Int</strong></th>
			<th align="center"><strong>Uint</strong></th>
			<th align="center"><strong>Float</strong></th>
			<th align="center"><strong>Double</strong></th>
			<th align="center"><strong>Decimal</strong></th>
			<th align="center"><strong>String</strong></th>
			<th align="center"><strong>Utf8</strong></th>
			<th align="center"><strong>Json</strong></th>
			<th align="center"><strong>Yson</strong></th>
			<th align="center"><strong>Uuid</strong></th>
			<th align="center"><strong>Date</strong></th>
			<th align="center"><strong>Datetime</strong></th>
			<th align="center"><strong>Timestamp</strong></th>
			<th align="center"><strong>Interval</strong></th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><strong>Bool</strong></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="yes-cell">Да<sup>1</sup></td>
			<td align="center" class="yes-cell">Да<sup>1</sup></td>
			<td align="center" class="yes-cell">Да<sup>1</sup></td>
			<td align="center" class="yes-cell">Да<sup>1</sup></td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
		</tr>
		<tr>
			<td><strong>Int</strong></td>
			<td align="center" class="yes-cell">Да<sup>2</sup></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да<sup>3</sup></td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
		</tr>
		<tr>
			<td><strong>Uint</strong></td>
			<td align="center" class="yes-cell">Да<sup>2</sup></td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
		</tr>
		<tr>
			<td><strong>Float</strong></td>
			<td align="center" class="yes-cell">Да<sup>2</sup></td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
		</tr>
		<tr>
			<td><strong>Double</strong></td>
			<td align="center" class="yes-cell">Да<sup>2</sup></td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
		</tr>
		<tr>
			<td><strong>Decimal</strong></td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
		</tr>
		<tr>
			<td><strong>String</strong></td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
		</tr>
		<tr>
			<td><strong>Utf8</strong></td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
		</tr>
		<tr>
			<td><strong>Json</strong></td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
		</tr>
		<tr>
			<td><strong>Uuid</strong></td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
		</tr>
		<tr>
			<td><strong>Date</strong></td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="no-cell">Нет</td>
		</tr>
		<tr>
			<td><strong>Datetime</strong></td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="no-cell">Нет</td>
		</tr>
		<tr>
			<td><strong>Timestamp</strong></td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="no-cell">Нет</td>
		</tr>
		<tr>
			<td><strong>Interval</strong></td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="yes-cell">Да</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="no-cell">Нет</td>
			<td align="center" class="dis-cell"></td>
		</tr>
	</tbody>
</table>

Примечания к таблице:

1. `True` => 1, `False` => 0.
2. Всегда `True`. Исключение: 0 => `False`.
3. Возможно только в случае неотрицательного значения.

### Неявное приведение {%implicit_cast} {#implicit-cast}

Неявное приведение типов, которое возникает в базовых операциях (+-\*/) между разными типами данных. В ячейках таблицы указан тип результата операции, если она возможна:

<table class="docutils">
	<thead>
		<tr>
			<th></th>
			<th align="center"><strong>Bool</strong></th>
			<th align="center"><strong>Int</strong></th>
			<th align="center"><strong>Uint</strong></th>
			<th align="center"><strong>Float</strong></th>
			<th align="center"><strong>Double</strong></th>
			<th align="center"><strong>Decimal</strong></th>
			<th align="center"><strong>String</strong></th>
			<th align="center"><strong>Utf8</strong></th>
			<th align="center"><strong>Json</strong></th>
			<th align="center"><strong>Yson</strong></th>
			<th align="center"><strong>Uuid</strong></th>
			<th align="center"><strong>Date</strong></th>
			<th align="center"><strong>Datetime</strong></th>
			<th align="center"><strong>Timestamp</strong></th>
			<th align="center"><strong>Interval</strong></th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><strong>Bool</strong></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
		</tr>
		<tr>
			<td><strong>Int</strong></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="yes-cell">Int</td>
			<td align="center" class="yes-cell">Int</td>
			<td align="center" class="yes-cell">Float</td>
			<td align="center" class="yes-cell">Double</td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
		</tr>
		<tr>
			<td><strong>Uint</strong></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="yes-cell">Int</td>
			<td align="center" class="yes-cell">Uint</td>
			<td align="center" class="yes-cell">Float</td>
			<td align="center" class="yes-cell">Double</td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
		</tr>
		<tr>
			<td><strong>Float</strong></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="yes-cell">Float</td>
			<td align="center" class="yes-cell">Float</td>
			<td align="center" class="yes-cell">Float</td>
			<td align="center" class="yes-cell">Double</td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
		</tr>
		<tr>
			<td><strong>Double</strong></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="yes-cell">Double</td>
			<td align="center" class="yes-cell">Double</td>
			<td align="center" class="yes-cell">Double</td>
			<td align="center" class="yes-cell">Double</td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
		</tr>
		<tr>
			<td><strong>Decimal</strong></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="yes-cell">Decimal</td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
		</tr>
		<tr>
			<td><strong>String</strong></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
		</tr>
		<tr>
			<td><strong>Utf8</strong></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
		</tr>
		<tr>
			<td><strong>Json</strong></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
		</tr>
		<tr>
			<td><strong>Uuid</strong></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
		</tr>
		<tr>
			<td><strong>Date</strong></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="yes-cell">Date</td>
		</tr>
		<tr>
			<td><strong>Datetime</strong></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="yes-cell">Datetime</td>
		</tr>
		<tr>
			<td><strong>Timestamp</strong></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="yes-cell">Timestamp</td>
		</tr>
		<tr>
			<td><strong>Interval</strong></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="dis-cell"></td>
			<td align="center" class="yes-cell">Date</td>
			<td align="center" class="yes-cell">Datetime</td>
			<td align="center" class="yes-cell">Timestamp</td>
			<td align="center" class="yes-cell">Interval</td>
		</tr>
	</tbody>
</table>
