{% note info %}

Some variables aren't serialized and therefore can't be saved. For example, a variable with a file open for writing: `f = open("file.txt", "w")`.

A warning is shown for these variables during the assignment: `The following variables cannot be serialized:`.

{% endnote %}