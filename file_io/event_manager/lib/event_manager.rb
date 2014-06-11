require 'csv'
require 'sunlight/congress'
require 'erb'
require 'Date'

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

def clean_zipcode(zipcode)
	zipcode.to_s.rjust(5,"0").slice(0,5)
end

def legislators_from_zipcode(zipcode)
	legislators = Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

def save_thank_you_letter(id, form_letter)
	Dir.mkdir("output") unless Dir.exists? "output"

	filename = "output/thanks_#{id}.html"

	File.open(filename,'w') do |file|
		file.puts form_letter
	end
end

def clean_phone(phone)
  phone = phone.to_s.scan(/\d/).join('')
  if (phone.length < 10) || (phone.length > 11) || (phone.length > 10 && phone[0] != '1')
    phone = "0000000000"
  end
  phone.insert(0,'(').insert(4,')').insert(5,' ').insert(9,'-')
end

def get_date(date)
  DateTime.strptime(date, "%m/%d/%y %H:%M")
end

def get_hours(datetimes)
  hours = Hash.new 0 
  datetimes.each{ |datetime| hours[datetime.hour] += 1 }
  hours
end

def get_days(datetimes)
  days = Hash.new 0 
  datetimes.each{ |datetime| days[datetime.wday] += 1 }
  days
end

puts "Event Manager Initialized!"

contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol
registered_datetimes = []

template_letter = File.read "form_letter.html.erb"
erb_template = ERB.new template_letter

contents.each do |row|
	id = row[0]
	name = row[:first_name]
	zipcode = clean_zipcode(row[:zipcode])
	phone = clean_phone(row[:homephone])
  registered_datetimes << get_date(row[:regdate])

	legislators = legislators_from_zipcode(zipcode)

	form_letter = erb_template.result(binding)

	save_thank_you_letter(id, form_letter)
end

hours = 
best_hour = get_hours(registered_datetimes).max_by { |k,v| v }
best_day = get_days(registered_datetimes).max_by { |k,v| v }

puts "Hour with the most registrations was: #{best_hour[0]} with #{best_hour[1]} registrations."
puts "Day with most registrations was #{Date::DAYNAMES[best_day[0]]} with #{best_day[1]} registrations"



