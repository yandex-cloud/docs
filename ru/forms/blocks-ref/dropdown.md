# Выпадающий список

В этом блоке пользователь может выбрать один из пунктов выпадающего списка. Например, семейное положение.

![](../../_assets/forms/tutorial-list.gif)

## Настройки блока {#sec_settings}

### Вопрос {#question}

Введите заголовок списка или формулировку вопроса.

{% include [question](../../_includes/forms/question.md) %}

### Ответы {#param-answers}

Задайте варианты, которые сможет выбрать пользователь:

- Чтобы добавить вариант ответа, выберите поле **Добавить вариант** и введите текст ответа.

- Чтобы форматировать текст ответа, используйте [разметку Markdown](../appearance.md#section_pzm_m1j_j3b).

- Чтобы изменить положение варианта в списке, перетащите его за значок ![](../../_assets/forms/drag-answer.png). 

{% include [id-required-hidden](../../_includes/forms/id-required-hidden.md) %}

{% include [sort](../../_includes/forms/sort.md) %}

### Подставить первый вариант ответа в поле {#first}

Включите эту опцию, чтобы первый вариант ответа в списке подставлялся в поле по умолчанию. Например, если вы считаете, что этот вариант подходит для большинства пользователей. 
Сортировка ответов влияет на то, какой ответ будет подставлен в поле.

### Фильтровать ответы при вводе текста в поле {#filter}

Включите эту опцию, чтобы пользователь мог вводить текст в поле со списком. При этом в списке будут отображаться только те варианты ответа, в которых есть совпадение с введенным текстом.

