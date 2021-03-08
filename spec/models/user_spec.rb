require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do 
    it 'Must be created with a password and password_confirmation' do
      @user = User.create(name: "James", email: "example@example.com",password: 'ABC', password_confirmation: 'ABC')
      expect(@user.valid?).to be true
    end
    it "Should throw error if password and confirm don't match" do
      @user = User.create(name: "James", email: "example@example.com",password: 'ABC', password_confirmation: 'YZX')
      expect(@user.valid?).to be false
    end 
    it "Should have a unique email" do
      user1 = User.create(name: "James", email: "example1@example.com",password: 'ABC', password_confirmation: 'ABC')
      user2 = User.create(name: "John", email: "example2@example.com",password: 'ABC', password_confirmation: 'ABC')
      
      expect(user1.valid?).to be true
      expect(user2.valid?).to be true
    end
    it "Should throw error if email matches previously used email(not case sensitive)" do
      user1 = User.create(name: "James", email: "example@example.com",password: 'ABC', password_confirmation: 'ABC')
      user2 = User.create(name: "John", email: "example@example.com",password: 'ABC', password_confirmation: 'ABC')
      
      expect(user1.valid?).to be true
      expect(user2.valid?).to be false
    end
    it "Should be created with email, name" do
      @user = User.create(name: "James", email: "example@example.com", password: "1234", password_confirmation: "1234")
      expect(@user.valid?).to be true 
    end 
    it "Should throw error if one is not included" do
      @user = User.create(name: nil, email: "example@example.com", password: "1234", password_confirmation: "1234")
      expect(@user.valid?).to be false 
    end 
    it "Should create account when password is above the minumum char count" do 
      @user = User.create(name: "James", email: "example@example.com", password: "1234", password_confirmation: "1234")
      expect(@user.valid?).to be true 
    end 
    it "Should not create account when password is below minimum char count" do 
      @user = User.create(name: "Johnny", email: "example@example.com", password: "12", password_confirmation: "12")
      expect(@user.valid?).to be false 
    end  
  end 
  describe '.authenticate_with_credentials' do 
    before do  
      @user = User.create(name: "Johnny", email: "example@example.com", password: "1234", password_confirmation: "1234")
    end 

    it "Should return False with bad password" do 
      @logged_user = User.authenticate_with_credentials("example@example.com", "123")
      expect(@logged_user).to be nil
    end
     

    it "Should allow login when there are spaces around the email" do
      @logged_user = User.authenticate_with_credentials(" example@example.com", "1234")
      expect(@logged_user.valid?).to_not be nil
    end

    it "Should allow login when there weird cases around the email" do
      @logged_user = User.authenticate_with_credentials(" exAmpLe@example.com", "1234")
      expect(@logged_user.valid?).to_not be nil
    end
end 
end
 