module Solusvm
  class ServerWrapper < Server
    attr_accessor :data, :diskspace, :memory
    
    def initialize(vid)
      self.data = self.info_all(vid)
      if self.successful?
        hdd = self.data["hdd"].split(",")
        memory = self.data["memory"].split(",")
      
        self.memory = {:total => memory[0], :used => memory[1], :free => memory[2], :percent => memory[4]}
        self.diskspace = {:total => hdd[0], :used => hdd[1], :free => hdd[2], :percentage => hdd[3]}
      end
    end
    
    def load_graph
      if self.successful?
        self.api_endpoint.to_s.gsub("/api/admin/command.php","") + self.data["loadgraph"]
      else
        ""
      end
    end
    
    def traffic_graph
      if self.successful?
        self.api_endpoint.to_s.gsub("/api/admin/command.php","") + self.data["trafficgraph"] 
      else
        ""
      end
    end
    
    def used_memory
      self.memory[:used].to_f / 1024 / 1024
    end
    
    def used_space
      self.diskspace[:used].to_f / 1024 / 1024 / 1024
    end
    
    def free_space
      self.diskspace[:free].to_f / 1024 / 1024 / 1024
    end
    
    def total_space
      self.diskspace[:total].to_f / 1024 / 1024 / 1024
    end
    
    def percentage_used
      self.diskspace[:percentage]
    end
  end
end
