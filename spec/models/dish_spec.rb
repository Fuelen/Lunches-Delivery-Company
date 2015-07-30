require 'rails_helper'

RSpec.describe Dish, type: :model do
  context "before create" do
    let(:dish) { build(:dish) }

    it "has price lower than 0.01" do
      dish.price = -9.24
      expect(dish).to be_invalid
    end

    it "has price greater than or equal to 0.01" do
      dish.price = 2
      expect(dish).to be_valid
    end
  end

  context "when created" do
    let(:dish) { create(:dish) }

    it "is available on today" do
      expect(dish.available_on).to eq Date.today
    end
  end
end
