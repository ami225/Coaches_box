require 'rails_helper'
describe 'ユーザーのテスト' do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  describe 'ユーザー詳細画面のテスト' do
    before do
      login_as(user, scope: :user)
      visit users_my_page_path(user)
    end
    context '表示のテスト' do
      it 'ユーザー編集画面へのリンクがあるか' do
        expect(page).to have_link 'プロフィールを編集'
      end
      it 'プロフィールを編集ボタンの遷移先はユーザー編集画面か' do
        click_link 'プロフィールを編集'
        expect(current_path).to eq '/users/' + user.id.to_s + '/edit'
      end
      it 'いいねしたコーチ一覧へのリンクがあるか' do
        expect(page).to have_link 'いいねしたコーチ一覧へ'
      end
      it 'いいねしたコーチ一覧へのリンクの遷移先はいいねしたコーチ一覧か' do
        click_link 'いいねしたコーチ一覧へ'
        expect(current_path).to eq '/favorite_coaches'
      end
      it 'コーチとのDMのリンクがあるか' do
        expect(page).to have_link 'コーチとのDM'
      end
      it 'コーチとのDMのリンクの遷移先はコーチとのDM一覧か' do
        click_link 'コーチとのDM'
        expect(current_path).to eq '/rooms'
      end
    end
  end
  describe 'ユーザー編集画面のテスト' do
    before do
    login_as(user, scope: :user)
    visit edit_user_path(user)
    end
    context '表示のテスト' do
      it 'name編集フォームが表示される' do
        expect(page).to have_field 'user[name]', with: user.name
      end
      it 'introduction編集フォームが表示される' do
        expect(page).to have_field 'user[introduction]', with: user.introduction
      end
      it '変更を保存するボタンを表示する' do
        expect(page).to have_button '変更を保存する'
      end
    end
    context 'ボタンのテスト' do
      it 'リダイレクト先が、ユーザー詳細画面になっている' do
        click_button '変更を保存する'
        expect(current_path).to eq '/users/my_page'
      end
    end
    context '更新のテスト' do
      before do
        @user_old_name = user.name
        @user_old_intrpduction = user.introduction
        fill_in 'user[name]', with: Faker::Lorem.characters(number: 7)
        fill_in 'user[introduction]', with: Faker::Lorem.characters(number: 10)
        click_button '変更を保存する'
      end
      it 'nameが正しく更新される' do
        expect(user.reload.name).not_to eq @user_old_name
      end
      it 'introductionが正しく更新される' do
        expect(user.reload.introduction).not_to eq @user_old_intrpduction
      end
    end
    context 'ボタンのテスト' do
      it 'リダイレクト先が、ユーザー詳細画面になっている' do
        click_button '変更を保存する'
        expect(current_path).to eq '/users/my_page'
      end
    end
  end
end