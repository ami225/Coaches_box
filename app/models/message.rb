class Message < ApplicationRecord
  # messageコントローラーにコメントアウトしているものを記述できれば、blongs_to :userとcoachアソシエーション
  belongs_to :room
end
