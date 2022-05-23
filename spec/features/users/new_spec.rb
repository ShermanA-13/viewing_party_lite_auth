require 'rails_helper'

RSpec.describe 'Registration Page', type: :feature do
  describe 'when a visitor visits /register' do
    before(:each) do
      @user1 = User.create!(name: 'Sabin Figaro', email: 'sabinff6@square.com', password: '1234',
                            password_confirmation: '1234')
      @user2 = User.create!(name: 'Edgar Figaro', email: 'edgarff6@square.com', password: '1234',
                            password_confirmation: '1234')
      visit '/register'
    end

    it 'has a form' do
      expect(page).to have_content('Name:')
      expect(page).to have_content('Email:')
      expect(page).to have_content('Password:')
      expect(page).to have_content('Confirm password:')
    end

    it 'creates a new user' do
      expect(User.all).to eq([@user1, @user2])

      fill_in('name', with: 'Celeste Chere')
      fill_in('email', with: 'celesff6@square.com')
      fill_in('password', with: '1234')
      fill_in('password_confirmation', with: '1234')
      click_on 'Register'

      user3 = User.last

      expect(user3.name).to eq('Celeste Chere')
      expect(user3.email).to eq('celesff6@square.com')
      expect(user3).to_not have_attribute(:password)
    end

    it 'redirects to user/dashboard' do
      fill_in('name', with: 'Celeste Chere')
      fill_in('email', with: 'celesff6@square.com')
      fill_in('password', with: '1234')
      fill_in('password_confirmation', with: '1234')
      click_on 'Register'

      user3 = User.last

      expect(current_path).to eq("/users/#{user3.id}")
    end

    it 'wont register a user with non matching passwords ' do
      visit register_path

      fill_in 'email', with: 'user@email.com'
      fill_in 'name', with: 'user'
      fill_in 'password', with: '1234'
      fill_in 'password_confirmation', with: '12345'

      click_on 'Register'

      expect(page).to have_content("Password confirmation doesn't match Password")

      expect(page).to have_content(/Password confirmation doesn't match Password/)
    end
  end
end
