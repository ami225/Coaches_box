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
      #login_asでdeviseで二つ作っているときはscope: :(ログインさせたいもの)を書く
      login_as(coach, scope: :coach)
      visit new_coaches_post_path
    end
    context '表示の確認' do
      it 'new_coaches_post_pathが"coaches/posts/new"であるか' do 
        expect(current_path).to eq('/coaches/posts/new')
      end
      it 'titleフォームが表示される' do
        expect(page).to have_field 'post[title]'
      end
      it '説明文フォームが表示される' do
        expect(page).to have_field 'post[body]'
      end
      it '投稿ボタンが表示されているか' do
        expect(page).to have_button '投稿する'
      end
    end
  end
  describe "投稿一覧のテスト" do
    before do
      login_as(coach, scope: :coach)
      visit coaches_posts_path
    end
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/coaches/posts'
      end
    end
  end
  describe "投稿画面のテスト" do
    context '投稿成功のテスト' do
      #ログインさせるためにcoachを作成
      let(:coach){ create(:coach) }
      before do
        #login_asでログインできる
        login_as(coach)
        visit new_coaches_post_path
        fill_in 'post[title]', with: Faker::Lorem.characters(number: 5)
        fill_in 'post[body]', with: Faker::Lorem.characters(number: 20)
      end
      it '自分の新しい投稿が正しく保存される' do
        expect { click_button '投稿' }.to change(coach.posts, :count).by(1)
      end
      it 'リダイレクト先が、保存できた投稿の詳細画面になっている' do
        click_button '投稿'
        expect(current_path).to eq '/coaches/posts/' + Post.last.id.to_s
      end
    end
  end
  describe "投稿詳細画面のテスト" do
    let(:coach){ create(:coach) }
      before do
        #login_asでログインできる
        login_as(coach, scope: :coach)
      visit coaches_post_path(post)
    end
    context '表示の確認' do
      it 'コーチ詳細画面へのリンクがあるか' do
        expect(page).to have_link 'Coach Profile'
      end
    end
    context '遷移先の確認' do
      it 'Coach Profileの遷移先はコーチ詳細画面か' do
        click_link 'Coach Profile'
        expect(current_path).to eq '/coaches/coaches/' + coach.id.to_s
      end
    end
  end
  describe "コーチ詳細画面のテスト" do
    let(:coach){ create(:coach) }
    before do
        #login_asでログインできる
        login_as(coach)
      visit coaches_coach_path(coach)
    end
    context '表示の確認' do
      it '投稿のEditが表示される' do
        expect(page).to have_link 'Edit'
      end
      it '投稿のDestroyが表示される' do
        expect(page).to have_link 'Destroy'
      end
    end
    context '編集リンクのテスト' do
      it '編集画面に遷移する' do
        click_link 'Edit'
        expect(current_path).to eq '/coaches/posts/' + post.id.to_s + '/edit'
      end
    end
    context '削除リンクのテスト' do
      before do
        click_link 'Destroy'
      end
      it '正しく削除される' do
        expect(Post.where(id: post.id).count).to eq 0
      end
      it 'リダイレクト先が、投稿一覧画面になっている' do
        expect(current_path).to eq '/coaches/coaches/' + coach.id.to_s
      end
    end
  end
  describe "投稿編集画面のテスト" do
    let(:coach){ create(:coach) }
    before do
        #login_asでログインできる
      login_as(coach)
      visit edit_coaches_post_path(post)
    end
    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/coaches/posts/' + post.id.to_s + '/edit'
      end
      it 'title編集フォームが表示される' do
        expect(page).to have_field 'post[title]', with: post.title
      end
      it '説明文編集フォームが表示される' do
        expect(page).to have_field 'post[body]', with: post.body
      end
      it '変更を保存するボタンが表示される' do
        expect(page).to have_button '変更を保存する'
      end
    end
    context '編集成功のテスト' do
      before do
        @post_old_title = post.title
        @post_old_body = post.body
        fill_in 'post[title]', with: Faker::Lorem.characters(number: 4)
        fill_in 'post[body]', with: Faker::Lorem.characters(number: 19)
        click_button '変更を保存する'
      end
      it 'titleが正しく更新される' do
        expect(post.reload.title).not_to eq @post_old_title
      end
      it 'bodyが正しく更新される' do
        expect(post.reload.body).not_to eq @post_old_body
      end
      it 'リダイレクト先が、更新した投稿の詳細画面になっている' do
        expect(current_path).to eq '/coaches/posts/' + post.id.to_s
      end
    end
  end
end

