namespace :level do
  desc "GEnerate slugs for missin ones"
  task generate_level_slugs: :environment do
    puts 'Started generating slugs!'

    missing_slugs = Level.where(slug: nil)

    puts "Missing slugs: #{missing_slugs.count}"

    missing_slugs.each do |l|
      stream_name = l.stream.name
      puts "Level ##{l.name} => #{stream_name}"
      l.update(slug: "#{l.name}#{stream_name}".parameterize)
      puts "Generated missing slugs"
    end
  end
end