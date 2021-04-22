require 'rails_helper'
describe 'ユーザーroomのテスト' do
  let(:user) { create(:user) }
  let(:coach) { create(:coach) }
  describe 'room一覧画面のテスト' do
    before do
    visit rooms_path
    end
  end
  context '表示のテスト' do
    it 'room詳細へのリンクがあるか' do
      expect(page).to have_link 'チャットルームへ'
    end
  end
  context '遷移先の確認' do
      it 'Coach Profileの遷移先はroom詳細画面か' do
        click_link 'チャットルームへ'
        expect(current_path).to eq '/rooms/' + room.id.to_s
      end
    end
end