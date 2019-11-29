module TasmotaAgent
  class Message
    # effectively tableless model class for holding the message object
    # base class, others will inherit from this
    # subclasses will define patterns and extract attributes from message payloads
    # return result will be mapped attributes, ready to insert Entry records
    # could be inserted with bulk_write or insert_many

    def initialize(*args)
    end
  end
end
