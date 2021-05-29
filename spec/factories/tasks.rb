FactoryBot.define do
  factory :task do

    title { 'test_title' }
    content { 'test_content' }
    limit { '2021-05-22 05:22:00' }
  end
end
