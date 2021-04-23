FactoryBot.define do
  factory :favorite do
    # coach_spec.rbでfavoriteをcreateできるようにするために記述
    association :user
    association :coach
  end
end
