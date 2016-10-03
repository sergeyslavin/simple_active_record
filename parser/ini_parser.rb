require_relative 'abstract_parser'
require 'inifile'

module Parser
  class IniParser < AbstractParser
    def parse_from_file(file_path)
      init_data = IniFile.load(file_path)

      if init_data.nil?
        return nil
      end

      result = []
      init_data.each_section do |section|
        sorted_by_keys = init_data[section].keys.group_by { |e| e[/\[\d\]/] }
        pairs_without_nils = sorted_by_keys.delete_if { |k, v| k.nil? }
        pairs_without_nils = pairs_without_nils.sort.to_h
        pairs_without_nils.each do |_, value|
          build_item = {}
          value.each do |key_for_item|
            item_key = get_keys_from_string(key_for_item).last
            build_item[item_key] = init_data[section][key_for_item]
          end
          result << build_item
        end
      end
      result
    end

    def get_keys_from_string(item)
      item.scan(/\[(.*?)\]/).flatten
    end
  end
end
