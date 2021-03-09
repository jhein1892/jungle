require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do
  before :each do
    @user = User.create!(
      name: 'First User',
      email: 'first@user.com',
      password: '123456',
      password_confirmation: '123456'
    )

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
  
  scenario "They can login, and it shows that they are logged in" do 
    visit "/login"

    within 'form' do
      fill_in id: 'email', with: "first@user.com"
      fill_in id: 'password', with: "123456"

      click_button 'Submit'
    end 
    expect(page). to have_content 'Signed in as: First User'
    save_screenshot

  end 

end
