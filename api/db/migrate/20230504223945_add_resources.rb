class AddResources < ActiveRecord::Migration[6.1]
  PRODUCTS = [
    {
      name: 'Fujifilm Digital Camera',
      url: 'https://www.manualslib.com/manual/1454452/Fujifilm-X-T3.html',
      faqs: [
        {
          question: 'How do I clean the lens?',
          answer: 'Well you know, use a cloth.'
        }
      ]
    },
    {
      name: 'Dewalt Vacuum Cleaner',
      url: 'https://www.manualslib.com/manual/2316769/Dewalt-Dxv06p.html',
      faqs: [
        {
          question: 'How do I clean the lens?',
          answer: 'Well you know, use a cloth.'
        }
      ]
    },
    {
      name: 'Bosh Color Monitor',
      url: 'https://www.manualslib.com/manual/1554242/Bosch-Ddu-9.html',
      faqs: [
        {
          question: 'How do I clean the lens?',
          answer: 'Well you know, use a cloth.'
        }
      ]
    },
    {
      name: 'LG External HDD',
      url: 'https://www.manualslib.com/manual/792116/Lg-Xg1.html#product-External',
      faqs: [
        {
          question: 'How do I clean the lens?',
          answer: 'Well you know, use a cloth.'
        }
      ]
    },
    {
      name: 'Yamaha Wireless Speaker',
      url: 'https://www.manualslib.com/manual/1583076/Baby-Brezza-Formula-Pro-Advanced.html',
      slug: 'yamaha-wireless-speaker',
      faqs: [
        {
          question: 'How do I clean the lens?',
          answer: 'Well you know, use a cloth.'
        }
      ]
    }
  ].freeze

  def change
    PRODUCTS.each do |product|
      r = Resource.create!(product.except(:faqs))

      product[:faqs].each_with_index do |faq, i|
        r.resource_faqs.create!(faq.merge(priority: i))
      end
    end
  end
end
