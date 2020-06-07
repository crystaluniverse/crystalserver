

# serialization format v1

this format is not the best one and not even that efficient but allows us to develop fast.

## bytestring: of byte +msgpack

| name  | size in bytes | descr |
|---|---|---|
| format  | int8  | 1 today |
| msgpack encoded data | bytes | the data |

## msgpack inside the msgpack

the message pack is a list of following records

| name  | size in bytes | descr |
|---|---|---|
| 3bot_id | int32 | id of crystal 3bot |
| obj_id | int32 | id of object in crystal 3bot |
| schema url | string | points to the schema used |
| payload | bytes | msgpack encoded object itself |
| optional signature | 64bytes | signature with priv key of crystal 3bot |

## remarks

- in other words we are embedding 2 msgpack obj in each other.
- the first 8 bytes is to identify the format
- then list of 4 or 5 records
- the 4e record is a msgpack again which is the serialized obj which is represented by the schema
- this data gets stored in e.g. BCDB or redis or ...




