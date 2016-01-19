class Request
  attr_reader :method, 
              :path, 
              :protocol,
              :params,
              :raw_data

  def self.create(client)
    raw_data = []
    while line = client.gets and !line.chomp.empty?
      raw_data << line.chomp
    end
    new(raw_data)
  end

  def initialize(raw_data)
    @method, path, @protocol = raw_data.first.split(" ")
    @path, @params = parse_params(path)
    @raw_data      = raw_data
    # the following lines set instance variables for each header...
    # probably unnecessary? 
    # raw_data.drop(1).each do |line|
    #   key, value = line.split(": ") 
    #   instance_variable_set("@#{key.downcase.gsub("-","_")}", value) 
    # end
  end

  def debugging_info
    "<pre>#{raw_data.join("\n")}</pre>"
  end

  def parse_params(path)
    if path.include?('?')
      path, raw_params = path.split('?')
      params = raw_params.split('&').each_with_object({}) do |pair, obj|
        key, val = pair.split('=')
        obj[key] = val
        obj
      end
      [path, params]
    else
      [path, {}]
    end
  end
end

