require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
  
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "Can checkout cart after adding product to it" do
    visit root_path
  
    expect(page).to have_content("My Cart (0)")
    page.find('article.product:first-child').click_on "Add"
    
    expect(page).to have_content("My Cart (1)")
    # expect(page).to have_content("Products")
    save_and_open_screenshot
  
  end 
end



