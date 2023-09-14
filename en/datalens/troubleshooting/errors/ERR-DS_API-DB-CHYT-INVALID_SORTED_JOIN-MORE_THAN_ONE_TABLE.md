# Cannot join a concatenation of tables with another table

`ERR.DS_API.DB.CHYT.INVALID_SORTED_JOIN.MORE_THAN_ONE_TABLE`

When connecting to CHYT, in JOINs you can't use two table ranges
(that is, left and right both). One of the ranges needs to be rewritten as a subquery.
