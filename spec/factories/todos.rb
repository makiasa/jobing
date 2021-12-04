FactoryBot.define do
  factory :todo do
    content { "テストを行う" }
    deadline { "2021-12-10" }
    status { 0 }
    user
    work
  end
end