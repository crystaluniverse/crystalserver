require "../types"

struct Crystal::Model::Job < Crystal::Schema
    property url : Url? = Url.new "twin.job"
    property time_start :  T
    property time_stop : T
    property action_url : Url?
    property params : JSON?
    property result : JSON?
    property timeout : I = 300
    property retry : I
    property twin_id : I # crystal twin id who called it
    property topic_id : I # topic id, topic as used in 3bot server for a particular twin_id
    property return_queue : S # return queue, can be any string
    property return_queue_secrets : LS  # secrets, are just strings which need to be given for the person who want to query the return queue
    property datalinks : LI  # job can be linked to one or more data objects of the twin/topic (optional)
end
