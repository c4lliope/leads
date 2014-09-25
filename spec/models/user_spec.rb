require 'spec_helper'

describe User, 'Validations' do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:token) }
end
