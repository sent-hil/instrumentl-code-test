class AddResources < ActiveRecord::Migration[6.1]
  # TODO: figure out better way to manage this
  PRODUCTS = [
    {
      name: 'Fujifilm Digital Camera',
      url: 'https://www.manualslib.com/manual/1454452/Fujifilm-X-T3.html',
      faqs: [
        { question: 'What do histograms show?', answer: 'Histograms show the distribution of tones in the image.' },
        { question: 'How can you view separate RGB histograms?',
          answer: 'To view separate RGB histograms, press the function button to which HISTOGRAM is assigned.' },
        { question: 'What does the touch screen mode indicator do?',
          answer: 'The touch screen mode indicator displays different touch controls available during shooting or playback, depending on the selected mode.' },
        { question: 'Can touch controls be used during playback?',
          answer: 'Yes, touch controls can be used for swipe, pinch-out, pinch-in, double-tap, and drag operations during playback.' },
        { question: 'How do you attach a lens?',
          answer: 'Place the lens on the mount, keeping the marks on the lens and camera aligned, and then rotate the lens until it clicks into place.' }
      ]
    },
    {
      name: 'Dewalt Vacuum Cleaner',
      url: 'https://www.manualslib.com/manual/2316769/Dewalt-Dxv06p.html',
      faqs: [
        { question: 'What should I not vacuum with this product?',
          answer: 'Do not vacuum explosive dust, flammable or combustible liquids or hot ashes. Do not use this vac as a sprayer for any flammable or combustible liquid. To reduce the risk of health hazards from vapors or dusts, do not vacuum toxic materials.' },
        { question: 'What safety measures should I take when operating the product?',
          answer: 'Always wear safety goggles complying with ANSI Z87.1 (or in Canada, CSA Z94.3) before starting operation. To reduce the risk of fire or explosion, do not operate this vac in areas with flammable gases, vapors or explosive dust in the air.' },
        { question: 'What should I do before replacing the power head?',
          answer: 'Refer to the manual to ensure you have the proper filter installed for the cleaning operation.' },
        { question: 'Can I vacuum liquids with this product?',
          answer: 'Yes, but it is recommended to use a foam filter over the filter cage when vacuuming liquids containing debris, and to remove the cartridge filter when picking up large amounts of liquid.' },
        { question: 'Can I use this product to blow debris?',
          answer: 'Yes, the vac contains a blowing feature which can be used to blow sawdust and other debris out of garages or off patios and driveways.' }
      ]
    },
    {
      name: 'Bosh Color Monitor',
      url: 'https://www.manualslib.com/manual/1554242/Bosch-Ddu-9.html',
      faqs: [
        { question: 'What type of monitor is the LTC 2917/91?',
          answer: ' The LTC 2917/91 is a high performance, high resolution color display monitor with a 44 cm (17 in.) CRT.' },
        { question: 'What type of inputs does the LTC 2917/91 have?',
          answer: 'The LTC 2917/91 includes two loop through composite video inputs, using BNC connectors and impedance switches, and one set of loop-through Y/C connectors for S-video signals.' },
        { question: 'Does the LTC 2917/91 have audio capability?',
          answer: 'Yes, the LTC 2917/91 features single line level audio for composite video A and composite video B-Y/C inputs.' },
        { question: 'What is the maximum horizontal resolution of the LTC 2917/91 monitor?',
          answer: 'The LTC 2917/91 monitor provides 700 TV lines of resolution, which is the minimum horizontal resolution.' },
        { question: 'What kind of certifications and approvals does the LTC 2917/91 monitor have?',
          answer: 'The LTC 2917/91 monitor complies with FCC Part 15, ICES-003, CE regulations, UL, CSA, EN, and IEC standards, and also complies with DHHS Rules 21 CFR.' }
      ]
    },
    {
      name: 'LG External HDD',
      url: 'https://www.manualslib.com/manual/792116/Lg-Xg1.html#product-External',
      faqs: [
        { question: 'What type of external HDD is this?', answer: 'This is an LG External HDD Hard Disk Drive XG1.' },
        { question: 'What is the maximum temperature the external HDD can be exposed to?',
          answer: 'The external HDD should be kept away from areas with temperatures above 35 ℃ (95 ℉)' },
        { question: 'What is the warranty for this product?',
          answer: 'LG Electronics will replace this product if it is faulty due to a manufacturing or materials defect, except where damage is caused by your use or negligence.' }
      ]
    },
    {
      name: 'GE HDMI Switch',
      url: 'https://www.manualslib.com/manual/1583076/Baby-Brezza-Formula-Pro-Advanced.html',
      faqs: [
        { question: 'What is included in the package contents of the 3-Port HDMI Switch?',
          answer: 'The package includes the 3-Port HDMI Switch, a remote control, an AC/DC 120V power adapter, and a user manual.' },
        { question: 'How many HDMI-enabled devices can be connected to the 3-Port HDMI Switch?',
          answer: 'The 3-Port HDMI Switch can connect up to three HDMI-enabled devices to a single HDMI port.' },
        { question: 'What is the default input when the switch is first powered on?',
          answer: 'Input 1 is the default input when the switch is first powered on.' },
        { question: 'What should you do if the LED is not illuminated on the switch?',
          answer: 'Make sure the AC/DC power supply is plugged into a working outlet, make sure the DC plug is plugged completely into the switch, and make sure the power is turned on by pressing the Power/Select Button (Input 1 should be illuminated).' },
        { question: 'What is HDCP?',
          answer: 'HDCP stands for High-bandwidth Digital Content Protection, which is a technology embraced by the Motion Picture Association of America that eliminates the reproduction of copyrighted material.' }
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
