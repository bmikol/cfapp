require 'rails_helper'

describe Comment do
  before do
    @product = Product.create!(name: 'race bike', price: '99.99')
    @user = User.create!(email: 'foo@bar.com', password: 'password')
    @comment = Comment.create!(rating: 1, user: @user, body: 'Awful bike!', product: @product)
  end

  it 'is not valid without user' do
    expect(Comment.new(rating: 1, body: 'Awesome bike!', product: @product)).not_to be_valid
  end

  it 'is not valid without body' do
    expect(Comment.new(rating: 1, user: @user, product: @product)).not_to be_valid
  end

  it 'is not valid without product' do
    expect(Comment.new(rating: 1, user: @user, body: 'Awesome bike!')).not_to be_valid
  end

  it 'is not valid with decimal rating' do
    @comment.rating = 3.5
    expect(@comment).not_to be_valid
  end

  it 'is not valid with alphabetic rating' do
    @comment.rating = 'b'
    expect(@comment).not_to be_valid
  end
end
