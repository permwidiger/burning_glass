module Burning_Glass
  class Client
    attr_reader :instanceCode, :wsdl

    #Initialize the client class that will be used for all Burning_Glass requests.
    #
    # @param [Hash] options
    # @option options String :wsdl The url for the Burning Glass wsdl
    # @option options Integer :instanceCode The unique instance code for your version of the Burning Glass service
    # @option

    def initialize(options={})
      @wsdl = options[:wsdl]
      @instanceCode = options[:instanceCode] || 'YOUR_BURNING_GLASS_INSTANCE_CODE_CAN_GO_HERE'
      @svcCall = options[:svcCall] || 'tag_binary_data'
      @svcResponse = options[:svcResponse] ||  'tag_binary_data_response'
      @svcReturn = options[:svcReturn] || 'tag_binary_data_return'
    end

    def connection
      Savon.client(wsdl: wsdl, log: false)
    end

    def parse(file)
      result = connection.call(@svcCall, message: {InstanceCode: @instanceCode, BinaryData: Base64.encode64(file)})
      Resume.parse(result.body[@svcResponse][@svcReturn])
    end

    def parse_from_file(filename)
      begin
        puts "File #{filename} found, trying to parse..."
        resume_raw = File.read(filename)
      rescue Exception => e
        binding.pry
        return nil
      end

      parse(resume_raw)
    end
  end
end
