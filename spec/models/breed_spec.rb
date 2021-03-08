require 'rails_helper'

RSpec.describe Breed, type: :model do
  describe "#Validations" do 
    let(:breed) { build(:breed) }
    
    it "should have valid factory" do 
      expect(breed).to be_valid 
    end

    it "has to have a name" do 
      breed.name = ''
      expect(breed).not_to be_valid 
      expect(breed.errors[:name]).to include("can't be blank")
    end

    it "has to have a breed_id" do 
      breed.breed_id = ''
      expect(breed).not_to be_valid
      expect(breed.errors[:breed_id]).to include("can't be blank")
    end

    it "has to have a rarity number" do 
      breed.rarity = 'a'
      expect(breed).not_to be_valid
      expect(breed.errors[:rarity]).to include("is not a number")
    end

    it "has to have a valid rarity number" do 
      breed.rarity = -1
      expect(breed).not_to be_valid
      expect(breed.errors[:rarity]).to include("must be greater than or equal to 0")

      breed.rarity = 6
      expect(breed).not_to be_valid
      expect(breed.errors[:rarity]).to include("must be less than 6")
    end
  end
end
