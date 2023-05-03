FactoryBot.define do
  factory(:resource) do
    name { Faker::Name.name }
    summary { Faker::Lorem.sentences.join(" ") }
  end
end
