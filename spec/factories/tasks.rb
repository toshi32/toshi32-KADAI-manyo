FactoryBot.define do
  factory :task do
    title { 'task' }
    content { 'task' }
    limit { '2021-05-10' }
    status_name { 1 }
    priority { 1 }
    association :user
  end
  factory :task2, class: "Task" do
    title { 'task2' }
    content { 'task2' }
    limit { '2021-05-20' }
    status_name { 2 }
    priority { 2 }
    association :user
  end
  factory :task3, class: "Task" do
    title { 'task3' }
    content { 'task3' }
    limit { '2021-04-30' }
    status_name { 3 }
    priority { 3 }
    association :user
  end
end
