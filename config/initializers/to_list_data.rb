class Array
  def to_list_data
    map { |item| [item.name, item.id] }
  end
end