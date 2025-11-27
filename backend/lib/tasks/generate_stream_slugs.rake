namespace :stream do
  desc 'Generate slugs for the missing ones'
  task generate_stream_slugs: :environment do
    puts 'Started generating slugs'
    missing_slugs = Stream.where(slug: nil)
    puts "Missing slugs: #{missing_slugs.count}"

    missing_slugs.each do |stream|
      stream.update(slug: stream.name.parameterize)
      puts "Generated the missing slugs for #{stream.name} -> #{stream.slug}"
    end
  end
end