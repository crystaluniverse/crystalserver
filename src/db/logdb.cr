# module Crystalserver

#     class FilesystemLogDB

#         #path where the logs will be stored
#         # see log_logging.md
#         property @path : String

#         #serialize the object given to the serialized value & store in log
#         #add time to it
#         def process( obj: ...)
            
#         end

#         # regex filter in PCRE
#         # this allows you to find everything e.g. tags, source, ...
#         # returns the logs just like the original text
#         def find( time_from : Int,  time_to : Int, regex_filter : String, processors : Array(Procsessor) )
#         end

#         # find based on job, twin_id, 
#         # text filter is just something*sss  only * and ? and text, it matches everywhere
#         # internally the text filter gets converted to real regex above (this function uses above find)
#         # if time not specified will never be more than 1 day, if not specified is last day
#         # if time_from specified , but not time_to then time_from + 1 day (till today)
#         # if time_to specified, but not time_from then 24h ago
#         # if std out given then will format & send to stdout or other stream as specified
#         def find( time_from : Int = 0,  time_to : Int = 0, job_id : Int = 0, twin_id : Int = 0, 
#             topic_id : Int = 0, text_filter : String, processors : Array(Processor) )
#         end

#         # format
#         # make the raw text format nicely readable by people
#         def format( logtext : String):



#     end


#     #prints the found results to std out
#     class Processor
        
#     end

#     #prints the found results to std out
#     class ProcessorPrinter < Processor

#         # include_filters are regex for things to show, if not used then show all
#         # exclude_filters are regex 
#         def initialize(@show_time = False : Bool, include_filters = "" : String, exclude_filters = "" : String)
#         end        


#     end

# end
  