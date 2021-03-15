require 'rails_helper'

RSpec.describe Cat, type: :model do
  describe "#Validations" do 
    let(:breed) { create(:breed) }
    let(:cat) { build(:cat, breed_id: breed.id) }

    it "should have valid factory" do 
      expect(cat).to be_valid
    end

    it "has to have a breed name" do 
      cat.breed_name = ''
      expect(cat).not_to be_valid
      expect(cat.errors[:breed_name]).to include("can't be blank")
    end

    it "has to have a cat url" do 
      cat.cat_url = ''
      expect(cat).not_to be_valid
      expect(cat.errors[:cat_url]).to include("can't be blank")
    end
  end

  describe ".Methods" do 
    let(:breed) { create(:breed) }
    it "should return cats in proper order" do 
      older_cat = create(:cat, breed_id: breed.id, created_at: 1.hour.ago)
      recent_cat = create(:cat, breed_id: breed.id)
      expect(described_class.recent).to eq(
        [recent_cat, older_cat]
      )

      recent_cat.update_column(:created_at, 2.hour.ago)
      expect(described_class.recent).to eq(
        [older_cat, recent_cat]
      )
    end
  end
end
