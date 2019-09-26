require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:date)}
    it {should validate_presence_of(:time)}
    it {should validate_presence_of(:address)}
    it {should validate_presence_of(:user_id)}
  end

	describe 'relationships' do
		it {should belong_to :user}
		it {should have_many :event_attendees}
	end

  describe '#host_name' do
    it "returns the host's name" do
      user = create(:user)
      event = create(:event, user_id: user.id)

      expect(event.host_name).to eq('Baxter McDog')
    end
  end

end
