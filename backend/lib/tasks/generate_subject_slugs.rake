namespace :subject do
  desc "Generate missing subject slugs"
  task generate_subject_slugs: :environment do
    puts "Started generating missing slugs..."

    missing_slugs = Subject.where(slug: nil)
    puts "Missisng slugs: #{missing_slugs.count}"

    missing_slugs.each do |s|
      generated_Slug = s.name.parameterize

      s.update(slug: generated_Slug)

      puts "Generated slugs for #{s.name} => #{generated_Slug}"
    end
  end
end