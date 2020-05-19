# textual wire data format

Aim is to have a format which 

- can be streamed as text
- is fast to parse
- is readable by humans
- can encompass all data obj possible

## generic principles

- first char defines the type, if not given then is just text for log stdout/err
- is separated with |
- if it doesn't exist then is log of level 3 = stdout

## log or text in general

```\n``` separated lines of text which can be read from a filesystem or can come in as a stream (stream interface)

### default

```
only text, is just a message, e.g. a paragraph
```

### level

level is like importance, is nr in front of ```|```

```
3|only text, is just a message
```

- CRITICAL 	9
- ERROR 	8
- WARNING 	6
- ENDUSER   4
- INFO 	    3
- LOG       2
- DEBUG 	1


- STDERR = ERROR is 8

### specify tags & level in text

```
3|only text, is just a message <<color:red group:thisone category:performance.hd description:'sss sss'>> 
```

- tags are an important feature for future functionality
- tags are in  ```<< >>```

### context (special type of tag, default predefined one)

- Is where the e.g. log info came from, structured as a tag
- context has predefined format too:  ```$filepath:$linenr:$class.$def``` or ```$filepath:$linenr:$def```

```
3|only text, is just a message <<size:big group:thisone category:performance.hd context:'/root/code/file/something.py:30:mymethod'>> 
```

### remarks

```
3| only text, is just a message <<color:red important>> #some remark, not processed
```

- all after # does not get processed
- when # at start, also ignore

### use colors

```
only text, is just a {RED} message {RESET}
```

when send to stdout, the right ansi chars will be used to colorize

### Job ID

- at end of line do ```[$jobid]```
- at end of line do ```[$twinid:$jobid]```
- defines where the e.g. logs belong too

### time marked

To store the log it needs to get time marked this is done by putting

```$epoch-```

in front of the log

e.g.

```
4235345- 3: only text, is just a {RED} message {RESET}
# or
4235345-3:only text, is just a {RED} message {RESET}
# or
4235345-only text, is just a {RED} message {RESET}
# or
4235345-   only text, is just a {RED} message {RESET}
```

## data

- is a multiline format
- uses code block like in markdown


> \```json $schemaurl($twinid.$topicid.$id)<BR>
> here some data in yaml, toml or json ...<BR>
> \```

or

> \```yaml $schemaurl($twinid.$topicid.$id)<BR>
> here some data in yaml, toml or json ...<BR>
> \```

or 

> \```toml $schemaurl($twinid.$topicid.$id)<BR>
> here some data in yaml, toml or json ...<BR>
> \```

the cool thing is that in markdown it would format well to a dataobj
and the schema is not seeable in rendering but ofcourse is in source format

### schemaurl

- schemaurl is a ```.``` separated url, can be just 1 name
- if only 1 name given then will look on the defined topic if that name exists for url (1 or 2e part of a bigger url)  
- e.g. book would match 
    - ```something.book```
    - ```book```    
    - ```book.3```  #because last is just a version
    - ```something.book.3```
    - but would not match ```something.book.sub``` or ```something.book.sub.3```


### format of the topline in the code block

```
#just the used schema
$format $schemaurl
```

```
$format $schemaurl($twinid.$topicid.$id)
```

```
#no ID so is new one
$format $schemaurl($twinid.$topicid.new)

```
#id specified but not topic id, but because is still unique in a 3bot it will still work
#only useful for update
$format $schemaurl($twinid.$id)
```

this topline allows us to specified if the data is already stored on a 3bot or not, its a unique location

