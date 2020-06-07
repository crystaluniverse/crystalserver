# Data identification

## principles

> ```$3botid:$topicid:$schemaid:$objid```

there always need to be 3 ```:```

### 3botid (tid)

- is a nr (the official nr as used in phonebook)
- or is the 3bot name e.g. kristof.ibiza or kristof.3bot or kristof (is same as kristof.3bot)

### topicid (pid)

- can be a nr, unique per 3bot, if a nr then 3bot needs to be specified
- topicid can also be a name (String), each topic is unique in a 3bot
    - . can be used in topicid
    - e.g. ```threefold.ambassadors.cairo.wiki```

### schemaid (sid)

- schemaurl is a ```.``` separated url, can be just 1 name
- if only 1 name given then will look on the defined topic if that name exists for url (1 or 2e part of a bigger url)  
- e.g. book would match 
    - ```something.book```
    - ```book```    
    - ```book.3```  #because last is just a version
    - ```something.book.3```
    - but would not match ```something.book.sub``` or ```something.book.sub.3```
- possible schema's are defined per topic if not found there per 3bot


### objectid (objid or oid)

> ```$3botid:$topicid:$schemaid:new``` <BR>
> ```$3botid:$topicid:$schemaid:```

if no ID so is new one,or can use 'new' as word

- the object id is a nr or a name (if there is a name field on the obj)

## used in dedicated file

- filename ```$3botid:$topicid:$schemaid:$objid.toml```
- the extension is in ["toml","yaml","json","msgp"]
    - msgp is messagepack
- inside the file there is the data

## used as part of a file

!!!include:data_in_text.md

