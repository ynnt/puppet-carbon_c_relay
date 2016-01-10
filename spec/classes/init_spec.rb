require 'spec_helper'
describe 'carbon_c_relay' do

  context 'with defaults for all parameters' do
    it { should contain_class('carbon_c_relay') }
  end
end
