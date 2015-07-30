require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:first_user) { create(:user) }

  context "when first creating" do
    it "is admin" do
      expect(first_user.admin?).to be true
    end

    it "has name 'Launches Admin'" do
      expect(first_user.name).to eq "Launches Admin"
    end
  end

  context "when second creating" do
    let(:second_user) { create(:other_user) }

    it "is not admin" do
      expect(second_user.admin?).to be false
    end

    it "has its name" do
      expect(second_user.name).to eq second_user.name
    end
  end
end
