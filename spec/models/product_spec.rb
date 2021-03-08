require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it 'Should have name' do
      @product = Product.new(:name => "Chair")
      expect(@product.name).to be_present
    end

    it 'Should have a price' do
      @product = Product.new(:price => 20)
      expect(@product.price).to be_present
    end

    it 'Should have a quantity' do 
      @product = Product.new(:quantity => 100)
      expect(@product.quantity).to be_present
    end

    it 'Should have a category' do
      @product = Product.new(:category_id => 2)
      expect(@product.category_id).to be_present
    end
 
    it 'Should return something bad with a validation field being nil' do
      @category = Category.new(:name => 'Junk')
      @product = Product.new(name: nil, price: 20, quantity: 100, category_id: 2).valid?
      expect(@product).to be_falsey
    end
    
    it 'Should return error when full_messages' do
      @product = Product.new(name: nil, price: 20, quantity: 100, category_id: 2)

      expect(@product.valid?).to be false
      # puts @product.errors.full_messages
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end 
  end
end
