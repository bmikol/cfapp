require 'rails_helper'

describe Product do
  before do
    @product = Product.create!(name: 'race bike', price: '99.99')
    @user = User.create!(email: 'foo@bar.com', password: 'password')
    @product.comments.create!(rating: 1, user: @user, body: 'Awful bike!')
    @product.comments.create!(rating: 3, user: @user, body: 'Meh')
    @product.comments.create!(rating: 5, user: @user, body: 'Awesome bike!')
  end

  it 'returns the average rating of all comments' do
    expect(@product.average_rating).to eq 3
  end

  it 'is not valid without name' do
    expect(Product.new(description: 'Nice bike', price: '99.99')).not_to be_valid
  end

  it 'is not valid without price' do
    expect(Product.new(description: 'Nice bike', name: 'race bike')).not_to be_valid
  end
end
