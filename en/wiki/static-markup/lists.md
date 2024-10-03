---
title: How to work with lists in {{ wiki-full-name }}
description: In this tutorial, you will learn how to use lists in {{ wiki-name }}.
---

# Lists

## Numbered list {#section_numbered}

{% list tabs %}

- New editor

   {% include [static-markdown-alert](../../_includes/wiki/static-markdown-alert.md) %}

   To make a numbered list, use numbers with the `.` or `)` symbol. Numbering is performed dynamically during building, so the order of numbers is irrelevant.

   Markup:
   ```
   1. Item 1.
   1. Item 2.
   1. Item 3.
   ```

   {% cut "See the result" %}

   1. Item 1.
   2. Item 2.
   3. Item 3.

   {% endcut %}

- Old editor

   ### List with numbers {#section_numbered_numbers}

   - Before each item in the list, add a number with a dot and a space.

        {% note info %}

        The numbering of the list starts with the number that you put before the first item. The order of the numbers in the markup does not affect the numbering of the finished list, but it is more convenient to use the source text if the list items are numbered consecutively.

        {% endnote %}

   - To create a second-level list item, add three spaces at the beginning of the line.

   - To skip the numbering steps, put `#` after the number with a dot and the number that the numbering starts with will continue.

   - Separate the list from the following text with an empty line.

   Markup:

   ```
   1. List item
   2. List item
      1. Nested list item
      2. Nested list item
      3. Nested list item
   3.#8 Item after skipping items in the numbering sequence
   4. Ninth item of the list
   ```

   {% cut "See the result" %}

   ![](../../_assets/wiki/numerated-list-numbers-example.png)

   {% endcut %}

   ### List with letters {#section_numbered_letters}

   - A list with letters is created in the same way as a [numbered list](#section_numbered_numbers), except that it uses Latin letters instead of numbers.

   - To create a list with Roman numerals, add the letter `I` or `i` before each list item with a dot and a space.

   - Lists with letters do not support skipping numbering steps using the `#` symbol.

   Markup:

   ```
   List with capital letters:
   A. List item
   B. List item

   List with lowercase letters:
   a. List item
   b. List item

   List with Roman numerals:
   I. List item
   I. List item
   ```

   {% cut "See the result" %}

   ![](../../_assets/wiki/numerated-list-letters-example.png)

   {% endcut %}

{% endlist %}

## Bulleted list {#section_bullet}

{% list tabs %}

- New editor

   {% include [static-markdown-alert](../../_includes/wiki/static-markdown-alert.md) %}

   - Insert the `*` marker symbol before each item in the bulleted list.
   - To create a second-level list item, add two spaces at the beginning of the line.
   - Separate the list from the following text with an empty line.

   Markup:

   ```
   * List item
   * List item
     * Nested list item
     * Nested list item
   * List item
   ```

   {% cut "See the result" %}

   ![](../../_assets/wiki/unordered-list-example.png)

   {% endcut %}

- Old editor

   - Insert a marker symbol before each item in the bulleted list. You can use `-`, `*`, or `+` as markers.
   - To create a second-level list item, add two spaces at the beginning of the line.
   - Separate the list from the following text with an empty line.

   Markup:

   ```
   * List item
   * List item
     * Nested list item
     * Nested list item
   * List item
   ```

   {% cut "See the result" %}

   ![](../../_assets/wiki/unordered-list-example.png)

   {% endcut %}

{% endlist %}

## Combined list {#section_combined}

{% list tabs %}

- New editor

   {% include [static-markdown-alert](../../_includes/wiki/static-markdown-alert.md) %}

   You can include a bulleted sub-list into your numbered list and vice versa:

   ```
   1. Ordered list item
   1. Ordered list item
      * Unordered nested list item
      * Unordered nested list item
   1. Ordered list item
   ```

   {% cut "See the result" %}

   ![](../../_assets/wiki/combined-list-example.png)

   {% endcut %}

- Old editor

   You can include a bulleted sub-list into your numbered list and vice versa:

   ```
   1. Ordered list item
   2. Ordered list item
      * Unordered nested list item
      * Unordered nested list item
   1. Ordered list item
   ```

   {% cut "See the result" %}

   ![](../../_assets/wiki/combined-list-example.png)

   {% endcut %}

{% endlist %}

## Block elements inside a list {#section_elem-incl}

{% list tabs %}

- New editor

   {% include [static-markdown-alert](../../_includes/wiki/static-markdown-alert.md) %}

- Old editor

   To ensure that [`cut` titles](document-structure.md#section-cut), [quotes](quoting.md), [code blocks](source.md), [tables](grids.md), and other elements nested in the list are displayed correctly, make a left indent of four spaces in front of them relative to the list marker:

   ```
   1. item 1
       <[Quote with a list
       1. text
       1. text
       1. text
       ]>
   1. item 2
   ```
   {% cut "See the result" %}

   ![](../../_assets/wiki/add-elem1.png)

   {% endcut %}

{% endlist %}

## To-do lists {#section_check}

{% list tabs %}

- New editor

   You can learn how to work with a to-do/task list in [this guide](../wysiwyg/embed-content.md#tickets-list) for working with the [visual editor](../pages-types.md#new-editor).

- Old editor

   A to-do list (checklist) is a numbered or bulleted list where you can mark completed items. To create a to-do list, add a space and the following characters after the number or bullet in each item:

   - `[]` for an unmarked item.

   - `[x]` for a marked item.

   {% list tabs %}

   - Numbered list

      ```
      1. [x] Checked item
      2. [] Unchecked item
      3. [] Unchecked item
      ```

      {% cut "See the result" %}

      ![](../../_assets/wiki/checklist-num.png)

      {% endcut %}

   - Bulleted list

      ```
      + List item
      - [x] Checked item
      - [] Unchecked item
      ```

      {% cut "See the result" %}

      ![](../../_assets/wiki/checklist-bullet.png)

      {% endcut %}

   {% endlist %}

{% endlist %}
