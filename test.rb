require 'colorize'

database = [{ 'id' => '9e6da960-330f-11ec-8d3d-0242ac130003',
              'make' => 'Volkswagen',
              'model' => 'Tiguan',
              'year' => 2013,
              'odometer' => 157_000,
              'price' => 15_600,
              'description' => 'Official car',
              'date_added' => '3/10/21' },
            { 'id' => '8f724eb6-330f-11ec-8d3d-0242ac130003',
              'make' => 'Volkswagen',
              'model' => 'Passat',
              'year' => 2013,
              'odometer' => 205_000,
              'price' => 12_200,
              'description' => 'Sell volkswagen passat b7 bluemotion technology',
              'date_added' => '10/10/21' }]

rows = database.map do |car|
  car.map do |key, value|
    [key.to_s.light_blue, value.to_s.magenta]
  end
end.flatten(1)
