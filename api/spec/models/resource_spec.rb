require 'rails_helper'

RSpec.describe Resource, type: :model do
  it 'sets slug before saving resource' do
    r = build :resource, slug: nil
    r.save!

    expect(r.slug).to_not be_nil
    expect(r.slug.downcase).to eq(r.slug)
  end
end
