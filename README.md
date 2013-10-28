
A ruby gem to connect to the Burning Glass LensWebSrv service

# BurningGlass

A ruby gem to connect to the Burning Glass LensWebSrv service for parsing resumes.

## Installation

Add this line to your application's Gemfile:

    gem 'burning_glass'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install burning_glass

## Usage

    Access to the Burning Glass LensWebSrv is required for this gem to work. See http://www.burning-glass.com/ for more info.


    Step 1:
        Create a Sovren client connection. There are two ways to do this.
            - Edit client.rb and replace the following line with your Burning Glass key:

                    @instanceCode = options[:instanceCode] || "YOUR_BURNING_GLASS_INSTANCE_CODE_CAN_GO_HERE"

            - Pass your client key into the initializer with the instanceCode param:

                    @client = Burning_Glass::Client.new(wsdl: Settings.burning_glass.wsdl, instanceCode: Settings.burning_glass.instance_code)

                    where wsdl: is the location of the Burning Glass WSDL and instanceCode: is your Burning Glass issued instance code / access key

        Pass the resume you wish to parse into client.parse

                    client.parse(resume_doc)

        The response will be the BGXML from the Burning Glass LensWebSrv service.

    The gem is currently calling the Burning Glass "tag_binary_data" call. You can easily set it to call any other service by adding the params :svcCall, :svcResponse and :svcReturn to the client initializer.
