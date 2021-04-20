require 'rails_helper'

describe '[STEP1] ユーザログイン前のテスト' do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end
    
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
      
      it 'Log inリンクの内容が正しい' do
        expect(page).to have_link log_in_link, href: new_user_session_path
      end
      
      it 'Sign upリンクの内容が正しい' do
        expect(page).to have_link sign_up_link, href: new_user_registration_path
      end
    end
  end
      
  describe 'ユーザ新規登録のテスト' do
    before do
      visit new_user_registration_path
    end
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_up'
      end
      it 'nameフォームが表示される' do
        expect(page).to have_field 'user[name]'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'Sign upボタンが表示される' do
        expect(page).to have_button 'Sign up'
      end
    end
  end


  describe 'コーチ新規登録のテスト' do
    before do
      visit new_coach_registration_path
    end
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/coaches/sign_up'
      end
      it 'nameフォームが表示される' do
        expect(page).to have_field 'coach[name]'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'coach[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'coach[password]'
      end
      it 'Sign upボタンが表示される' do
        expect(page).to have_button 'Sign up'
      end
    end
  
    
    context '新規登録成功のテスト' do
      before do
        fill_in 'user[name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
      end
      it '正しく新規登録される' do
        expect { click_button 'Sign up' }.to change(User.all, :count).by(1)
      end
      it '新規登録後のリダイレクト先が、新規登録できたユーザの詳細画面になっている' do
        click_button 'Sign up'
        expect(current_path).to eq '/users/my_page'
      end
    end
  end
  
  describe 'ユーザログイン' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
    end
    
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_in'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'Log inボタンが表示される' do
        expect(page).to have_button 'Log in'
      end
    end
    
    context 'ログイン成功のテスト' do
      before do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'Log in'
      end
      it 'ログイン後のリダイレクト先が、ログインできたユーザの詳細画面になっている' do
        click_button 'Sign up'
        expect(current_path).to eq '/users/my_page'
      end
    end
    context 'ログイン失敗のテスト' do
      before do
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'Log in'
      end

      it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
        expect(current_path).to eq '/users/sign_in'
      end
    end
  end
  describe 'コーチログイン' do
    let(:coach) { create(:coach) }

    before do
      visit new_coach_session_path
    end
    
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/coaches/sign_in'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'coach[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'coach[password]'
      end
      it 'Log inボタンが表示される' do
        expect(page).to have_button 'Log in'
      end
    end
    
    context 'ログイン成功のテスト' do
      before do
        fill_in 'coach[email]', with: coach.email
        fill_in 'coach[password]', with: coach.password
        click_button 'Log in'
      end
      it 'ログイン後のリダイレクト先が、ログインできたコーチの詳細画面になっている' do
        click_button 'Sign up'
        expect(current_path).to eq '/coaches/coaches/' + coach.id.to_s
      end
    end
    context 'ログイン失敗のテスト' do
      before do
        fill_in 'coach[email]', with: ''
        fill_in 'coach[password]', with: ''
        click_button 'Log in'
      end

      it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
        expect(current_path).to eq '/coaches/sign_in'
      end
    end
  end
end
