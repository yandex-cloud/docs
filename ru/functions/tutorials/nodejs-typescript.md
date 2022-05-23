# Создание функции Node.js с помощью TypeScript

Поскольку Node.js не поддерживает [TypeScript](https://www.typescriptlang.org/) нативно, вам придется скомпилировать код TypeScript в JavaScript. После этого вы сможете загрузить и выполнить вашу функцию в **{{ sf-name }}**.

## Настройка среды разработки
- Установите [Node.js](https://nodejs.org/ru/).

- Войдите в директорию с вашим проектом.
- Установите [TypeScript](https://www.typescriptlang.org/download):
```
npm install typescript --save-dev
```

- Создайте конфигурацию Typescript, выполните:
```
npx ts --init --preserveConstEnums --moduleResolution Node --isolatedModules --outDir build --strict false --target ES2021
```

Вы можете изменить значение аргумента `target`, если вы хотите использовать более старую версию JavaScript. Максимальное значение зависит от используемой версии Node.js:
| Версия Node.js | Максимальная версия |
|----|----|
| 12 | ES2019 |
| 14 | ES2020 |
| 16 | ES2021 |

 ## Сборка функции {{ sf-name }}
 Скомпилируйте функцию, выполните:
 ```
 npx tsc
 ```

В папке проекта появится директория `build`. Заархивируйте её содержимое в zip-файл.

## [Загрузка функции в {{ sf-full-name }}](../operations/function/version-manage.md)
