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

    it "has to have a cats_count number" do 
      breed = create(:breed)
      cat1, cat2, cat3 = create_list(:cat, 3, breed_id: breed.id)
      breed.reload
      expect(breed[:cats_count]).to eq(3)
    end
  end

  describe ".Methods" do 
    it "should return breeds in correct order" do 
      older_breed = create(:breed, name: 'Acat')
      recent_breed = create(:breed)
      expect(described_class.ordered).to eq(
        [older_breed, recent_breed]
      )

      recent_breed.update_column(:name, 'Abreed')
      expect(described_class.ordered).to eq(
        [recent_breed, older_breed]
      )
    end

    it "should filter breeds by rarity" do 
      breed1, breed2, breed3 = create_list(:breed, 3, rarity: 3)
      breed1.update_column(:rarity, 5)
      
      expect(described_class.filter_by_rarity(3)).to eq(
        [breed2, breed3]
      )
      expect(described_class.filter_by_rarity(5)).to eq(
        [breed1]
      )
    end

    it "should filter breeds by name" do 
      breed1, breed2, breed3 = create_list(:breed, 3, name: "funnycat")
      breed1.update_column(:name, "happycat")

      expect(described_class.filter_by_name('funn')).to eq(
        [breed2, breed3]
      )
      expect(described_class.filter_by_name('happyc')).to eq(
        [breed1]
      )
    end
  end
end
