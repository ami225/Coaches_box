require 'rails_helper'
describe 'コーチのテスト' do
  let(:coach) { create(:coach) }
  let(:other_coach) { create(:coach) }
  describe 'コーチ一覧画面のテスト' do
    before do
    login_as(coach, scope: :coach)
    visit coaches_coaches_path
    end
    context '表示のテスト' do
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
  describe 'コーチ詳細画面のテスト' do
    before do
    login_as(coach, scope: :coach)
    visit coaches_coach_path(coach)
    end
    context '表示のテスト' do
      it 'コーチ編集画面へのリンクがあるか' do
        expect(page).to have_link '編集する'
      end
      it '編集するボタンの遷移先はコーチ編集画面か' do
        click_link '編集する'
        expect(current_path).to eq '/coaches/coaches/' + coach.id.to_s + '/edit'
      end
    end
  end
  describe 'コーチ編集画面のテスト' do
    before do
    login_as(coach, scope: :coach)
    visit edit_coaches_coach_path(coach)
    end
    context '表示のテスト' do
      it 'name編集フォームが表示される' do
        expect(page).to have_field 'coach[name]', with: coach.name
      end
      it 'introduction編集フォームが表示される' do
        expect(page).to have_field 'coach[introduction]', with: coach.introduction
      end
      it '変更を保存するボタンを表示する' do
        expect(page).to have_button '変更を保存する'
      end
    end
    context '更新のテスト' do
      before do
        @coach_old_name = coach.name
        @coach_old_intrpduction = coach.introduction
        fill_in 'coach[name]', with: Faker::Lorem.characters(number: 7)
        fill_in 'coach[introduction]', with: Faker::Lorem.characters(number: 10)
        click_button '変更を保存する'
      end
      it 'nameが正しく更新される' do
        expect(coach.reload.name).not_to eq @coach_old_name
      end
      it 'introductionが正しく更新される' do
        expect(coach.reload.introduction).not_to eq @coach_old_intrpduction
      end
    end
    context 'ボタンのテスト' do
      it 'リダイレクト先が、コーチ詳細画面になっている' do
        click_button '変更を保存する'
        expect(current_path).to eq '/coaches/coaches/' + coach.id.to_s
      end
    end
  end
end