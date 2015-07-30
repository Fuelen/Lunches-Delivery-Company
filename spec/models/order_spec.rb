require 'rails_helper'

RSpec.describe Order, type: :model do
  context "before creation" do
    let(:first_course) { create :first_course }
    let(:main_course)  { create :main_course }
    let(:drink)        { create :drink }
    let(:order)        { build  :order }

    it "has invalid first course" do
      order.first_course_id = main_course.id
      expect(order).to be_invalid
    end

    it "has valid first course" do
      order.first_course_id = first_course.id
      expect(order).to be_valid
    end

    it "has invalid main course" do
      order.main_course_id = first_course.id
      expect(order).to be_invalid
    end

    it "has valid main course" do
      order.main_course_id = main_course.id
      expect(order).to be_valid
    end

    it "has invalid drink" do
      order.drink_id = main_course.id
      expect(order).to be_invalid
    end

    it "has valid drink" do
      order.drink_id = drink.id
      expect(order).to be_valid
    end
  end

  describe "#created_on" do
    let(:new_order)       { build  :order }
    let(:persisted_order) { create :order }

    it { expect(new_order.created_on).to be_nil }
    it { expect(persisted_order.created_on).to eq Date.today }
  end

  describe "#total_price" do
    let(:first_course)    { create :first_course, price: 10 }
    let(:main_course)     { create :main_course,  price: 15 }
    let(:drink)           { create :drink,        price: 5  }
    let(:new_order)       { build(:order,
                                  first_course: first_course,
                                  main_course: main_course,
                                  drink: drink) }
    let(:persisted_order) { create(:order,
                                   first_course: first_course,
                                   main_course: main_course,
                                   drink: drink) }

    it { expect(new_order.total_price).to be_nil }
    it { expect(persisted_order.total_price).to eq 30 }
  end

end
