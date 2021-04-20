require 'rails_helper'

RSpec.describe 'Coachモデルのテスト', type: :model do
  let(:coach) { create(:coach) }
  describe 'バリデーションのテスト' do

    subject { coach.valid? }
    let!(:other_coach) { create(:coach) }
    

    context 'nameカラム' do
      it '空欄でないこと' do
        coach.name = ''
        is_expected.to eq false
      end
      it '2文字以上であること: 1文字は×' do
        coach.name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '2文字以上であること: 2文字は〇' do
        coach.name = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end
      it '20文字以下であること: 20文字は〇' do
        coach.name = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      it '20文字以下であること: 21文字は×' do
        coach.name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end

    context 'introductionカラム' do
      it '50文字以下であること: 50文字は〇' do
        coach.introduction = Faker::Lorem.characters(number: 50)
        is_expected.to eq true
      end
      it '50文字以下であること: 51文字は×' do
        coach.introduction = Faker::Lorem.characters(number: 51)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Postモデルとの関係' do
      it '1:Nとなっている' do
        expect(Coach.reflect_on_association(:posts).macro).to eq :has_many
      end
    end
  end
  #いいね機能のテスト
  describe "def favorited_by?(user)" do
    let(:user) { create(:user) }
    it 'favoriteにuser_idが入っている時にtrueで返す' do
      #factory bot(favorite)にアソシエーションを書かないとcreteは使えないので記述
      #ここでfavoriteを作成してすでにletで定義しているuserとcoachここで明示的に記入して重複しないようにする
      create(:favorite, user: user, coach: coach)
      expect(coach.favorited_by?(user)).to be true
    end
    it 'favoriteにuser_idが入っていない時にfalseで返す' do
      create(:favorite, user: user, coach: coach)
      expect(coach.favorited_by?(user)).to_not be false
    end
  end
  
   #検索メソッドのテスト
  describe 'def self.looks_for(searches, words)' do
    it "検索文字列がperfect_matchで返す" do
      #コーチを作成して、nameを"test_item"さん
      create(:coach, name: "test_item")
      #inputは完全一致なのでフルネームを代入
      input = "test_item"
      #outputはinputを同じでなければ返さないので、output = input
      output = input
      #resにメソッドでinputの人を探して
      res = Coach.looks_for("perfect_match", input)
      #resの人はoutputと完全一致しているか検証
      expect(res.first.name).to eq output
    end
    it "検索文字列がpartial_matchdで返す" do
      #コーチを作成して、nameを"other_test_item"さん
      create(:coach, name: "other_test_item")
      #部分一致なので"other_test_item"の"test_item"の部分だけを代入
      input = "test_item"
      #全体の名前を代入
      output = "other_test_item"
      #メソッドと返すものを代入
      res = Coach.looks_for("partial_match", input)
      #inputの部分一致でoutputの人を返せているか
      expect(res.first.name).to eq output
    end
  end
  
  describe "def is_same?(current_coach)" do
    create(coach: coach)
    login_coach
      it 'ログインしているコーチのみtrueにしているか' do
        expect(Coach.is_same?(@coach)).to be true
      end
  end
  
  
end