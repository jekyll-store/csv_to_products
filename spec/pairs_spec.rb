require 'pairs'

describe Pairs do
  let(:row) do
    {
      'name' => 'Flower & Power',
      'price' => '6.5',
      'sku' => 'FP2392',
      'weight' => '',
      'Sock Fabric' => 'Cotton and Wool',
      'description' => 'A low-cut cotton sock for those who miss the sixties!',
      'sizes[Small]' => 'y',
      'sizes[Medium]' => 'y',
      'sizes[Large]' => 'n',
      'genders[Female]' => 'y',
      'genders[Male]' => 'n'
    }
  end

  it 'parse correctly' do
    expected = "name: 'Flower & Power'\n" \
               "price: 6.5\n" \
               "sku: FP2392\n" \
               "sock_fabric: Cotton and Wool\n" \
               "sizes: [Small, Medium]\n" \
               "genders: [Female]\n"
    expect(Pairs.create(row)).to eq(expected)
  end
end
