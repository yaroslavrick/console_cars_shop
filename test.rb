# frozen_string_literal: true

require 'terminal-table'

searches_data = [
  { rules: { make: 'chevrolet', model: '', year_from: '', year_to: '', price_from: '', price_to: '' },
    stats: { requests_quantity: 3 }, user: 'email@email.com' },
  { rules: { make: 'ford', model: '', year_from: '', year_to: '', price_from: '', price_to: '' },
    stats: { requests_quantity: 1 }, user: 'email@email.com' },
  { rules: { make: 'lexus', model: '', year_from: '', year_to: '', price_from: '', price_to: '' },
    stats: { requests_quantity: 1 }, user: 'email@email.com' }
]

searches_data.each do |car|
  rows = car[:rules]
  table = Terminal::Table.new(
    title: 'Title',
    headings: ['Firs header', 'second header'],
    rows: rows
  )
  # table.style = TABLE_STYLE
  puts table
end
