require 'rails_helper'

describe Product do
  before do
    @product = Product.create!(name: 'race bike', price: '99.99')
    @user = User.create!(email: 'foo@bar.com', password: 'password')
    @product.comments.create!(rating: 1, user: @user, body: 'Awful bike!')
    @product.comments.create!(rating: 3, user: @user, body: 'Meh')
    @product.comments.create!(rating: 5, user: @user, body: 'Awesome bike!')
  end

  it 'returns product' do
    expect(@product).to be(@product)
  end

  it 'returns the average rating of all comments' do
    expect(@product.average_rating).to eq 3
  end

  it 'returns the highest rating comment of all comments' do
    expect(@product.highest_rating_comment.body).to eq('Awesome bike!')
  end

  it 'returns the lowest rating of all comments' do
    expect(@product.lowest_rating_comment.body).to eq('Awful bike!')
  end

  it 'is not valid without name' do
    expect(Product.new(description: 'Nice bike', price: '99.99')).not_to be_valid
  end

  it 'is not valid without price' do
    expect(Product.new(description: 'Nice bike', name: 'race bike')).not_to be_valid
  end

  it 'returns a search' do
    pinklady = Product.create(
      name: 'Pink Lady Apple',
      price: '2.99'
    )
    grannysmith = Product.create(
      name: 'Granny Smith Apple',
      price: '1.99'
    )
    valencia = Product.create(
      name: 'Valencia Orange',
      price: '0.99'
    )
    expect(Product.search('Apple')).to eq[pinklady, grannysmith]
  end
end
