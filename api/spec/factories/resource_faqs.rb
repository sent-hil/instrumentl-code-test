FactoryBot.define do
  factory(:resource_faq) do
    resource
    question { Faker::Lorem.question }
    answer { Faker::Lorem.sentences.join(" ") }
    priority { 1 }
  end
end
