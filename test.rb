search_rules = { make: 'ford', model: '', year_from: '', year_to: '', price_from: '', price_to: '',
                 sort_option: '', sort_direction: '' }
requests_quantity = 19
total_quantity = 2

def create_data(search_rules, requests_quantity, total_quantity)
  result = {}
  result[:rules] = search_rules
  result[:stats] = {
    requests_quantity:,
    total_quantity:
  }
  result
end