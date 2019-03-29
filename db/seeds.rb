# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# durations [start, end, hours, minutes]
durations = [['CDG - Paris', 'FCO - Rome', 2, 0],
            ['CDG - Paris', 'FRA - Frankfurt', 2, 10],
            ['CDG - Paris', 'LHR - London', 1, 10],
            ['CDG - Paris', 'MAD - Madrid', 2, 5],
            ['FCO - Rome', 'FRA - Frankfurt', 1, 55],
            ['FCO - Rome', 'LHR - London', 2, 35],
            ['FCO - Rome', 'MAD - Madrid', 2, 25],
            ['FRA - Frankfurt', 'LHR - London', 1, 35],
            ['FRA - Frankfurt', 'MAD - Madrid', 2, 40],
            ['LHR - London', 'MAD - Madrid', 2, 20]]

def mins_to_duration(mins)
  hours = (mins / 60).floor.to_s
  mins = mins % 60
  mins < 10 ? mins = '0' + mins.to_s : mins = mins.to_s
  hours + 'h ' + mins + 'm'
end

def mins_to_time(mins)
  hours = (mins / 60).floor
  hours < 10 ? hours = '0' + hours.to_s : hours = hours.to_s
  mins = mins % 60
  mins < 10 ? mins = '0' + mins.to_s : mins = mins.to_s
  hours + ':' + mins
end

# flight [code, from, to, duration, departs, arrives]
def create_flights(from, to, hours, mins, num)
  new_flights = []
  first = 390 + rand(120)
  last = 1290 - rand(120)
  interval = ((last - first) / (num - 1)).floor
  duration_int = hours * 60 + mins
  num.times do |i|
    code = 'DF' + (rand(3555) + 2000).to_s
    departs_int = first + interval * i
    arrives = mins_to_time(departs_int + duration_int)
    departs = mins_to_time(departs_int)
    duration = mins_to_duration(duration_int)
    new_flights << [code, from, to, duration, departs, arrives]
  end
  new_flights
end

srand 8391
flights = []

durations.each do |flight|
  outbound, inbound = [], []
  num = rand(3) + 2
  outbound = create_flights(flight[0], flight[1], flight[2], flight[3], num)
  outbound.each {|f| flights << f}
  inbound = create_flights(flight[1], flight[0], flight[2], flight[3], num)
  inbound.each {|f| flights << f}
end

Airport::delete_all # not for production
Flight::delete_all # not for production

Airport.create!(name: durations[0][0]) # CDG
Airport.create!(name:  durations[4][0]) # FCO
Airport.create!(name:  durations[7][0]) # FRA
Airport.create!(name:  durations[9][0]) # LHR
Airport.create!(name:  durations[3][1]) # MAD

flights.each do |f|
  @from = Airport.find_by(name: f[1])
  @to = Airport.find_by(name: f[2])
  Flight.create(code: f[0], from_id: @from.id, to_id: @to.id, duration: f[3],
                departure: f[4], arrival: f[5])
end
