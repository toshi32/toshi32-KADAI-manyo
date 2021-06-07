FactoryBot.define do
  factory :label do
    name { "NEW BOOK" }
  end
  factory :label2, class: "Label" do
    name { "NET CHK" }
  end
  factory :label3, class: "Label" do
    name { "FNL CHK" }
  end
end
