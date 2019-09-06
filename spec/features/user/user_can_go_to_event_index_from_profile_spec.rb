require 'rails_helper'

RSpec.describe 'As a user' do
  describe 'When I visit my profile page' do
    it "I can click on events in your neighborhood and I'm taken to event index page" do
      user = User.create!(first_name: 'Jon', last_name: 'Doe', address: "123 Main St", city: "Denver", state: "CO", zip: 80203, email: "joe@example.com")
      id = user.id

      event_1 = user.events.create!(title: "Football Watch Party", date: "9-13-19", time: "8:00pm", address: "123 Main St", food: true, booze: true)
      event_2 = user.events.create!(title: "Book Club", date: "10-13-19", time: "8:00pm", address: "123 Main St", food: false, booze: false)
      event_3 = user.events.create!(title: "Poker Night", date: "11-13-19", time: "8:00pm", address: "123 Main St", food: false, booze: true)

      visit "/profile"

      expect(current_path).to eq(profile_path(id))

      expect(page).to have_content("Events in Your Neighborhood")
      click_link 'Events in Your Neighborhood'

      expect(page).to have_content("Nearby Events")

      within ".event-#{event_2.id}" do
        expect(page).to have_content(event_2.title)
        expect(page).to have_link(event_2.title)
        expect(page).to have_content("10-13-19")
      end
    end
  end
end
