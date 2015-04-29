require 'csv'
require 'fileutils'
require_relative 'pairs'

module CSVToProducts
  class << self
    def parse(file, folder)
      @folder = folder
      @names = []

      file_exists?(file)
      create_folder
      each_row(file) { check; create_product }
    end

    private

    attr_reader :folder, :row

    def file_exists?(file)
      fail(FileNotFound) unless File.exists?(file)
    end

    def create_folder
      FileUtils.mkdir_p(folder) unless File.directory?(folder)
    end

    def each_row(file)
      CSV.foreach(file, headers: true) { |row| @row = row; yield }
    end

    def check
      fail(NameNotFound) unless row['name']
      fail(PriceNotFound) unless row['price']
      fail(NameNotUnique) if @names.include?(row['name'])
      fail(PriceNotNumeric) unless is_number?(row['price'])
      @names << row['name']
    end

    def create_product
      pairs = Pairs.create(row)
      description = row['description']
      File.write(product_path, "---\n#{pairs}---\n#{description}")
    end

    def product_path
      File.expand_path("#{dasherize(row['name'])}.md", folder)
    end

    def dasherize(s)
      s.to_s.gsub(' ', '-').downcase
    end

    def is_number?(s)
      Float(s) rescue false
    end
  end
end

class FileNotFound < StandardError; end
class NameNotFound < StandardError; end
class PriceNotFound < StandardError; end
class NameNotUnique < StandardError; end
class PriceNotNumeric < StandardError; end
