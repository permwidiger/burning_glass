require 'spec_helper'

describe Burning_Glass::Client do
  Given(:bg_client) { Burning_Glass::Client.new(endpoint: "foo1", username: "foo2", password: "foo3") }

  context 'init' do
    Then { bg_client.should_not be_nil }
  end

  context '.config' do
    Then { bg_client.should respond_to :endpoint }
    Then { bg_client.endpoint == "foo1" }
    Then { bg_client.should respond_to :username }
    Then { bg_client.username == "foo2" }
    Then { bg_client.should respond_to :password }
    Then { bg_client.password == "foo3" }
  end

  describe 'parsing' do
    Given(:bg_client) { Burning_Glass::Client.new(endpoint: "http://www.foo.com/") }
    Given(:resume) { File.read(File.expand_path(File.dirname(__FILE__) + '/../support/ResumeSample.doc')) }

    context ".parse", vcr: {cassette_name: 'parsed_resume'} do
      When(:result) { bg_client.parse(resume) }
      Then { result.class.should == Burning_Glass::Resume }
    end
  end
end