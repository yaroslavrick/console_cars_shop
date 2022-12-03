searches_data = [{:rules=>{:make=>"ford", :model=>"", :year_from=>"", :year_to=>"", :price_from=>"", :price_to=>"", :sort_option=>"", :sort_direction=>""},
  :stats=>{:requests_quantity=>1, :total_quantity=>2}},
 {:rules=>{:make=>"volkswagen", :model=>"", :year_from=>"", :year_to=>"", :price_from=>"15000000", :price_to=>"", :sort_option=>"price", :sort_direction=>""},
  :stats=>{:requests_quantity=>1, :total_quantity=>0}},
 {:rules=>{:make=>"ford", :model=>"focus", :year_from=>"", :year_to=>"", :price_from=>"", :price_to=>"", :sort_option=>"", :sort_direction=>""},
  :stats=>{:requests_quantity=>1, :total_quantity=>1}}
]

search_rules = {:make=>"ford", :model=>"focus", :year_from=>"", :year_to=>"", :price_from=>"", :price_to=>"", :sort_option=>"", :sort_direction=>""}

new = searches_data.map do |hash|
  if hash[:rules] == search_rules
    hash[:stats][:requests_quantity] += 1
  else
    hash
  end
end
p new