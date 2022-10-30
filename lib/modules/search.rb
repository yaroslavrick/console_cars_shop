module Search
  def create_query(options)
    hash = options.clone
    query = {
      pairs: {},
      sort: {
        by: hash.delete(:sort_by) || 'date_added',
        order: hash.delete(:sort_direction) || 'desc'
      }
    }

    year_from = nil
    year_to = nil
    price_from = nil
    price_to = nil

    hash.each_key do |key|
      case key
      when :year_from
        year_from = hash[key]
      when :year_to
        year_to = hash[key]
      when :price_from
        price_from = hash[key]
      when :price_to
        price_to = hash[key]
      else
        query[:pairs][key] = hash[key]
      end
    end

    query[:pairs]['year'] = year_from..year_to
    query[:pairs]['price'] = price_from..price_to

    query
  end

  def equivalent?(pair1, pair2)
    case pair2
    when Range
      pair2 === pair1
    when String
      pair2 == pair1.downcase
    else
      false
    end
  end

  def sort_cars(obj_to_sort, sort_by, sort_order)
    sort_factor = sort_order == 'desc' ? -1 : 1
    if sort_by == 'price'
      obj_to_sort.sort { |a, b| (a['price'] <=> b['price']) * sort_factor }
    else
      obj_to_sort.sort { |a, b| (DateTime.parse(a['date_added']) <=> DateTime.parse(b['date_added'])) * sort_factor }
    end
  end

  def search(cars_in_db, query)
    # all returns true or false of all values
    unsorted = cars_in_db.select do |car|
      query[:pairs].all? do |car_attr, query_value|
        equivalent?(car[car_attr], query_value)
      end
    end
    sort_cars(unsorted, query[:sort][:by], query[:sort][:order])
  end
end
