---
title: "Какие элементы HTML доступны в {{ wiki-full-name }}"
description: "Из статьи вы узнаете, какие элементы HTML доступны в {{ wiki-name }}."
---

# Элементы HTML

## Теги {#html-tags}

{% list tabs %}

- Новый редактор

    {% include [static-markdown-alert](../../_includes/wiki/static-markdown-alert.md) %}

    Вставленный HTML код в данном виде редактора, будет отображаться как текст:
    
    Например:

    ```html
    <table border="1">
      <tr><td>Значение 1</td><td>Значение 2</td></tr>
      <tr><td>Значение 3</td><td>Значение 4</td></tr>
    </table>
    ```
    {% cut "Как выглядит результат" %}
    ```  
    <table border="1">
    <tr><td>Значение 1</td><td>Значение 2</td></tr>
    <tr><td>Значение 3</td><td>Значение 4</td></tr>
    </table>
    ```
    {% endcut %}


    В данном виде редактора HTML код лучше добавлять на страницу с помощью [визуального редактора](../pages-types.md#new-editor). Для вставки кода используйте кнопку ![](../../_assets/wiki/svg/link.svg) на панели задач.

- Старый редактор
    
    {% note alert %}
    
    Одновременное использование HTML и разметки {{ wiki-name }} может привести к некорректной работе HTML и непредсказуемым ошибкам. Это связано с пересечением разметок и, как следствие, нарушением структуры страниц.
    
    {% endnote %}
    
    Чтобы вставить на страницу элементы оформления, которые не предусмотрены разметкой Markdown, вы можете использовать в тексте теги HTML.
    
    Например:
    
    * ```html
      <p style="color: gray; font-weight: bold;">Текст серого цвета</p>
      ```
        {% cut "Как выглядит результат" %}
    
        <p style="color: gray; font-weight: bold;">Текст серого цвета</p>
        
        {% endcut %}
    
    * ```html
      <p style="border-width: 4px; border-style: double; border-color: orange;">Текст в рамке</p>
      ```
    
        {% cut "Как выглядит результат" %}
    
        <p style="border-width: 4px; border-style: double; border-color: orange;">Текст в рамке</p>
    
        {% endcut %}
    
    * ```html
      <table border="1">
        <tr><td>Значение 1</td><td>Значение 2</td></tr>
        <tr><td>Значение 3</td><td>Значение 4</td></tr>
      </table>
      ```
    
        {% cut "Как выглядит результат" %}
    
        <table border="1">
          <tr><td>Значение 1</td><td>Значение 2</td></tr>
          <tr><td>Значение 3</td><td>Значение 4</td></tr>
        </table>
    
        {% endcut %}

{% endlist %}

