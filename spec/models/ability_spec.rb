require 'rails_helper'

describe User do
  it 'is not valid when new user is admin' do
    expect(User.new.admin?).to be false
  end
end
