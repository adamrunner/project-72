module Services
  module Agent
    class MessageReceiver
      def self.parse(string)
        string.split(",").map {|b| {b.split(":")[0].downcase => b.split(":")[1]} }.inject(&:merge)
      end
    end
  end
end