require 'rails_helper'

describe '投稿のテスト' do
  #let!で事前評価で代入されてテストが通る
  let!(:coach){create(:coach)}
  let!(:post) { create(:post, title:'title', body:'body', coach_id: coach.id) }
  describe 'トップ画面(root_path)のテスト' do
    before do
      visit root_path
    end
    context '表示の確認' do
      it 'top_pathが"/"であるか' do
          expect(current_path).to eq('/')
      end
    end
  end
  describe "投稿画面(new_coaches_post_path)のテスト" do
    before do
      visit new_coaches_post_path
    end
    context '表示の確認' do
      it 'new_coaches_post_pathが"coaches/posts/new"であるか' do 
        expect(current_path).to eq('/coaches/posts/new')
      end
      it '投稿ボタンが表示されているか' do
        expect(page).to have_button '投稿する'
      end
    end
  end
  describe "投稿一覧のテスト" do
    before do
      visit coaches_posts_path
    end
    
    context '更新処理に関するテスト' do
      it '更新後のリダイレクト先は正しいか' do
        fill_in 'post[title]', with: Faker::Lorem.characters(number:5)
        fill_in 'post[body]', with: Faker::Lorem.characters(number:20)
        click_button '変更を保存する'
        expect(page).to have_current_path coaches_post_pat(post)
      end
    end
  end
end
