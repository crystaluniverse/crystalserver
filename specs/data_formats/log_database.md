# log

log is not an object its the textual representation

see [all_in_one_textformat](all_in_one_textformat.md)

it never gets stored as an object, always at runtime deserialized (is too inefficient to store as objects   ).

## how does it get stored

there are 2 options to store logs

### in BCDB

as object [logcontainer](schemas/logcontainer.toml)

### on filesystem

```$dirlocation/$year/$month-$day/$hour.log```

- month: 01-12
- day: 01-31 
- year: 2002-2100
- hour: 00-24

e.g.

```/var/log/2020/05-30/15.log```
