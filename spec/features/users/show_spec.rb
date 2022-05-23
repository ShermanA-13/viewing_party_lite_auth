require 'rails_helper'
require 'time'

RSpec.describe 'user/dashboard', type: :feature do
  before(:each) do
    @date = Date.new(2022, 0o5, 17)
    @time = Time.now

    @user_1 = User.create!(
      name: 'user_1',
      email: 'email_3@gmail.com',
      password: '1234',
      password_confirmation: '1234'
    )
    @user_2 = User.create!(
      name: 'user_2',
      email: 'email_4@gmail.com',
      password: '1234',
      password_confirmation: '1234'
    )
    @user_3 = User.create!(
      name: 'user_3',
      email: 'email_1@gmail.com',
      password: '2341',
      password_confirmation: '2341'
    )

    @party1 = Party.create!(host_id: @user_1.id, movie_id: 16, date: @date, start_time: @time, length: 120)
    @party2 = Party.create!(host_id: @user_1.id, movie_id: 19, date: @date, start_time: @time, length: 120)
    UserParty.create!(user_id: @user_1.id, party_id: @party1.id, host: true)
    UserParty.create!(user_id: @user_1.id, party_id: @party2.id, host: false)
    visit "/users/#{@user_1.id}"
  end

  describe 'when I visit user/dashboard' do
    it 'displays a welcome' do
      expect(page).to have_content('Hello user_1!')
    end

    it 'has a button to Discover Movies' do
      expect(page).to have_link('Discover Movies')
    end

    it 'has a section to see viewing parties' do
      expect(page).to have_content('Viewing Parties')
    end
  end
end
