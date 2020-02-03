# Работа с YQL из Jupyter
## Введение {#introduction}
<a name="jupyter-intro"></a>

В [Python клиентской библиотеке YQL](../interfaces/python.md) помимо основной функциональности для отправки запросов на YQL включен набор дополнительных механизмов для упрощения её исользования из [Jupyter](http://jupyter.org) (бывший IPython Notebook):

* Специальная команда `%yql` (в терминах IPython — *«magic»*) для отправки запросов в сервис YQL.
* Хелпер для конвертации результата запроса в [pandas.DataFrame](http://pandas.pydata.org/pandas-docs/stable/generated/pandas.DataFrame.html).
* Используя pandas.DataFrame, легко [построить график](http://pandas.pydata.org/pandas-docs/stable/visualization.html) с помощью [matplotlib](http://matplotlib.org).
* Подсветка синтаксиса YQL в ячейках (с учетом отличий YQL от стандартного SQL).
* Подпрограмма `yql jupyter` в [консольном клиенте](../interfaces/cli.md), запускающая преднастроенный экземпляр Jupyter, включающий всё, что показалось нам полезным для значительной доли пользователей. В частности:
  * [Jupyter](http://jupyter.org) + [IPython](http://ipython.org);
  * [Клиентская библиотека YQL](../interfaces/python.md);
  * [pandas](http://pandas.pydata.org) + [matplotlib](http://matplotlib.org) + [numpy](http://www.numpy.org/) + [scipy](http://www.scipy.org/);
  * [sklearn](http://scikit-learn.org/) + [sklearn-pandas](https://github.com/paulgb/sklearn-pandas);
  * [Клиент YT](https://wiki.yandex-team.ru/yt/pythonwrapper/) и [Nile](https://wiki.yandex-team.ru/statbox/logtools/nile/).

Как выглядит вся эта конструкция в сборе:
![](https://wiki.yandex-team.ru/yql/userguide/jupyter/.files/yql-jupyter.jpg)

<blockquote>%yql по умолчанию при запуске возвращает такой объект в переменную _, а также можно написать ~%%yql --out foo, чтобы он попал в переменную foo.</blockquote>

## Установка {setup}
### Инструкции для создания новой инсталляции Jupyter {#instructions-for-creating-a-new-jupiter-installation}
#### Linux / Mac OS X {#linux-mac-os-x}
Самый простой способ установить и запустить Jupyter + клиент YQL — воспользоваться упоминавшейся во введении командой `yql jupyter` в [консольном клиенте](../interfaces/cli.md). Из-за большого числа библиотек в экосистеме IPython/Jupyter, они не включены в бинарник (втащить их в таком объеме в Аркадию — крайне трудоёмко), а скачиваются при первом запуске. Как следствие, не исключены конфликты с уже установленным в системе Python.

При первом запуске `yql jupyter` работает следующим образом:

1. С [Sandbox](https://wiki.yandex-team.ru/sandbox) скачивается готовый virtualenv со всеми необходимыми библиотеками.

  * <span style="color:gray;">Есть три сборки — под `darwin` (Mac OS X), `precise` и `trusty`. При запуске выполняется попытка с помощью системных вызовов определить тип операционной системы (Linux/Mac OS/Windows) и дистрибутив (для Linunx). Если для данной ОС есть готовая сборка — она будет уставлена, в противном случае — запускается скрипт, выполняющий установку из pypi, у которого значительно больше требований к наличию в системе установленных библиотек, компиляторов и утилит. Другими словами, для запуска на платформе, не входящей в список поддерживаемых, потребуется специальная настройка.</span>
2. Разархивируется в `$HOME/.yql/jupyter/env`.
3. В нём исправляются все пути, так как в virtualenv принято использовать абсолютные.
4. В `$HOME/.yql/jupyter/notebook` копируется ipynb с примером, а также устанавливаются нестандартные javascript-расширения и css-стили. Сюда же будут сохраняться notebooks из интерфейса jupyter.
5. Запускается `$HOME/.yql/jupyter/scripts/launch.sh`, который просто вызывает `jupyter notebook` из virtualenv с правильными аргументами.
При последующих запусках первые 4 пункта, как правило, пропускаются.

#### Windows {#windows}
Не единственно возможная, но опробованная на практике инструкция для Windows:

1. Скачать и установить Anaconda для Python 2.7: <https://www.continuum.io/downloads#_windows> (при установке нужно выбрать per-user вариант, в противном случае приведенные ниже пути придется адаптировать).
2. Выполнить `pip.exe install -i https://pypi.yandex-team.ru/simple/ "yql[full]"` (используя pip.exe из Anaconda).
3. Скопировать файлы:

  * <https://a.yandex-team.ru/arc/trunk/arcadia/yql/library/python/yql/ipython/jupyter_scripts/yql_codemirror.js> -> `%APPDATA%\..\Local\Continuum\Anaconda2\Lib\site-packages\notebook\static\components\codemirror\mode\yql\yql.js`
  * <https://a.yandex-team.ru/arc/trunk/arcadia/yql/library/python/yql/ipython/jupyter_scripts/yql_custom.css> -> `%APPDATA%\..\Local\Continuum\Anaconda2\Lib\site-packages\notebook\static\custom\custom.css`
  * Создать где угодно директорию `scripts` и положить туда <https://a.yandex-team.ru/arc/trunk/arcadia/yql/library/python/yql/ipython/jupyter_scripts/yql_nbextension.js>
4. Заготовка для скрипта запуска: <https://a.yandex-team.ru/arc/trunk/arcadia/yql/library/python/yql/ipython/jupyter_scripts_windows/jupiter.cmd> (в расчете, что он лежит рядом с директорией `scripts` из предыдущего пункта).

Будем благодарны, если кто-нибудь доавтоматизирует и отладит эти пункты под веткой `if is_windows: ...`: <https://a.yandex-team.ru/arc/trunk/arcadia/yql/cli/interactive/jupyter.py> (запускать без сборки в бинарник можно с помощью [yql.cmd jupyter](https://a.yandex-team.ru/arc/trunk/arcadia/yql/cli/yql.cmd)).

### Подключение к существующей инсталляции Jupyter {#connecting-to-an-existing-jupiter-installation}
В связи с многообразием возможных способов как она может быть устроена (разные ОС, версии Jupyter/IPython/Python, используемый способ установки Python библиотек, многопользовательский режим Jupyter и т.п.), готовой инструкции на все случаи жизни здесь нет.

В общих чертах процесс должен быть аналогичен описанной выше [инструкции для Windows](#windows):

1. Программа-минимум — просто [установить клиентскую библиотеку YQL](../interfaces/python.md) наиболее подходящим способом.
2. В составе клиентской библиотеки располагаются два extension'а ([magic.py](https://a.yandex-team.ru/arc/trunk/arcadia/yql/library/python/yql/ipython/magic.py) и [yql_nbextension.js](https://a.yandex-team.ru/arc/trunk/arcadia/yql/library/python/yql/ipython/jupyter_scripts/yql_nbextension.js)), которые в совокупности реализуют [%yql magic](#yqlmagic) - их нужно подключить к своей инсталляции принятым в неё способом, возможно адаптировав под своё окружение, если оно отличается от `yql jupyter`.
3. Опционально устанавливаем подсветку синтаксиса для [%yql magic](#yqlmagic) [yql_codemirror.js](https://a.yandex-team.ru/arc/trunk/arcadia/yql/library/python/yql/ipython/jupyter_scripts/yql_codemirror.js)

## Настройка и обновление {#configuring-and-updating}
### virtualenv {#virtualenv}
Как упоминалось выше, окружение для работы с YQL из Jupyter реализовано на основе стандартного для Python-мира [virtualenv](https://virtualenv.pypa.io/). Из этого есть несколько следствий:

* Можно активировать виртуальное окружение (командой `$ source $HOME/.yql/jupyter/env/bin/activate`) и устанавливать/обновлять/удалять любые библиотеки с помощью pip.
* [Клиент YQL](../interfaces/python.md) можно установить/обновить через `$ pip install --upgrade -i <https://pypi.yandex-team.ru/simple/> "yql[full]"` в любом другом virtualenv. Суффикс `[full]` можно не указывать, он устанавливает опциональные зависимости. Чтобы получить JavaScript или CSS как в `yql jupyter` для полученнго любым другим способом virtualenv, нужно вручную разложить файлы по аналогии с 3 пунктом приведенной выше [инструкции для Windows](#windows).

### Безопасность {#security}
Так как веб-интерфейс Jupyter имеет полный доступ к тому окружению, из которого он был запущен (в частности, к файловой системе), при наличии в нем чего-либо не публичного, крайне рекомендуется «запирать» Jupyter под пароль. Делается это следующим образом:
``` sh
$ source $HOME/.yql/jupyter/env/bin/activate
$ python
Python 2.7.10 (default, Oct 23 2015, 18:05:06)
[GCC 4.2.1 Compatible Apple LLVM 7.0.0 (clang-700.0.59.5)] on darwin
Type "help", "copyright", "credits" or "license" for more information.
>>> from notebook.auth import passwd; passwd()
Enter password:                                  # вводим какой-нибудь достаточно сложный пароль
Verify password:
'sha1:f5c2b5390a91:4c4db7310df346c1580b5262bafa9541b0aa0a73'
>>> ^D
$ yql jupyter --NotebookApp.password='sha1:f5c2b5390a91:4c4db7310df346c1580b5262bafa9541b0aa0a73'
```
После чего перед открытием веб-интерфейса Jupyter выводится запрос ввести тот же пароль.

### CSS {#css}
При первичной установке в `$HOME/.jupyter/custom/custom.css` копируется тема оформления Jupyter, в которой подсветка синтаксиса YQL, на наш взгляд, смотрится более или менее прилично. Если этот файл уже существует, он больше не перезаписывается.
Если эта тема оформления вас по каким-то причинам не устраивает, то:

* Можно вернуть toolbar, удалив секцию, отмеченную соответствующим заметным комментарием.
* Можно откатиться до стандартной темы оформления с помощью `$ echo "" > $HOME/.jupyter/custom/custom.css`
* Можно внести любые правки в CSS на свой вкус.

## Использование {#using}

### %yql magic {#yql-magic}
<a name="yqlmagic"></a>

* Запускает выполнение указанного следом запроса, например `%yql SELECT 2+2;`, и синхронно ожидает результата. С удвоенным % в начале — многострочный режим. По окончании результат печатается в виде HTML-таблицы.
* Объект результата аналогичен клиентской библиотеке, так что её примеры актуальны: <https://a.yandex-team.ru/arc/trunk/arcadia/yql/library/python/yql/api/v1/examples.> При желании можно пользоваться клиентской библиотекой, не прибегая к специфичной для Jupyter обертке (magic) — результат в обоих случаях эквивалентен.
* Настраивается `%yql` через стандартный для IPython механизм `%config YqlMagic`.
* В примере, который загружается при старте клиента, аутентификационный токен для работы с [YQL HTTP API](../interfaces/http.md) указывается с помощью параметра `%config`, но нужно быть осторожным, чтобы случайно не поделиться своим токеном с коллегой. На постоянной основе удобнее передавать токен через переменную окружения `YQL_TOKEN`. Например, добавив `export YQL_TOKEN='xxxxxx'` в `.bashrc/.zshrc`. Однако в этом случае следует ограничить права на чтение файла `.bashrc`: `$ chmod 600 $HOME/.bashrc`. [Получить YQL-токен можно здесь](https://yql.yandex-team.ru/?settings_mode=token).
* Вручную загрузить расширение `%yql magic`, если по каким-либо причинам это не произошло автоматически, можно командой `%load_ext yql.ipython.magic`.
* В многострочном режиме ввода запроса (с двумя процентами) в первой строке можно использовать опции:
  * <code>%%yql --out &lt;OUT&gt;</code> — указать имя переменной, в которую будет записан результат (при этом не отключается поведение Jupyter по умолчанию, и результат magic также записывается и в переменную %%_%%);
  * <code>%%yql --bg</code> — не дожидаться выполнения синхронно (этот режим можно включить, указав & вместо последней точки запятой в запросе, как и в консольном клиенте);
  * <code>`yql --dataframe / `yql --full-dataframe</code> — вернуть результат в виде `pandas.DataFrame`;
  * <code>%%yql --help</code> — вывести список доступных опций.

### pandas helper {#pandas-helper}
У объекта, возвращаемоего в качестве результата запроса, есть свойство `dataframe`, которое конвертирует результат в формат библиотеки pandas. Этот формат особенно удобен для дальнейших преобразований данных уже на клиенте. Подробнее о работе с данными в pandas можно ознакомиться в оригинальной [документации по DataFrame](http://pandas.pydata.org/pandas-docs/stable/generated/pandas.DataFrame.html).

Стоит иметь в виду, что:

* По умолчанию, если результат оказался больше 100 строк, то на клиент возвращаются лишь выборка данных (100 строк) и координаты таблицы с полным результатом на кластере. Узнать о такой ситуации можно по свойству `is_truncated` на результате или таблице, в этом случае координаты таблиц с полными данными указываются в поле `refs`.
* При обращении к свойству объекта результата `full_dataframe` выполняется попытка скачать результат целиком напрямую с кластера, прежде чем конструировать DataFrame. Однако стоит иметь в виду некоторые ограничения этого механизма, перечисленные в [инструкции к консольному клиенту](../interfaces/cli.md).

### matplotlib {#matplotlib}
В библиотеке pandas реализована удобная интеграция с matplotlib, которая доступна с помощью методов `.plot()` и `.plot.***()` на объекте DataFrame или производных от него (cм. в предыдущем разделе описание свойства объекта результата `dataframe`). Подробнее об интеграции с matplotlib — [на сайте библиотеки pandas](http://pandas.pydata.org/pandas-docs/stable/visualization.html). Пример можно увидеть на скриншоте [во введении к настоящему документу](#jupyter-intro).

## Дальнейшее развитие {#further-development}

* Со временем понадобится в каком-то виде более прозрачный механизм обновления, сейчас только вручную через `pip` или удаление `$HOME/.yql/jupyter` (<span style="color:red;">NB: Новые notebooks, сохраненные через интерфейс, сохраняются в `$HOME/.yql/jupyter/notebook`, необходим бэкап этого каталога перед удалением `$HOME/.yql/jupyter`</span>).
* Когда в Jupyter появится человеческий API для автокомплита ([слегка подзаброшенный тредик на GitHub](https://github.com/jupyter/jupyter_client/issues/51)), надо будет прикрутить туда нашу библиотеку от консольного клиента.
* При наличии спроса надо будет доавтоматизировать версию запуска под Windows.
* Твой пункт. Feature request'ы, вопросы и пожелания можно присылать на рассылку [yql@](http://ml.yandex-team.ru/lists/yql) или сразу в <http://st.yandex-team.ru/YQL.>
