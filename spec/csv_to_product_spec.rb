require 'csv_to_products'
require 'fileutils'

describe CSVToProducts do
  TMP = File.expand_path('../tmp', __FILE__)
  before { FileUtils.rm_rf(TMP) }
  after(:all) { FileUtils.rm_rf(TMP) }

  context 'with valid csv' do
    before do
      allow(Pairs).to receive(:create).and_return("PAIRS\n")
      socks_file = File.expand_path('../CSVs/socks.csv', __FILE__)
      CSVToProducts.parse(socks_file, TMP)
    end

    it 'creates correctly named files' do
      expected = %w(big-dot.md business.md flower-power.md hearts.md luxury-silky.md)
      expect(Dir.entries(TMP)).to include(*expected)
    end

    it 'places pairs in front matter and description afterwards' do
      expected = "---\nPAIRS\n---\nA fun ankle-cut sock, suitable for everyone."
      expect(File.read(File.expand_path('big-dot.md', TMP))).to eq(expected)
    end
  end

  it 'raises error if file does not exist' do
    non_existant_file = File.expand_path('../CSVs/does-not-exist.csv', __FILE__)
    expect { CSVToProducts.parse(non_existant_file, TMP) }.to raise_error(FileNotFound)
  end

  it 'raises error if name missing' do
    missing_name_file = File.expand_path('../CSVs/missing-name.csv', __FILE__)
    expect { CSVToProducts.parse(missing_name_file, TMP) }.to raise_error(NameNotFound)
  end

  it 'raises error if price missing' do
    missing_price_file = File.expand_path('../CSVs/missing-price.csv', __FILE__)
    expect { CSVToProducts.parse(missing_price_file, TMP) }.to raise_error(PriceNotFound)
  end

  it 'raises error if name repeated' do
    repeated_name_file = File.expand_path('../CSVs/repeated-name.csv', __FILE__)
    expect { CSVToProducts.parse(repeated_name_file, TMP) }.to raise_error(NameNotUnique)
  end

  it 'raises error if price is not numeric' do
    non_numeric_price_file = File.expand_path('../CSVs/non-numeric-price.csv', __FILE__)
    expect { CSVToProducts.parse(non_numeric_price_file, TMP) }.to raise_error(PriceNotNumeric)
  end
end
