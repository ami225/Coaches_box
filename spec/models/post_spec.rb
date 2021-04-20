# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Postモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    #expect(user.valid?).to eq ''を「is_expected.to eq false」と省略できるように
    subject { post.valid? }

    let(:coach) { create(:coach) }
    let!(:post) { build(:post, coach_id: coach.id) }
    
    context 'titleカラム' do
      it '空欄でないこと' do
        post.title = ''
        is_expected.to eq false
      end
    end

    context 'bodyカラム' do
      it '空欄でないこと' do
        post.body = ''
        is_expected.to eq false
      end
      it '200文字以下であること: 300文字は〇' do
        post.body = Faker::Lorem.characters(number: 300)
        is_expected.to eq true
      end
      it '200文字以下であること: 301文字は×' do
        post.body = Faker::Lorem.characters(number: 301)
        is_expected.to eq false
      end
    end
  end
    #検索メソッドのテスト
  describe 'def self.looks_for(searches, words)' do
    let(:coach) { create(:coach) }
    it "検索文字列がperfect_matchで返す" do
      #postを作成して、titleを"test_item"
      create(:post, coach_id: coach.id, title: "test_item")
      #inputは完全一致なのでフルtitlenameを代入
      input = "test_item"
      #outputはinputを同じでなければ返さないので、output = input
      output = input
      #resにメソッドでinputのpostを探して
      res = Post.looks_for("perfect_match", input)
      #resのpostはoutputと完全一致しているか検証
      expect(res.first.title).to eq output
    end
    it "検索文字列がpartial_matchdで返す" do
      #postを作成して、titleを"other_test_item"
      create(:post, coach_id: coach.id, title: "other_test_item")
      #部分一致なので"other_test_item"の"test_item"の部分だけを代入
      input = "test_item"
      #全体のtitleを代入
      output = "other_test_item"
      #メソッドと返すものを代入
      res = Post.looks_for("partial_match", input)
      #inputの部分一致でoutputのpostを返せているか
      expect(res.first.title).to eq output
    end
  end
end
