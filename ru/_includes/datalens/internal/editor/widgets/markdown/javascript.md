## JavaScript {#javascript}

### Общая информация {#common}

В результате выполнения вкладки JavaScript должны быть экcпортированы данные для отрисовки Markdown.

### Доступные методы {#available-methods}

* **`ChartEditor.getParams()`** - возвращает объект с нормализованными параметрами.

* **`ChartEditor.getLoadedData()`** - возвращает объект с данными, запрошенными на вкладке Urls.

* **`ChartEditor.getSharedData()`** - возвращает объект с общими данными для всех вкладок c вкладки Shared.


### Пример {#example}

```js
// формируем текст

const inline = 'Для вставки кода внутри предложений нужно заключать этот код в апострофы'
                + '`<html class="ie no-js">`.';

const text = `
# Заголовок h1
## Заголовок h2
### Заголовок h3
#### Заголовок h4

${inline}
`;

// экспортируем данные для отрисовки
module.exports = {
    markdown: text
};
```
