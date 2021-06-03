FactoryBot.define do
  factory :user do
    name { "test_user1" }
    email { "user1@example.com" }
    password { "5555555" }
    password_confirmation { "5555555" }
    admin { "一般" }
  end
  factory :admin_user, class: "User" do
    name { "test_user2" }
    email { "user2@example.com" }
    password { "6666666" }
    password_confirmation { "6666666" }
    admin { "管理者" }
  end
end
